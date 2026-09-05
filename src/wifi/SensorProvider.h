#pragma once

#include "Configuration.h"
#include <ArduinoJson.h>

class ISensorProvider {
public:
  virtual float getTemperature(bool *current) { if (current != NULL) { *current = false; } return 0; };
  virtual float getHumidity(bool *current) { if (current != NULL) { *current = false; } return 0; };
  virtual float getBaroPressure(bool *current) { if (current != NULL) { *current = false; } return 0; };
  virtual float getVoltage(bool *current) { if (current != NULL) { *current = false; } return 0; };
  virtual uid_t getVoltageADC(bool *current) { if (current != NULL) { *current = false; } return 0; };
  virtual float getLoadVoltage(bool *current) { if (current != NULL) { *current = false; } return 0; };
  virtual float getLoadCurrent(bool *current) { if (current != NULL) { *current = false; } return 0; };
  virtual float getLoadPower(bool *current) { if (current != NULL) { *current = false; } return 0; };
  virtual bool isCurrentSensorReady() { return false; };
  virtual uint8_t getTempSensorAddress() { return 0; };
  virtual const char* getTempSensorName() { return "none"; };
  virtual float getGasResistance(bool *current) { if (current != NULL) { *current = false; } return 0; };
  virtual float getIAQ(bool *current) { if (current != NULL) { *current = false; } return 0; };
  virtual uint8_t getIAQAccuracy() { return 0; };
  virtual const char* getIAQRating() { return ""; };
  virtual const char* getIAQAccuracyText() { return ""; };
  virtual float getIAQBaseline() { return 0; };
  virtual float getIAQCompensatedGas() { return 0; };
  virtual uint32_t getIAQTrackedSeconds() { return 0; };
  virtual uint8_t getIAQHistoryCount() { return 0; };
  virtual bool getIAQHistorySample(uint8_t i, float *iaq, float *baseline) { return false; };
  virtual uint32_t getDeviceId() { return CONFIG_getDeviceId(); };
  virtual uint32_t getUptime() { return CONFIG_getUpTime(); };
  virtual bool isSensorReady() { return false; };
  virtual JsonDocument& getDeviceSettings();
  virtual bool setDeviceSettings(JsonDocument ac);
};
