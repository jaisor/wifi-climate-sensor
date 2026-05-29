# WiFi Climate Sensor

![device1](assets/device1.jpg)

Supported features:
* ESP8266, ESP32 or ESP32-C3 based
* Built-in web server with UI for sensor reading and configuration
* Selectable temperature/humidity sensor: AHT20, BME280, DHT22, DS18B20
* MQTT support for transmitting sensor data
* Home Assistant MQTT auto-discovery for temperature, humidity and voltage sensors
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
