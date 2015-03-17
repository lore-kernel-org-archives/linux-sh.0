From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 17 Mar 2015 07:15:23 +0000
Subject: [RFC V2 3/4] ARM: shmobile: r8a7790: lager: add i2c-demuxer to dts
Message-Id: <1426576524-22315-4-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Changes since RFC V1: rebased, added the sound-codec entry, fixed a typo

 arch/arm/boot/dts/r8a7790-lager.dts | 66 ++++++++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 0c3b6783b72add..bf0065d676428d 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -222,6 +222,40 @@
 			};
 		};
 	};
+
+	i2c-demux {
+
+		compatible = "i2c-demux-pinctrl";
+		i2c-parent = <&iic2>, <&i2c2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+
+			ak4643: sound-codec@12 {
+				compatible = "asahi-kasei,ak4643";
+				#sound-dai-cells = <0>;
+				reg = <0x12>;
+			};
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
 };
 
 &du {
@@ -303,6 +337,11 @@
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
@@ -481,31 +520,18 @@
 	pinctrl-names = "default";
 };
 
+&i2c2	{
+	status = "ok";
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "active";
+};
+
 &iic2	{
 	status = "okay";
 	pinctrl-0 = <&iic2_pins>;
-	pinctrl-names = "default";
+	pinctrl-names = "active";
 
 	clock-frequency = <100000>;
-
-	ak4643: sound-codec@12 {
-		compatible = "asahi-kasei,ak4643";
-		#sound-dai-cells = <0>;
-		reg = <0x12>;
-	};
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
 };
 
 &iic3 {
-- 
2.1.4

