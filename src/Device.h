#pragma once

#include <functional>
#include "Configuration.h"
#include "wifi/SensorProvider.h"

#ifdef TEMP_SENSOR_DS18B20
  #include <OneWire.h>
  #include <DS18B20.h>
#endif
#ifdef TEMP_SENSOR_BME280
  #include <Adafruit_Sensor.h>
  #include <Adafruit_BME280.h>
#endif
#ifdef TEMP_SENSOR_DHT
  #include <DHT.h>
  #include <DHT_U.h>
#endif

#define STALE_READING_AGE_MS 10000 // 10 sec

class CDevice: public ISensorProvider {

public:
	CDevice();
  ~CDevice();
  void loop();

  virtual bool isSensorReady() { return sensorReady; };

  virtual float getTemperature(bool *current);
#if defined(TEMP_SENSOR_BME280) || defined(TEMP_SENSOR_DHT) || defined(TEMP_SENSOR_BME280)
  virtual float getHumidity(bool *current);
#endif
#if defined(TEMP_SENSOR_BME280)
  virtual float getBaroPressure(bool *current);
#endif
#ifdef BATTERY_SENSOR
  virtual float getBatteryVoltage(bool *current);
#endif

  virtual JsonDocument& getDeviceSettings();
  virtual bool setDeviceSettings(JsonDocument ac);

private:
  unsigned long tMillisUp;

  unsigned long tMillisTemp;
  unsigned long tLastReading;
  bool sensorReady;

  JsonDocument jsonDeviceSettings;
  
  float _temperature;
#ifdef TEMP_SENSOR_DS18B20
  OneWire *oneWire;
  DS18B20 *ds18b20;
#endif
#ifdef TEMP_SENSOR_BME280
  float _humidity, _baro_pressure;
  Adafruit_BME280 *_bme;
#endif
#ifdef TEMP_SENSOR_DHT
  float _humidity;
  DHT_Unified *_dht;
  unsigned long minDelayMs;
#endif

};