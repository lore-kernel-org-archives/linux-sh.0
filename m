From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 07 Jan 2016 20:50:59 +0000
Subject: [PATCH 1/2] dt-bindings: move I2C eeprom descriptions to the proper file
Message-Id: <1452199860-3601-2-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1452199860-3601-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1452199860-3601-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Simon Horman <horms@verge.net.au>, linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

EEPROMs can have additional properties, so they are not suitable for
trivial-devices.txt. Move most bindings to the designated eeprom.txt.
Add the missing "atmel,24c08" while doing that. Note that the remaining
ones in trivial-devices need to be dealt with seperately because of
improper manufacturer names.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/devicetree/bindings/eeprom/eeprom.txt   | 19 ++++++++++++++-----
 .../devicetree/bindings/i2c/trivial-devices.txt       | 13 -------------
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/eeprom/eeprom.txt b/Documentation/devicetree/bindings/eeprom/eeprom.txt
index 4342c10de1bf8d..acb600399c3d94 100644
--- a/Documentation/devicetree/bindings/eeprom/eeprom.txt
+++ b/Documentation/devicetree/bindings/eeprom/eeprom.txt
@@ -2,11 +2,20 @@ EEPROMs (I2C)
 
 Required properties:
 
-  - compatible : should be "<manufacturer>,<type>"
-		 If there is no specific driver for <manufacturer>, a generic
-		 driver based on <type> is selected. Possible types are:
-		 24c00, 24c01, 24c02, 24c04, 24c08, 24c16, 24c32, 24c64,
-		 24c128, 24c256, 24c512, 24c1024, spd
+  - compatible : should be "<manufacturer>,<type>", like these:
+
+	"atmel,24c00", "atmel,24c01", "atmel,24c02", "atmel,24c04",
+	"atmel,24c08", "atmel,24c16", "atmel,24c32", "atmel,24c64",
+	"atmel,24c128", "atmel,24c256", "atmel,24c512", "atmel,24c1024"
+
+	"catalyst,24c32"
+
+	"ramtron,24c64"
+
+	 If there is no specific driver for <manufacturer>, a generic
+	 driver based on <type> is selected. Possible types are:
+	 "24c00", "24c01", "24c02", "24c04", "24c08", "24c16", "24c32", "24c64",
+	 "24c128", "24c256", "24c512", "24c1024", "spd"
 
   - reg : the I2C address of the EEPROM
 
diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index c50cf13c852e51..7e41304e45f81e 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -21,21 +21,9 @@ adi,adt7490		+/-1C TDM Extended Temp Range I.C
 adi,adxl345		Three-Axis Digital Accelerometer
 adi,adxl346		Three-Axis Digital Accelerometer (backward-compatibility value "adi,adxl345" must be listed too)
 at,24c08		i2c serial eeprom  (24cxx)
-atmel,24c00		i2c serial eeprom  (24cxx)
-atmel,24c01		i2c serial eeprom  (24cxx)
-atmel,24c02		i2c serial eeprom  (24cxx)
-atmel,24c04		i2c serial eeprom  (24cxx)
-atmel,24c16		i2c serial eeprom  (24cxx)
-atmel,24c32		i2c serial eeprom  (24cxx)
-atmel,24c64		i2c serial eeprom  (24cxx)
-atmel,24c128		i2c serial eeprom  (24cxx)
-atmel,24c256		i2c serial eeprom  (24cxx)
-atmel,24c512		i2c serial eeprom  (24cxx)
-atmel,24c1024		i2c serial eeprom  (24cxx)
 atmel,at97sc3204t	i2c trusted platform module (TPM)
 capella,cm32181		CM32181: Ambient Light Sensor
 capella,cm3232		CM3232: Ambient Light Sensor
-catalyst,24c32		i2c serial eeprom
 cirrus,cs42l51		Cirrus Logic CS42L51 audio codec
 dallas,ds1307		64 x 8, Serial, I2C Real-Time Clock
 dallas,ds1338		I2C RTC with 56-Byte NV RAM
@@ -80,7 +68,6 @@ ovti,ov5642		OV5642: Color CMOS QSXGA (5-megapixel) Image Sensor with OmniBSI an
 pericom,pt7c4338	Real-time Clock Module
 plx,pex8648		48-Lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
 pulsedlight,lidar-lite-v2	Pulsedlight LIDAR range-finding sensor
-ramtron,24c64		i2c serial eeprom  (24cxx)
 ricoh,r2025sd		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
 ricoh,r2221tl		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
 ricoh,rs5c372a		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
-- 
2.1.4

