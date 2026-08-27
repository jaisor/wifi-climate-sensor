# WiFi Climate Sensor

![device1](assets/device1.jpg)

Supported features:
* ESP8266, ESP32, ESP32-C3 or ESP32-S3 based
* Built-in web server with UI for sensor reading and configuration
* Selectable temperature/humidity sensor: AHT20, BME280, DHT22, DS18B20
* I2C autodetection of the AHT20 and BME280, selected and saved automatically on boot
* Optional INA219 I2C power monitor for bus voltage and current, auto-detected at boot
* MQTT support for transmitting sensor data
* Home Assistant MQTT auto-discovery for temperature, humidity, voltage, current and power sensors
* OTA firmware update using ElegantOTA at `/update`
* OTA firmware update triggered via MQTT config topic
* 3D printed case for clean and seamless mounting

# Usage

## Initial boot / reset

Compile for your select ESP architecture and flash over USB.

On first boot the device creates a self-hosted WiFi access point (AP) with SSID starting with `ESP8266CLSEN` or `ESP32CLSEN` and WPA2 password `password123`
In self-hosted AP mode, the device gives itself `192.168.4.1` IP address.

The device can be connected to an existing AP using the `/wifi` option

![wifi screenshot](assets/screen_mobile_wifi.jpg)

## Resetting / erasing configuration

The device will reset itself to default configuration and self-hosted AP if unable to complete its boot sequence within 2 seconds (smooth boot) 3 times in a row.
This can be forced by power-cycling the device several times. Powered up durations should be about 1 second (less than 2 second, but enough for the CPU to start). 

# Climate sensor autodetection

On boot the I2C bus is probed for the two climate sensors that live on it, and the first match is selected and
persisted to EEPROM, so a freshly flashed board generally needs no sensor configuration at all:

| Sensor | Addresses probed |
|---|---|
| BME280 | `0x76`, then `0x77` |
| AHT20 | `0x38` |

Whichever address answers is remembered, so a BME280 strapped to `0x77` is opened on `0x77`. Because `0x76`/`0x77`
are shared with the BMP280, a BMP280 is probed as a BME280 candidate but rejected by the chip id check inside
`Adafruit_BME280::begin()`, leaving the sensor unconfigured rather than misreported.

Autodetection only overrides the stored setting when nothing is configured yet, or when the configured sensor is
itself an I2C one that no longer answers - swapping a BME280 for an AHT20 is picked up on the next boot. An explicit
DS18B20 or DHT22 selection is never overridden, since neither is on the I2C bus. Set `TEMP_SENSOR_AUTODETECT` in
[Configuration.h](src/Configuration.h) to turn the whole thing off and go back to choosing the sensor by hand.

Note that on the ESP32-C3 the DS18B20 data pin and `SCL` are the same GPIO. When a DS18B20 is selected the I2C bus
is never started, so neither autodetection nor the INA219 runs on that target.

# Power monitoring (INA219)

An optional [INA219](https://www.ti.com/product/INA219) high side current/voltage monitor can be wired to the I2C bus.
It is probed at address `0x40` on every boot: when present its readings show up as a **Power** card on the main page
below temperature and humidity, and in the MQTT payload. When absent the card is omitted entirely and the sensor is
skipped with no further effect. The `/sensor` page splits its settings into an **Environment Sensor** area and a
**Power Sensor** area, each showing the detected sensor name and its pin or I2C address.

These readings are independent of the `voltage_v` value, which is still sampled through the ADC voltage divider.
The INA219 reports the voltage across its own shunt, so the two can be wired to different rails.

| Board | SDA | SCL |
|---|---|---|
| ESP32-C3 | `GPIO7` | `GPIO6` |
| ESP32-S3 | `GPIO8` | `GPIO9` |
| ESP32 / ESP8266 | core default | core default |

Pins are set by `I2C_SDA_PIN` / `I2C_SCL_PIN` in [Configuration.h](src/Configuration.h), and the I2C address by
`INA219_I2C_ID`. The bus is shared with the BME280, AHT20 and OLED peripherals.

# MQTT

## Sensor data

The device publishes a JSON payload to `{mqttTopic}/json` every 5 minutes. Example payload:

```json
{
  "device_id": 12345678,
  "temperature": 21.5,
  "temperature_unit": "Celsius",
  "humidity": 55.2,
  "voltage_v": 12.1,
  "ina219_voltage_v": 12.043,
  "ina219_current_ma": 184.2,
  "ina219_power_mw": 2218.3,
  "wifi_rssi": -67,
  "wifi_percent": 66,
  "timestamp_iso8601": "2026-05-28T12:00:00Z",
  "uptime_millis": 300000
}
```

## Home Assistant auto-discovery

On every MQTT publish the device sends Home Assistant MQTT discovery messages, automatically registering the following entities under a single device:

| Entity | Discovery topic |
|---|---|
| Temperature | `homeassistant/sensor/{deviceId}_temperature/config` |
| Humidity | `homeassistant/sensor/{deviceId}_humidity/config` |
| Voltage | `homeassistant/sensor/{deviceId}_voltage/config` |
| INA219 Voltage | `homeassistant/sensor/{deviceId}_ina219_voltage/config` |
| INA219 Current | `homeassistant/sensor/{deviceId}_ina219_current/config` |
| INA219 Power | `homeassistant/sensor/{deviceId}_ina219_power/config` |

No manual configuration in Home Assistant is required — enable MQTT integration and the device will appear automatically.

## Remote configuration

Publish a JSON payload to `{mqttTopic}/{deviceId}/config` to update configuration at runtime:

```json
{
  "name": "Living Room Sensor",
  "deepSleepDurationSec": 300,
  "ledEnabled": true,
  "tempUnit": 0
}
```

The retained message is deleted immediately after receipt to prevent re-applying on reconnect.

## OTA firmware update over MQTT

Publish a JSON payload to `{mqttTopic}/{deviceId}/config` with a `firmware_location` key to trigger a firmware update:

```json
{ "firmware_location": "http://my-server/firmware_device_.bin" }
```

The substring `_device_` in the URL is replaced with the target architecture before the download:

| Board | Replacement |
|---|---|
| ESP8266 | `ESP8266` |
| ESP32 | `ESP32` |
| ESP32-C3 | `ESP32C3` |
| ESP32-S3 | `ESP32S3` |

So `firmware_device_.bin` becomes e.g. `firmware_ESP32C3_.bin`. The device reboots automatically on a successful update.

The ESP can also be upadted over web OTA at `/update` after the device IP.

# Schematic, PCB and assembly

[Schematic and PCB available online](https://a360.co/4gnvt9p)

[Gerber files uploaded here](https://365.altium.com/files/86EDE8C7-B795-499B-9DB7-9364AABE9626)

[Gedber files direct download](assets/gerber.zip)

[Schematic EAGLE sch file](assets/schematic_eagle.sch)

![Schematic](assets/schematic.png)
![PCB](assets/pcb.png)


# Case
![case preview](assets/case.jpg)

STL files:
* [bottom](assets/case_bottom.stl)
* [top](assets/case_top.stl) - if too tight fitting, scale top up by 1%

# Apache proxy setup

Example configuration for exposing a local network device via Apache proxy. Strong advise to use SSL/HTTPS and appropriate authentication and authorization controls to reduce risk of bad actors. 

```
                <Location /ac>
                        AuthType Basic
                        Authname "Password Required"
                        AuthUserFile /etc/apache2/.htpasswd
                        Require valid-user
                </Location>

                ProxyPass /ac/roomname http://192.168.x.y disablereuse=On
                ProxyPassReverse /ac/roomname http://192.168.x.y
```
