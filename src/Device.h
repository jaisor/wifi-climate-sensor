#pragma once

#include <functional>
#include <deque>
#include "Configuration.h"
#include "wifi/SensorProvider.h"

#include <OneWire.h>
#include <DS18B20.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_BME280.h>
#include <Adafruit_BME680.h>
#include <DHT.h>
#include <DHT_U.h>
#include <Adafruit_AHTX0.h>

#ifdef CURRENT_SENSOR
  #include <Adafruit_INA219.h>
#endif

#ifdef OLED
  #include <Adafruit_SSD1306.h>
  #include <Adafruit_GFX.h>
#endif


#define STALE_READING_AGE_MS 10000 // 10 sec

class CDevice: public ISensorProvider {

public:
	CDevice();
  ~CDevice();
  void loop();

  #ifdef TEMP_SENSOR_AUTODETECT
  tempSensorType detectI2CTempSensor();
  #endif

  virtual bool isSensorReady() { return sensorReady; };
  
  #ifdef TEMP_SENSOR
  virtual float getTemperature(bool *current);
  virtual float getHumidity(bool *current);
  virtual float getBaroPressure(bool *current);
  virtual float getGasResistance(bool *current);
  #endif
  virtual float getVoltage(bool *current);
  virtual uint16_t getVoltageADC(bool *current);

  #ifdef CURRENT_SENSOR
  virtual bool isCurrentSensorReady() { return currentSensorReady; };
  virtual float getLoadVoltage(bool *current);
  virtual float getLoadCurrent(bool *current);
  virtual float getLoadPower(bool *current);
  #endif

  #ifdef OLED
  Adafruit_SSD1306* display() const { return _display; };
  Adafruit_SSD1306 *_display;
  #endif

  virtual uint8_t getTempSensorAddress() { return tempSensorAddress; };
  virtual const char* getTempSensorName();

  virtual JsonDocument& getDeviceSettings();
  virtual bool setDeviceSettings(JsonDocument ac);

private:
  bool i2cReady;
  unsigned long tMillisUp;

  unsigned long tMillisTemp;
  unsigned long tLastReading;
  bool sensorReady;

  JsonDocument jsonDeviceSettings;
  
  float temperature, humidity, baro_pressure;

  // TEMP_SENSOR_DS18B20
  OneWire *oneWire;
  DS18B20 *ds18b20;
  //TEMP_SENSOR_BME280
  Adafruit_BME280 *bme280;
  uint8_t tempSensorAddress; // I2C address the climate sensor answered on, 0 for the 1-Wire/digital ones
  // TEMP_SENSOR_BME688
  Adafruit_BME680 *bme688;
  uint8_t bme68xVariant;        // BME68X_VARIANT_BME688 or 0x00 for the BME680
  uint32_t bme688ReadingReadyAt; // 0 when no forced-mode reading is in flight
  float gas_resistance;
  // TEMP_SENSOR_DHT
  DHT_Unified *dht;
  // TEMP_SENSOR_AHT
  Adafruit_AHTX0 *aht;

  #ifdef CURRENT_SENSOR
  Adafruit_INA219 *ina219;
  bool currentSensorReady;
  unsigned long tMillisCurrent, tLastCurrentReading;
  float loadVoltage, loadCurrent_mA, loadPower_mW;
  #endif

  unsigned long minDelayMs;
  #ifdef VOLTAGE_SENSOR
  std::deque<uint16_t> voltageValues = {};
  uint8_t voltageSamples = 0;
  uint16_t voltageAvg = 0;
  unsigned long voltageSensorDelay = 0;
  #endif
};
