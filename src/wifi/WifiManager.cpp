#if !( defined(ESP32) ) && !( defined(ESP8266) )
  #error This code is intended to run on ESP8266 or ESP32 platform!
#endif

#include <Arduino.h>
#include <WiFiClient.h>
#include <time.h>
#include <ezTime.h>
#include <ElegantOTA.h>
#if defined(ESP32)
  #include <HTTPUpdate.h>
#elif defined(ESP8266)
  #include <ESP8266httpUpdate.h>
#endif
#include <StreamUtils.h>
#include <AsyncJson.h>
#include <version.h>
#include "Configuration.h"
#include "wifi/WifiManager.h"
#include "wifi/HTMLAssets.h"

#define MAX_CONNECT_TIMEOUT_MS 15000 // 10 seconds to connect before creating its own AP
#define POST_UPDATE_INTERVAL 300000 // Every 5 min

const int RSSI_MAX =-50;// define maximum straighten of signal in dBm
const int RSSI_MIN =-100;// define minimum strength of signal in dBm

WiFiClient espClient;

const unsigned char icon_wifi [] PROGMEM = {
	0x00, 0x00, 0x70, 0x00, 0x7e, 0x00, 0x07, 0x80, 0x01, 0xc0, 0x70, 0xe0, 0x7c, 0x30, 0x0e, 0x38, 
	0x03, 0x18, 0x61, 0x8c, 0x78, 0xcc, 0x1c, 0xc4, 0x0c, 0x66, 0x46, 0x66, 0x66, 0x66, 0x00, 0x00
};

const unsigned char icon_ip [] PROGMEM = {
	0x0, 0xee, 0x49, 0x49, 0x4e, 0x48, 0xe8, 0x0
};

int dBmtoPercentage(int dBm) {
  int quality;
  if(dBm <= RSSI_MIN) {
    quality = 0;
  } else if(dBm >= RSSI_MAX) {  
    quality = 100;
  } else {
    quality = 2 * (dBm + 100);
  }
  return quality;
}

CWifiManager::CWifiManager(ISensorProvider *sensorProvider)
:sensorProvider(sensorProvider), postedSensorUpdate(false), rebootNeeded(false), wifiRetries(0) {  

  sensorJson["dev_name"] = configuration.name;
  sensorJson["version"] = VERSION;
  sensorJson["version_short"] = VERSION_SHORT;
  sensorJson["chip_model"] = CONFIG_getChipModel();
  sensorJson["chip_revision"] = CONFIG_getChipRevision();
  sensorJson["flash_size_bytes"] = CONFIG_getFlashChipSize();

  strcpy(SSID, configuration.wifiSsid);
  server = new AsyncWebServer(WEB_SERVER_PORT);
  mqtt.setClient(espClient);
  connect();
}

// WiFi.localIP() is 0.0.0.0 while running as a soft AP, so the reachable address has to be
// picked per mode rather than read from localIP() unconditionally.
String CWifiManager::currentIP() {
  return isApMode() ? WiFi.softAPIP().toString() : WiFi.localIP().toString();
}

void CWifiManager::connect() {

  status = WF_CONNECTING;
  strcpy(softAP_SSID, "");
  tMillis = millis();

  uint32_t deviceId = CONFIG_getDeviceId();
  sensorJson["device_id"] = deviceId;
  Log.infoln("Device ID: '%i'", deviceId);

  if (strlen(SSID)) {

    // Join AP from Config
    Log.infoln("Connecting to WiFi: '%s' with power %i", SSID, configuration.wifiPower);
    WiFi.begin(SSID, configuration.wifiPassword);
#if defined(ESP32)
    wifi_power_t txPower = WIFI_POWER_19_5dBm; // default
    switch (configuration.wifiPower) {
      case 76: txPower = WIFI_POWER_19dBm; break;   // 19dBm
      case 74: txPower = WIFI_POWER_18_5dBm; break; // 18.5dBm
      case 68: txPower = WIFI_POWER_17dBm; break;   // 17dBm
      case 60: txPower = WIFI_POWER_15dBm; break;   // 15dBm
      case 52: txPower = WIFI_POWER_13dBm; break;   // 13dBm
      case 44: txPower = WIFI_POWER_11dBm; break;   // 11dBm
      case 34: txPower = WIFI_POWER_8_5dBm; break;  // 8.5dBm
      case 28: txPower = WIFI_POWER_7dBm; break;    // 7dBm
      case 20: txPower = WIFI_POWER_5dBm; break;    // 5dBm
      case 8:  txPower = WIFI_POWER_2dBm; break;    // 2dBm
      case -4: txPower = WIFI_POWER_MINUS_1dBm; break; // -1dBm
      default: txPower = WIFI_POWER_19_5dBm; // 19.5dBm
    }
    WiFi.setTxPower(txPower);
#elif defined(ESP8266)
    float txPower = 20.5; // default 
    switch (configuration.wifiPower) {
      case 76: txPower = 19; break;   // 19dBm
      case 74: txPower = 18.5; break; // 18.5dBm
      case 68: txPower = 17; break;   // 17dBm
      case 60: txPower = 15; break;   // 15dBm
      case 52: txPower = 13; break;   // 13dBm
      case 44: txPower = 11; break;   // 11dBm
      case 34: txPower = 8.5; break;  // 8.5dBm
      case 28: txPower = 7; break;    // 7dBm
      case 20: txPower = 5; break;    // 5dBm
      case 8:  txPower = 2; break;    // 2dBm
      case -4: txPower = 1; break; // -1dBm
      default: txPower = 20.5; // 19.5dBm
    }
    WiFi.setOutputPower(txPower); 
#endif
    wifiRetries = 0;

  } else {

    // Create AP using fallback and chip ID
    sprintf_P(softAP_SSID, "%s_%i", WIFI_FALLBACK_SSID, deviceId);
    Log.infoln("Creating WiFi: '%s' / '%s'", softAP_SSID, WIFI_FALLBACK_PASS);

    if (WiFi.softAP(softAP_SSID, WIFI_FALLBACK_PASS)) {
      wifiRetries = 0;
      tsAPReboot = millis();
      Log.infoln("Wifi AP '%s' created, listening on '%s'", softAP_SSID, WiFi.softAPIP().toString().c_str());
    } else {
      Log.errorln("Wifi AP faliled");
    };

  }
  
}

void CWifiManager::listen() {

  status = WF_LISTENING;

  // Web
  server->on("/", [this](AsyncWebServerRequest *r){ handleRoot(r); });
  server->on("/style.css", HTTP_GET, [this](AsyncWebServerRequest *r){ handleStyleCSS(r); });
  server->on("/favicon.ico", HTTP_GET, [](AsyncWebServerRequest *request){ request->send(404); });
  //
  server->on("/wifi", HTTP_GET | HTTP_POST, [this](AsyncWebServerRequest *r){ handleWifi(r); });
  server->on("/sensor", HTTP_GET | HTTP_POST, [this](AsyncWebServerRequest *r){ handleSensor(r); });
  server->on("/device", HTTP_GET | HTTP_POST, [this](AsyncWebServerRequest *r){ handleDevice(r); });
  //
  server->on("/factory_reset", HTTP_POST, [this](AsyncWebServerRequest *r){ handleFactoryReset(r); });
  server->on("/reboot", HTTP_POST, [this](AsyncWebServerRequest *r){ handleReboot(r); });
  server->on("/mqtt_reconnect", HTTP_POST, [this](AsyncWebServerRequest *r){ handleFixMQTT(r); });
#ifdef WEB_LOGGING
  server->on("/log", HTTP_GET, [](AsyncWebServerRequest *request){ 
    Log.traceln("handleLog");
    intLEDOn();
    AsyncResponseStream *response = request->beginResponseStream("text/plain; charset=UTF-8", 16384);
    response->println(logStream.str().c_str());
    request->send(response);
    intLEDOff();
  });
#endif
  server->on("/api", HTTP_GET, [this](AsyncWebServerRequest *r){ handleRestAPI_HP(r); });
  AsyncCallbackJsonWebHandler* handler = new AsyncCallbackJsonWebHandler("/api", [this](AsyncWebServerRequest *request, JsonVariant &json) {
    bool success = this->updateConfigFromJson(json.as<JsonObject>());
    if (success) {
      handleRestAPI_HP(request);
    } else {
      AsyncResponseStream *response = request->beginResponseStream("text/plain; charset=UTF-8", 64);
      response->print("ERROR");
      response->setCode(500);
      request->send(response);
    }
  });
  server->addHandler(handler);


  server->begin();
  Log.infoln("Web server listening on http://%s:%i", currentIP().c_str(), WEB_SERVER_PORT);
  
  sensorJson["ip"] = currentIP();
  sensorJson["mac_address"] = WiFi.macAddress();

  // NTP
  Log.infoln("Configuring time from %s at %i (%i)", configuration.ntpServer, configuration.gmtOffset_sec, configuration.daylightOffset_sec);
  configTime(configuration.gmtOffset_sec, configuration.daylightOffset_sec, configuration.ntpServer);
  struct tm timeinfo;
  if(getLocalTime(&timeinfo)){
    Log.noticeln("The time is %i:%i", timeinfo.tm_hour,timeinfo.tm_min);
  }

  // OTA
  ElegantOTA.begin(server);

  // MQTT
  mqtt.setServer(configuration.mqttServer, configuration.mqttPort);

  using std::placeholders::_1;
  using std::placeholders::_2;
  using std::placeholders::_3;
  mqtt.setCallback(std::bind( &CWifiManager::mqttCallback, this, _1,_2,_3));

  if (strlen(configuration.mqttServer) && strlen(configuration.mqttTopic) && !mqtt.connected()) {
    Log.noticeln("Attempting MQTT connection to '%s:%i' ...", configuration.mqttServer, configuration.mqttPort);
    if (mqtt.connect(String(CONFIG_getDeviceId()).c_str())) {
      Log.noticeln("MQTT connected");
      
      sprintf_P(mqttSubcribeTopicConfig, "%s/%u/config", configuration.mqttTopic, CONFIG_getDeviceId());
      bool r = mqtt.subscribe(mqttSubcribeTopicConfig);
      Log.noticeln("Subscribed for config changes to MQTT topic '%s' success = %T", mqttSubcribeTopicConfig, r);

      postSensorUpdate();
    } else {
      Log.warningln("MQTT connect failed, rc=%i", mqtt.state());
    }
  }
}

void CWifiManager::loop() {

  ElegantOTA.loop();

  if (rebootNeeded && millis() - tMillis > 300) {
    Log.noticeln("Rebooting...");
  #if defined(ESP32)
    ESP.restart();
  #elif defined(ESP8266)
    ESP.reset();
  #endif
    return;
  }

  if (WiFi.status() == WL_CONNECTED || isApMode() ) {
    // WiFi is connected

    if (status != WF_LISTENING) {  
      if (isApMode()) {
        Log.noticeln("WiFi AP '%s' ready, IP address: %s", softAP_SSID, WiFi.softAPIP().toString().c_str());
      } else {
        Log.noticeln("WiFi connected to '%s', IP address: %s, gateway: %s, subnet: %s, RSSI: %i dBm",
          WiFi.SSID().c_str(),
          WiFi.localIP().toString().c_str(),
          WiFi.gatewayIP().toString().c_str(),
          WiFi.subnetMask().toString().c_str(),
          WiFi.RSSI());
      }
      // Start listening for requests
      listen();
      return;
    }

    #ifdef OLED
    display->setTextSize(0);
    display->drawBitmap(0, 0, icon_wifi, 16, 16, 1);
    display->drawBitmap(18, 8, icon_ip, 8, 8, 1);
    display->setCursor(18,0);
    if (isApMode()) {
      display->print(WIFI_FALLBACK_SSID);
      display->print("...");
      display->setCursor(26,8);
      display->print(WiFi.softAPIP().toString().c_str());  
    } else {
      display->print(configuration.wifiSsid);
      display->print(" ");
      display->print(dBmtoPercentage(WiFi.RSSI()));
      display->print("%");
      display->setCursor(26,8);
      display->print(WiFi.localIP().toString());  
    }
    
    display->display();
    #endif

    mqtt.loop();
    
    if (!isApMode() && strlen(configuration.mqttServer) && strlen(configuration.mqttTopic)) {
      if (millis() - tMillis > POST_UPDATE_INTERVAL || !postedSensorUpdate) {
        if (postSensorUpdate()) {
          postedSensorUpdate = true;
          tMillis = millis();
        }
      }
    }

    if (isApMode() && strlen(configuration.wifiSsid)) {
      if (WiFi.softAPgetStationNum() > 0)  {
        tsAPReboot = millis();
      } else if (millis() - tsAPReboot > 60000) {
        // Reboot if in AP mode and no connected clients, in hope of connecting to real AP
        Log.infoln(F("Rebooting after a minute in AP with no connections"));
        rebootNeeded = true;
      }
    }

  } else if (WiFi.status() == WL_NO_SSID_AVAIL && !isApMode()) {
    // Can't find desired AP
    if (millis() - tMillis > MAX_CONNECT_TIMEOUT_MS) {
      tMillis = millis();
      if (++wifiRetries > 1) {
        Log.warningln("Failed to find previous AP (wifi status %i) after %l ms, create an AP instead", WiFi.status(), (millis() - tMillis));
        strcpy(SSID, "");
        WiFi.disconnect(false, true);
        connect();
      } else {
        Log.warningln("Can't find previous AP (wifi status %i) trying again attempt: %i", WiFi.status(), wifiRetries);
      }
      //Log.infoln("WifiMode == %i", WiFi.getMode());
    }
  } else {
    // WiFi is down
    switch (status) {
      case WF_LISTENING: {
      Log.infoln("Disconnecting %i", status);
      server->end();
      status = WF_CONNECTING;
      connect();
      } break;
      case WF_CONNECTING: {
        if (millis() - tMillis > MAX_CONNECT_TIMEOUT_MS) {
          tMillis = millis();
          if (++wifiRetries > 3) {
            Log.warningln("Connecting failed (wifi status %i) after %l ms, create an AP instead", WiFi.status(), (millis() - tMillis));
            strcpy(SSID, "");
          }
          connect();
        }
      } break;
    } // switch
  }
  
}

void CWifiManager::handleRoot(AsyncWebServerRequest *request) {
  Log.traceln("handleRoot");
  intLEDOn();

  AsyncResponseStream *response = request->beginResponseStream("text/html; charset=UTF-8", 4096);
  printHTMLTop(response);
  printHTMLMain(response);
  printHTMLBottom(response);
  request->send(response);

  intLEDOff();
}

void CWifiManager::handleWifi(AsyncWebServerRequest *request) {
  Log.traceln("handleWifi: %i - %s", request->method(), request->methodToString());
  intLEDOn();

  if (request->method() == HTTP_POST) {
    String ssid = request->arg("ssid");
    String password = request->arg("password");
    String wifiPowerStr = request->arg("wifiPower");
    int wifiPower = wifiPowerStr.length() > 0 ? wifiPowerStr.toInt() : 78;

    AsyncResponseStream *response = request->beginResponseStream("text/html; charset=UTF-8", 2048);

    printHTMLTop(response);
    response->printf("<p>Connecting to '%s' ... see you on the other side!</p>", ssid.c_str());
    printHTMLBottom(response);

    request->send(response);

    ssid.toCharArray(configuration.wifiSsid, sizeof(configuration.wifiSsid));
    password.toCharArray(configuration.wifiPassword, sizeof(configuration.wifiPassword));
    configuration.wifiPower = wifiPower;

    Log.noticeln("Saved config SSID: '%s'", configuration.wifiSsid);
    Log.noticeln("Saved WiFi Power: %i", configuration.wifiPower);

    EEPROM_saveConfig();

    strcpy(SSID, configuration.wifiSsid);
    WiFi.disconnect(true, true);
    tMillis = millis();
    rebootNeeded = true;
  } else {
    // Generate WiFi power options with current selection marked
    char wifiPowerOptions[1024];
    snprintf_P(wifiPowerOptions, 1024, PSTR("\
      <option %s value='78'>WIFI_POWER_19_5dBm (7.8dBm)</option>\
      <option %s value='76'>WIFI_POWER_19dBm (7.6dBm)</option>\
      <option %s value='74'>WIFI_POWER_18_5dBm (7.4dBm)</option>\
      <option %s value='68'>WIFI_POWER_17dBm (6.8dBm)</option>\
      <option %s value='60'>WIFI_POWER_15dBm (6.0dBm)</option>\
      <option %s value='52'>WIFI_POWER_13dBm (5.2dBm)</option>\
      <option %s value='44'>WIFI_POWER_11dBm (4.4dBm)</option>\
      <option %s value='34'>WIFI_POWER_8_5dBm (3.4dBm)</option>\
      <option %s value='28'>WIFI_POWER_7dBm (2.8dBm)</option>\
      <option %s value='20'>WIFI_POWER_5dBm (2.0dBm)</option>\
      <option %s value='8'>WIFI_POWER_2dBm (0.8dBm)</option>\
      <option %s value='-4'>WIFI_POWER_MINUS_1dBm (-0.4dBm)</option>\
      "), 
      configuration.wifiPower == 78 ? "selected" : "",
      configuration.wifiPower == 76 ? "selected" : "",
      configuration.wifiPower == 74 ? "selected" : "",
      configuration.wifiPower == 68 ? "selected" : "",
      configuration.wifiPower == 60 ? "selected" : "",
      configuration.wifiPower == 52 ? "selected" : "",
      configuration.wifiPower == 44 ? "selected" : "",
      configuration.wifiPower == 34 ? "selected" : "",
      configuration.wifiPower == 28 ? "selected" : "",
      configuration.wifiPower == 20 ? "selected" : "",
      configuration.wifiPower == 8 ? "selected" : "",
      configuration.wifiPower == -4 ? "selected" : ""
    );

    AsyncResponseStream *response = request->beginResponseStream("text/html; charset=UTF-8", 6144);
    printHTMLTop(response);
    response->printf_P(htmlWifi, configuration.wifiSsid, wifiPowerOptions);
    printHTMLBottom(response);
    request->send(response);
  }

  intLEDOff();
}

void CWifiManager::handleSensor(AsyncWebServerRequest *request) {
  Log.traceln("handleSensor: %s", request->methodToString());
  intLEDOn();

  if (request->method() == HTTP_POST) {
    
    #ifdef TEMP_SENSOR
    uint16_t tempUnit = atoi(request->arg("tempUnit").c_str());
    configuration.tempUnit = tempUnit;
    Log.infoln("Temperature unit: %u", tempUnit);

    tempSensorType tempSensor = (tempSensorType)atoi(request->arg("tempSensor").c_str());
    configuration.tempSensor = tempSensor;
    Log.infoln("Temperature sensor type: %u", tempSensor);

    configuration.tCorrection[0].measured = atoff(request->arg("tMeasured1").c_str());
    configuration.tCorrection[0].actual = atoff(request->arg("tActual1").c_str());
    configuration.tCorrection[1].measured = atoff(request->arg("tMeasured2").c_str());
    configuration.tCorrection[1].actual = atoff(request->arg("tActual2").c_str());

    configuration.hCorrection[0].measured = atoff(request->arg("hMeasured1").c_str());
    configuration.hCorrection[0].actual = atoff(request->arg("hActual1").c_str());
    configuration.hCorrection[1].measured = atoff(request->arg("hMeasured2").c_str());
    configuration.hCorrection[1].actual = atoff(request->arg("hActual2").c_str());
    #endif

    configuration.voltageDivider = atoff(request->arg("voltageDivider").c_str());

    EEPROM_saveConfig();
    Log.verboseln("Config saved");
    
    request->redirect("sensor");
    tMillis = millis();

    Log.infoln("Requesting reboot...");
    rebootNeeded = true;

  } else {

    #ifdef TEMP_SENSOR
    char tempUnit[256];
    snprintf(tempUnit, 256, "<option %s value='0'>Celsius</option>\
      <option %s value='1'>Fahrenheit</option>", 
      configuration.tempUnit == TEMP_UNIT_CELSIUS ? "selected" : "", 
      configuration.tempUnit == TEMP_UNIT_FAHRENHEIT ? "selected" : "");
    
    char tempSensor[512] = "";
    snprintf_P(tempSensor, 512, PSTR("\
      <option %s value='0'>-</option>\
      <option %s value='1'>DS18B20</option>\
      <option %s value='2'>BME280</option>\
      <option %s value='3'>DHT22</option>\
      <option %s value='4'>AHT20</option>\
      <option %s value='5'>BME688</option>\
      "), 
      configuration.tempSensor == TEMP_SENSOR_UNSUPPORTED ? "selected" : "", 
      configuration.tempSensor == TEMP_SENSOR_DS18B20 ? "selected" : "", 
      configuration.tempSensor == TEMP_SENSOR_BME280 ? "selected" : "", 
      configuration.tempSensor == TEMP_SENSOR_DHT22 ? "selected" : "", 
      configuration.tempSensor == TEMP_SENSOR_AHT20 ? "selected" : "",
      configuration.tempSensor == TEMP_SENSOR_BME688 ? "selected" : ""
    );

    float t = sensorProvider->getTemperature(NULL);
    if (configuration.tempUnit == TEMP_UNIT_FAHRENHEIT) {
      t = t * 1.8 + 32;
    }

    char envSensor[192];
    printEnvSensorLabel(envSensor, sizeof(envSensor));

    char pwrSensor[256];
    printPowerSensorLabel(pwrSensor, sizeof(pwrSensor));

    AsyncResponseStream *response = request->beginResponseStream("text/html; charset=UTF-8", 10240);
    printHTMLTop(response);
    response->printf_P(htmlSensor, envSensor, tempSensor, tempUnit,
      t, (configuration.tempUnit == TEMP_UNIT_CELSIUS ? "C" : (configuration.tempUnit == TEMP_UNIT_FAHRENHEIT ? "F" : "" )),
      configuration.tCorrection[0].measured, configuration.tCorrection[0].actual,
      configuration.tCorrection[1].measured, configuration.tCorrection[1].actual,
      sensorProvider->getHumidity(NULL),
      configuration.hCorrection[0].measured, configuration.hCorrection[0].actual,
      configuration.hCorrection[1].measured, configuration.hCorrection[1].actual,
      pwrSensor,
      sensorProvider->getVoltage(NULL), sensorProvider->getVoltageADC(NULL),
      configuration.voltageDivider
    );
    #else
    char pwrSensor[256];
    printPowerSensorLabel(pwrSensor, sizeof(pwrSensor));

    AsyncResponseStream *response = request->beginResponseStream("text/html; charset=UTF-8", 6144);
    printHTMLTop(response);
    response->printf_P(htmlSensor, pwrSensor,
      sensorProvider->getVoltage(NULL), sensorProvider->getVoltageADC(NULL),
      configuration.voltageDivider
    );
    #endif
    printHTMLBottom(response);
    request->send(response);

  }

  intLEDOff();
}


void CWifiManager::handleDevice(AsyncWebServerRequest *request) {
  Log.traceln("handleDevice: %s", request->methodToString());
  intLEDOn();

  if (request->method() == HTTP_POST) {
    configuration.ledEnabled = request->hasArg("ledEnabled");

    String deviceName = request->arg("deviceName");
    deviceName.toCharArray(configuration.name, sizeof(configuration.name));
    Log.infoln("Device req name: %s", deviceName);
    Log.infoln("Device size %i name: %s", sizeof(configuration.name), configuration.name);

    uint16_t deepSleepDurationSec = atoi(request->arg("deepSleepDuration").c_str()) * 60;
    configuration.deepSleepDurationSec = deepSleepDurationSec;
    Log.infoln("deepSleepDurationSec : %u", deepSleepDurationSec);

    String mqttServer = request->arg("mqttServer");
    mqttServer.toCharArray(configuration.mqttServer, sizeof(configuration.mqttServer));
    Log.infoln("MQTT Server: %s", mqttServer);

    uint16_t mqttPort = atoi(request->arg("mqttPort").c_str());
    configuration.mqttPort = mqttPort;
    Log.infoln("MQTT Port: %u", mqttPort);

    String mqttTopic = request->arg("mqttTopic");
    mqttTopic.toCharArray(configuration.mqttTopic, sizeof(configuration.mqttTopic));
    Log.infoln("MQTT Topic: %s", mqttTopic);

    EEPROM_saveConfig();
    
    request->redirect("device");
    tMillis = millis();
    rebootNeeded = true;
  } else {

    uint16_t sleepMin = (uint16_t)(configuration.deepSleepDurationSec / 60);

    AsyncResponseStream *response = request->beginResponseStream("text/html; charset=UTF-8", 6144);
    printHTMLTop(response);
    response->printf_P(htmlDevice,
      CONFIG_getChipModel().c_str(), CONFIG_getChipRevision(),
      CONFIG_getFlashChipSize() / (1024 * 1024), WiFi.macAddress().c_str(),
      configuration.ledEnabled ? "checked" : "",
      configuration.name, sleepMin, sleepMin,
      configuration.mqttServer, configuration.mqttPort, configuration.mqttTopic);
    printHTMLBottom(response);
    request->send(response);
  }
  intLEDOff();
}

void CWifiManager::handleFactoryReset(AsyncWebServerRequest *request) {
  Log.traceln("handleFactoryReset");
  intLEDOn();
  
  AsyncResponseStream *response = request->beginResponseStream("text/plain; charset=UTF-8", 64);
  response->setCode(200);
  response->print("OK");

  EEPROM_wipe();
  tMillis = millis();
  rebootNeeded = true;
  
  request->send(response);
  intLEDOff();
}

void CWifiManager::handleReboot(AsyncWebServerRequest *request) {
  Log.traceln("handleReboot");
  intLEDOn();
  
  AsyncResponseStream *response = request->beginResponseStream("text/plain; charset=UTF-8", 64);
  response->setCode(200);
  response->print("OK");

  tMillis = millis();
  rebootNeeded = true;
  
  request->send(response);
  intLEDOff();
}

void CWifiManager::handleFixMQTT(AsyncWebServerRequest *request) {
  Log.traceln("handleReboot");
  intLEDOn();
  
  ensureMQTTConnected();

  request->redirect("/");
  intLEDOff();
}

void CWifiManager::handleRestAPI_HP(AsyncWebServerRequest *request) {
  Log.traceln("handleRestAPI_HP: %s", request->methodToString());
  intLEDOn();
  
  updateSensorJson();

  String jsonStr;
  serializeJson(sensorJson, jsonStr);
  Log.verboseln("API payload: '%s'", jsonStr.c_str());

  AsyncResponseStream *response = request->beginResponseStream("application/json; charset=UTF-8", 2048);
  response->print(jsonStr);
  response->setCode(200);
  request->send(response);

  intLEDOff();
}

void CWifiManager::handleRestAPI_Device(AsyncWebServerRequest *request) {
  Log.traceln("handleRestAPI_Device: %s", request->methodToString());
  intLEDOn();
  
  int iv;

  iv = dBmtoPercentage(WiFi.RSSI());
  sensorJson["wifi_percent"] = iv;
  sensorJson["wifi_rssi"] = WiFi.RSSI();

  time_t now; 
  time(&now);
  unsigned long uptimeMillis = CONFIG_getUpTime();

  sensorJson["uptime_millis"] = uptimeMillis;
  // Convert to ISO8601 for JSON
  char buf[sizeof "2011-10-08T07:07:09Z"];
  strftime(buf, sizeof buf, "%FT%TZ", gmtime(&now));
  sensorJson["timestamp_iso8601"] = String(buf);

  sensorJson["mqttConfigTopic"] = mqttSubcribeTopicConfig;

#if defined(TEMP_SENSOR_PIN)
  bool sensorReady = sensorProvider->isSensorReady();
  float v;

  if (sensorReady) {
    bool current = false;
    v = sensorProvider->getTemperature(&current);
    if (configuration.tempUnit == TEMP_UNIT_FAHRENHEIT) {
      v = v * 1.8 + 32;
    }
    char tunit[32];
    snprintf(tunit, 32, (configuration.tempUnit == TEMP_UNIT_CELSIUS ? "Celsius" : (configuration.tempUnit == TEMP_UNIT_FAHRENHEIT ? "Fahrenheit" : "" )));
    
    if (current) {
      sensorJson["temperature"] = v;
      sensorJson["temperature_unit"] = tunit;
    }

    v = sensorProvider->getHumidity(&current);
    if (current) {
      sensorJson["humidity"] = v;
      sensorJson["humidit_unit"] = "percent";
    }
  }
#endif

  
  String jsonStr;
  serializeJson(sensorJson, jsonStr);
  Log.verboseln("deviceSettings: '%s'", jsonStr.c_str());

  AsyncResponseStream *response = request->beginResponseStream("application/json; charset=UTF-8", 2048);
  response->print(jsonStr);
  response->setCode(200);
  request->send(response);

  intLEDOff();
}

void CWifiManager::handleStyleCSS(AsyncWebServerRequest *request) {
  Log.traceln("handleStyleCSS");
  static uint32_t dataLen = strlen_P(cssPico);
  AsyncWebServerResponse *response = request->beginChunkedResponse("text/css; charset=UTF-8", [](uint8_t *buffer, size_t maxLen, size_t index) -> size_t {
    size_t len = (dataLen>maxLen)?maxLen:dataLen;
    if (len > 0) {
      memcpy_P(buffer, cssPico + index, len);
      dataLen -= len;
    } else {
      dataLen = strlen_P(cssPico);
    }
    return len;
  });
  request->send(response);
}

bool CWifiManager::postSensorUpdate() {

  if (!strlen(configuration.mqttTopic)) {
    Log.warningln("Blank MQTT topic");
    return false;
  }

  if (!ensureMQTTConnected()) {
    Log.errorln("Unable to post sensor update due to MQTT connection issues");
    return false;
  }

  intLEDOn();
  if (!updateSensorJson()) {
    Log.errorln("Unable to update sensor JSON");
    intLEDOff();
    return false;
  }

  publishHADiscovery();

  // sensor Json
  char topic[255];
  sprintf_P(topic, "%s/json", configuration.mqttTopic);
  mqtt.beginPublish(topic, measureJson(sensorJson), false);
  BufferingPrint bufferedClient(mqtt, 32);
  serializeJson(sensorJson, bufferedClient);
  bufferedClient.flush();
  mqtt.endPublish();

  String jsonStr;
  serializeJson(sensorJson, jsonStr);
  Log.noticeln("Sent '%s' json to MQTT topic '%s'", jsonStr.c_str(), topic);

  intLEDOff();
  return true;
}

bool CWifiManager::updateSensorJson() {
  int iv = dBmtoPercentage(WiFi.RSSI());
  sensorJson["wifi_percent"] = iv;
  sensorJson["wifi_rssi"] = WiFi.RSSI();
  sensorJson["wifi_power"] = configuration.wifiPower;

  time_t now; 
  time(&now);
  unsigned long uptimeMillis = CONFIG_getUpTime();

  sensorJson["uptime_millis"] = uptimeMillis;
  // Convert to ISO8601 for JSON
  char buf[sizeof "2011-10-08T07:07:09Z"];
  strftime(buf, sizeof buf, "%FT%TZ", gmtime(&now));
  sensorJson["timestamp_iso8601"] = String(buf);

  sensorJson["led_enabled"] = configuration.ledEnabled;
  sensorJson["led_enabled_text"] = configuration.ledEnabled ? "yes" : "no";

#ifdef CURRENT_SENSOR
  // INA219 readings are reported separately from the ADC divider voltage above
  bool ina219Current;
  float ina219Voltage = sensorProvider->getLoadVoltage(&ina219Current);
  if (ina219Current) {
    sensorJson["ina219_voltage_v"] = ina219Voltage;
    sensorJson["ina219_current_ma"] = sensorProvider->getLoadCurrent(NULL);
    sensorJson["ina219_power_mw"] = sensorProvider->getLoadPower(NULL);
  }
#endif

#if defined(TEMP_SENSOR_PIN)
  // A missing or failed climate sensor must not suppress the whole payload: the wifi,
  // voltage and INA219 values are still worth publishing, and on a board with no climate
  // sensor at all they are the only values there are.
  if (!sensorProvider->isSensorReady()) {
    Log.warningln("Climate sensor not ready, publishing without temperature and humidity");
  } else {

    sensorJson["temp_sensor_type"] = configuration.tempSensor;
    sensorJson["temp_sensor_name"] = sensorProvider->getTempSensorName();

    bool current;
    float t = sensorProvider->getTemperature(&current);
    if (current) {
      if (configuration.tempUnit == TEMP_UNIT_FAHRENHEIT) {
        t = t * 1.8 + 32;
      }
      sensorJson["temperature_uncorrected"] = t;
      sensorJson["temperature"] = correctT(t);
      sensorJson["temperature_current"] = current;

      char tunit[32];
      snprintf(tunit, 32, (configuration.tempUnit == TEMP_UNIT_CELSIUS ? "Celsius" : (configuration.tempUnit == TEMP_UNIT_FAHRENHEIT ? "Fahrenheit" : "" )));
      sensorJson["temperature_unit"] = tunit;
    }

    float h = sensorProvider->getHumidity(&current);
    if (current) {
      sensorJson["humidity_uncorrected"] = h;
      sensorJson["humidity"] = correctH(h);
      sensorJson["humidit_unit"] = "percent";
      sensorJson["humidity_current"] = current;
    }

    float p = sensorProvider->getBaroPressure(&current);
    if (current && p > 0) {
      sensorJson["pressure_pa"] = p;
      sensorJson["pressure_hpa"] = p / 100.0f;
      sensorJson["pressure_unit"] = "hPa";
    }

    float gas = sensorProvider->getGasResistance(&current);
    if (current && gas > 0) {
      sensorJson["gas_resistance_ohms"] = gas;
      sensorJson["gas_resistance_unit"] = "Ohm";
    }

    float iaq = sensorProvider->getIAQ(&current);
    if (current) {
      sensorJson["iaq"] = iaq;
      sensorJson["iaq_rating"] = sensorProvider->getIAQRating();
      sensorJson["iaq_accuracy"] = sensorProvider->getIAQAccuracy();
      sensorJson["iaq_accuracy_text"] = sensorProvider->getIAQAccuracyText();
    }
  }
#endif
#ifdef VOLTAGE_SENSOR
  if (configuration.voltageDivider > 0) {
    sensorJson["voltage_v"] = sensorProvider->getVoltage(NULL);
    sensorJson["adc_raw"] = sensorProvider->getVoltageADC(NULL);
  }
#endif
#ifdef RADIO_RF24
  sensorJson["rf24_channel"] = configuration.rf24_channel;
  sensorJson["rf24_data_rate"] = configuration.rf24_data_rate;
  sensorJson["rf24_pa_level"] = configuration.rf24_pa_level;
  sensorJson["rf24_pipe_suffix"] = configuration.rf24_pipe_suffix;
  sensorJson["rf_msq_queue_size"] = messageQueue->getQueue()->size();
#endif

  JsonDocument cfg = sensorProvider->getDeviceSettings();
  sensorJson["config_topic"] = mqttSubcribeTopicConfig;
  sensorJson["config"] = cfg;

  return true;
}

bool CWifiManager::isApMode() { 

#if defined(ESP32)
  return WiFi.getMode() == WIFI_AP || WiFi.getMode() == WIFI_MODE_APSTA; 
#elif defined(ESP8266)
  return WiFi.getMode() == WIFI_AP || WiFi.getMode() == WIFI_AP_STA; 
#endif

}

void CWifiManager::mqttCallback(char *topic, uint8_t *payload, unsigned int length) {

  if (length == 0) {
    return;
  }

  Log.verboseln("Received %u bytes message on MQTT topic '%s'", length, topic);
  if (!strcmp(topic, mqttSubcribeTopicConfig)) {
    DeserializationError de = deserializeJson(configJson, (const byte*)payload, length);
    if (de) {
      Log.errorln("Failed to deserialize MQTT json: %s", de.c_str());
      return;
    }

    String jsonStr;
    serializeJson(configJson, jsonStr);
    Log.noticeln("Received configuration over MQTT with json: '%s'", jsonStr.c_str());

    // Delete the config message in case it was retained
    mqtt.publish(mqttSubcribeTopicConfig, NULL, 0, true);
    Log.noticeln("Deleted config message");

    if (!configJson["firmware_location"].isNull()) {
      performOTAUpdate(configJson["firmware_location"].as<String>());
      return;
    }

    updateConfigFromJson(configJson);

    EEPROM_saveConfig();
    postedSensorUpdate = postSensorUpdate();
  }
  
}

void CWifiManager::printHTMLTop(Print *p) {
  int sec = millis() / 1000;
  int min = sec / 60;
  int hr = min / 60;

  char mqttStat[255];
  if (mqtt.state() == MQTT_CONNECTED) {
    snprintf_P(mqttStat, 255, PSTR("✅"));
  } else {
    snprintf_P(mqttStat, 255, PSTR("<a href='mqtt_reconnect'>❌<sup>%i</sup></a>"), mqtt.state());
  }

  p->printf_P(htmlTop, 
    configuration.name, 
    isApMode() ? softAP_SSID : SSID, dBmtoPercentage(WiFi.RSSI()),
    mqttStat, hr, min % 60, sec % 60,
    configuration.name
  );
}

void CWifiManager::printHTMLBottom(Print *p) {
  JsonDocument ac = sensorProvider->getDeviceSettings();
  String jsonStr;
  serializeJson(ac, jsonStr);
  //Log.verboseln("hpSettings: '%s'", jsonStr.c_str());
  p->printf_P(htmlBottom, VERSION, jsonStr.c_str());
}

// Name plus the pin or I2C address the sensor actually sits on, so the Sensor page
// reflects the wiring rather than just the configured type
void CWifiManager::printEnvSensorLabel(char *buf, size_t len) {
#ifdef TEMP_SENSOR
  const char *state = sensorProvider->isSensorReady() ? "✅" : "❌";
  switch (configuration.tempSensor) {
    case TEMP_SENSOR_DS18B20:
      snprintf_P(buf, len, PSTR("DS18B20 <small>(1-Wire GPIO%d)</small> %s"), (int)TEMP_SENSOR_PIN, state);
      break;
    case TEMP_SENSOR_BME280:
      snprintf_P(buf, len, PSTR("BME280 <small>(I2C 0x%02X)</small> %s"),
        sensorProvider->getTempSensorAddress(), state);
      break;
    case TEMP_SENSOR_DHT22:
      snprintf_P(buf, len, PSTR("DHT22 <small>(GPIO%d)</small> %s"), (int)TEMP_SENSOR_PIN, state);
      break;
    case TEMP_SENSOR_AHT20:
      snprintf_P(buf, len, PSTR("AHT20 <small>(I2C 0x%02X)</small> %s"),
        sensorProvider->getTempSensorAddress(), state);
      break;
    case TEMP_SENSOR_BME688:
      snprintf_P(buf, len, PSTR("%s <small>(I2C 0x%02X)</small> %s"),
        sensorProvider->getTempSensorName(), sensorProvider->getTempSensorAddress(), state);
      break;
    default:
      snprintf_P(buf, len, PSTR("none <small>(no sensor selected)</small>"));
      break;
  }
#else
  snprintf_P(buf, len, PSTR("none"));
#endif
}

void CWifiManager::printPowerSensorLabel(char *buf, size_t len) {
  buf[0] = 0;
#ifdef CURRENT_SENSOR
  if (sensorProvider->isCurrentSensorReady()) {
    snprintf_P(buf, len, PSTR(
      "<label>Detected <kbd>INA219 <small>(I2C 0x%02X)</small> ✅</kbd></label>"
      "<label>Reading <kbd>%0.3f V</kbd> / <kbd>%0.1f mA</kbd> / <kbd>%0.1f mW</kbd></label>"
      "<br/>"),
      INA219_I2C_ID,
      sensorProvider->getLoadVoltage(NULL),
      sensorProvider->getLoadCurrent(NULL),
      sensorProvider->getLoadPower(NULL));
  } else {
    snprintf_P(buf, len, PSTR(
      "<label>Detected <kbd>INA219 <small>(I2C 0x%02X)</small> ❌ not found</kbd></label>"
      "<br/>"), INA219_I2C_ID);
  }
#endif
}

void CWifiManager::printHTMLMain(Print *p) {

  char climate[1536] = "";
#ifdef TEMP_SENSOR
  {
    size_t len = 0;
    bool fresh = false;
    float pressure = sensorProvider->getBaroPressure(&fresh);
    if (fresh && pressure > 0) {
      len += snprintf_P(climate, sizeof(climate), htmlMainPressure, pressure / 100.0f);
    }
    float iaq = sensorProvider->getIAQ(&fresh);
    if (fresh && len < sizeof(climate)) {
      len += snprintf_P(climate + len, sizeof(climate) - len, htmlMainIAQ,
        iaq, sensorProvider->getIAQRating(), sensorProvider->getIAQAccuracyText());
    }
    float gas = sensorProvider->getGasResistance(&fresh);
    if (fresh && gas > 0 && len < sizeof(climate)) {
      snprintf_P(climate + len, sizeof(climate) - len, htmlMainGas, gas / 1000.0f);
    }
  }
#endif

  char power[512] = "";
#ifdef CURRENT_SENSOR
  if (sensorProvider->isCurrentSensorReady()) {
    snprintf_P(power, sizeof(power), htmlMainPower,
      sensorProvider->getLoadVoltage(NULL),
      sensorProvider->getLoadCurrent(NULL),
      sensorProvider->getLoadPower(NULL));
  }
#endif

#ifdef TEMP_SENSOR
  float t = sensorProvider->getTemperature(NULL);
  float h = sensorProvider->getHumidity(NULL);

  t = configuration.tempUnit == TEMP_UNIT_CELSIUS ? t : t * 1.8 + 32;
  t = correctT(t);
  h = correctH(h);

  p->printf_P(htmlMain, t, configuration.tempUnit == TEMP_UNIT_CELSIUS ? "C" : "F", h, climate, power);
#else
  p->printf_P(htmlMain, 0, "", 0, climate, power);
#endif
}

void CWifiManager::publishHADiscovery() {
  char discoveryTopic[255];
  char stateTopic[255];
  uint32_t deviceId = CONFIG_getDeviceId();
  snprintf(stateTopic, sizeof(stateTopic), "%s/json", configuration.mqttTopic);

  auto publishDoc = [&](JsonDocument &doc) {
    mqtt.beginPublish(discoveryTopic, measureJson(doc), true);
    BufferingPrint bufferedClient(mqtt, 32);
    serializeJson(doc, bufferedClient);
    bufferedClient.flush();
    mqtt.endPublish();
    Log.noticeln("Published HA discovery to '%s'", discoveryTopic);
  };

  auto addDevice = [&](JsonDocument &doc) {
    JsonObject device = doc["device"].to<JsonObject>();
    device["identifiers"][0] = String(deviceId);
    device["name"] = configuration.name;
    device["model"] = DEVICE_NAME;
    device["manufacturer"] = "Custom";
  };

#ifdef TEMP_SENSOR
  // Temperature
  snprintf(discoveryTopic, sizeof(discoveryTopic), "homeassistant/sensor/%u_temperature/config", deviceId);
  {
    JsonDocument doc;
    doc["name"] = String(configuration.name) + " Temperature";
    doc["unique_id"] = String(deviceId) + "_temperature";
    doc["device_class"] = "temperature";
    doc["state_topic"] = stateTopic;
    doc["value_template"] = "{{ value_json.temperature }}";
    doc["unit_of_measurement"] = (configuration.tempUnit == TEMP_UNIT_FAHRENHEIT) ? "°F" : "°C";
    addDevice(doc);
    publishDoc(doc);
  }

  // Humidity
  snprintf(discoveryTopic, sizeof(discoveryTopic), "homeassistant/sensor/%u_humidity/config", deviceId);
  {
    JsonDocument doc;
    doc["name"] = String(configuration.name) + " Humidity";
    doc["unique_id"] = String(deviceId) + "_humidity";
    doc["device_class"] = "humidity";
    doc["state_topic"] = stateTopic;
    doc["value_template"] = "{{ value_json.humidity }}";
    doc["unit_of_measurement"] = "%";
    addDevice(doc);
    publishDoc(doc);
  }

  // Pressure, reported by the BME280 and BME688 only
  {
    bool hasPressure = false;
    sensorProvider->getBaroPressure(&hasPressure);
    if (hasPressure && sensorProvider->getBaroPressure(NULL) > 0) {
      snprintf(discoveryTopic, sizeof(discoveryTopic), "homeassistant/sensor/%u_pressure/config", deviceId);
      JsonDocument doc;
      doc["name"] = String(configuration.name) + " Pressure";
      doc["unique_id"] = String(deviceId) + "_pressure";
      doc["device_class"] = "atmospheric_pressure";
      doc["state_class"] = "measurement";
      doc["state_topic"] = stateTopic;
      doc["value_template"] = "{{ value_json.pressure_hpa }}";
      doc["unit_of_measurement"] = "hPa";
      addDevice(doc);
      publishDoc(doc);
    }
  }

  // Gas resistance, reported by the BME688 only. Home Assistant has no device class for a
  // raw resistance, so it is published as a plain measurement.
  {
    bool hasGas = false;
    sensorProvider->getGasResistance(&hasGas);
    if (hasGas) {
      snprintf(discoveryTopic, sizeof(discoveryTopic), "homeassistant/sensor/%u_gas_resistance/config", deviceId);
      JsonDocument doc;
      doc["name"] = String(configuration.name) + " Gas Resistance";
      doc["unique_id"] = String(deviceId) + "_gas_resistance";
      doc["state_class"] = "measurement";
      doc["state_topic"] = stateTopic;
      doc["value_template"] = "{{ value_json.gas_resistance_ohms }}";
      doc["unit_of_measurement"] = "Ω";
      doc["icon"] = "mdi:gas-cylinder";
      addDevice(doc);
      publishDoc(doc);
    }
  }

  // Estimated IAQ, BME688 only
  {
    bool hasIAQ = false;
    sensorProvider->getIAQ(&hasIAQ);
    if (hasIAQ) {
      snprintf(discoveryTopic, sizeof(discoveryTopic), "homeassistant/sensor/%u_iaq/config", deviceId);
      {
        JsonDocument doc;
        doc["name"] = String(configuration.name) + " Air Quality";
        doc["unique_id"] = String(deviceId) + "_iaq";
        doc["device_class"] = "aqi";
        doc["state_class"] = "measurement";
        doc["state_topic"] = stateTopic;
        doc["value_template"] = "{{ value_json.iaq }}";
        doc["json_attributes_topic"] = stateTopic;
        doc["json_attributes_template"] =
          "{{ {'rating': value_json.iaq_rating, 'accuracy': value_json.iaq_accuracy_text} | tojson }}";
        addDevice(doc);
        publishDoc(doc);
      }

      // Whether the baseline has settled enough to trust the number above
      snprintf(discoveryTopic, sizeof(discoveryTopic), "homeassistant/sensor/%u_iaq_accuracy/config", deviceId);
      {
        JsonDocument doc;
        doc["name"] = String(configuration.name) + " Air Quality Accuracy";
        doc["unique_id"] = String(deviceId) + "_iaq_accuracy";
        doc["entity_category"] = "diagnostic";
        doc["state_topic"] = stateTopic;
        doc["value_template"] = "{{ value_json.iaq_accuracy }}";
        doc["icon"] = "mdi:progress-check";
        addDevice(doc);
        publishDoc(doc);
      }
    }
  }
#endif

#ifdef VOLTAGE_SENSOR
  // Voltage
  snprintf(discoveryTopic, sizeof(discoveryTopic), "homeassistant/sensor/%u_voltage/config", deviceId);
  {
    JsonDocument doc;
    doc["name"] = String(configuration.name) + " Voltage";
    doc["unique_id"] = String(deviceId) + "_voltage";
    doc["device_class"] = "voltage";
    doc["state_topic"] = stateTopic;
    doc["value_template"] = "{{ value_json.voltage_v }}";
    doc["unit_of_measurement"] = "V";
    addDevice(doc);
    publishDoc(doc);
  }
#endif

#ifdef CURRENT_SENSOR
  if (sensorProvider->isCurrentSensorReady()) {
    // INA219 voltage
    snprintf(discoveryTopic, sizeof(discoveryTopic), "homeassistant/sensor/%u_ina219_voltage/config", deviceId);
    {
      JsonDocument doc;
      doc["name"] = String(configuration.name) + " INA219 Voltage";
      doc["unique_id"] = String(deviceId) + "_ina219_voltage";
      doc["device_class"] = "voltage";
      doc["state_topic"] = stateTopic;
      doc["value_template"] = "{{ value_json.ina219_voltage_v }}";
      doc["unit_of_measurement"] = "V";
      addDevice(doc);
      publishDoc(doc);
    }

    // INA219 current
    snprintf(discoveryTopic, sizeof(discoveryTopic), "homeassistant/sensor/%u_ina219_current/config", deviceId);
    {
      JsonDocument doc;
      doc["name"] = String(configuration.name) + " INA219 Current";
      doc["unique_id"] = String(deviceId) + "_ina219_current";
      doc["device_class"] = "current";
      doc["state_topic"] = stateTopic;
      doc["value_template"] = "{{ value_json.ina219_current_ma }}";
      doc["unit_of_measurement"] = "mA";
      addDevice(doc);
      publishDoc(doc);
    }

    // INA219 power
    snprintf(discoveryTopic, sizeof(discoveryTopic), "homeassistant/sensor/%u_ina219_power/config", deviceId);
    {
      JsonDocument doc;
      doc["name"] = String(configuration.name) + " INA219 Power";
      doc["unique_id"] = String(deviceId) + "_ina219_power";
      doc["device_class"] = "power";
      doc["state_topic"] = stateTopic;
      doc["value_template"] = "{{ value_json.ina219_power_mw }}";
      doc["unit_of_measurement"] = "mW";
      addDevice(doc);
      publishDoc(doc);
    }
  }
#endif
}

void CWifiManager::performOTAUpdate(const String& url) {
  String firmwareUrl = url;

#if defined(CONFIG_IDF_TARGET_ESP32C3)
  firmwareUrl.replace("_device_", "ESP32C3");
#elif defined(CONFIG_IDF_TARGET_ESP32S3)
  firmwareUrl.replace("_device_", "ESP32S3");
#elif defined(ESP32)
  firmwareUrl.replace("_device_", "ESP32");
#elif defined(ESP8266)
  firmwareUrl.replace("_device_", "ESP8266");
#endif

  Log.noticeln("Starting OTA update from: '%s'", firmwareUrl.c_str());

#if defined(ESP32)
  WiFiClient updateClient;
  t_httpUpdate_return ret = httpUpdate.update(updateClient, firmwareUrl);
  switch (ret) {
    case HTTP_UPDATE_FAILED:
      Log.errorln("OTA failed (%i): %s", httpUpdate.getLastError(), httpUpdate.getLastErrorString().c_str());
      break;
    case HTTP_UPDATE_NO_UPDATES:
      Log.noticeln("OTA: no update available");
      break;
    case HTTP_UPDATE_OK:
      Log.noticeln("OTA succeeded, rebooting...");
      break;
  }
#elif defined(ESP8266)
  WiFiClient updateClient;
  t_httpUpdate_return ret = ESPhttpUpdate.update(updateClient, firmwareUrl);
  switch (ret) {
    case HTTP_UPDATE_FAILED:
      Log.errorln("OTA failed (%i): %s", ESPhttpUpdate.getLastError(), ESPhttpUpdate.getLastErrorString().c_str());
      break;
    case HTTP_UPDATE_NO_UPDATES:
      Log.noticeln("OTA: no update available");
      break;
    case HTTP_UPDATE_OK:
      Log.noticeln("OTA succeeded, rebooting...");
      break;
  }
#endif
}

bool CWifiManager::ensureMQTTConnected() {
  if (!mqtt.connected() || mqtt.state() != MQTT_CONNECTED) {
    if (strlen(configuration.mqttServer) && strlen(configuration.mqttTopic)) { // Reconnectable
      Log.noticeln("Attempting to reconnect from MQTT state %i at '%s:%i' ...", mqtt.state(), configuration.mqttServer, configuration.mqttPort);
      if (mqtt.connect(String(CONFIG_getDeviceId()).c_str())) {
        Log.noticeln("MQTT reconnected");
        sprintf_P(mqttSubcribeTopicConfig, "%s/%u/config", configuration.mqttTopic, CONFIG_getDeviceId());
        bool r = mqtt.subscribe(mqttSubcribeTopicConfig);
        Log.noticeln("Subscribed for config changes to MQTT topic '%s' success = %T", mqttSubcribeTopicConfig, r);
      } else {
        Log.warningln("MQTT reconnect failed, rc=%i", mqtt.state());
      }
    }
    if (!mqtt.connected() || mqtt.state() != MQTT_CONNECTED) {
      Log.noticeln("MQTT not connected %i", mqtt.state());
      return false;
    }
  }
  return true;
}

bool CWifiManager::updateConfigFromJson(JsonDocument jsonObj) {

  if (!jsonObj["name"].isNull()) {
    Log.traceln("Setting 'name' to %s", jsonObj["name"].as<const char*>());
    strncpy(configuration.name, jsonObj["name"].as<const char*>(), 128);
  }

  if (!jsonObj["mqttTopic"].isNull()) {
    Log.traceln("Setting 'mqttTopic' to %s", jsonObj["mqttTopic"].as<const char*>());
    strncpy(configuration.mqttTopic, jsonObj["mqttTopic"].as<const char*>(), 64);
  }

  if (!jsonObj["deepSleepDurationSec"].isNull()) {
    Log.traceln("Setting 'deepSleepDurationSec' to %s", jsonObj["deepSleepDurationSec"].as<unsigned short>());
    configuration.deepSleepDurationSec = jsonObj["deepSleepDurationSec"].as<unsigned short>();
  }

  if (!jsonObj["ledEnabled"].isNull()) {
    Log.traceln("Setting 'ledEnabled' to %s", jsonObj["ledEnabled"].as<bool>() ? "true" : "false");
    configuration.ledEnabled = jsonObj["ledEnabled"].as<bool>();
  }

  #ifdef TEMP_SENSOR
  if (!jsonObj["tempUnit"].isNull()) {
    Log.traceln("Setting 'tempUnit' to %s", jsonObj["tempUnit"].as<unsigned char>());
    configuration.tempUnit = jsonObj["tempUnit"].as<unsigned char>();
  }
  #endif

  return true;
}
