#include <Arduino.h>
#include <functional>
#include <ArduinoLog.h>

#include "Device.h"

#ifdef TEMP_SENSOR_DS18B20
#include <Wire.h>
#endif

CDevice::CDevice() {

  tMillisUp = millis();
  tMillisTemp = millis();
  sensorReady = false;

#ifdef OLED
  _display = new Adafruit_SSD1306(OLED_SCREEN_WIDTH, OLED_SCREEN_HEIGHT, &Wire, -1);
  if(!_display->begin(SSD1306_SWITCHCAPVCC, OLED_I2C_ID)) {
      Log.errorln("SSD1306 OLED initialiation failed with ID %x", OLED_I2C_ID);
      while (1);
  }
  _display->clearDisplay();
  _display->setTextColor(WHITE);
#endif

  tLastReading = 0;
#ifdef TEMP_SENSOR_DS18B20
  pinMode(TEMP_SENSOR_PIN, INPUT_PULLUP);
  oneWire = new OneWire(TEMP_SENSOR_PIN);
  DeviceAddress da;
  ds18b20 = new DS18B20(oneWire);
  ds18b20->setConfig(DS18B20_CRC);
  ds18b20->begin();

  ds18b20->getAddress(da);
  String addr = "";
  for (uint8_t i = 0; i < 8; i++) {
    if (da[i] < 16) {
      addr += String("o");
    }
    addr += String(da[i], HEX);
  }
  Log.noticeln(F("DS18B20 sensor at address: %s"), addr.c_str());
  
  ds18b20->setResolution(12);
  ds18b20->requestTemperatures();

  sensorReady = true;
  tMillisTemp = 0;
#endif
#ifdef TEMP_SENSOR_BME280
  _bme = new Adafruit_BME280();
  if (!_bme->begin(BME_I2C_ID)) {
    Log.errorln(F("BME280 sensor initialization failed with ID %x"), BME_I2C_ID);
    sensorReady = false;
  } else {
    sensorReady = true;
    tMillisTemp = 0;
  }
#endif
#ifdef TEMP_SENSOR_DHT
  _dht = new DHT_Unified(TEMP_SENSOR_PIN, TEMP_SENSOR_DHT_TYPE);
  _dht->begin();
  sensor_t sensor;
  _dht->temperature().getSensor(&sensor);
  Log.noticeln(F("DHT temperature sensor name(%s) v(%u) id(%u) range(%F - %F) res(%F)"),
    sensor.name, sensor.version, sensor.sensor_id, 
    sensor.min_value, sensor.max_value, sensor.resolution);
  _dht->humidity().getSensor(&sensor);
  Log.noticeln(F("DHT humidity sensor name(%s) v(%u) id(%u) range(%F - %F) res(%F)"),
    sensor.name, sensor.version, sensor.sensor_id, 
    sensor.min_value, sensor.max_value, sensor.resolution);
  minDelayMs = sensor.min_delay / 1000;
  Log.noticeln(F("DHT sensor min delay %i"), minDelayMs);
#endif
#ifdef TEMP_SENSOR_AHT
  _aht = new Adafruit_AHTX0();
  if (!_aht->begin()) {
    Log.errorln("Failed to initialize AHT sensor, check wiring");
    sensorReady = false;
  } else {
    sensorReady = true;
    tMillisTemp = 0;
  }
  minDelayMs = 100;
#endif

#ifdef BATTERY_SENSOR
  #if SEEED_XIAO_M0
    analogReadResolution(12);
  #endif
  pinMode(BATTERY_SENSOR_ADC_PIN, INPUT);
#endif


#if defined(ESP32)
#elif defined(ESP8266)
#elif defined(SEEED_XIAO_M0)
#endif
  
  jsonDeviceSettings["connected"] = false;

  #ifdef DEBUG_MOCK_HP
    jsonDeviceSettings["connected"] = true;
  #endif
  Log.infoln(F("Device initialized"));
}

CDevice::~CDevice() { 
#ifdef TEMP_SENSOR_DS18B20
  delete ds18b20;
#endif
#ifdef TEMP_SENSOR_BME280
  delete _bme;
#endif
#ifdef TEMP_SENSOR_DHT
  delete _dht;
#endif
#ifdef TEMP_SENSOR_AHT
  delete _aht;
#endif
#ifdef OLED
  delete _display;
#endif
  Log.noticeln(F("Device destroyed"));
}

void CDevice::loop() {

  uint32_t delay = 1000;
  #if defined(TEMP_SENSOR_DHT) || defined(TEMP_SENSOR_BME280) || defined(TEMP_SENSOR_AHT)
    delay += minDelayMs;
  #endif

  if (!sensorReady && millis() - tMillisTemp > delay) {
    sensorReady = true;
  }

  if (sensorReady && millis() - tMillisTemp > delay) {
    #ifdef TEMP_SENSOR_DS18B20
      if (ds18b20->isConversionComplete()) {
        _temperature = ds18b20->getTempC();
        ds18b20->setResolution(12);
        ds18b20->requestTemperatures();
        tLastReading = millis();
        Log.traceln(F("DS18B20 temp: %FC %FF"), _temperature, _temperature*1.8+32);
      } else {
        //Log.infoln(F("DS18B20 conversion not complete"));
      }
    #endif
    #ifdef TEMP_SENSOR_BME280
      _temperature = _bme->readTemperature();
      _humidity = _bme->readHumidity();
      _baro_pressure = _bme->readPressure();
      tLastReading = millis();
    #endif
    #ifdef TEMP_SENSOR_DHT
      if (millis() - tLastReading > delay) {
        sensors_event_t event;
        // temperature
        _dht->temperature().getEvent(&event);
        if (isnan(event.temperature)) {
          //Log.warningln(F("Error reading DHT temperature!"));
        } else {
          _temperature = event.temperature;
          Log.traceln(F("DHT temp: %FC %FF"), _temperature, _temperature*1.8+32);
        }
        // humidity
        _dht->humidity().getEvent(&event);
        if (isnan(event.relative_humidity)) {
          //Log.warningln(F("Error reading DHT humidity!"));
        }
        else {
          _humidity = event.relative_humidity;
          Log.traceln(F("DHT humidity: %F%%"), _humidity);
        }
        
        tLastReading = millis();
      }
    #endif
    #ifdef TEMP_SENSOR_AHT
      if (millis() - tLastReading > delay) {
        sensors_event_t eh, et;
        bool goodRead = _aht->getEvent(&eh, &et);
        if (goodRead) {
          // temperature
          if (isnan(et.temperature)) {
            Log.warningln(F("Error reading AHT temperature!"));
            goodRead = false;
          } else {
            _temperature = et.temperature;
            //Log.noticeln("AHT temp: %FC %FF", _temperature, _temperature*1.8+32);
          }
          // humidity
          if (isnan(eh.relative_humidity)) {
            Log.warningln(F("Error reading AHT humidity!"));
            goodRead = false;
          }
          else {
            _humidity = eh.relative_humidity;
            //Log.noticeln("AHT humidity: %F%%", _humidity);
          }
          tLastReading = millis();
        } else {
          Log.warningln(F("Error getting AHT event!"));
        }
      }
    #endif
  }

  #if !defined(ESP8266) || (defined(ESP8266) && defined(DISABLE_LOGGING))
  //.sync();
  #endif

  #ifdef OLED
  char st[256];
  
  _display->setTextSize(0);
  _display->setCursor(0,17);
  _display->setTextSize(1);  
  float t = getTemperature(NULL);
  snprintf(st, 256, "Temperature: %0.1f%s\n", configuration.tempUnit == TEMP_UNIT_CELSIUS ? t : t * 1.8 + 32, configuration.tempUnit == TEMP_UNIT_CELSIUS ? "C" : "F");
  _display->print(st);
  snprintf(st, 256, "Humidity: %0.1f%%", getHumidity(NULL));
  _display->print(st);

  #endif

}

#if defined(TEMP_SENSOR_DS18B20) || defined(TEMP_SENSOR_DHT) || defined(TEMP_SENSOR_BME280) || defined(TEMP_SENSOR_AHT)
float CDevice::getTemperature(bool *current) {
  if (current != NULL) { 
    *current = millis() - tLastReading < STALE_READING_AGE_MS; 
  }
  return _temperature;
}
#else
float CDevice::getTemperature(bool *current) {
  return 0;
}
#endif

#if defined(TEMP_SENSOR_DHT) || defined(TEMP_SENSOR_BME280) || defined(TEMP_SENSOR_AHT)
float CDevice::getHumidity(bool *current) {
  if (current != NULL) { 
    *current = millis() - tLastReading < STALE_READING_AGE_MS; 
  }
  return _humidity;
}
#endif

#if defined(TEMP_SENSOR_BME280)
float CDevice::getBaroPressure(bool *current) {
  if (current != NULL) { 
    *current = millis() - tLastReading < STALE_READING_AGE_MS; 
  }
  return _baro_pressure;
}
#endif

#ifdef BATTERY_SENSOR
float CDevice::getBatteryVoltage(bool *current) {  
  if (current != NULL) { *current = true; } 
  int vi = analogRead(BATTERY_SENSOR_ADC_PIN);
  float v = (float)vi/configuration.battVoltsDivider;
  Log.verboseln(F("Battery voltage raw: %i volts: %D"), vi, v);
  return v; 
}
#endif

JsonDocument& CDevice::getDeviceSettings() {

  jsonDeviceSettings["ts"] = millis();

  return jsonDeviceSettings;
}

bool CDevice::setDeviceSettings(JsonDocument ac) {
  #ifdef DEBUG_MOCK_HP
    jsonDeviceSettings["temperature"] = ac["temperature"];
    return true;
  #else
    jsonDeviceSettings["temperature"] = ac["temperature"];
    return true;
  #endif
}