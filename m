From: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Date: Fri, 04 Jul 2014 00:19:51 +0000
Subject: [PATCH v2] ARM: shmobile: Lager: Correct I2C bus for VDD MPU regulator
Message-Id: <53B5F327.5040301@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I2C bus for VDD MPU regulator is IIC3, not I2C3.

Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
---
v2:
  - re-based on top of tag renesas-devel-v3.16-rc3-20140701.
  - removed redundant spaces.

 arch/arm/boot/dts/r8a7790-lager.dts |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 544202b..ffe0523 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -215,9 +215,9 @@
 		renesas,function = "i2c2";
 	};
 
-	i2c3_pins: i2c3 {
-		renesas,groups = "i2c3";
-		renesas,function = "i2c3";
+	iic3_pins: iic3 {
+		renesas,groups = "iic3";
+		renesas,function = "iic3";
 	};
 
 	usb0_pins: usb0 {
@@ -368,9 +368,9 @@
 	pinctrl-names = "default";
 };
 
-&i2c3 {
+&iic3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c3_pins>;
+	pinctrl-0 = <&iic3_pins>;
 	status = "okay";
 
 	vdd_dvfs: regulator@68 {
-- 
1.7.9.5
