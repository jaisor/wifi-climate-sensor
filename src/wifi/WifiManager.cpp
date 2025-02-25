#if !( defined(ESP32) ) && !( defined(ESP8266) )
  #error This code is intended to run on ESP8266 or ESP32 platform!
#endif

#include <Arduino.h>
#include <WiFiClient.h>
#include <Time.h>
#include <ezTime.h>
#include <ElegantOTA.h>
#include <StreamUtils.h>
#include <AsyncJson.h>
#include <Version.h>
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
  sensorJson["build_number"] = BUILD_NUMBER;
  sensorJson["deepSleepDurationSec"] = configuration.deepSleepDurationSec;
  #ifdef VOLTAGE_SENSOR
  sensorJson["voltageDivider"] = configuration.voltageDivider;
  #endif

  strcpy(SSID, configuration.wifiSsid);
  server = new AsyncWebServer(WEB_SERVER_PORT);
  mqtt.setClient(espClient);
  connect();
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
    Log.infoln("Connecting to WiFi: '%s'", SSID);
    WiFi.begin(SSID, configuration.wifiPassword);
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
  server->on("/", std::bind(&CWifiManager::handleRoot, this, std::placeholders::_1));
  server->on("/style.css", HTTP_GET, std::bind(&CWifiManager::handleStyleCSS, this, std::placeholders::_1));
  server->on("/favicon.ico", HTTP_GET, [](AsyncWebServerRequest *request){ request->send(404); });
  //
  server->on("/wifi", HTTP_GET | HTTP_POST, std::bind(&CWifiManager::handleWifi, this, std::placeholders::_1));
#ifdef TEMP_SENSOR
  server->on("/sensor", HTTP_GET | HTTP_POST, std::bind(&CWifiManager::handleSensor, this, std::placeholders::_1));
#endif
  server->on("/device", HTTP_GET | HTTP_POST, std::bind(&CWifiManager::handleDevice, this, std::placeholders::_1));
  //
  server->on("/factory_reset", HTTP_POST, std::bind(&CWifiManager::handleFactoryReset, this, std::placeholders::_1));
  server->on("/reboot", HTTP_POST, std::bind(&CWifiManager::handleReboot, this, std::placeholders::_1));
  server->on("/mqtt_reconnect", HTTP_POST, std::bind(&CWifiManager::handleFixMQTT, this, std::placeholders::_1));
#ifdef WEB_LOGGING
  server->on("/log", HTTP_GET, [](AsyncWebServerRequest *request){ 
    Log.traceln("handleLog");
    intLEDOn();
    AsyncResponseStream *response = request->beginResponseStream("text/plain; charset=UTF-8");
    response->println(logStream.str().c_str());
    request->send(response);
    intLEDOff();
  });
#endif
  server->on("/api", HTTP_GET, std::bind(&CWifiManager::handleRestAPI_HP, this, std::placeholders::_1));
  AsyncCallbackJsonWebHandler* handler = new AsyncCallbackJsonWebHandler("/api", [this](AsyncWebServerRequest *request, JsonVariant &json) {
    bool success = this->saveHP(json.as<JsonObject>());
    if (success) {
      handleRestAPI_HP(request);
    } else {
      AsyncResponseStream *response = request->beginResponseStream("text/plain; charset=UTF-8");
      response->print("ERROR");
      response->setCode(500);
      request->send(response);
    }
  });
  server->addHandler(handler);


  server->begin();
  Log.infoln("Web server listening on %s port %i", WiFi.localIP().toString().c_str(), WEB_SERVER_PORT);
  
  sensorJson["ip"] = WiFi.localIP().toString();

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
      if (millis() - tMillis > POST_UPDATE_INTERVAL) {
        tMillis = millis();
        postSensorUpdate();
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

  AsyncResponseStream *response = request->beginResponseStream("text/html; charset=UTF-8");
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
    
    AsyncResponseStream *response = request->beginResponseStream("text/html; charset=UTF-8");
    
    printHTMLTop(response);
    response->printf("<p>Connecting to '%s' ... see you on the other side!</p>", ssid.c_str());
    printHTMLBottom(response);

    request->send(response);

    ssid.toCharArray(configuration.wifiSsid, sizeof(configuration.wifiSsid));
    password.toCharArray(configuration.wifiPassword, sizeof(configuration.wifiPassword));

    Log.noticeln("Saved config SSID: '%s'", configuration.wifiSsid);

    EEPROM_saveConfig();

    strcpy(SSID, configuration.wifiSsid);
    WiFi.disconnect(true, true);
    tMillis = millis();
    rebootNeeded = true;
  } else {
    AsyncResponseStream *response = request->beginResponseStream("text/html; charset=UTF-8");
    printHTMLTop(response);
    response->printf_P(htmlWifi);
    printHTMLBottom(response);
    request->send(response);
  }

  intLEDOff();
}

#ifdef TEMP_SENSOR
void CWifiManager::handleSensor(AsyncWebServerRequest *request) {
  Log.traceln("handleSensor: %s", request->methodToString());
  intLEDOn();

  if (request->method() == HTTP_POST) {
    
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

    configuration.voltageDivider = atoff(request->arg("voltageDivider").c_str());
    
    EEPROM_saveConfig();
    
    request->redirect("sensor");
    tMillis = millis();
    rebootNeeded = true;

  } else {

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
      "), 
      configuration.tempSensor == TEMP_SENSOR_UNSUPPORTED ? "selected" : "", 
      configuration.tempSensor == TEMP_SENSOR_DS18B20 ? "selected" : "", 
      configuration.tempSensor == TEMP_SENSOR_BME280 ? "selected" : "", 
      configuration.tempSensor == TEMP_SENSOR_DHT22 ? "selected" : "", 
      configuration.tempSensor == TEMP_SENSOR_AHT20 ? "selected" : ""
    );

    float t = sensorProvider->getTemperature(NULL);
    if (configuration.tempUnit == TEMP_UNIT_FAHRENHEIT) {
      t = t * 1.8 + 32;
    }

    AsyncResponseStream *response = request->beginResponseStream("text/html; charset=UTF-8");
    printHTMLTop(response);
    response->printf_P(htmlSensor, tempSensor, tempUnit,
      t, (configuration.tempUnit == TEMP_UNIT_CELSIUS ? "C" : (configuration.tempUnit == TEMP_UNIT_FAHRENHEIT ? "F" : "" )),
      configuration.tCorrection[0].measured, configuration.tCorrection[0].actual,
      configuration.tCorrection[1].measured, configuration.tCorrection[1].actual,
      sensorProvider->getHumidity(NULL),
      configuration.hCorrection[0].measured, configuration.hCorrection[0].actual,
      configuration.hCorrection[1].measured, configuration.hCorrection[1].actual,
      sensorProvider->getVoltage(NULL), analogRead(VOLTAGE_SENSOR_ADC_PIN),
      configuration.voltageDivider
    );
    printHTMLBottom(response);
    request->send(response);

  }

  intLEDOff();
}
#endif

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
    AsyncResponseStream *response = request->beginResponseStream("text/html; charset=UTF-8");
    printHTMLTop(response);
    response->printf_P(htmlDevice, configuration.ledEnabled ? "checked" : "",
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
  
  AsyncResponseStream *response = request->beginResponseStream("text/plain; charset=UTF-8");
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
  
  AsyncResponseStream *response = request->beginResponseStream("text/plain; charset=UTF-8");
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
  
  JsonDocument ac = sensorProvider->getDeviceSettings();
  
  String jsonStr;
  serializeJson(ac, jsonStr);
  Log.verboseln("hpSettings: '%s'", jsonStr.c_str());

  AsyncResponseStream *response = request->beginResponseStream("application/json; charset=UTF-8");
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

  AsyncResponseStream *response = request->beginResponseStream("application/json; charset=UTF-8");
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

void CWifiManager::postSensorUpdate() {

  if (!strlen(configuration.mqttTopic)) {
    Log.warningln("Blank MQTT topic");
    return;
  }

  if (!ensureMQTTConnected()) {
    Log.errorln("Unable to post sensor update due to MQTT connection issues");
    return;
  }

  intLEDOn();

  char topic[255];
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
  sensorJson["ledEnabled"] = configuration.ledEnabled;
  sensorJson["ledEnabled_label"] = configuration.ledEnabled ? "yes" : "no";

#if defined(TEMP_SENSOR_PIN)
  bool sensorReady = sensorProvider->isSensorReady();
  
  if (sensorReady) {
    bool current;

    float t = sensorProvider->getTemperature(&current);
    if (current) {
      if (configuration.tempUnit == TEMP_UNIT_FAHRENHEIT) {
        t = t * 1.8 + 32;
      }
      sensorJson["temperature_raw"] = t;
      sensorJson["temperature"] = correctT(t);

      char tunit[32];
      snprintf(tunit, 32, (configuration.tempUnit == TEMP_UNIT_CELSIUS ? "Celsius" : (configuration.tempUnit == TEMP_UNIT_FAHRENHEIT ? "Fahrenheit" : "" )));
      sensorJson["temperature_unit"] = tunit;
    }

    float h = sensorProvider->getHumidity(&current);
    if (current) {
      sensorJson["humidity_raw"] = h;
      sensorJson["humidity"] = correctH(h);
      sensorJson["humidit_unit"] = "percent";
    }
  }
#endif
#ifdef VOLTAGE_SENSOR
  if (configuration.voltageDivider > 0) {
    sensorJson["voltage_v"] = sensorProvider->getVoltage(NULL);
    iv = analogRead(VOLTAGE_SENSOR_ADC_PIN);
    sensorJson["adc_raw"] = iv;
  }
#endif
#ifdef RADIO_RF24
  sensorJson["rf24_channel"] = configuration.rf24_channel;
  sensorJson["rf24_data_rate"] = configuration.rf24_data_rate;
  sensorJson["rf24_pa_level"] = configuration.rf24_pa_level;
  sensorJson["rf24_pipe_suffix"] = configuration.rf24_pipe_suffix;
  sensorJson["rf_msq_queue_size"] = messageQueue->getQueue()->size();
#endif

  sensorJson["device"] = sensorProvider->getDeviceSettings();

  // sensor Json
  sprintf_P(topic, "%s/json", configuration.mqttTopic);
  mqtt.beginPublish(topic, measureJson(sensorJson), false);
  BufferingPrint bufferedClient(mqtt, 32);
  serializeJson(sensorJson, bufferedClient);
  bufferedClient.flush();
  mqtt.endPublish();

  String jsonStr;
  serializeJson(sensorJson, jsonStr);
  Log.noticeln("Sent '%s' json to MQTT topic '%s'", jsonStr.c_str(), topic);

  postedSensorUpdate = true;
  intLEDOff();
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
    deserializeJson(configJson, (const byte*)payload, length);

    String jsonStr;
    serializeJson(configJson, jsonStr);
    Log.noticeln("Received configuration over MQTT with json: '%s'", jsonStr.c_str());

    if (!configJson["name"].isNull()) {
      Log.traceln("Setting 'name' to %s", configJson["name"].as<const char*>());
      strncpy(configuration.name, configJson["name"].as<const char*>(), 128);
    }

    if (!configJson["mqttTopic"].isNull()) {
      Log.traceln("Setting 'mqttTopic' to %s", configJson["mqttTopic"].as<const char*>());
      strncpy(configuration.mqttTopic, configJson["mqttTopic"].as<const char*>(), 64);
    }

    if (!configJson["deepSleepDurationSec"].isNull()) {
      uint16_t deepSleepDurationSec = configJson["deepSleepDurationSec"].as<unsigned int>();
      configuration.deepSleepDurationSec = deepSleepDurationSec;
      Log.traceln("Setting 'deepSleepDurationSec' to %u", deepSleepDurationSec);
    }

    // Delete the config message in case it was retained
    mqtt.publish(mqttSubcribeTopicConfig, NULL, 0, true);
    Log.noticeln("Deleted config message");

    EEPROM_saveConfig();
    postSensorUpdate();
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

void CWifiManager::printHTMLMain(Print *p) {

#ifdef TEMP_SENSOR
  float t = sensorProvider->getTemperature(NULL);
  float h = sensorProvider->getHumidity(NULL);

  t = configuration.tempUnit == TEMP_UNIT_CELSIUS ? t : t * 1.8 + 32;
  t = correctT(t);
  h = correctH(h);

  p->printf_P(htmlMain, t, configuration.tempUnit == TEMP_UNIT_CELSIUS ? "C" : "F", h);
#else
  p->printf_P(htmlMain, 0, "", 0);
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

bool CWifiManager::saveHP(JsonObject jsonObj) {
  /*
  JsonDocument ac = sensorProvider->getDeviceSettings();

    if (jsonObj.containsKey("power")) { ac["power"] = jsonObj["power"]; }
    if (jsonObj.containsKey("mode")) { ac["mode"] = jsonObj["mode"]; }
    
    if (jsonObj.containsKey("temperature")) {
      int tu = jsonObj["temperature"];
      ac["temperature"] = roundf(configuration.tempUnit == TEMP_UNIT_CELSIUS ? tu : (((float)tu - 32.0) / 1.8));
    }

    if (jsonObj.containsKey("fan")) { ac["fan"] = jsonObj["fan"]; }
    if (jsonObj.containsKey("vane")) { ac["vane"] = jsonObj["vane"]; }
    if (jsonObj.containsKey("wideVane")) { ac["wideVane"] = jsonObj["wideVane"]; }
    
    String jsonStr;
    serializeJson(ac, jsonStr);
    Log.verboseln("new hpSettings: '%s'", jsonStr.c_str());
    
    return sensorProvider->setDeviceSettings(ac);
    */
   return false;
}

bool CWifiManager::saveDevice(JsonObject jsonObj) {
  return true;
}