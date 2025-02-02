<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE eagle SYSTEM "eagle.dtd">
<eagle version="9.7.0">
<drawing>
<settings>
<setting alwaysvectorfont="no"/>
<setting verticaltext="up"/>
</settings>
<grid distance="0.1" unitdist="inch" unit="inch" style="lines" multiple="1" display="no" altdistance="0.01" altunitdist="inch" altunit="inch"/>
<layers>
<layer number="1" name="Top" color="4" fill="1" visible="no" active="no"/>
<layer number="16" name="Bottom" color="1" fill="1" visible="no" active="no"/>
<layer number="17" name="Pads" color="2" fill="1" visible="no" active="no"/>
<layer number="18" name="Vias" color="2" fill="1" visible="no" active="no"/>
<layer number="19" name="Unrouted" color="6" fill="1" visible="no" active="no"/>
<layer number="20" name="Dimension" color="24" fill="1" visible="no" active="no"/>
<layer number="21" name="tPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="22" name="bPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="23" name="tOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="24" name="bOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="25" name="tNames" color="7" fill="1" visible="no" active="no"/>
<layer number="26" name="bNames" color="7" fill="1" visible="no" active="no"/>
<layer number="27" name="tValues" color="7" fill="1" visible="no" active="no"/>
<layer number="28" name="bValues" color="7" fill="1" visible="no" active="no"/>
<layer number="29" name="tStop" color="7" fill="3" visible="no" active="no"/>
<layer number="30" name="bStop" color="7" fill="6" visible="no" active="no"/>
<layer number="31" name="tCream" color="7" fill="4" visible="no" active="no"/>
<layer number="32" name="bCream" color="7" fill="5" visible="no" active="no"/>
<layer number="33" name="tFinish" color="6" fill="3" visible="no" active="no"/>
<layer number="34" name="bFinish" color="6" fill="6" visible="no" active="no"/>
<layer number="35" name="tGlue" color="7" fill="4" visible="no" active="no"/>
<layer number="36" name="bGlue" color="7" fill="5" visible="no" active="no"/>
<layer number="37" name="tTest" color="7" fill="1" visible="no" active="no"/>
<layer number="38" name="bTest" color="7" fill="1" visible="no" active="no"/>
<layer number="39" name="tKeepout" color="4" fill="11" visible="no" active="no"/>
<layer number="40" name="bKeepout" color="1" fill="11" visible="no" active="no"/>
<layer number="41" name="tRestrict" color="4" fill="10" visible="no" active="no"/>
<layer number="42" name="bRestrict" color="1" fill="10" visible="no" active="no"/>
<layer number="43" name="vRestrict" color="2" fill="10" visible="no" active="no"/>
<layer number="44" name="Drills" color="7" fill="1" visible="no" active="no"/>
<layer number="45" name="Holes" color="7" fill="1" visible="no" active="no"/>
<layer number="46" name="Milling" color="3" fill="1" visible="no" active="no"/>
<layer number="47" name="Measures" color="7" fill="1" visible="no" active="no"/>
<layer number="48" name="Document" color="7" fill="1" visible="no" active="no"/>
<layer number="49" name="Reference" color="7" fill="1" visible="no" active="no"/>
<layer number="51" name="tDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="52" name="bDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="88" name="SimResults" color="9" fill="1" visible="yes" active="yes"/>
<layer number="89" name="SimProbes" color="9" fill="1" visible="yes" active="yes"/>
<layer number="90" name="Modules" color="5" fill="1" visible="yes" active="yes"/>
<layer number="91" name="Nets" color="2" fill="1" visible="yes" active="yes"/>
<layer number="92" name="Busses" color="1" fill="1" visible="yes" active="yes"/>
<layer number="93" name="Pins" color="2" fill="1" visible="no" active="yes"/>
<layer number="94" name="Symbols" color="4" fill="1" visible="yes" active="yes"/>
<layer number="95" name="Names" color="7" fill="1" visible="yes" active="yes"/>
<layer number="96" name="Values" color="7" fill="1" visible="yes" active="yes"/>
<layer number="97" name="Info" color="7" fill="1" visible="yes" active="yes"/>
<layer number="98" name="Guide" color="6" fill="1" visible="yes" active="yes"/>
</layers>
<schematic xreflabel="%F%N/%S.%C%R" xrefpart="/%S.%C%R">
<libraries>
<library name="Power_Symbols" urn="urn:adsk.eagle:library:16502351">
<description>&lt;B&gt;Supply &amp; Ground symbols</description>
<packages>
</packages>
<symbols>
<symbol name="GND" urn="urn:adsk.eagle:symbol:16502380/3" library_version="22">
<description>Ground (GND) Arrow</description>
<wire x1="-1.27" y1="0" x2="1.27" y2="0" width="0.1524" layer="94"/>
<wire x1="1.27" y1="0" x2="0" y2="-1.27" width="0.1524" layer="94"/>
<wire x1="0" y1="-1.27" x2="-1.27" y2="0" width="0.1524" layer="94"/>
<pin name="GND" x="0" y="2.54" visible="off" length="short" direction="sup" rot="R270"/>
<text x="0" y="-2.54" size="1.778" layer="96" align="top-center">&gt;VALUE</text>
</symbol>
<symbol name="+5V" urn="urn:adsk.eagle:symbol:18498226/3" library_version="22">
<description>5 Volt (5V0) Bar</description>
<wire x1="1.905" y1="2.54" x2="-1.905" y2="2.54" width="0.1524" layer="94"/>
<pin name="+5V" x="0" y="0" visible="off" length="short" direction="sup" rot="R90"/>
<text x="0" y="5.08" size="1.778" layer="96" align="top-center">&gt;VALUE</text>
</symbol>
<symbol name="+3.3V" urn="urn:adsk.eagle:symbol:18498252/3" library_version="22">
<description>3.3 Volt (3V3) Bar</description>
<wire x1="1.905" y1="2.54" x2="-1.905" y2="2.54" width="0.1524" layer="94"/>
<pin name="+3.3V" x="0" y="0" visible="off" length="short" direction="sup" rot="R90"/>
<text x="0" y="5.08" size="1.778" layer="96" align="top-center">&gt;VALUE</text>
</symbol>
<symbol name="+V" urn="urn:adsk.eagle:symbol:16502354/5" library_version="22">
<wire x1="-1.905" y1="0" x2="1.905" y2="0" width="0.1524" layer="94"/>
<pin name="+V" x="0" y="-2.54" visible="off" length="short" direction="sup" rot="R90"/>
<text x="0" y="2.54" size="1.778" layer="96" align="top-center">&gt;VALUE</text>
</symbol>
</symbols>
<devicesets>
<deviceset name="GND" urn="urn:adsk.eagle:component:16502425/6" prefix="SUPPLY" uservalue="yes" library_version="22">
<description>&lt;b&gt;SUPPLY SYMBOL&lt;/b&gt; - Ground (GND) Arrow</description>
<gates>
<gate name="G$1" symbol="GND" x="0" y="0"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name="">
<attribute name="CATEGORY" value="Supply" constant="no"/>
<attribute name="VALUE" value="GND" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="+5V" urn="urn:adsk.eagle:component:16502432/8" prefix="SUPPLY" uservalue="yes" library_version="22">
<description>&lt;b&gt;SUPPLY SYMBOL&lt;/b&gt;  5 Volt (5V0) Bar</description>
<gates>
<gate name="G$1" symbol="+5V" x="0" y="0"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name="">
<attribute name="CATEGORY" value="Supply" constant="no"/>
<attribute name="VALUE" value="+5V" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="+3.3V" urn="urn:adsk.eagle:component:16502431/8" prefix="SUPPLY" uservalue="yes" library_version="22">
<description>&lt;b&gt;SUPPLY SYMBOL&lt;/b&gt;  3.3 Volt (3V3) Bar</description>
<gates>
<gate name="G$1" symbol="+3.3V" x="0" y="0"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name="">
<attribute name="CATEGORY" value="Supply" constant="no"/>
<attribute name="VALUE" value="+3.3V" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="+V" urn="urn:adsk.eagle:component:16502422/8" prefix="SUPPLY" uservalue="yes" library_version="22">
<description>&lt;b&gt;SUPPLY SYMBOL&lt;/b&gt;  Positive Voltage (+V) Bar</description>
<gates>
<gate name="G$1" symbol="+V" x="0" y="2.54"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name="">
<attribute name="CATEGORY" value="Supply" constant="no"/>
<attribute name="VALUE" value="+V" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="esp8266modules" urn="urn:adsk.wipprod:fs.file:vf.rqZeGJ0zQBSPVXdJP1cbFw">
<packages>
<package name="WEMOS-D1-MINI" library_version="1">
<description>WeMos.cc
D1 mini
ESP8266 module</description>
<wire x1="9.17" y1="15.216" x2="9.17" y2="9.416" width="0.127" layer="21"/>
<wire x1="-6.83" y1="9.416" x2="-6.83" y2="15.216" width="0.127" layer="21"/>
<wire x1="-6.83" y1="15.216" x2="9.17" y2="15.216" width="0.127" layer="21"/>
<wire x1="-6.83" y1="9.416" x2="9.17" y2="9.416" width="0.127" layer="21"/>
<pad name="5V" x="12.7" y="-10.16" drill="1.016" diameter="1.8288" shape="long"/>
<pad name="GND" x="12.7" y="-7.62" drill="1.016" diameter="1.8288" shape="long"/>
<pad name="D4" x="12.7" y="-5.08" drill="1.016" diameter="1.8288" shape="long"/>
<pad name="D3" x="12.7" y="-2.54" drill="1.016" diameter="1.8288" shape="long"/>
<pad name="D2" x="12.7" y="0" drill="1.016" diameter="1.8288" shape="long"/>
<pad name="D1" x="12.7" y="2.54" drill="1.016" diameter="1.8288" shape="long"/>
<pad name="RX" x="12.7" y="5.08" drill="1.016" diameter="1.8288" shape="long"/>
<pad name="TX" x="12.7" y="7.62" drill="1.016" diameter="1.8288" shape="long"/>
<pad name="3V3" x="-10.16" y="-10.16" drill="1.016" diameter="1.8288" shape="long" rot="R180"/>
<pad name="D8" x="-10.16" y="-7.62" drill="1.016" diameter="1.8288" shape="long" rot="R180"/>
<pad name="D7" x="-10.16" y="-5.08" drill="1.016" diameter="1.8288" shape="long" rot="R180"/>
<pad name="D6" x="-10.16" y="-2.54" drill="1.016" diameter="1.8288" shape="long" rot="R180"/>
<pad name="D5" x="-10.16" y="0" drill="1.016" diameter="1.8288" shape="long" rot="R180"/>
<pad name="D0" x="-10.16" y="2.54" drill="1.016" diameter="1.8288" shape="long" rot="R180"/>
<pad name="A0" x="-10.16" y="5.08" drill="1.016" diameter="1.8288" shape="long" rot="R180"/>
<pad name="RESET" x="-10.16" y="7.62" drill="1.016" diameter="1.8288" shape="long" rot="R180"/>
<text x="-2.54" y="-6.35" size="1.4224" layer="21">WeMos.cc
D1 mini</text>
<text x="12.7" y="-17.78" size="1.4224" layer="25" align="bottom-right">&gt;Name</text>
<wire x1="-6.8326" y1="9.4234" x2="-6.8326" y2="-8.89" width="0.127" layer="21"/>
<wire x1="9.144" y1="9.4234" x2="9.1694" y2="9.4234" width="0.127" layer="21"/>
<wire x1="9.1694" y1="9.4234" x2="9.1694" y2="-8.89" width="0.127" layer="21"/>
<wire x1="13.97" y1="12.7" x2="13.97" y2="-19.05" width="0.127" layer="21"/>
<wire x1="-8.89" y1="15.24" x2="11.43" y2="15.24" width="0.127" layer="21"/>
<wire x1="-11.43" y1="12.7" x2="-8.89" y2="15.24" width="0.127" layer="21" curve="-90"/>
<wire x1="11.43" y1="15.24" x2="13.97" y2="12.7" width="0.127" layer="21" curve="-90"/>
<wire x1="-11.43" y1="12.7" x2="-11.43" y2="-19.05" width="0.127" layer="21"/>
<wire x1="-11.43" y1="-19.05" x2="13.97" y2="-19.05" width="0.127" layer="21"/>
<wire x1="-6.8326" y1="-8.89" x2="9.144" y2="-8.89" width="0.127" layer="21"/>
<text x="-8.89" y="7.62" size="0.762" layer="25" align="center-left">RST</text>
<text x="-8.89" y="5.08" size="0.762" layer="25" align="center-left">A0</text>
<text x="-8.89" y="2.54" size="0.762" layer="25" align="center-left">D0</text>
<text x="-8.89" y="0" size="0.762" layer="25" align="center-left">D5</text>
<text x="-8.89" y="-2.54" size="0.762" layer="25" align="center-left">D6</text>
<text x="-8.89" y="-5.08" size="0.762" layer="25" align="center-left">D7</text>
<text x="-8.89" y="-7.62" size="0.762" layer="25" align="center-left">D8</text>
<text x="-8.89" y="-10.16" size="0.762" layer="25" align="center-left">3V3</text>
<text x="11.43" y="-10.16" size="0.762" layer="25" rot="R180" align="center-left">5V</text>
<text x="11.43" y="-7.62" size="0.762" layer="25" rot="R180" align="center-left">GND</text>
<text x="11.43" y="-5.08" size="0.762" layer="25" rot="R180" align="center-left">D4</text>
<text x="11.43" y="-2.54" size="0.762" layer="25" rot="R180" align="center-left">D3</text>
<text x="11.43" y="0" size="0.762" layer="25" rot="R180" align="center-left">D2</text>
<text x="11.43" y="2.54" size="0.762" layer="25" rot="R180" align="center-left">D1</text>
<text x="11.43" y="5.08" size="0.762" layer="25" rot="R180" align="center-left">RX</text>
<text x="11.43" y="7.62" size="0.762" layer="25" rot="R180" align="center-left">TX</text>
<wire x1="-2.54" y1="-19.05" x2="5.08" y2="-19.05" width="0.2032" layer="21"/>
<wire x1="5.08" y1="-19.05" x2="5.08" y2="-13.97" width="0.2032" layer="21"/>
<wire x1="5.08" y1="-13.97" x2="-2.54" y2="-13.97" width="0.2032" layer="21"/>
<wire x1="-2.54" y1="-13.97" x2="-2.54" y2="-19.05" width="0.2032" layer="21"/>
<text x="1.27" y="12.7" size="1.4224" layer="25" align="center">ANTENNA
KEEP CLEAR</text>
<text x="1.27" y="-16.51" size="1.016" layer="25" align="center">USB
MICRO</text>
<wire x1="-6.35" y1="-12.7" x2="-10.16" y2="-12.7" width="0.2032" layer="21"/>
<wire x1="-10.16" y1="-12.7" x2="-10.16" y2="-17.78" width="0.2032" layer="21"/>
<wire x1="-10.16" y1="-17.78" x2="-6.35" y2="-17.78" width="0.2032" layer="21"/>
<wire x1="-6.35" y1="-17.78" x2="-6.35" y2="-12.7" width="0.2032" layer="21"/>
<text x="-8.255" y="-15.24" size="0.635" layer="25" align="center">RESET
SWITCH</text>
</package>
</packages>
<symbols>
<symbol name="WEMOS-D1-MINI" library_version="1">
<description>WeMos.cc
D1 mini
ESP8266 module</description>
<wire x1="-10.16" y1="12.7" x2="-10.16" y2="-12.7" width="0.254" layer="94"/>
<wire x1="-10.16" y1="-12.7" x2="12.7" y2="-12.7" width="0.254" layer="94"/>
<wire x1="12.7" y1="-12.7" x2="12.7" y2="12.7" width="0.254" layer="94"/>
<wire x1="12.7" y1="12.7" x2="-10.16" y2="12.7" width="0.254" layer="94"/>
<pin name="RESET" x="-15.24" y="10.16" visible="pin" length="middle"/>
<pin name="A0" x="-15.24" y="7.62" visible="pin" length="middle"/>
<pin name="D0" x="-15.24" y="5.08" visible="pin" length="middle"/>
<pin name="D5" x="-15.24" y="2.54" visible="pin" length="middle"/>
<pin name="D6" x="-15.24" y="0" visible="pin" length="middle"/>
<pin name="D7" x="-15.24" y="-2.54" visible="pin" length="middle"/>
<pin name="D8" x="-15.24" y="-5.08" visible="pin" length="middle"/>
<pin name="3V3" x="-15.24" y="-7.62" visible="pin" length="middle"/>
<pin name="5V" x="17.78" y="-7.62" visible="pin" length="middle" rot="R180"/>
<pin name="GND" x="17.78" y="-5.08" visible="pin" length="middle" rot="R180"/>
<pin name="D4" x="17.78" y="-2.54" visible="pin" length="middle" rot="R180"/>
<pin name="D3" x="17.78" y="0" visible="pin" length="middle" rot="R180"/>
<pin name="D2" x="17.78" y="2.54" visible="pin" length="middle" rot="R180"/>
<pin name="D1" x="17.78" y="5.08" visible="pin" length="middle" rot="R180"/>
<pin name="RX" x="17.78" y="7.62" visible="pin" length="middle" rot="R180"/>
<pin name="TX" x="17.78" y="10.16" visible="pin" length="middle" rot="R180"/>
<text x="-10.16" y="12.7" size="1.778" layer="95">&gt;Name</text>
<text x="-7.62" y="-15.24" size="1.778" layer="96">&gt;Value</text>
</symbol>
</symbols>
<devicesets>
<deviceset name="WEMOS-D1-MINI" prefix="WEMOS" uservalue="yes" library_version="1">
<description>WeMos.cc
D1 mini
ESP8266 module</description>
<gates>
<gate name="D1" symbol="WEMOS-D1-MINI" x="0" y="0"/>
</gates>
<devices>
<device name="" package="WEMOS-D1-MINI">
<connects>
<connect gate="D1" pin="3V3" pad="3V3"/>
<connect gate="D1" pin="5V" pad="5V"/>
<connect gate="D1" pin="A0" pad="A0"/>
<connect gate="D1" pin="D0" pad="D0"/>
<connect gate="D1" pin="D1" pad="D1"/>
<connect gate="D1" pin="D2" pad="D2"/>
<connect gate="D1" pin="D3" pad="D3"/>
<connect gate="D1" pin="D4" pad="D4"/>
<connect gate="D1" pin="D5" pad="D5"/>
<connect gate="D1" pin="D6" pad="D6"/>
<connect gate="D1" pin="D7" pad="D7"/>
<connect gate="D1" pin="D8" pad="D8"/>
<connect gate="D1" pin="GND" pad="GND"/>
<connect gate="D1" pin="RESET" pad="RESET"/>
<connect gate="D1" pin="RX" pad="RX"/>
<connect gate="D1" pin="TX" pad="TX"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="Resistor" urn="urn:adsk.eagle:library:16378527">
<description>&lt;B&gt;Resistors, Potentiometers, TrimPot</description>
<packages>
<package name="RESC1005X40" urn="urn:adsk.eagle:footprint:16378540/5" library_version="21">
<description>Chip, 1.05 X 0.54 X 0.40 mm body
&lt;p&gt;Chip package with body size 1.05 X 0.54 X 0.40 mm&lt;/p&gt;</description>
<wire x1="0.55" y1="0.636" x2="-0.55" y2="0.636" width="0.127" layer="21"/>
<wire x1="0.55" y1="-0.636" x2="-0.55" y2="-0.636" width="0.127" layer="21"/>
<wire x1="0.55" y1="-0.3" x2="-0.55" y2="-0.3" width="0.12" layer="51"/>
<wire x1="-0.55" y1="-0.3" x2="-0.55" y2="0.3" width="0.12" layer="51"/>
<wire x1="-0.55" y1="0.3" x2="0.55" y2="0.3" width="0.12" layer="51"/>
<wire x1="0.55" y1="0.3" x2="0.55" y2="-0.3" width="0.12" layer="51"/>
<smd name="1" x="-0.5075" y="0" dx="0.5351" dy="0.644" layer="1"/>
<smd name="2" x="0.5075" y="0" dx="0.5351" dy="0.644" layer="1"/>
<text x="0" y="1.271" size="1.27" layer="25" align="bottom-center">&gt;NAME</text>
<text x="0" y="-1.271" size="1.27" layer="27" align="top-center">&gt;VALUE</text>
</package>
<package name="RESC1608X60" urn="urn:adsk.eagle:footprint:16378537/5" library_version="21">
<description>Chip, 1.60 X 0.82 X 0.60 mm body
&lt;p&gt;Chip package with body size 1.60 X 0.82 X 0.60 mm&lt;/p&gt;</description>
<wire x1="0.85" y1="0.8009" x2="-0.85" y2="0.8009" width="0.127" layer="21"/>
<wire x1="0.85" y1="-0.8009" x2="-0.85" y2="-0.8009" width="0.127" layer="21"/>
<wire x1="0.85" y1="-0.475" x2="-0.85" y2="-0.475" width="0.12" layer="51"/>
<wire x1="-0.85" y1="-0.475" x2="-0.85" y2="0.475" width="0.12" layer="51"/>
<wire x1="-0.85" y1="0.475" x2="0.85" y2="0.475" width="0.12" layer="51"/>
<wire x1="0.85" y1="0.475" x2="0.85" y2="-0.475" width="0.12" layer="51"/>
<smd name="1" x="-0.8152" y="0" dx="0.7987" dy="0.9739" layer="1"/>
<smd name="2" x="0.8152" y="0" dx="0.7987" dy="0.9739" layer="1"/>
<text x="0" y="1.4359" size="1.27" layer="25" align="bottom-center">&gt;NAME</text>
<text x="0" y="-1.4359" size="1.27" layer="27" align="top-center">&gt;VALUE</text>
</package>
<package name="RESC2012X65" urn="urn:adsk.eagle:footprint:16378532/5" library_version="21">
<description>Chip, 2.00 X 1.25 X 0.65 mm body
&lt;p&gt;Chip package with body size 2.00 X 1.25 X 0.65 mm&lt;/p&gt;</description>
<wire x1="1.075" y1="1.0241" x2="-1.075" y2="1.0241" width="0.127" layer="21"/>
<wire x1="1.075" y1="-1.0241" x2="-1.075" y2="-1.0241" width="0.127" layer="21"/>
<wire x1="1.075" y1="-0.7" x2="-1.075" y2="-0.7" width="0.12" layer="51"/>
<wire x1="-1.075" y1="-0.7" x2="-1.075" y2="0.7" width="0.12" layer="51"/>
<wire x1="-1.075" y1="0.7" x2="1.075" y2="0.7" width="0.12" layer="51"/>
<wire x1="1.075" y1="0.7" x2="1.075" y2="-0.7" width="0.12" layer="51"/>
<smd name="1" x="-0.9195" y="0" dx="1.0312" dy="1.4202" layer="1"/>
<smd name="2" x="0.9195" y="0" dx="1.0312" dy="1.4202" layer="1"/>
<text x="0" y="1.6591" size="1.27" layer="25" align="bottom-center">&gt;NAME</text>
<text x="0" y="-1.6591" size="1.27" layer="27" align="top-center">&gt;VALUE</text>
</package>
<package name="RESC3216X70" urn="urn:adsk.eagle:footprint:16378539/5" library_version="21">
<description>Chip, 3.20 X 1.60 X 0.70 mm body
&lt;p&gt;Chip package with body size 3.20 X 1.60 X 0.70 mm&lt;/p&gt;</description>
<wire x1="1.7" y1="1.2217" x2="-1.7" y2="1.2217" width="0.127" layer="21"/>
<wire x1="1.7" y1="-1.2217" x2="-1.7" y2="-1.2217" width="0.127" layer="21"/>
<wire x1="1.7" y1="-0.9" x2="-1.7" y2="-0.9" width="0.12" layer="51"/>
<wire x1="-1.7" y1="-0.9" x2="-1.7" y2="0.9" width="0.12" layer="51"/>
<wire x1="-1.7" y1="0.9" x2="1.7" y2="0.9" width="0.12" layer="51"/>
<wire x1="1.7" y1="0.9" x2="1.7" y2="-0.9" width="0.12" layer="51"/>
<smd name="1" x="-1.4754" y="0" dx="1.1646" dy="1.8153" layer="1"/>
<smd name="2" x="1.4754" y="0" dx="1.1646" dy="1.8153" layer="1"/>
<text x="0" y="1.8567" size="1.27" layer="25" align="bottom-center">&gt;NAME</text>
<text x="0" y="-1.8567" size="1.27" layer="27" align="top-center">&gt;VALUE</text>
</package>
<package name="RESC3224X71" urn="urn:adsk.eagle:footprint:16378536/5" library_version="21">
<description>Chip, 3.20 X 2.49 X 0.71 mm body
&lt;p&gt;Chip package with body size 3.20 X 2.49 X 0.71 mm&lt;/p&gt;</description>
<wire x1="1.675" y1="1.6441" x2="-1.675" y2="1.6441" width="0.127" layer="21"/>
<wire x1="1.675" y1="-1.6441" x2="-1.675" y2="-1.6441" width="0.127" layer="21"/>
<wire x1="1.675" y1="-1.32" x2="-1.675" y2="-1.32" width="0.12" layer="51"/>
<wire x1="-1.675" y1="-1.32" x2="-1.675" y2="1.32" width="0.12" layer="51"/>
<wire x1="-1.675" y1="1.32" x2="1.675" y2="1.32" width="0.12" layer="51"/>
<wire x1="1.675" y1="1.32" x2="1.675" y2="-1.32" width="0.12" layer="51"/>
<smd name="1" x="-1.4695" y="0" dx="1.1312" dy="2.6602" layer="1"/>
<smd name="2" x="1.4695" y="0" dx="1.1312" dy="2.6602" layer="1"/>
<text x="0" y="2.2791" size="1.27" layer="25" align="bottom-center">&gt;NAME</text>
<text x="0" y="-2.2791" size="1.27" layer="27" align="top-center">&gt;VALUE</text>
</package>
<package name="RESC5025X71" urn="urn:adsk.eagle:footprint:16378538/5" library_version="21">
<description>Chip, 5.00 X 2.50 X 0.71 mm body
&lt;p&gt;Chip package with body size 5.00 X 2.50 X 0.71 mm&lt;/p&gt;</description>
<wire x1="2.575" y1="1.6491" x2="-2.575" y2="1.6491" width="0.127" layer="21"/>
<wire x1="2.575" y1="-1.6491" x2="-2.575" y2="-1.6491" width="0.127" layer="21"/>
<wire x1="2.575" y1="-1.325" x2="-2.575" y2="-1.325" width="0.12" layer="51"/>
<wire x1="-2.575" y1="-1.325" x2="-2.575" y2="1.325" width="0.12" layer="51"/>
<wire x1="-2.575" y1="1.325" x2="2.575" y2="1.325" width="0.12" layer="51"/>
<wire x1="2.575" y1="1.325" x2="2.575" y2="-1.325" width="0.12" layer="51"/>
<smd name="1" x="-2.3195" y="0" dx="1.2312" dy="2.6702" layer="1"/>
<smd name="2" x="2.3195" y="0" dx="1.2312" dy="2.6702" layer="1"/>
<text x="0" y="2.2841" size="1.27" layer="25" align="bottom-center">&gt;NAME</text>
<text x="0" y="-2.2841" size="1.27" layer="27" align="top-center">&gt;VALUE</text>
</package>
<package name="RESC6332X71" urn="urn:adsk.eagle:footprint:16378533/5" library_version="21">
<description>Chip, 6.30 X 3.20 X 0.71 mm body
&lt;p&gt;Chip package with body size 6.30 X 3.20 X 0.71 mm&lt;/p&gt;</description>
<wire x1="3.225" y1="1.9991" x2="-3.225" y2="1.9991" width="0.127" layer="21"/>
<wire x1="3.225" y1="-1.9991" x2="-3.225" y2="-1.9991" width="0.127" layer="21"/>
<wire x1="3.225" y1="-1.675" x2="-3.225" y2="-1.675" width="0.12" layer="51"/>
<wire x1="-3.225" y1="-1.675" x2="-3.225" y2="1.675" width="0.12" layer="51"/>
<wire x1="-3.225" y1="1.675" x2="3.225" y2="1.675" width="0.12" layer="51"/>
<wire x1="3.225" y1="1.675" x2="3.225" y2="-1.675" width="0.12" layer="51"/>
<smd name="1" x="-2.9695" y="0" dx="1.2312" dy="3.3702" layer="1"/>
<smd name="2" x="2.9695" y="0" dx="1.2312" dy="3.3702" layer="1"/>
<text x="0" y="2.6341" size="1.27" layer="25" align="bottom-center">&gt;NAME</text>
<text x="0" y="-2.6341" size="1.27" layer="27" align="top-center">&gt;VALUE</text>
</package>
<package name="RESAD1176W63L850D250B" urn="urn:adsk.eagle:footprint:16378542/5" library_version="21">
<description>AXIAL Resistor, 11.76 mm pitch, 8.5 mm body length, 2.5 mm body diameter
&lt;p&gt;AXIAL Resistor package with 11.76 mm pitch, 0.63 mm lead diameter, 8.5 mm body length and 2.5 mm body diameter&lt;/p&gt;</description>
<wire x1="-4.25" y1="1.25" x2="-4.25" y2="-1.25" width="0.127" layer="21"/>
<wire x1="-4.25" y1="-1.25" x2="4.25" y2="-1.25" width="0.127" layer="21"/>
<wire x1="4.25" y1="-1.25" x2="4.25" y2="1.25" width="0.127" layer="21"/>
<wire x1="4.25" y1="1.25" x2="-4.25" y2="1.25" width="0.127" layer="21"/>
<wire x1="-4.25" y1="0" x2="-4.911" y2="0" width="0.127" layer="21"/>
<wire x1="4.25" y1="0" x2="4.911" y2="0" width="0.127" layer="21"/>
<wire x1="4.25" y1="-1.25" x2="-4.25" y2="-1.25" width="0.12" layer="51"/>
<wire x1="-4.25" y1="-1.25" x2="-4.25" y2="1.25" width="0.12" layer="51"/>
<wire x1="-4.25" y1="1.25" x2="4.25" y2="1.25" width="0.12" layer="51"/>
<wire x1="4.25" y1="1.25" x2="4.25" y2="-1.25" width="0.12" layer="51"/>
<pad name="1" x="-5.88" y="0" drill="0.83" diameter="1.43"/>
<pad name="2" x="5.88" y="0" drill="0.83" diameter="1.43"/>
<text x="0" y="1.885" size="1.27" layer="25" align="bottom-center">&gt;NAME</text>
<text x="0" y="-1.885" size="1.27" layer="27" align="top-center">&gt;VALUE</text>
</package>
<package name="RESMELF3515" urn="urn:adsk.eagle:footprint:16378534/5" library_version="21">
<description>MELF, 3.50 mm length, 1.52 mm diameter
&lt;p&gt;MELF Resistor package with 3.50 mm length and 1.52 mm diameter&lt;/p&gt;</description>
<wire x1="1.105" y1="1.1825" x2="-1.105" y2="1.1825" width="0.127" layer="21"/>
<wire x1="-1.105" y1="-1.1825" x2="1.105" y2="-1.1825" width="0.127" layer="21"/>
<wire x1="1.85" y1="-0.8" x2="-1.85" y2="-0.8" width="0.12" layer="51"/>
<wire x1="-1.85" y1="-0.8" x2="-1.85" y2="0.8" width="0.12" layer="51"/>
<wire x1="-1.85" y1="0.8" x2="1.85" y2="0.8" width="0.12" layer="51"/>
<wire x1="1.85" y1="0.8" x2="1.85" y2="-0.8" width="0.12" layer="51"/>
<smd name="1" x="-1.6813" y="0" dx="1.1527" dy="1.7371" layer="1"/>
<smd name="2" x="1.6813" y="0" dx="1.1527" dy="1.7371" layer="1"/>
<text x="0" y="1.8175" size="1.27" layer="25" align="bottom-center">&gt;NAME</text>
<text x="0" y="-1.8175" size="1.27" layer="27" align="top-center">&gt;VALUE</text>
</package>
<package name="RESMELF2014" urn="urn:adsk.eagle:footprint:16378535/5" library_version="21">
<description>MELF, 2.00 mm length, 1.40 mm diameter
&lt;p&gt;MELF Resistor package with 2.00 mm length and 1.40 mm diameter&lt;/p&gt;</description>
<wire x1="0.5189" y1="1.114" x2="-0.5189" y2="1.114" width="0.127" layer="21"/>
<wire x1="-0.5189" y1="-1.114" x2="0.5189" y2="-1.114" width="0.127" layer="21"/>
<wire x1="1.05" y1="-0.725" x2="-1.05" y2="-0.725" width="0.12" layer="51"/>
<wire x1="-1.05" y1="-0.725" x2="-1.05" y2="0.725" width="0.12" layer="51"/>
<wire x1="-1.05" y1="0.725" x2="1.05" y2="0.725" width="0.12" layer="51"/>
<wire x1="1.05" y1="0.725" x2="1.05" y2="-0.725" width="0.12" layer="51"/>
<smd name="1" x="-0.9918" y="0" dx="0.9456" dy="1.6" layer="1"/>
<smd name="2" x="0.9918" y="0" dx="0.9456" dy="1.6" layer="1"/>
<text x="0" y="1.749" size="1.27" layer="25" align="bottom-center">&gt;NAME</text>
<text x="0" y="-1.749" size="1.27" layer="27" align="top-center">&gt;VALUE</text>
</package>
<package name="RESMELF5924" urn="urn:adsk.eagle:footprint:16378541/5" library_version="21">
<description>MELF, 5.90 mm length, 2.45 mm diameter
&lt;p&gt;MELF Resistor package with 5.90 mm length and 2.45 mm diameter&lt;/p&gt;</description>
<wire x1="2.1315" y1="1.639" x2="-2.1315" y2="1.639" width="0.127" layer="21"/>
<wire x1="-2.1315" y1="-1.639" x2="2.1315" y2="-1.639" width="0.127" layer="21"/>
<wire x1="3.05" y1="-1.25" x2="-3.05" y2="-1.25" width="0.12" layer="51"/>
<wire x1="-3.05" y1="-1.25" x2="-3.05" y2="1.25" width="0.12" layer="51"/>
<wire x1="-3.05" y1="1.25" x2="3.05" y2="1.25" width="0.12" layer="51"/>
<wire x1="3.05" y1="1.25" x2="3.05" y2="-1.25" width="0.12" layer="51"/>
<smd name="1" x="-2.7946" y="0" dx="1.3261" dy="2.65" layer="1"/>
<smd name="2" x="2.7946" y="0" dx="1.3261" dy="2.65" layer="1"/>
<text x="0" y="2.274" size="1.27" layer="25" align="bottom-center">&gt;NAME</text>
<text x="0" y="-2.274" size="1.27" layer="27" align="top-center">&gt;VALUE</text>
</package>
<package name="RESMELF3218" urn="urn:adsk.eagle:footprint:16378531/5" library_version="21">
<description>MELF, 3.20 mm length, 1.80 mm diameter
&lt;p&gt;MELF Resistor package with 3.20 mm length and 1.80 mm diameter&lt;/p&gt;</description>
<wire x1="0.8815" y1="1.314" x2="-0.8815" y2="1.314" width="0.127" layer="21"/>
<wire x1="-0.8815" y1="-1.314" x2="0.8815" y2="-1.314" width="0.127" layer="21"/>
<wire x1="1.7" y1="-0.925" x2="-1.7" y2="-0.925" width="0.12" layer="51"/>
<wire x1="-1.7" y1="-0.925" x2="-1.7" y2="0.925" width="0.12" layer="51"/>
<wire x1="-1.7" y1="0.925" x2="1.7" y2="0.925" width="0.12" layer="51"/>
<wire x1="1.7" y1="0.925" x2="1.7" y2="-0.925" width="0.12" layer="51"/>
<smd name="1" x="-1.4946" y="0" dx="1.2261" dy="2" layer="1"/>
<smd name="2" x="1.4946" y="0" dx="1.2261" dy="2" layer="1"/>
<text x="0" y="1.949" size="1.27" layer="25" align="bottom-center">&gt;NAME</text>
<text x="0" y="-1.949" size="1.27" layer="27" align="top-center">&gt;VALUE</text>
</package>
<package name="RESAD724W46L381D178B" urn="urn:adsk.eagle:footprint:16378530/5" library_version="21">
<description>Axial Resistor, 7.24 mm pitch, 3.81 mm body length, 1.78 mm body diameter
&lt;p&gt;Axial Resistor package with 7.24 mm pitch (lead spacing), 0.46 mm lead diameter, 3.81 mm body length and 1.78 mm body diameter&lt;/p&gt;</description>
<wire x1="-2.16" y1="1.015" x2="-2.16" y2="-1.015" width="0.127" layer="21"/>
<wire x1="-2.16" y1="-1.015" x2="2.16" y2="-1.015" width="0.127" layer="21"/>
<wire x1="2.16" y1="-1.015" x2="2.16" y2="1.015" width="0.127" layer="21"/>
<wire x1="2.16" y1="1.015" x2="-2.16" y2="1.015" width="0.127" layer="21"/>
<wire x1="-2.16" y1="0" x2="-2.736" y2="0" width="0.127" layer="21"/>
<wire x1="2.16" y1="0" x2="2.736" y2="0" width="0.127" layer="21"/>
<wire x1="2.16" y1="-1.015" x2="-2.16" y2="-1.015" width="0.12" layer="51"/>
<wire x1="-2.16" y1="-1.015" x2="-2.16" y2="1.015" width="0.12" layer="51"/>
<wire x1="-2.16" y1="1.015" x2="2.16" y2="1.015" width="0.12" layer="51"/>
<wire x1="2.16" y1="1.015" x2="2.16" y2="-1.015" width="0.12" layer="51"/>
<pad name="1" x="-3.62" y="0" drill="0.66" diameter="1.26"/>
<pad name="2" x="3.62" y="0" drill="0.66" diameter="1.26"/>
<text x="0" y="1.65" size="1.27" layer="25" align="bottom-center">&gt;NAME</text>
<text x="0" y="-1.65" size="1.27" layer="27" align="top-center">&gt;VALUE</text>
</package>
</packages>
<packages3d>
<package3d name="RESC1005X40" urn="urn:adsk.eagle:package:16378568/5" type="model">
<description>Chip, 1.05 X 0.54 X 0.40 mm body
&lt;p&gt;Chip package with body size 1.05 X 0.54 X 0.40 mm&lt;/p&gt;</description>
<packageinstances>
<packageinstance name="RESC1005X40"/>
</packageinstances>
</package3d>
<package3d name="RESC1608X60" urn="urn:adsk.eagle:package:16378565/5" type="model">
<description>Chip, 1.60 X 0.82 X 0.60 mm body
&lt;p&gt;Chip package with body size 1.60 X 0.82 X 0.60 mm&lt;/p&gt;</description>
<packageinstances>
<packageinstance name="RESC1608X60"/>
</packageinstances>
</package3d>
<package3d name="RESC2012X65" urn="urn:adsk.eagle:package:16378559/5" type="model">
<description>Chip, 2.00 X 1.25 X 0.65 mm body
&lt;p&gt;Chip package with body size 2.00 X 1.25 X 0.65 mm&lt;/p&gt;</description>
<packageinstances>
<packageinstance name="RESC2012X65"/>
</packageinstances>
</package3d>
<package3d name="RESC3216X70" urn="urn:adsk.eagle:package:16378566/5" type="model">
<description>Chip, 3.20 X 1.60 X 0.70 mm body
&lt;p&gt;Chip package with body size 3.20 X 1.60 X 0.70 mm&lt;/p&gt;</description>
<packageinstances>
<packageinstance name="RESC3216X70"/>
</packageinstances>
</package3d>
<package3d name="RESC3224X71" urn="urn:adsk.eagle:package:16378563/7" type="model">
<description>Chip, 3.20 X 2.49 X 0.71 mm body
&lt;p&gt;Chip package with body size 3.20 X 2.49 X 0.71 mm&lt;/p&gt;</description>
<packageinstances>
<packageinstance name="RESC3224X71"/>
</packageinstances>
</package3d>
<package3d name="RESC5025X71" urn="urn:adsk.eagle:package:16378564/5" type="model">
<description>Chip, 5.00 X 2.50 X 0.71 mm body
&lt;p&gt;Chip package with body size 5.00 X 2.50 X 0.71 mm&lt;/p&gt;</description>
<packageinstances>
<packageinstance name="RESC5025X71"/>
</packageinstances>
</package3d>
<package3d name="RESC6332X71L" urn="urn:adsk.eagle:package:16378557/6" type="model">
<description>Chip, 6.30 X 3.20 X 0.71 mm body
&lt;p&gt;Chip package with body size 6.30 X 3.20 X 0.71 mm&lt;/p&gt;</description>
<packageinstances>
<packageinstance name="RESC6332X71"/>
</packageinstances>
</package3d>
<package3d name="RESAD1176W63L850D250B" urn="urn:adsk.eagle:package:16378560/5" type="model">
<description>AXIAL Resistor, 11.76 mm pitch, 8.5 mm body length, 2.5 mm body diameter
&lt;p&gt;AXIAL Resistor package with 11.76 mm pitch, 0.63 mm lead diameter, 8.5 mm body length and 2.5 mm body diameter&lt;/p&gt;</description>
<packageinstances>
<packageinstance name="RESAD1176W63L850D250B"/>
</packageinstances>
</package3d>
<package3d name="RESMELF3515" urn="urn:adsk.eagle:package:16378562/5" type="model">
<description>MELF, 3.50 mm length, 1.52 mm diameter
&lt;p&gt;MELF Resistor package with 3.50 mm length and 1.52 mm diameter&lt;/p&gt;</description>
<packageinstances>
<packageinstance name="RESMELF3515"/>
</packageinstances>
</package3d>
<package3d name="RESMELF2014" urn="urn:adsk.eagle:package:16378558/5" type="model">
<description>MELF, 2.00 mm length, 1.40 mm diameter
&lt;p&gt;MELF Resistor package with 2.00 mm length and 1.40 mm diameter&lt;/p&gt;</description>
<packageinstances>
<packageinstance name="RESMELF2014"/>
</packageinstances>
</package3d>
<package3d name="RESMELF5924" urn="urn:adsk.eagle:package:16378567/6" type="model">
<description>MELF, 5.90 mm length, 2.45 mm diameter
&lt;p&gt;MELF Resistor package with 5.90 mm length and 2.45 mm diameter&lt;/p&gt;</description>
<packageinstances>
<packageinstance name="RESMELF5924"/>
</packageinstances>
</package3d>
<package3d name="RESMELF3218" urn="urn:adsk.eagle:package:16378556/5" type="model">
<description>MELF, 3.20 mm length, 1.80 mm diameter
&lt;p&gt;MELF Resistor package with 3.20 mm length and 1.80 mm diameter&lt;/p&gt;</description>
<packageinstances>
<packageinstance name="RESMELF3218"/>
</packageinstances>
</package3d>
<package3d name="RESAD724W46L381D178B" urn="urn:adsk.eagle:package:16378561/5" type="model">
<description>Axial Resistor, 7.24 mm pitch, 3.81 mm body length, 1.78 mm body diameter
&lt;p&gt;Axial Resistor package with 7.24 mm pitch (lead spacing), 0.46 mm lead diameter, 3.81 mm body length and 1.78 mm body diameter&lt;/p&gt;</description>
<packageinstances>
<packageinstance name="RESAD724W46L381D178B"/>
</packageinstances>
</package3d>
</packages3d>
<symbols>
<symbol name="R" urn="urn:adsk.eagle:symbol:16378529/5" library_version="21">
<description>RESISTOR</description>
<wire x1="-2.54" y1="-0.889" x2="2.54" y2="-0.889" width="0.1524" layer="94"/>
<wire x1="2.54" y1="0.889" x2="-2.54" y2="0.889" width="0.1524" layer="94"/>
<wire x1="2.54" y1="-0.889" x2="2.54" y2="0.889" width="0.1524" layer="94"/>
<wire x1="-2.54" y1="-0.889" x2="-2.54" y2="0.889" width="0.1524" layer="94"/>
<pin name="1" x="-5.08" y="0" visible="off" length="short" direction="pas" swaplevel="1"/>
<pin name="2" x="5.08" y="0" visible="off" length="short" direction="pas" swaplevel="1" rot="R180"/>
<text x="0" y="2.54" size="1.778" layer="95" align="center">&gt;NAME</text>
<text x="0" y="-5.08" size="1.778" layer="95" align="center">&gt;SPICEMODEL</text>
<text x="0" y="-2.54" size="1.778" layer="96" align="center">&gt;VALUE</text>
<text x="0" y="-7.62" size="1.778" layer="95" align="center">&gt;SPICEEXTRA</text>
</symbol>
</symbols>
<devicesets>
<deviceset name="R" urn="urn:adsk.eagle:component:16378570/12" prefix="R" uservalue="yes" library_version="21">
<description>Resistor Fixed - Generic</description>
<gates>
<gate name="G$1" symbol="R" x="0" y="0"/>
</gates>
<devices>
<device name="CHIP-0402(1005-METRIC)" package="RESC1005X40">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:16378568/5"/>
</package3dinstances>
<technologies>
<technology name="_">
<attribute name="CATEGORY" value="Resistors" constant="no"/>
<attribute name="DATASHEET" value="" constant="no"/>
<attribute name="DESCRIPTION" value="Chip Resistor 1.05 X 0.54 X 0.40 mm body 0402(1005-METRIC) Package" constant="no"/>
<attribute name="MANUFACTURER" value="" constant="no"/>
<attribute name="MPN" value="" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="" constant="no"/>
<attribute name="PACKAGE_SIZE" value="0402" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="" constant="no"/>
<attribute name="ROHS" value="" constant="no"/>
<attribute name="SERIES" value="" constant="no"/>
<attribute name="SUBCATEGORY" value="" constant="no"/>
<attribute name="TEMPERATURE_COEFFICIENT" value="" constant="no"/>
<attribute name="THERMALLOSS" value="" constant="no"/>
<attribute name="TOLERANCE" value="" constant="no"/>
<attribute name="TYPE" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="CHIP-0603(1608-METRIC)" package="RESC1608X60">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:16378565/5"/>
</package3dinstances>
<technologies>
<technology name="_">
<attribute name="CATEGORY" value="Resistors" constant="no"/>
<attribute name="DATASHEET" value="" constant="no"/>
<attribute name="DESCRIPTION" value="Chip Resistor 1.60 X 0.82 X 0.60 mm body 0603(1608-METRIC) Package" constant="no"/>
<attribute name="MANUFACTURER" value="" constant="no"/>
<attribute name="MPN" value="" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="" constant="no"/>
<attribute name="PACKAGE_SIZE" value="0603" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="" constant="no"/>
<attribute name="ROHS" value="" constant="no"/>
<attribute name="SERIES" value="" constant="no"/>
<attribute name="SUBCATEGORY" value="" constant="no"/>
<attribute name="TEMPERATURE_COEFFICIENT" value="" constant="no"/>
<attribute name="THERMALLOSS" value="" constant="no"/>
<attribute name="TOLERANCE" value="" constant="no"/>
<attribute name="TYPE" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="CHIP-0805(2012-METRIC)" package="RESC2012X65">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:16378559/5"/>
</package3dinstances>
<technologies>
<technology name="_">
<attribute name="CATEGORY" value="Resistors" constant="no"/>
<attribute name="DATASHEET" value="" constant="no"/>
<attribute name="DESCRIPTION" value="Chip Resistor 2.00 X 1.25 X 0.65 mm body 0805(2012-METRIC) Package" constant="no"/>
<attribute name="MANUFACTURER" value="" constant="no"/>
<attribute name="MPN" value="" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="" constant="no"/>
<attribute name="PACKAGE_SIZE" value="0805" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="" constant="no"/>
<attribute name="ROHS" value="" constant="no"/>
<attribute name="SERIES" value="" constant="no"/>
<attribute name="SUBCATEGORY" value="" constant="no"/>
<attribute name="TEMPERATURE_COEFFICIENT" value="" constant="no"/>
<attribute name="THERMALLOSS" value="" constant="no"/>
<attribute name="TOLERANCE" value="" constant="no"/>
<attribute name="TYPE" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="CHIP-1206(3216-METRIC)" package="RESC3216X70">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:16378566/5"/>
</package3dinstances>
<technologies>
<technology name="_">
<attribute name="CATEGORY" value="Resistors" constant="no"/>
<attribute name="DATASHEET" value="" constant="no"/>
<attribute name="DESCRIPTION" value="Chip Resistor 3.20 X 1.60 X 0.70 mm body 1206(3216-METRIC) Package" constant="no"/>
<attribute name="MANUFACTURER" value="" constant="no"/>
<attribute name="MPN" value="" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1206" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="" constant="no"/>
<attribute name="ROHS" value="" constant="no"/>
<attribute name="SERIES" value="" constant="no"/>
<attribute name="SUBCATEGORY" value="" constant="no"/>
<attribute name="TEMPERATURE_COEFFICIENT" value="" constant="no"/>
<attribute name="THERMALLOSS" value="" constant="no"/>
<attribute name="TOLERANCE" value="" constant="no"/>
<attribute name="TYPE" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="CHIP-1210(3225-METRIC)" package="RESC3224X71">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:16378563/7"/>
</package3dinstances>
<technologies>
<technology name="_">
<attribute name="CATEGORY" value="Resistors" constant="no"/>
<attribute name="DATASHEET" value="" constant="no"/>
<attribute name="DESCRIPTION" value="Chip Resistor 3.20 X 2.49 X 0.71 mm body 1210(3225-METRIC) Package" constant="no"/>
<attribute name="MANUFACTURER" value="" constant="no"/>
<attribute name="MPN" value="" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1210" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="" constant="no"/>
<attribute name="ROHS" value="" constant="no"/>
<attribute name="SERIES" value="" constant="no"/>
<attribute name="SUBCATEGORY" value="" constant="no"/>
<attribute name="TEMPERATURE_COEFFICIENT" value="" constant="no"/>
<attribute name="THERMALLOSS" value="" constant="no"/>
<attribute name="TOLERANCE" value="" constant="no"/>
<attribute name="TYPE" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="CHIP-2010(5025-METRIC)" package="RESC5025X71">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:16378564/5"/>
</package3dinstances>
<technologies>
<technology name="_">
<attribute name="CATEGORY" value="Resistors" constant="no"/>
<attribute name="DATASHEET" value="" constant="no"/>
<attribute name="DESCRIPTION" value="Chip Resistor 5.00 X 2.50 X 0.71 mm body 2010(5025-METRIC) Package" constant="no"/>
<attribute name="MANUFACTURER" value="" constant="no"/>
<attribute name="MPN" value="" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="" constant="no"/>
<attribute name="PACKAGE_SIZE" value="2010" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="" constant="no"/>
<attribute name="ROHS" value="" constant="no"/>
<attribute name="SERIES" value="" constant="no"/>
<attribute name="SUBCATEGORY" value="" constant="no"/>
<attribute name="TEMPERATURE_COEFFICIENT" value="" constant="no"/>
<attribute name="THERMALLOSS" value="" constant="no"/>
<attribute name="TOLERANCE" value="" constant="no"/>
<attribute name="TYPE" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="CHIP-2512(6332-METRIC)" package="RESC6332X71">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:16378557/6"/>
</package3dinstances>
<technologies>
<technology name="_">
<attribute name="CATEGORY" value="Resistors" constant="no"/>
<attribute name="DATASHEET" value="" constant="no"/>
<attribute name="DESCRIPTION" value="Chip Resistor 6.30 X 3.20 X 0.71 mm body 2512(6332-METRIC) Package" constant="no"/>
<attribute name="MANUFACTURER" value="" constant="no"/>
<attribute name="MPN" value="" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="" constant="no"/>
<attribute name="PACKAGE_SIZE" value="2512" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="" constant="no"/>
<attribute name="ROHS" value="" constant="no"/>
<attribute name="SERIES" value="" constant="no"/>
<attribute name="SUBCATEGORY" value="" constant="no"/>
<attribute name="TEMPERATURE_COEFFICIENT" value="" constant="no"/>
<attribute name="THERMALLOSS" value="" constant="no"/>
<attribute name="TOLERANCE" value="" constant="no"/>
<attribute name="TYPE" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="AXIAL-11.7MM-PITCH" package="RESAD1176W63L850D250B">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:16378560/5"/>
</package3dinstances>
<technologies>
<technology name="_">
<attribute name="CATEGORY" value="Resistors" constant="no"/>
<attribute name="DATASHEET" value="" constant="no"/>
<attribute name="DESCRIPTION" value="Axial Resistor 11.76 mm pitch 8.5 mm body length 2.5 mm body diameter" constant="no"/>
<attribute name="MANUFACTURER" value="" constant="no"/>
<attribute name="MPN" value="" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="" constant="no"/>
<attribute name="PACKAGE_SIZE" value="AXIAL" constant="no"/>
<attribute name="PACKAGE_TYPE" value="THT" constant="no"/>
<attribute name="PART_STATUS" value="" constant="no"/>
<attribute name="ROHS" value="" constant="no"/>
<attribute name="SERIES" value="" constant="no"/>
<attribute name="SUBCATEGORY" value="" constant="no"/>
<attribute name="TEMPERATURE_COEFFICIENT" value="" constant="no"/>
<attribute name="THERMALLOSS" value="" constant="no"/>
<attribute name="TOLERANCE" value="" constant="no"/>
<attribute name="TYPE" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="MELF(3515-METRIC)" package="RESMELF3515">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:16378562/5"/>
</package3dinstances>
<technologies>
<technology name="_">
<attribute name="CATEGORY" value="Resistors" constant="no"/>
<attribute name="DATASHEET" value="" constant="no"/>
<attribute name="DESCRIPTION" value="MELF Resistor 3.50 mm length Resistor 1.52 mm diameter 3515-METRIC Package" constant="no"/>
<attribute name="MANUFACTURER" value="" constant="no"/>
<attribute name="MPN" value="" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="" constant="no"/>
<attribute name="PACKAGE_SIZE" value="MELF" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="" constant="no"/>
<attribute name="ROHS" value="" constant="no"/>
<attribute name="SERIES" value="" constant="no"/>
<attribute name="SUBCATEGORY" value="" constant="no"/>
<attribute name="TEMPERATURE_COEFFICIENT" value="" constant="no"/>
<attribute name="THERMALLOSS" value="" constant="no"/>
<attribute name="TOLERANCE" value="" constant="no"/>
<attribute name="TYPE" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="MELF(2014-METRIC)" package="RESMELF2014">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:16378558/5"/>
</package3dinstances>
<technologies>
<technology name="_">
<attribute name="CATEGORY" value="Resistors" constant="no"/>
<attribute name="DATASHEET" value="" constant="no"/>
<attribute name="DESCRIPTION" value="MELF Resistor 2.00 mm length Resistor 1.40 mm diameter 2014-METRIC Package" constant="no"/>
<attribute name="MANUFACTURER" value="" constant="no"/>
<attribute name="MPN" value="" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="" constant="no"/>
<attribute name="PACKAGE_SIZE" value="MELF" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="" constant="no"/>
<attribute name="ROHS" value="" constant="no"/>
<attribute name="SERIES" value="" constant="no"/>
<attribute name="SUBCATEGORY" value="" constant="no"/>
<attribute name="TEMPERATURE_COEFFICIENT" value="" constant="no"/>
<attribute name="THERMALLOSS" value="" constant="no"/>
<attribute name="TOLERANCE" value="" constant="no"/>
<attribute name="TYPE" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="MELF(5924-METRIC)" package="RESMELF5924">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:16378567/6"/>
</package3dinstances>
<technologies>
<technology name="_">
<attribute name="CATEGORY" value="Resistors" constant="no"/>
<attribute name="DATASHEET" value="" constant="no"/>
<attribute name="DESCRIPTION" value="MELF Resistor 5.90 mm length Resistor 2.45 mm diameter 5924-METRIC Package" constant="no"/>
<attribute name="MANUFACTURER" value="" constant="no"/>
<attribute name="MPN" value="" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="" constant="no"/>
<attribute name="PACKAGE_SIZE" value="MELF" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="" constant="no"/>
<attribute name="ROHS" value="" constant="no"/>
<attribute name="SERIES" value="" constant="no"/>
<attribute name="SUBCATEGORY" value="" constant="no"/>
<attribute name="TEMPERATURE_COEFFICIENT" value="" constant="no"/>
<attribute name="THERMALLOSS" value="" constant="no"/>
<attribute name="TOLERANCE" value="" constant="no"/>
<attribute name="TYPE" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="MELF(3218-METRIC)" package="RESMELF3218">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:16378556/5"/>
</package3dinstances>
<technologies>
<technology name="_">
<attribute name="CATEGORY" value="Resistors" constant="no"/>
<attribute name="DATASHEET" value="" constant="no"/>
<attribute name="DESCRIPTION" value="MELF Resistor 3.20 mm length Resistor 1.80 mm diameter 3218-METRIC Package" constant="no"/>
<attribute name="MANUFACTURER" value="" constant="no"/>
<attribute name="MPN" value="" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="" constant="no"/>
<attribute name="PACKAGE_SIZE" value="MELF" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="" constant="no"/>
<attribute name="ROHS" value="" constant="no"/>
<attribute name="SERIES" value="" constant="no"/>
<attribute name="SUBCATEGORY" value="" constant="no"/>
<attribute name="TEMPERATURE_COEFFICIENT" value="" constant="no"/>
<attribute name="THERMALLOSS" value="" constant="no"/>
<attribute name="TOLERANCE" value="" constant="no"/>
<attribute name="TYPE" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="AXIAL-7.2MM-PITCH" package="RESAD724W46L381D178B">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:16378561/5"/>
</package3dinstances>
<technologies>
<technology name="_">
<attribute name="CATEGORY" value="Resistors" constant="no"/>
<attribute name="DATASHEET" value="" constant="no"/>
<attribute name="DESCRIPTION" value="Axial Resistor 7.24 mm pitch 3.81 mm body length 1.78 mm body diameter" constant="no"/>
<attribute name="MANUFACTURER" value="" constant="no"/>
<attribute name="MPN" value="" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="" constant="no"/>
<attribute name="PACKAGE_SIZE" value="AXIAL" constant="no"/>
<attribute name="PACKAGE_TYPE" value="THT" constant="no"/>
<attribute name="PART_STATUS" value="" constant="no"/>
<attribute name="ROHS" value="" constant="no"/>
<attribute name="SERIES" value="" constant="no"/>
<attribute name="SUBCATEGORY" value="" constant="no"/>
<attribute name="TEMPERATURE_COEFFICIENT" value="" constant="no"/>
<attribute name="THERMALLOSS" value="" constant="no"/>
<attribute name="TOLERANCE" value="" constant="no"/>
<attribute name="TYPE" value="" constant="no"/>
</technology>
</technologies>
</device>
</devices>
<spice>
<pinmapping spiceprefix="R">
<pinmap gate="G$1" pin="1" pinorder="1"/>
<pinmap gate="G$1" pin="2" pinorder="2"/>
</pinmapping>
</spice>
</deviceset>
</devicesets>
</library>
<library name="Jaisor Lib" urn="urn:adsk.wipprod:fs.file:vf._iimQKIpT1GV9qWvNx8InQ">
<packages>
<package name="USB-TA-SLD" urn="urn:adsk.eagle:footprint:46693768/4" library_version="31">
<wire x1="-6.225" y1="0.775" x2="-6.225" y2="-0.775" width="0" layer="46"/>
<wire x1="-6.225" y1="-0.775" x2="-5.175" y2="-0.775" width="0" layer="46" curve="180"/>
<wire x1="-5.175" y1="-0.775" x2="-5.175" y2="0.775" width="0" layer="46"/>
<wire x1="-5.175" y1="0.775" x2="-6.225" y2="0.775" width="0" layer="46" curve="180"/>
<wire x1="5.175" y1="0.775" x2="5.175" y2="-0.775" width="0" layer="46"/>
<wire x1="5.175" y1="-0.775" x2="6.225" y2="-0.775" width="0" layer="46" curve="180"/>
<wire x1="6.225" y1="-0.775" x2="6.225" y2="0.775" width="0" layer="46"/>
<wire x1="6.225" y1="0.775" x2="5.175" y2="0.775" width="0" layer="46" curve="180"/>
<wire x1="-6.762" y1="-2.75" x2="6.762" y2="-2.75" width="0.127" layer="51"/>
<wire x1="6.762" y1="-2.75" x2="6.762" y2="3.159" width="0.127" layer="51"/>
<wire x1="6.762" y1="3.159" x2="-6.762" y2="3.159" width="0.127" layer="51"/>
<wire x1="-6.762" y1="-17.927" x2="6.762" y2="-17.927" width="0.127" layer="51"/>
<wire x1="6.762" y1="-17.927" x2="6.762" y2="-2.75" width="0.127" layer="51"/>
<wire x1="-6" y1="-2" x2="-6.635" y2="-2.877" width="0.127" layer="21"/>
<wire x1="-6.635" y1="-2.877" x2="6.762" y2="-2.877" width="0.127" layer="21"/>
<wire x1="6.762" y1="-2.877" x2="6" y2="-2" width="0.127" layer="21"/>
<wire x1="-6.75" y1="3.11" x2="-6.75" y2="-18.05" width="0.05" layer="39"/>
<wire x1="-6.75" y1="-18.05" x2="6.75" y2="-18.05" width="0.05" layer="39"/>
<wire x1="6.75" y1="-18.05" x2="6.75" y2="3.11" width="0.05" layer="39"/>
<wire x1="6.75" y1="3.11" x2="-6.75" y2="3.11" width="0.05" layer="39"/>
<wire x1="-6.635" y1="-2.877" x2="-6.635" y2="-17.927" width="0.127" layer="21"/>
<wire x1="-6.635" y1="-17.927" x2="6.762" y2="-17.927" width="0.127" layer="21"/>
<wire x1="6.762" y1="-17.927" x2="6.762" y2="-2.877" width="0.127" layer="21"/>
<wire x1="-6.635" y1="3.159" x2="6.762" y2="3.159" width="0.127" layer="21"/>
<wire x1="6.762" y1="3.159" x2="6.762" y2="-2.877" width="0.127" layer="21"/>
<wire x1="-6.635" y1="-2.877" x2="-6.635" y2="3.159" width="0.127" layer="21"/>
<wire x1="-6.762" y1="3.159" x2="-6.762" y2="-2.75" width="0.127" layer="51"/>
<wire x1="-6.762" y1="-2.75" x2="-6.762" y2="-17.927" width="0.127" layer="51"/>
<text x="6.28" y="-2.47" size="0.4064" layer="51">PCB EDGE</text>
<text x="-6.9" y="3.6" size="1.27" layer="25">&gt;NAME</text>
<text x="-6.9" y="-18.33" size="1.27" layer="27" align="top-left">&gt;VALUE</text>
<circle x="3.5" y="3.4" radius="0.1" width="0.2" layer="21"/>
<circle x="3.5" y="3.4" radius="0.1" width="0.2" layer="51"/>
<pad name="1" x="3.5" y="2.1" drill="1" shape="square"/>
<pad name="2" x="1" y="2.1" drill="1"/>
<pad name="3" x="-1" y="2.1" drill="1"/>
<pad name="4" x="-3.5" y="2.1" drill="1"/>
<pad name="S2" x="-5.7" y="0" drill="1.05" shape="long" rot="R90"/>
<pad name="S1" x="5.7" y="0" drill="1.05" shape="long" rot="R90"/>
<hole x="2.25" y="-0.762" drill="1.25"/>
<hole x="-2.25" y="-0.762" drill="1.25"/>
</package>
<package name="AHT20" urn="urn:adsk.eagle:footprint:46694042/3" locally_modified="yes" library_version="28" library_locally_modified="yes">
<description>&lt;b&gt;PIN HEADER&lt;/b&gt;</description>
<pad name="VIN" x="-3.81" y="-0.508" drill="1.016" shape="long" rot="R90"/>
<pad name="GND" x="-1.27" y="-0.508" drill="1.016" shape="long" rot="R90"/>
<pad name="SCL" x="1.27" y="-0.508" drill="1.016" shape="long" rot="R90"/>
<pad name="SDA" x="3.81" y="-0.508" drill="1.016" shape="long" rot="R90"/>
<text x="-5.1562" y="1.8288" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-5.08" y="-4.445" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="1.016" y1="-0.254" x2="1.524" y2="0.254" layer="51"/>
<rectangle x1="-1.524" y1="-0.254" x2="-1.016" y2="0.254" layer="51"/>
<rectangle x1="-4.064" y1="-0.254" x2="-3.556" y2="0.254" layer="51"/>
<rectangle x1="3.556" y1="-0.254" x2="4.064" y2="0.254" layer="51"/>
<wire x1="5.08" y1="-1.905" x2="5.08" y2="1.27" width="0.127" layer="21"/>
<wire x1="5.08" y1="1.27" x2="-5.08" y2="1.27" width="0.127" layer="21"/>
<wire x1="-5.08" y1="1.27" x2="-5.08" y2="-1.905" width="0.127" layer="21"/>
<wire x1="-5.08" y1="-1.905" x2="-4.445" y2="-2.54" width="0.127" layer="21"/>
<wire x1="-4.445" y1="-2.54" x2="4.445" y2="-2.54" width="0.127" layer="21"/>
<wire x1="4.445" y1="-2.54" x2="5.08" y2="-1.905" width="0.127" layer="21"/>
</package>
</packages>
<packages3d>
<package3d name="MOLEX_48037-0001" urn="urn:adsk.eagle:package:46693770/4" type="box">
<packageinstances>
<packageinstance name="USB-TA-SLD"/>
</packageinstances>
</package3d>
<package3d name="1X04" urn="urn:adsk.eagle:package:46694044/3" type="model">
<description>&lt;b&gt;PIN HEADER&lt;/b&gt;</description>
<packageinstances>
<packageinstance name="AHT20"/>
</packageinstances>
</package3d>
</packages3d>
<symbols>
<symbol name="USB-TA-SLD" urn="urn:adsk.eagle:symbol:46693769/3" library_version="27">
<wire x1="-5.08" y1="7.62" x2="-5.08" y2="-10.16" width="0.254" layer="94"/>
<wire x1="-5.08" y1="-10.16" x2="5.08" y2="-10.16" width="0.254" layer="94"/>
<wire x1="5.08" y1="-10.16" x2="5.08" y2="7.62" width="0.254" layer="94"/>
<wire x1="5.08" y1="7.62" x2="-5.08" y2="7.62" width="0.254" layer="94"/>
<text x="-5.08" y="8.89" size="1.778" layer="95">&gt;NAME</text>
<text x="-5.08" y="-12.7" size="1.778" layer="96">&gt;VALUE</text>
<pin name="VCC" x="-10.16" y="5.08" length="middle" direction="pwr"/>
<pin name="D-" x="-10.16" y="2.54" length="middle"/>
<pin name="D+" x="-10.16" y="0" length="middle"/>
<pin name="GND" x="-10.16" y="-2.54" length="middle" direction="pwr"/>
<pin name="SHIELD" x="-10.16" y="-7.62" length="middle" direction="pas"/>
</symbol>
<symbol name="AHT20" urn="urn:adsk.eagle:symbol:46694041/2" library_version="25">
<wire x1="-4.826" y1="-5.08" x2="8.89" y2="-5.08" width="0.4064" layer="94"/>
<wire x1="8.89" y1="-5.08" x2="8.89" y2="7.62" width="0.4064" layer="94"/>
<wire x1="8.89" y1="7.62" x2="-4.826" y2="7.62" width="0.4064" layer="94"/>
<wire x1="-4.826" y1="7.62" x2="-4.826" y2="-5.08" width="0.4064" layer="94"/>
<text x="-6.35" y="8.255" size="1.778" layer="95">&gt;NAME</text>
<text x="-6.35" y="-7.62" size="1.778" layer="96">&gt;VALUE</text>
<pin name="VIN" x="-10.16" y="5.08" length="middle" direction="pwr"/>
<pin name="GND" x="-10.16" y="2.54" length="middle" direction="pwr"/>
<pin name="SCL" x="-10.16" y="0" length="middle"/>
<pin name="SDA" x="-10.16" y="-2.54" length="middle"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="USB-TA-SLD" urn="urn:adsk.eagle:component:46693771/4" prefix="J" library_version="31">
<gates>
<gate name="G$1" symbol="USB-TA-SLD" x="0" y="0"/>
</gates>
<devices>
<device name="" package="USB-TA-SLD">
<connects>
<connect gate="G$1" pin="D+" pad="3"/>
<connect gate="G$1" pin="D-" pad="2"/>
<connect gate="G$1" pin="GND" pad="4"/>
<connect gate="G$1" pin="SHIELD" pad="S1 S2"/>
<connect gate="G$1" pin="VCC" pad="1"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:46693770/4"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="MANUFACTURER" value="Molex"/>
<attribute name="MAXIMUM_PACKAGE_HEIGHT" value="4.6mm"/>
<attribute name="PARTREV" value="D"/>
<attribute name="STANDARD" value="Manufacturer Recommendations"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="AHT20" urn="urn:adsk.eagle:component:46694045/3" prefix="JP" library_version="28" library_locally_modified="yes">
<description>&lt;b&gt;PIN HEADER&lt;/b&gt;</description>
<gates>
<gate name="A" symbol="AHT20" x="0" y="0"/>
</gates>
<devices>
<device name="" package="AHT20">
<connects>
<connect gate="A" pin="GND" pad="GND"/>
<connect gate="A" pin="SCL" pad="SCL"/>
<connect gate="A" pin="SDA" pad="SDA"/>
<connect gate="A" pin="VIN" pad="VIN"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:46694044/3"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="CATEGORY" value="Headers" constant="no"/>
<attribute name="DATASHEET" value="" constant="no"/>
<attribute name="DESCRIPTION" value="Header-Straight-4 Position" constant="no"/>
<attribute name="MANUFACTURER" value="" constant="no"/>
<attribute name="MPN" value="" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="" constant="no"/>
<attribute name="PACKAGE_SIZE" value="" constant="no"/>
<attribute name="PACKAGE_TYPE" value="THT" constant="no"/>
<attribute name="PART_STATUS" value="" constant="no"/>
<attribute name="PITCH" value="0.100&quot; (2.54mm)" constant="no"/>
<attribute name="ROHS" value="" constant="no"/>
<attribute name="SERIES" value="" constant="no"/>
<attribute name="SUBCATEGORY" value="Headers-Male Pins" constant="no"/>
<attribute name="THERMALLOSS" value="" constant="no"/>
<attribute name="TYPE" value="Board to Board or Cable-Unshrouded-Through Hole-Straight" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="Bridge Pad" urn="urn:adsk.wipprod:fs.file:vf.oQWzh5Q1QJyMyLjqQiBJig">
<description>&lt;b&gt;Resettable Fuses, Automotive Fuses</description>
<packages>
<package name="JUMPPAD" urn="urn:adsk.eagle:footprint:24934279/1" locally_modified="yes" library_version="2" library_locally_modified="yes">
<description>Chip, 4.55 X 3.24 X 1.25 mm body
 &lt;p&gt;Chip package with body size 4.55 X 3.24 X 1.25 mm&lt;/p&gt;</description>
<smd name="1" x="-1.345" y="0" dx="1.78" dy="3.15" layer="1"/>
<smd name="2" x="1.345" y="0" dx="1.78" dy="3.15" layer="1"/>
<wire x1="-2.365" y1="1.889" x2="2.365" y2="1.889" width="0.12" layer="21"/>
<wire x1="-2.365" y1="-1.889" x2="2.365" y2="-1.889" width="0.12" layer="21"/>
<wire x1="-2.365" y1="-1.705" x2="-2.365" y2="1.705" width="0.12" layer="51"/>
<wire x1="-2.365" y1="1.705" x2="2.365" y2="1.705" width="0.12" layer="51"/>
<wire x1="2.365" y1="1.705" x2="2.365" y2="-1.705" width="0.12" layer="51"/>
<wire x1="2.365" y1="-1.705" x2="-2.365" y2="-1.705" width="0.12" layer="51"/>
<text x="0" y="2.524" size="1.27" layer="25" align="bottom-center">&gt;NAME</text>
<text x="0" y="-2.524" size="1.27" layer="27" align="top-center">&gt;VALUE</text>
</package>
</packages>
<packages3d>
<package3d name="FUSC4532X125" urn="urn:adsk.eagle:package:24934287/4" type="model">
<description>Chip, 4.55 X 3.24 X 1.25 mm body
 &lt;p&gt;Chip package with body size 4.55 X 3.24 X 1.25 mm&lt;/p&gt;</description>
<packageinstances>
<packageinstance name="JUMPPAD"/>
</packageinstances>
</package3d>
</packages3d>
<symbols>
<symbol name="FUSE" urn="urn:adsk.eagle:symbol:24934280/1" library_version="2" library_locally_modified="yes">
<wire x1="-3.81" y1="-0.762" x2="3.81" y2="-0.762" width="0.254" layer="94"/>
<wire x1="3.81" y1="0.762" x2="-3.81" y2="0.762" width="0.254" layer="94"/>
<wire x1="3.81" y1="-0.762" x2="3.81" y2="0.762" width="0.254" layer="94"/>
<wire x1="-3.81" y1="0.762" x2="-3.81" y2="-0.762" width="0.254" layer="94"/>
<wire x1="-2.54" y1="0" x2="2.54" y2="0" width="0.1524" layer="94"/>
<text x="0" y="2.5" size="1.778" layer="95" align="center">&gt;NAME</text>
<text x="0" y="-2.5" size="1.778" layer="96" align="center">&gt;VALUE</text>
<pin name="2" x="5.08" y="0" visible="off" length="short" direction="pas" swaplevel="1" rot="R180"/>
<pin name="1" x="-5.08" y="0" visible="off" length="short" direction="pas" swaplevel="1"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="1812L" urn="urn:adsk.eagle:component:24934292/6" prefix="F" library_version="2" library_locally_modified="yes">
<description>1812L Series PTC provides surface mount overcurrent protection for applications where resettable protection is desired.
&lt;br&gt;&lt;a href="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717"&gt;Datasheet&lt;br&gt;</description>
<gates>
<gate name="G$1" symbol="FUSE" x="0" y="0"/>
</gates>
<devices>
<device name="" package="JUMPPAD">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:24934287/4"/>
</package3dinstances>
<technologies>
<technology name="010">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 30 V 100 mA Ih Surface Mount 1812 (4532 Metric) Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="100 mA" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="30 V" constant="no"/>
<attribute name="MPN" value="1812L010DR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="300 mA" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
<technology name="010/60">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 60 V 100 mA Ih Surface Mount 1812 (4532 Metric) Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="100 mA" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="60 V" constant="no"/>
<attribute name="MPN" value="1812L010/60DR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="300 mA" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
<technology name="014">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 60 V 140 mA Ih Surface Mount 1812 (4532 Metric) Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="140 mA" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="60 V" constant="no"/>
<attribute name="MPN" value="1812L014DR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="340 mA" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
<technology name="020">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 30 V 200 mA Ih Surface Mount 1812 (4532 Metric) Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="200 mA" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="30 V" constant="no"/>
<attribute name="MPN" value="1812L020PR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="400 mA" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
<technology name="020/60">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 60 V 200 mA Ih Surface Mount 1812 (4532 Metric) Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="200 mA" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="60 V" constant="no"/>
<attribute name="MPN" value="1812L020/60DR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="400 mA" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
<technology name="035/30">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 30 V 350 mA Ih Surface Mount 1812 (4532 Metric) Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="350 mA" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="30 V" constant="no"/>
<attribute name="MPN" value="1812L035/30DR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="750 mA" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
<technology name="035/60">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 60 V 350 mA Ih Surface Mount 1812 (4532 Metric) Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="350 mA" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="60 V" constant="no"/>
<attribute name="MPN" value="1812L035/60MR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="700 mA" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
<technology name="050">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 15 V 500 mA Ih Surface Mount 1812 (4532 Metric) Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="500 mA" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="15 V" constant="no"/>
<attribute name="MPN" value="1812L050PR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="1 A" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
<technology name="050/30">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 30 V 500 mA Ih Surface Mount 1812 (4532 Metric) Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="500 mA" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="30 V" constant="no"/>
<attribute name="MPN" value="1812L050/30PR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="1 A" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
<technology name="050/60">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 60 V 500 mA Ih Surface Mount 1812 (4532 Metric) Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="500 mA" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="60 V" constant="no"/>
<attribute name="MPN" value="1812L050/60MR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="1 A" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
<technology name="075">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 13.2 V 750 mA Ih Surface Mount 1812 (4532 Metric) Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="750 mA" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="13.2 V" constant="no"/>
<attribute name="MPN" value="1812L075PR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="1.5 A" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
<technology name="075/24">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 24 V 750 mA Ih Surface Mount 1812 (4532 Metric) Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="750 mA" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="24 V" constant="no"/>
<attribute name="MPN" value="1812L075/24DR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="1.5 A" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
<technology name="075/33">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 33 V 750 mA Ih Surface Mount 1812 (4532 Metric) Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="750 mA" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="33 V" constant="no"/>
<attribute name="MPN" value="1812L075/33DR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="1.5 A" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
<technology name="110">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 8 V 1.1 A Ih Surface Mount 1812 (4532 Metric) Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="1.1 A" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="8 V" constant="no"/>
<attribute name="MPN" value="1812L110PR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="2.2 A" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
<technology name="110/16">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 16 V 1.1 A Ih Surface Mount 1812 (4532 Metric) Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="1.1 A" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="16 V" constant="no"/>
<attribute name="MPN" value="1812L110/16DR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="1.95 A" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
<technology name="110/24">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 24 V 1.1 A Ih Surface Mount 1812 (4532 Metric) Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="1.1 A" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="24 V" constant="no"/>
<attribute name="MPN" value="1812L110/24DR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="1.95 A" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
<technology name="110/33">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 33 V 1.1 A Ih Surface Mount 1812 (4532 Metric) Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="1.1 A" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="33 V" constant="no"/>
<attribute name="MPN" value="1812L110/33MR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="1.95 A" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
<technology name="125/16">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 16 V 1.25 A Ih Surface Mount 1812 (4532 Metric) Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="1.25 A" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="16 V" constant="no"/>
<attribute name="MPN" value="1812L125/16DR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="2.5 A" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
<technology name="125/6">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 6 V 1.25 A Ih Surface Mount 1812 (4532 Metric)  Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="1.25 A" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="6 V" constant="no"/>
<attribute name="MPN" value="1812L125/6PR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="2.5 A" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
<technology name="150">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 8 V 1.25 A Ih Surface Mount 1812 (4532 Metric) Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="1.25 A" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="8 V" constant="no"/>
<attribute name="MPN" value="1812L150ZR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="3 A" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
<technology name="150/12">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 12 V 1.5 A Ih Surface Mount 1812 (4532 Metric) Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="1.5 A" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="12 V" constant="no"/>
<attribute name="MPN" value="1812L150/12DR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="3 A" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
<technology name="150/16">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 16 V 1.5 A Ih Surface Mount 1812 (4532 Metric) Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="1.5 A" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="16 V" constant="no"/>
<attribute name="MPN" value="1812L150/16DR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="3 A" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
<technology name="150/24">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 24 V 1.5 A Ih Surface Mount 1812 (4532 Metric) Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="1.5 A" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="24 V" constant="no"/>
<attribute name="MPN" value="1812L150/24MR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="3 A" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
<technology name="160">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 8 V 1.6 A Ih Surface Mount 1812 (4532 Metric) Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="1.6 A" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="8 V" constant="no"/>
<attribute name="MPN" value="1812L160PR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="2.8 A" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
<technology name="160/12">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 12 V 1.6 A Ih Surface Mount 1812 (4532 Metric) Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="1.6 A" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="12 V" constant="no"/>
<attribute name="MPN" value="1812L160/12DR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="2.8 A" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
<technology name="200/12">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 12 V 2 A Ih Surface Mount 1812 (4532 Metric) Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="2 A" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="12 V" constant="no"/>
<attribute name="MPN" value="1812L200/12DR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="3.5 A" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
<technology name="200/16">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 16 V 2 A Ih Surface Mount 1812 (4532 Metric) Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="2 A" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="16 V" constant="no"/>
<attribute name="MPN" value="1812L200/16DR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="3.5 A" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
<technology name="200TH">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 8 V 2 A Ih Surface Mount 1812 (4532 Metric) Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="2 A" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="8 V" constant="no"/>
<attribute name="MPN" value="1812L200THPR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="3.5 A" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
<technology name="260/12">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 12 V 2.6 A Ih Surface Mount 1812 (4532 Metric) Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="2.6 A" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="12 V" constant="no"/>
<attribute name="MPN" value="1812L260/12MR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="5 A" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
<technology name="260/16">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 16 V 2.6 A Ih Surface Mount 1812 (4532 Metric) Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="2.6 A" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="16 V" constant="no"/>
<attribute name="MPN" value="1812L260/16MR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="5 A" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
<technology name="260TH">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 8 V 2.6 A Ih Surface Mount 1812 (4532 Metric) Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="2.6 A" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="8 V" constant="no"/>
<attribute name="MPN" value="1812L260THDR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="5.2 A" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
<technology name="300">
<attribute name="CATEGORY" value="Fuses" constant="no"/>
<attribute name="DATASHEET" value="https://www.littelfuse.com/assetdocs/resettable-ptcs-1812l-datasheet?assetguid=ca5c80cb-504e-4a8a-8e74-0107520a1717" constant="no"/>
<attribute name="DESCRIPTION" value="Polymeric PTC Resettable Fuse 6 V 3 A Ih Surface Mount 1812 (4532 Metric) Concave" constant="no"/>
<attribute name="HOLD_CURRENT" value="3 A" constant="no"/>
<attribute name="MANUFACTURER" value="Littelfuse Inc." constant="no"/>
<attribute name="MAX_VOLTAGE" value="6 V" constant="no"/>
<attribute name="MPN" value="1812L300MR" constant="no"/>
<attribute name="OPERATING_TEMPERATURE" value="-40°C ~ 85°C" constant="no"/>
<attribute name="PACKAGE_SIZE" value="1812" constant="no"/>
<attribute name="PACKAGE_TYPE" value="SMD" constant="no"/>
<attribute name="PART_STATUS" value="ACTIVE" constant="no"/>
<attribute name="ROHS" value="COMPLIANT" constant="no"/>
<attribute name="SERIES" value="1812L" constant="no"/>
<attribute name="SUBCATEGORY" value="PTC Resettable Fuses" constant="no"/>
<attribute name="THERMALLOSS" value="0.8 W" constant="no"/>
<attribute name="TRIP_CURRENT" value="5 A" constant="no"/>
<attribute name="TYPE" value="Polymeric" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
</libraries>
<attributes>
</attributes>
<variantdefs>
</variantdefs>
<classes>
<class number="0" name="default" width="0" drill="0">
</class>
<class number="1" name="Power" width="0.6096" drill="0">
</class>
<class number="2" name="Signal" width="0.1524" drill="0">
</class>
</classes>
<parts>
<part name="SUPPLY2" library="Power_Symbols" library_urn="urn:adsk.eagle:library:16502351" deviceset="GND" device="" value="GND"/>
<part name="WEMOS1" library="esp8266modules" library_urn="urn:adsk.wipprod:fs.file:vf.rqZeGJ0zQBSPVXdJP1cbFw" deviceset="WEMOS-D1-MINI" device="">
<attribute name="CN" value="ESP8266 D1"/>
</part>
<part name="SUPPLY1" library="Power_Symbols" library_urn="urn:adsk.eagle:library:16502351" deviceset="GND" device="" value="GND"/>
<part name="SUPPLY3" library="Power_Symbols" library_urn="urn:adsk.eagle:library:16502351" deviceset="+5V" device="" value="+5V"/>
<part name="SUPPLY4" library="Power_Symbols" library_urn="urn:adsk.eagle:library:16502351" deviceset="+5V" device="" value="+5V"/>
<part name="SUPPLY5" library="Power_Symbols" library_urn="urn:adsk.eagle:library:16502351" deviceset="+3.3V" device="" value="+3.3V"/>
<part name="SUPPLY6" library="Power_Symbols" library_urn="urn:adsk.eagle:library:16502351" deviceset="+3.3V" device="" value="+3.3V"/>
<part name="SUPPLY7" library="Power_Symbols" library_urn="urn:adsk.eagle:library:16502351" deviceset="GND" device="" value="GND"/>
<part name="SUPPLY8" library="Power_Symbols" library_urn="urn:adsk.eagle:library:16502351" deviceset="GND" device="" value="GND"/>
<part name="SUPPLY9" library="Power_Symbols" library_urn="urn:adsk.eagle:library:16502351" deviceset="+5V" device="" value="+5V"/>
<part name="F1" library="Bridge Pad" library_urn="urn:adsk.wipprod:fs.file:vf.oQWzh5Q1QJyMyLjqQiBJig" deviceset="1812L" device="" package3d_urn="urn:adsk.eagle:package:24934287/4" technology="010"/>
<part name="R4" library="Resistor" library_urn="urn:adsk.eagle:library:16378527" deviceset="R" device="CHIP-0805(2012-METRIC)" package3d_urn="urn:adsk.eagle:package:16378559/5" technology="_" value="1K"/>
<part name="R1" library="Resistor" library_urn="urn:adsk.eagle:library:16378527" deviceset="R" device="CHIP-0805(2012-METRIC)" package3d_urn="urn:adsk.eagle:package:16378559/5" technology="_" value="22.1K"/>
<part name="R2" library="Resistor" library_urn="urn:adsk.eagle:library:16378527" deviceset="R" device="CHIP-0805(2012-METRIC)" package3d_urn="urn:adsk.eagle:package:16378559/5" technology="_" value="100K"/>
<part name="J1" library="Jaisor Lib" library_urn="urn:adsk.wipprod:fs.file:vf._iimQKIpT1GV9qWvNx8InQ" deviceset="USB-TA-SLD" device="" package3d_urn="urn:adsk.eagle:package:46693770/4" value="USB-TA-SLD"/>
<part name="ATH20" library="Jaisor Lib" library_urn="urn:adsk.wipprod:fs.file:vf._iimQKIpT1GV9qWvNx8InQ" deviceset="AHT20" device="" package3d_urn="urn:adsk.eagle:package:46694044/3" value="AHT20"/>
<part name="SUPPLY10" library="Power_Symbols" library_urn="urn:adsk.eagle:library:16502351" deviceset="+V" device="" value="VBUS"/>
</parts>
<sheets>
<sheet>
<plain>
<text x="-12.7" y="76.2" size="1.778" layer="91">Up to 16V for VBUS with given resisor values</text>
</plain>
<instances>
<instance part="SUPPLY2" gate="G$1" x="45.72" y="20.32" smashed="yes">
<attribute name="VALUE" x="45.72" y="17.78" size="1.778" layer="96" align="top-center"/>
</instance>
<instance part="WEMOS1" gate="D1" x="25.4" y="33.02" smashed="yes">
<attribute name="NAME" x="15.24" y="45.72" size="1.778" layer="95"/>
<attribute name="VALUE" x="17.78" y="17.78" size="1.778" layer="96"/>
<attribute name="CN" x="15.24" y="17.78" size="1.778" layer="96"/>
</instance>
<instance part="SUPPLY1" gate="G$1" x="111.76" y="40.64" smashed="yes">
<attribute name="VALUE" x="111.76" y="38.1" size="1.778" layer="96" align="top-center"/>
</instance>
<instance part="SUPPLY3" gate="G$1" x="111.76" y="58.42" smashed="yes">
<attribute name="VALUE" x="111.76" y="63.5" size="1.778" layer="96" align="top-center"/>
</instance>
<instance part="SUPPLY4" gate="G$1" x="50.8" y="25.4" smashed="yes">
<attribute name="VALUE" x="50.8" y="30.48" size="1.778" layer="96" align="top-center"/>
</instance>
<instance part="SUPPLY5" gate="G$1" x="73.66" y="63.5" smashed="yes">
<attribute name="VALUE" x="73.66" y="68.58" size="1.778" layer="96" align="top-center"/>
</instance>
<instance part="SUPPLY6" gate="G$1" x="5.08" y="25.4" smashed="yes">
<attribute name="VALUE" x="5.08" y="30.48" size="1.778" layer="96" align="top-center"/>
</instance>
<instance part="SUPPLY7" gate="G$1" x="76.2" y="43.18" smashed="yes">
<attribute name="VALUE" x="76.2" y="40.64" size="1.778" layer="96" align="top-center"/>
</instance>
<instance part="SUPPLY8" gate="G$1" x="-12.7" y="45.72" smashed="yes">
<attribute name="VALUE" x="-12.7" y="43.18" size="1.778" layer="96" align="top-center"/>
</instance>
<instance part="SUPPLY9" gate="G$1" x="10.16" y="68.58" smashed="yes">
<attribute name="VALUE" x="10.16" y="73.66" size="1.778" layer="96" align="top-center"/>
</instance>
<instance part="F1" gate="G$1" x="5.08" y="66.04" smashed="yes">
<attribute name="NAME" x="5.08" y="68.54" size="1.778" layer="95" align="center"/>
</instance>
<instance part="R4" gate="G$1" x="5.08" y="43.18" smashed="yes">
<attribute name="NAME" x="5.08" y="45.72" size="1.778" layer="95" align="center"/>
<attribute name="VALUE" x="5.08" y="40.64" size="1.778" layer="96" align="center"/>
</instance>
<instance part="R1" gate="G$1" x="-7.62" y="48.26" smashed="yes">
<attribute name="NAME" x="-7.62" y="50.8" size="1.778" layer="95" align="center"/>
<attribute name="VALUE" x="-7.62" y="45.72" size="1.778" layer="96" align="center"/>
</instance>
<instance part="R2" gate="G$1" x="-2.54" y="53.34" smashed="yes" rot="R270">
<attribute name="NAME" x="0" y="53.34" size="1.778" layer="95" rot="R270" align="center"/>
<attribute name="VALUE" x="-5.08" y="53.34" size="1.778" layer="96" rot="R270" align="center"/>
</instance>
<instance part="J1" gate="G$1" x="124.46" y="53.34" smashed="yes">
<attribute name="NAME" x="119.38" y="62.23" size="1.778" layer="95"/>
<attribute name="VALUE" x="119.38" y="40.64" size="1.778" layer="96"/>
</instance>
<instance part="ATH20" gate="A" x="88.9" y="50.8" smashed="yes">
<attribute name="NAME" x="82.55" y="59.055" size="1.778" layer="95"/>
<attribute name="VALUE" x="82.55" y="43.18" size="1.778" layer="96"/>
</instance>
<instance part="SUPPLY10" gate="G$1" x="-2.54" y="71.12" smashed="yes">
<attribute name="VALUE" x="-2.54" y="73.66" size="1.778" layer="96" align="top-center"/>
</instance>
</instances>
<busses>
</busses>
<nets>
<net name="GND" class="1">
<segment>
<pinref part="WEMOS1" gate="D1" pin="GND"/>
<pinref part="SUPPLY2" gate="G$1" pin="GND"/>
<wire x1="45.72" y1="22.86" x2="45.72" y2="27.94" width="0.1524" layer="91"/>
<wire x1="45.72" y1="27.94" x2="43.18" y2="27.94" width="0.1524" layer="91"/>
</segment>
<segment>
<wire x1="78.74" y1="53.34" x2="76.2" y2="53.34" width="0.1524" layer="91"/>
<wire x1="76.2" y1="53.34" x2="76.2" y2="45.72" width="0.1524" layer="91"/>
<pinref part="SUPPLY7" gate="G$1" pin="GND"/>
<pinref part="ATH20" gate="A" pin="GND"/>
</segment>
<segment>
<pinref part="SUPPLY8" gate="G$1" pin="GND"/>
<pinref part="R1" gate="G$1" pin="1"/>
</segment>
<segment>
<pinref part="SUPPLY1" gate="G$1" pin="GND"/>
<wire x1="114.3" y1="50.8" x2="111.76" y2="50.8" width="0.1524" layer="91"/>
<wire x1="111.76" y1="45.72" x2="111.76" y2="43.18" width="0.1524" layer="91"/>
<wire x1="111.76" y1="50.8" x2="111.76" y2="45.72" width="0.1524" layer="91"/>
<wire x1="111.76" y1="45.72" x2="114.3" y2="45.72" width="0.1524" layer="91"/>
<junction x="111.76" y="45.72"/>
<pinref part="J1" gate="G$1" pin="GND"/>
<pinref part="J1" gate="G$1" pin="SHIELD"/>
</segment>
</net>
<net name="+5V" class="1">
<segment>
<pinref part="SUPPLY3" gate="G$1" pin="+5V"/>
<wire x1="111.76" y1="58.42" x2="114.3" y2="58.42" width="0.1524" layer="91"/>
<pinref part="J1" gate="G$1" pin="VCC"/>
</segment>
<segment>
<pinref part="SUPPLY4" gate="G$1" pin="+5V"/>
<wire x1="50.8" y1="25.4" x2="43.18" y2="25.4" width="0.1524" layer="91"/>
<pinref part="WEMOS1" gate="D1" pin="5V"/>
</segment>
<segment>
<pinref part="SUPPLY9" gate="G$1" pin="+5V"/>
<wire x1="10.16" y1="66.04" x2="10.16" y2="68.58" width="0.1524" layer="91"/>
<pinref part="F1" gate="G$1" pin="2"/>
</segment>
</net>
<net name="+3.3V" class="1">
<segment>
<pinref part="WEMOS1" gate="D1" pin="3V3"/>
<pinref part="SUPPLY6" gate="G$1" pin="+3.3V"/>
<wire x1="5.08" y1="25.4" x2="10.16" y2="25.4" width="0.1524" layer="91"/>
</segment>
<segment>
<wire x1="78.74" y1="55.88" x2="73.66" y2="55.88" width="0.1524" layer="91"/>
<wire x1="73.66" y1="55.88" x2="73.66" y2="63.5" width="0.1524" layer="91"/>
<pinref part="SUPPLY5" gate="G$1" pin="+3.3V"/>
<pinref part="ATH20" gate="A" pin="VIN"/>
</segment>
</net>
<net name="N$4" class="2">
<segment>
<wire x1="0" y1="43.18" x2="0" y2="38.1" width="0.1524" layer="91"/>
<wire x1="0" y1="38.1" x2="10.16" y2="38.1" width="0.1524" layer="91"/>
<pinref part="WEMOS1" gate="D1" pin="D0"/>
<pinref part="R4" gate="G$1" pin="1"/>
</segment>
</net>
<net name="N$5" class="2">
<segment>
<pinref part="WEMOS1" gate="D1" pin="A0"/>
<wire x1="10.16" y1="40.64" x2="-2.54" y2="40.64" width="0.1524" layer="91"/>
<wire x1="-2.54" y1="40.64" x2="-2.54" y2="48.26" width="0.1524" layer="91"/>
<pinref part="R1" gate="G$1" pin="2"/>
<pinref part="R2" gate="G$1" pin="2"/>
<junction x="-2.54" y="48.26"/>
</segment>
</net>
<net name="N$3" class="2">
<segment>
<pinref part="WEMOS1" gate="D1" pin="RESET"/>
<pinref part="R4" gate="G$1" pin="2"/>
</segment>
</net>
<net name="N$1" class="0">
<segment>
<wire x1="78.74" y1="50.8" x2="45.72" y2="50.8" width="0.1524" layer="91"/>
<wire x1="45.72" y1="50.8" x2="45.72" y2="38.1" width="0.1524" layer="91"/>
<wire x1="45.72" y1="38.1" x2="43.18" y2="38.1" width="0.1524" layer="91"/>
<pinref part="WEMOS1" gate="D1" pin="D1"/>
<pinref part="ATH20" gate="A" pin="SCL"/>
</segment>
</net>
<net name="N$2" class="0">
<segment>
<pinref part="WEMOS1" gate="D1" pin="D2"/>
<wire x1="43.18" y1="35.56" x2="48.26" y2="35.56" width="0.1524" layer="91"/>
<wire x1="48.26" y1="35.56" x2="48.26" y2="48.26" width="0.1524" layer="91"/>
<wire x1="48.26" y1="48.26" x2="78.74" y2="48.26" width="0.1524" layer="91"/>
<pinref part="ATH20" gate="A" pin="SDA"/>
</segment>
</net>
<net name="VBUS" class="0">
<segment>
<pinref part="SUPPLY10" gate="G$1" pin="+V"/>
<wire x1="-2.54" y1="68.58" x2="-2.54" y2="66.04" width="0.1524" layer="91"/>
<wire x1="-2.54" y1="58.42" x2="-2.54" y2="66.04" width="0.1524" layer="91"/>
<wire x1="-2.54" y1="66.04" x2="0" y2="66.04" width="0.1524" layer="91"/>
<pinref part="R2" gate="G$1" pin="1"/>
<pinref part="F1" gate="G$1" pin="1"/>
<junction x="-2.54" y="66.04"/>
</segment>
</net>
</nets>
</sheet>
</sheets>
</schematic>
</drawing>
<compatibility>
<note version="6.3" minversion="6.2.2" severity="warning">
Since Version 6.2.2 text objects can contain more than one line,
which will not be processed correctly with this version.
</note>
<note version="8.2" severity="warning">
Since Version 8.2, EAGLE supports online libraries. The ids
of those online libraries will not be understood (or retained)
with this version.
</note>
<note version="8.3" severity="warning">
Since Version 8.3, EAGLE supports URNs for individual library
assets (packages, symbols, and devices). The URNs of those assets
will not be understood (or retained) with this version.
</note>
<note version="8.3" severity="warning">
Since Version 8.3, EAGLE supports the association of 3D packages
with devices in libraries, schematics, and board files. Those 3D
packages will not be understood (or retained) with this version.
</note>
<note version="8.4" severity="warning">
Since Version 8.4, EAGLE supports properties for SPICE simulation. 
Probes in schematics and SPICE mapping objects found in parts and library devices
will not be understood with this version. Update EAGLE to the latest version
for full support of SPICE simulation. 
</note>
</compatibility>
</eagle>
