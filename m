From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 29 Apr 2015 20:46:41 +0000
Subject: [PATCH v3 2/3] ARM: shmobile: r8a7790: lager: add i2c-demuxer to dts
Message-Id: <1430340402-21586-3-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

WIP/HACK! Not for upstream!

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 129 +++++++++++-------------------------
 1 file changed, 39 insertions(+), 90 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index aaa4f258e279cc..53aa867653e9fa 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -49,6 +49,7 @@
 	aliases {
 		serial0 = &scifa0;
 		serial1 = &scifa1;
+		i2c8 = &i2cbus8;
 	};
 
 	chosen {
@@ -223,17 +224,6 @@
 		};
 	};
 
-	hdmi-out {
-		compatible = "hdmi-connector";
-		type = "a";
-
-		port {
-			hdmi_con: endpoint {
-				remote-endpoint = <&adv7511_out>;
-			};
-		};
-	};
-
 	x2_clk: x2-clock {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -245,35 +235,36 @@
 		#clock-cells = <0>;
 		clock-frequency = <148500000>;
 	};
-};
 
-&du {
-	pinctrl-0 = <&du_pins>;
-	pinctrl-names = "default";
-	status = "okay";
+	i2cbus@8 {
 
-	clocks = <&mstp7_clks R8A7790_CLK_DU0>,
-		 <&mstp7_clks R8A7790_CLK_DU1>,
-		 <&mstp7_clks R8A7790_CLK_DU2>,
-		 <&mstp7_clks R8A7790_CLK_LVDS0>,
-		 <&mstp7_clks R8A7790_CLK_LVDS1>,
-		 <&x13_clk>, <&x2_clk>;
-	clock-names = "du.0", "du.1", "du.2", "lvds.0", "lvds.1",
-		      "dclkin.0", "dclkin.1";
-
-	ports {
-		port@0 {
-			endpoint {
-				remote-endpoint = <&adv7123_in>;
-			};
-		};
-		port@1 {
-			endpoint {
-				remote-endpoint = <&adv7511_in>;
+		compatible = "i2c-demux-pinctrl";
+		i2c-parent = <&iic2>, <&i2c2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2cbus8: i2c8@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ak4643: sound-codec@12 {
+				compatible = "asahi-kasei,ak4643";
+				#sound-dai-cells = <0>;
+				reg = <0x12>;
 			};
-		};
-		port@2 {
-			lvds_connector: endpoint {
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
 			};
 		};
 	};
@@ -340,6 +331,11 @@
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
@@ -518,63 +514,16 @@
 	pinctrl-names = "default";
 };
 
+&i2c2	{
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "active";
+};
+
 &iic2	{
-	status = "okay";
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
-
-	hdmi@39 {
-		compatible = "adi,adv7511w";
-		reg = <0x39>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
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
-
-			port@1 {
-				reg = <1>;
-				adv7511_out: endpoint {
-					remote-endpoint = <&hdmi_con>;
-				};
-			};
-		};
-	};
 };
 
 &iic3 {
-- 
2.1.4

