From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 16 Nov 2015 09:15:32 +0000
Subject: [PATCH 02/02] ARM: shmobile: r8a7793: gose: HDMI prototype hack
Message-Id: <20151116091532.20711.41502.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

This prototype patch adds r8a7793 GOSE HDMI video out support.

The r8a7793 GOSE board is similar to r8a7791 Koelsch. For those
boards an on-board HDMI encoder chip drives an HDMI port and
also a LVDS port is available for external LCD panels.

Basic testing with modetest seems to work well, but due to the
current state of r8a7793 SoC support all the dependencies are
not yet in place. In particular I2C and GPIO are lacking.

To check if the DU and HDMI drivers and hardware are working this
patch simply ties together I2C2 and GPIO3 with the DU and HDMI
devices. Once I2C and GPIO is enabled in upstream for r8a7793 and
GOSE then this patch can easily be reworked into something more
suitable for upstream.

Not-yet-Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/boot/dts/r8a7793-gose.dts |   98 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7793.dtsi     |   33 +++++++++++-
 2 files changed, 128 insertions(+), 3 deletions(-)

--- 0001/arch/arm/boot/dts/r8a7793-gose.dts
+++ work/arch/arm/boot/dts/r8a7793-gose.dts	2015-11-16 15:31:42.150513000 +0900
@@ -31,6 +31,54 @@
 		device_type = "memory";
 		reg = <0 0x40000000 0 0x40000000>;
 	};
+
+	hdmi-out {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con: endpoint {
+				remote-endpoint = <&adv7511_out>;
+			};
+		};
+	};
+
+	x2_clk: x2-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <74250000>;
+	};
+
+	x13_clk: x13-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <148500000>;
+	};
+};
+
+&du {
+	pinctrl-0 = <&du_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	clocks = <&mstp7_clks R8A7793_CLK_DU0>,
+		 <&mstp7_clks R8A7793_CLK_DU1>,
+		 <&mstp7_clks R8A7793_CLK_LVDS0>,
+		 <&x13_clk>, <&x2_clk>;
+	clock-names = "du.0", "du.1", "lvds.0",
+		      "dclkin.0", "dclkin.1";
+
+	ports {
+		port@0 {
+			endpoint {
+				remote-endpoint = <&adv7511_in>;
+			};
+		};
+		port@1 {
+			lvds_connector: endpoint {
+			};
+		};
+	};
 };
 
 &extal_clk {
@@ -38,6 +86,16 @@
 };
 
 &pfc {
+	i2c2_pins: i2c2 {
+		renesas,groups = "i2c2";
+		renesas,function = "i2c2";
+	};
+
+	du_pins: du {
+		renesas,groups = "du_rgb666", "du_sync", "du_disp", "du_clk_out_0";
+		renesas,function = "du";
+	};
+
 	scif0_pins: serial0 {
 		renesas,groups = "scif0_data_d";
 		renesas,function = "scif0";
@@ -134,4 +192,44 @@
 			};
 		};
 	};
+};
+
+&i2c2 {
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	clock-frequency = <100000>;
+
+	hdmi@39 {
+		compatible = "adi,adv7511w";
+		reg = <0x39>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
+
+		adi,input-depth = <8>;
+		adi,input-colorspace = "rgb";
+		adi,input-clock = "1x";
+		adi,input-style = <1>;
+		adi,input-justification = "evenly";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				adv7511_in: endpoint {
+					remote-endpoint = <&du_out_rgb>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				adv7511_out: endpoint {
+					remote-endpoint = <&hdmi_con>;
+				};
+			};
+		};
+	};
 };
--- 0013/arch/arm/boot/dts/r8a7793.dtsi
+++ work/arch/arm/boot/dts/r8a7793.dtsi	2015-11-16 15:34:33.710513000 +0900
@@ -19,6 +19,7 @@
 	#size-cells = <2>;
 
 	aliases {
+		i2c2 = &i2c2;
 		spi0 = &qspi;
 	};
 
@@ -57,6 +58,19 @@
 		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	gpio3: gpio@e6053000 {
+		compatible = "renesas,gpio-r8a7793", "renesas,gpio-rcar";
+		reg = <0 0xe6053000 0 0x50>;
+		interrupts = <0 7 IRQ_TYPE_LEVEL_HIGH>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 96 32>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		clocks = <&mstp9_clks R8A7793_CLK_GPIO3>;
+		power-domains = <&cpg_clocks>;
+	};
+
 	thermal@e61f0000 {
 		compatible = "renesas,thermal-r8a7793", "renesas,rcar-thermal";
 		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
@@ -194,6 +208,17 @@
 		dma-channels = <15>;
 	};
 
+	i2c2: i2c@e6530000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7793";
+		reg = <0 0xe6530000 0 0x40>;
+		interrupts = <0 286 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7793_CLK_I2C2>;
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
 	scif0: serial@e6e60000 {
 		compatible = "renesas,scif-r8a7793", "renesas,scif";
 		reg = <0 0xe6e60000 0 64>;
@@ -514,10 +539,12 @@
 		mstp9_clks: mstp9_clks@e6150994 {
 			compatible = "renesas,r8a7793-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
-			clocks = <&cpg_clocks R8A7793_CLK_QSPI>;
+			clocks = <&cp_clk>, <&cpg_clocks R8A7793_CLK_QSPI>,
+			       <&hp_clk>;
 			#clock-cells = <1>;
-			clock-indices = <R8A7793_CLK_QSPI_MOD>;
-			clock-output-names = "qspi_mod";
+			clock-indices = <R8A7793_CLK_GPIO3 R8A7793_CLK_QSPI_MOD
+				      R8A7793_CLK_I2C2>;
+			clock-output-names = "gpio3", "qspi_mod", "i2c2";
 		};
 	};
 
