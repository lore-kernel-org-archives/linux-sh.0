From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 06 Jan 2016 13:51:25 +0000
Subject: [RFC v2 4/4] ARM: shmobile: r8a7790: rework dts to use i2c demuxer
Message-Id: <1452088285-6427-5-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1452088285-6427-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1452088285-6427-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Jan Luebbe <jlu@pengutronix.de>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Create a seperate bus for HDMI related I2C slaves and assign it
to a i2c-gpio master. It can be switched to the i2c-rcar or
i2c-sh_mobile core at runtime.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 141 ++++++++++++++++++++++--------------
 1 file changed, 88 insertions(+), 53 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index c553abd711eeb3..d8f0ca8e094dad 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -49,6 +49,8 @@
 	aliases {
 		serial0 = &scifa0;
 		serial1 = &scifa1;
+		i2c8 = &i2chdmi;
+		i2c9 = &gpioi2c;
 	};
 
 	chosen {
@@ -252,6 +254,79 @@
 		#clock-cells = <0>;
 		clock-frequency = <148500000>;
 	};
+
+
+	gpioi2c: i2c@9 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "i2c-gpio";
+		status = "disabled";
+		gpios = <&gpio5 6 GPIO_ACTIVE_HIGH /* sda */
+			 &gpio5 5 GPIO_ACTIVE_HIGH /* scl */
+			>;
+		i2c-gpio,delay-us = <5>;
+	};
+
+	i2chdmi: i2c@8 {
+
+		compatible = "i2c-demux-pinctrl";
+		i2c-parent = <&gpioi2c>, <&iic2>, <&i2c2>;
+		i2c-bus-name = "i2c-hdmi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ak4643: sound-codec@12 {
+			compatible = "asahi-kasei,ak4643";
+
+			#sound-dai-cells = <0>;
+			reg = <0x12>;
+		};
+
+		composite-in@20 {
+			compatible = "adi,adv7180";
+			reg = <0x20>;
+			remote = <&vin1>;
+
+			port {
+				adv7180: endpoint {
+					bus-width = <8>;
+					remote-endpoint = <&vin1ep0>;
+				};
+			};
+		};
+
+		hdmi@39 {
+			compatible = "adi,adv7511w";
+			reg = <0x39>;
+			interrupt-parent = <&gpio1>;
+			interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
+
+			adi,input-depth = <8>;
+			adi,input-colorspace = "rgb";
+			adi,input-clock = "1x";
+			adi,input-style = <1>;
+			adi,input-justification = "evenly";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					adv7511_in: endpoint {
+						remote-endpoint = <&du_out_lvds0>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					adv7511_out: endpoint {
+						remote-endpoint = <&hdmi_con>;
+					};
+				};
+			};
+		};
+	};
 };
 
 &du {
@@ -352,6 +427,11 @@
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
@@ -532,63 +612,18 @@
 	pinctrl-names = "default";
 };
 
-&iic2	{
-	status = "okay";
-	pinctrl-0 = <&iic2_pins>;
-	pinctrl-names = "default";
+&i2c2	{
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "i2c-hdmi";
 
 	clock-frequency = <100000>;
+};
 
-	ak4643: codec@12 {
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
-
-	hdmi@39 {
-		compatible = "adi,adv7511w";
-		reg = <0x39>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
-
-		adi,input-depth = <8>;
-		adi,input-colorspace = "rgb";
-		adi,input-clock = "1x";
-		adi,input-style = <1>;
-		adi,input-justification = "evenly";
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
-				adv7511_in: endpoint {
-					remote-endpoint = <&du_out_lvds0>;
-				};
-			};
+&iic2	{
+	pinctrl-0 = <&iic2_pins>;
+	pinctrl-names = "i2c-hdmi";
 
-			port@1 {
-				reg = <1>;
-				adv7511_out: endpoint {
-					remote-endpoint = <&hdmi_con>;
-				};
-			};
-		};
-	};
+	clock-frequency = <100000>;
 };
 
 &iic3 {
-- 
2.1.4

