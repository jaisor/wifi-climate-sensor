#include <Arduino.h>
#include <functional>
#include <ArduinoLog.h>

#include "Device.h"

#ifdef TEMP_SENSOR_DS18B20
#include <Wire.h>
#endif

CDevice::CDevice()
:oneWire(NULL), ds18b20(NULL), bme280(NULL), dht(NULL), aht(NULL) {

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

  switch (configuration.tempSensor) {
    case TEMP_SENSOR_DS18B20: {
      jsonDeviceSettings["sensor_type"] = "DS18B20";
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
    } break;
    
    case TEMP_SENSOR_BME280: {
      jsonDeviceSettings["sensor_type"] = "BME280";
      bme280 = new Adafruit_BME280();
      if (!bme280->begin(BME280_I2C_ID)) {
        Log.errorln(F("BME280 sensor initialization failed with ID %x"), BME280_I2C_ID);
        sensorReady = false;
      } else {
        sensorReady = true;
        tMillisTemp = 0;
      }
    } break;

    case TEMP_SENSOR_DHT22: {
      jsonDeviceSettings["sensor_type"] = "DHT22";
      dht = new DHT_Unified(TEMP_SENSOR_PIN, DHT22);
      dht->begin();
      sensor_t sensor;
      dht->temperature().getSensor(&sensor);
      Log.noticeln(F("DHT temperature sensor name(%s) v(%u) id(%u) range(%F - %F) res(%F)"),
        sensor.name, sensor.version, sensor.sensor_id, 
        sensor.min_value, sensor.max_value, sensor.resolution);
      dht->humidity().getSensor(&sensor);
      Log.noticeln(F("DHT humidity sensor name(%s) v(%u) id(%u) range(%F - %F) res(%F)"),
        sensor.name, sensor.version, sensor.sensor_id, 
        sensor.min_value, sensor.max_value, sensor.resolution);
      minDelayMs = sensor.min_delay / 1000;
      Log.noticeln(F("DHT sensor min delay %i"), minDelayMs);
    } break;

    case TEMP_SENSOR_AHT20: {
      jsonDeviceSettings["sensor_type"] = "AHT20";
      aht = new Adafruit_AHTX0();
      if (!aht->begin()) {
        Log.errorln("Failed to initialize AHT sensor, check wiring");
        sensorReady = false;
      } else {
        sensorReady = true;
        tMillisTemp = 0;
      }
      minDelayMs = 100;
    } break;

    default:
      sensorReady = false;
      jsonDeviceSettings["sensor_type"] = "unknown";
      Log.errorln(F("Unsupported temperature sensor"));
      break;
  }

#ifdef VOLTAGE_SENSOR
  #if SEEED_XIAO_M0
    analogReadResolution(12);
  #endif
  pinMode(VOLTAGE_SENSOR_ADC_PIN, INPUT);
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
  delete ds18b20;
  delete bme280;
  delete dht;
  delete aht;
#ifdef OLED
  delete _display;
#endif
  Log.noticeln(F("Device destroyed"));
}

void CDevice::loop() {

  uint32_t delay = 1000;

  if (configuration.tempSensor == TEMP_SENSOR_DHT22 || 
    configuration.tempSensor == TEMP_SENSOR_BME280 || 
    configuration.tempSensor == TEMP_SENSOR_AHT20) {

    delay += minDelayMs;
  }

  if (!sensorReady && millis() - tMillisTemp > delay) {
    sensorReady = true;
  }

  if (sensorReady && millis() - tMillisTemp > delay) {

    switch (configuration.tempSensor) {
      case TEMP_SENSOR_DS18B20: {
        if (ds18b20->isConversionComplete()) {
          temperature = ds18b20->getTempC();
          ds18b20->setResolution(12);
          ds18b20->requestTemperatures();
          tLastReading = millis();
          Log.traceln(F("DS18B20 temp: %FC %FF"), temperature, temperature*1.8+32);
        }
      } break;
      
      case TEMP_SENSOR_BME280: {
        temperature = bme280->readTemperature();
        humidity = bme280->readHumidity();
        baro_pressure = bme280->readPressure();
        tLastReading = millis();
      } break;
  
      case TEMP_SENSOR_DHT22: {
        if (millis() - tLastReading > delay) {
          sensors_event_t event;
          // temperature
          dht->temperature().getEvent(&event);
          if (isnan(event.temperature)) {
            //Log.warningln(F("Error reading DHT temperature!"));
          } else {
            temperature = event.temperature;
            Log.traceln(F("DHT temp: %FC %FF"), temperature, temperature*1.8+32);
          }
          // humidity
          dht->humidity().getEvent(&event);
          if (isnan(event.relative_humidity)) {
            //Log.warningln(F("Error reading DHT humidity!"));
          }
          else {
            humidity = event.relative_humidity;
            Log.traceln(F("DHT humidity: %F%%"), humidity);
          }
          
          tLastReading = millis();
        }
      } break;
  
      case TEMP_SENSOR_AHT20: {
        if (millis() - tLastReading > delay) {
          sensors_event_t eh, et;
          bool goodRead = aht->getEvent(&eh, &et);
          if (goodRead) {
            // temperature
            if (isnan(et.temperature)) {
              Log.warningln(F("Error reading AHT temperature!"));
              goodRead = false;
            } else {
              temperature = et.temperature;
              Log.traceln("AHT temp: %FC %FF", temperature, temperature*1.8+32);
            }
            // humidity
            if (isnan(eh.relative_humidity)) {
              Log.warningln(F("Error reading AHT humidity!"));
              goodRead = false;
            }
            else {
              humidity = eh.relative_humidity;
              Log.traceln("AHT humidity: %F%%", humidity);
            }
            tLastReading = millis();
          } else {
            Log.warningln(F("Error getting AHT event!"));
            //tLastReading = millis();
          }
        }
      } break;
  
      default:
        break;
    }

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

float CDevice::getTemperature(bool *current) {
  if (current != NULL) { 
    *current = millis() - tLastReading < STALE_READING_AGE_MS; 
  }

  return configuration.tempSensor != TEMP_SENSOR_UNSUPPORTED ? temperature: 0;
}

float CDevice::getHumidity(bool *current) {
  if (current != NULL) { 
    *current = millis() - tLastReading < STALE_READING_AGE_MS; 
  }
  return configuration.tempSensor != TEMP_SENSOR_UNSUPPORTED ? humidity: 0;
}

float CDevice::getBaroPressure(bool *current) {
  if (current != NULL) { 
    *current = millis() - tLastReading < STALE_READING_AGE_MS; 
  }
  return configuration.tempSensor == TEMP_SENSOR_BME280 ? baro_pressure: 0;
}


#ifdef VOLTAGE_SENSOR
float CDevice::getVoltage(bool *current) {  
  if (current != NULL) { *current = true; } 
  int vi = analogRead(VOLTAGE_SENSOR_ADC_PIN);
  float v = (float)vi/configuration.voltageDivider;
  Log.verboseln(F("Voltage raw: %i volts: %D"), vi, v);
  return v; 
}
#endif

JsonDocument& CDevice::getDeviceSettings() {

  jsonDeviceSettings["ts"] = millis();
  jsonDeviceSettings["temp_sensor_type"] = configuration.tempSensor;

  switch (configuration.tempSensor) {
    case TEMP_SENSOR_DS18B20: jsonDeviceSettings["temp_sensor_type_label"] = "DS18B20"; break;
    case TEMP_SENSOR_BME280: jsonDeviceSettings["temp_sensor_type_label"] = "BME280"; break;
    case TEMP_SENSOR_DHT22: jsonDeviceSettings["temp_sensor_type_label"] = "DHT22"; break;
    case TEMP_SENSOR_AHT20: jsonDeviceSettings["temp_sensor_type_label"] = "AHT20"; break;
    default: jsonDeviceSettings["temp_sensor_type_label"] = "unsupported"; break;
  }

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