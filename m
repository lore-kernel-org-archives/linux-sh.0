From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 15 Dec 2014 20:20:16 +0000
Subject: [RFC 3/4] ARM: shmobile: r8a7790: lager: add i2c-demuxer to dts
Message-Id: <1418674817-12809-4-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 54 +++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 69098b906b39..4895eabc502d 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -144,6 +144,34 @@
 		states = <3300000 1
 			  1800000 0>;
 	};
+
+	i2c-demux {
+
+		compatible = "i2c-demux-pinctrl";
+		i2c-parent = <&iic2>, <&i2c2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c@2 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			composite-in@20 {
+				compatible = "adi,adv7180";
+				reg = <0x20>;
+				remote = <&vin1>;
+
+				port {
+					adv7180: endpoint {
+						bus-width = <8>;
+						remote-endpoint = <&vin1ep0>;
+					};
+				};
+			};
+		};
+	};
+
 };
 
 &extal_clk {
@@ -210,6 +238,11 @@
 		renesas,function = "iic1";
 	};
 
+	i2c2_pins: i2c2 {
+		renesas,groups = "i2c2";
+		renesas,function = "i2c2";
+	};
+
 	iic2_pins: iic2 {
 		renesas,groups = "iic2";
 		renesas,function = "iic2";
@@ -371,23 +404,16 @@
 	pinctrl-names = "default";
 };
 
+&i2c2	{
+	status = "ok";
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "active";
+};
+
 &iic2	{
 	status = "ok";
 	pinctrl-0 = <&iic2_pins>;
-	pinctrl-names = "default";
-
-	composite-in@20 {
-		compatible = "adi,adv7180";
-		reg = <0x20>;
-		remote = <&vin1>;
-
-		port {
-			adv7180: endpoint {
-				bus-width = <8>;
-				remote-endpoint = <&vin1ep0>;
-			};
-		};
-	};
+	pinctrl-names = "active";
 };
 
 &iic3 {
-- 
2.1.3

