From: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Date: Thu, 03 Jul 2014 01:05:01 +0000
Subject: [PATCH] ARM: shmobile: Lager: Correct I2C bus for VDD MPU regulator
Message-Id: <53B4AC3D.30801@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I2C bus for VDD MPU regulator is IIC3, not I2C3.

Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
---
  arch/arm/boot/dts/r8a7790-lager.dts |   10 +++++-----
  1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts 
b/arch/arm/boot/dts/r8a7790-lager.dts
index 0890d47..a8f32d7 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -215,9 +215,9 @@
          renesas,function = "i2c2";
      };

-    i2c3_pins: i2c3 {
-        renesas,groups = "i2c3";
-        renesas,function = "i2c3";
+    iic3_pins: iic3 {
+        renesas,groups = "iic3";
+        renesas,function = "iic3";
      };
  };

@@ -353,9 +353,9 @@
      pinctrl-names = "default";
  };

-&i2c3 {
+&iic3 {
      pinctrl-names = "default";
-    pinctrl-0 = <&i2c3_pins>;
+    pinctrl-0 = <&iic3_pins>;
      status = "okay";

      vdd_dvfs: regulator@68 {
-- 
1.7.9.5
