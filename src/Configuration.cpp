#include <Arduino.h>
#include <EEPROM.h>
#include <version.h>
#include "Configuration.h"

configuration_t configuration;
#ifdef WEB_LOGGING
  StringPrint logStream;
#endif

uint8_t EEPROM_initAndCheckFactoryReset() {
  Log.noticeln("Configuration size: %i", sizeof(configuration_t));
  
  EEPROM.begin(sizeof(configuration_t) + EEPROM_FACTORY_RESET + 1);
  uint8_t resetCounter = EEPROM.read(EEPROM_FACTORY_RESET);

  Log.noticeln("Factory reset counter: %i", resetCounter);
  Log.noticeln("EEPROM length: %i", EEPROM.length());

  // Bump reset counter
  EEPROM.write(EEPROM_FACTORY_RESET, resetCounter + 1);
  EEPROM.commit();

  return resetCounter;
}

void EEPROM_clearFactoryReset() {
  EEPROM.write(EEPROM_FACTORY_RESET, 0);
  EEPROM.commit();
}

void EEPROM_saveConfig() {
  portMUX_TYPE mx = portMUX_INITIALIZER_UNLOCKED;
  taskENTER_CRITICAL(&mx);
  
  Log.infoln("Saving configuration to EEPROM");
  EEPROM.put(EEPROM_CONFIGURATION_START, configuration);
  Log.verboseln("Committing EEPROM");
  EEPROM.commit();

  taskEXIT_CRITICAL(&mx);
}

void EEPROM_loadConfig() {

  configuration = {};
  EEPROM.get(EEPROM_CONFIGURATION_START, configuration);

  Log.noticeln("Configuration loaded: %s", configuration._loaded);

  //strcpy(configuration.wifiSsid, "");
  //strcpy(configuration.wifiPassword, "");

  if (strcmp(configuration._loaded, "jaisor")) {
    // blank
    Log.infoln("Blank configuration, loading defaults");
    strcpy(configuration._loaded, "jaisor");
    strcpy(configuration.name, DEVICE_NAME);
    configuration.ledEnabled = true;
    #ifdef WIFI
      strcpy(configuration.ntpServer, NTP_SERVER);
      configuration.gmtOffset_sec = NTP_GMT_OFFSET_SEC;
      configuration.daylightOffset_sec = NTP_DAYLIGHT_OFFSET_SEC;
      strcpy(configuration.mqttServer, "");
      configuration.mqttPort = 1883;
      strcpy(configuration.mqttTopic, "");
    #endif

    #ifdef VOLTAGE_SENSOR
      configuration.voltageDivider = VOLTAGE_DIVIDER_VALUE;
    #endif
    #ifdef TEMP_SENSOR
      configuration.tempSensor = TEMP_SENSOR_UNSUPPORTED;
      configuration.tempUnit = TEMP_UNIT_FAHRENHEIT;
      memset(configuration.tCorrection, 0, 2 * sizeof(sensorCorrection));
      memset(configuration.hCorrection, 0, 2 * sizeof(sensorCorrection));
    #endif

    configuration.deepSleepDurationSec = 0;

    EEPROM_saveConfig();
  }

#ifdef WIFI
  String wifiStr = String(configuration.wifiSsid);
  for (auto i : wifiStr) {
    if (!isAscii(i)) {
      Log.verboseln("Bad SSID, loading default: %s", wifiStr.c_str());
      strcpy(configuration.wifiSsid, "");
      break;
    }
  }
#endif

  Log.noticeln("Device name: %s", configuration.name);
  Log.noticeln("Version: %s", VERSION);
}

void EEPROM_wipe() {
  Log.warningln("Wiping configuration with size %i!", EEPROM.length());
  for (uint16_t i = 0; i < EEPROM.length() ; i++) {
    EEPROM.write(i, 0);
  }
  EEPROM.commit();
}

uint32_t CONFIG_getDeviceId() {
    // Create AP using fallback and chip ID
  uint32_t chipId = 0;
  #ifdef ESP32
    for(int i=0; i<17; i=i+8) {
    chipId |= ((ESP.getEfuseMac() >> (40 - i)) & 0xff) << i;
    }
  #elif ESP8266
    chipId = ESP.getChipId();
  #endif

  return chipId;
}

static unsigned long tMillisUp = millis();
unsigned long CONFIG_getUpTime() {  
  return millis() - tMillisUp;
}

static bool isIntLEDOn = false;
void intLEDOn() {
  if (configuration.ledEnabled) {
    #if (defined(SEEED_XIAO_M0) || defined(ESP8266))
      digitalWrite(INTERNAL_LED_PIN, LOW);
    #else
      digitalWrite(INTERNAL_LED_PIN, HIGH);
    #endif
    isIntLEDOn = true;
  }
}

void intLEDOff() {
  #if (defined(SEEED_XIAO_M0) || defined(ESP8266))
    digitalWrite(INTERNAL_LED_PIN, HIGH);
  #else
    digitalWrite(INTERNAL_LED_PIN, LOW);
  #endif
  isIntLEDOn = false;
}

void intLEDBlink(uint16_t ms) {
  if (isIntLEDOn) { intLEDOff(); } else { intLEDOn(); }
  delay(ms);
  if (isIntLEDOn) { intLEDOff(); } else { intLEDOn(); }
}

#if defined(TEMP_SENSOR)
  float _correct(sensorCorrection c[], float measured) {
    if (c[0].measured + c[0].actual + c[1].measured + c[1].actual == 0) {
      return measured;
    }
    float a = (c[1].actual-c[0].actual) / (c[1].measured-c[0].measured);
    float b = c[0].actual - a * c[0].measured;
    return a * measured + b;
  }

  float correctT(float measured) {
    return _correct(configuration.tCorrection, measured);
  }

  float correctH(float measured) {
    return _correct(configuration.hCorrection, measured);
  }
#endif