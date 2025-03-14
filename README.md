# WiFi Climate Sensor

![device1](assets/device1.jpg)

Supported features:
* ESP8266 or ESP32 based with an ATH20 I2C sensor
* Built-in web server with UI for sensor reading and configuration
* WiFi with both self-hosted or joining existing access points
* MQTT support for transmitting data
* OTA firmware update using ElegantOTA at `/update`
* 3D printed case for clean and seamless mounting

# Usage

## Initial boot / reset

On first boot the device creates a self-hosted WiFi access point (AP) with SSID starting with `ESP8266CLSEN` or `ESP32CLSEN` and WPA2 password `password123`
In self-hosted AP mode, the device gives itself `192.168.4.1` IP address.

The device can be connected to an existing AP using the `/wifi` option

![wifi screenshot](assets/screen_mobile_wifi.jpg)

## Resetting / erasing configuration

The device will reset itself to default configuration and self-hosted AP if unable to complete its boot sequence within 2 seconds (smooth boot) 3 times in a row.
This can be forced by power-cycling the device several times. Powered up durations should be about 1 second (less than 2 second, but enough for the CPU to start). 

# Programming the ESP8266

Compile and upload the project using USB. After the resistors are removed (see below), future updates will have to be made using OTA. 
Access to OTA is at `/update` path at the device's IP. See Initial boot below on how to connect to the self-hosted AP.

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
