From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 13 Oct 2015 13:07:14 +0000
Subject: [PATCH] [WIP] arm64: renesas: r8a7795: Switch from cpg-mstp to cpg-mssr
Message-Id: <1444741634-15181-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
For your convenience, I have pushed this into topic/gen3-latest of my
renesas-drivers repository.

 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 248 ++++++++++++++++--------------
 include/dt-bindings/clock/r8a7795-clock.h |  92 ++++++-----
 2 files changed, 176 insertions(+), 164 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 8e88ef240a9e28ff..b74dfefc89e98f93 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -72,7 +72,7 @@
 			gpio-ranges = <&pfc 0 0 32>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			clocks = <&mstp9_clks R8A7795_CLK_GPIO0>;
+			clocks = <&mssr R8A7795_CLK_GPIO0>;
 		};
 
 		gpio1: gpio@e6051000 {
@@ -85,7 +85,7 @@
 			gpio-ranges = <&pfc 0 32 32>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			clocks = <&mstp9_clks R8A7795_CLK_GPIO1>;
+			clocks = <&mssr R8A7795_CLK_GPIO1>;
 		};
 
 		gpio2: gpio@e6052000 {
@@ -98,7 +98,7 @@
 			gpio-ranges = <&pfc 0 64 32>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			clocks = <&mstp9_clks R8A7795_CLK_GPIO2>;
+			clocks = <&mssr R8A7795_CLK_GPIO2>;
 		};
 
 		gpio3: gpio@e6053000 {
@@ -111,7 +111,7 @@
 			gpio-ranges = <&pfc 0 96 32>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			clocks = <&mstp9_clks R8A7795_CLK_GPIO3>;
+			clocks = <&mssr R8A7795_CLK_GPIO3>;
 		};
 
 		gpio4: gpio@e6054000 {
@@ -124,7 +124,7 @@
 			gpio-ranges = <&pfc 0 128 32>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			clocks = <&mstp9_clks R8A7795_CLK_GPIO4>;
+			clocks = <&mssr R8A7795_CLK_GPIO4>;
 		};
 
 		gpio5: gpio@e6055000 {
@@ -137,7 +137,7 @@
 			gpio-ranges = <&pfc 0 160 32>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			clocks = <&mstp9_clks R8A7795_CLK_GPIO5>;
+			clocks = <&mssr R8A7795_CLK_GPIO5>;
 		};
 
 		gpio6: gpio@e6055400 {
@@ -150,7 +150,7 @@
 			gpio-ranges = <&pfc 0 192 32>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			clocks = <&mstp9_clks R8A7795_CLK_GPIO6>;
+			clocks = <&mssr R8A7795_CLK_GPIO6>;
 		};
 
 		gpio7: gpio@e6055800 {
@@ -163,7 +163,7 @@
 			gpio-ranges = <&pfc 0 224 32>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			clocks = <&mstp9_clks R8A7795_CLK_GPIO7>;
+			clocks = <&mssr R8A7795_CLK_GPIO7>;
 		};
 
 		timer {
@@ -411,7 +411,47 @@
 						<&s3d4_clk>, <&s3d4_clk>,
 						<&s3d4_clk>,
 						/* MSTP3 */
-						<&s3d4_clk>;
+						<&s3d4_clk>,
+						/* MSTP5 */
+						<&s3d4_clk>, <&s3d4_clk>,
+						/* MSTP8 */
+						<&s3d2_clk>,
+						/* MSTP9 */
+						<&cp_clk>, <&cp_clk>,
+						<&cp_clk>, <&cp_clk>,
+						<&cp_clk>, <&cp_clk>,
+						<&cp_clk>, <&cp_clk>,
+						<&s3d2_clk>, <&s3d2_clk>,
+						<&s3d2_clk>, <&s3d2_clk>,
+						<&s3d2_clk>, <&s3d2_clk>,
+						<&s3d2_clk>,
+						/* MSTP10 */
+						<&s3d4_clk>,
+						<&mssr R8A7795_CLK_SSI_ALL>,
+						<&mssr R8A7795_CLK_SSI_ALL>,
+						<&mssr R8A7795_CLK_SSI_ALL>,
+						<&mssr R8A7795_CLK_SSI_ALL>,
+						<&mssr R8A7795_CLK_SSI_ALL>,
+						<&mssr R8A7795_CLK_SSI_ALL>,
+						<&mssr R8A7795_CLK_SSI_ALL>,
+						<&mssr R8A7795_CLK_SSI_ALL>,
+						<&mssr R8A7795_CLK_SSI_ALL>,
+						<&mssr R8A7795_CLK_SSI_ALL>,
+						<&s3d4_clk>,
+						<&mssr R8A7795_CLK_SCU_ALL>,
+						<&mssr R8A7795_CLK_SCU_ALL>,
+						<&mssr R8A7795_CLK_SCU_ALL>,
+						<&mssr R8A7795_CLK_SCU_ALL>,
+						<&mssr R8A7795_CLK_SCU_ALL>,
+						<&mssr R8A7795_CLK_SCU_ALL>,
+						<&mssr R8A7795_CLK_SCU_ALL>,
+						<&mssr R8A7795_CLK_SCU_ALL>,
+						<&mssr R8A7795_CLK_SCU_ALL>,
+						<&mssr R8A7795_CLK_SCU_ALL>,
+						<&mssr R8A7795_CLK_SCU_ALL>,
+						<&mssr R8A7795_CLK_SCU_ALL>,
+						<&mssr R8A7795_CLK_SCU_ALL>,
+						<&mssr R8A7795_CLK_SCU_ALL>;
 					clock-indices = <
 						/* MSTP2 */
 						R8A7795_CLK_SCIF5
@@ -421,97 +461,72 @@
 						R8A7795_CLK_SCIF0
 						/* MSTP3 */
 						R8A7795_CLK_SCIF2
+						/* MSTP5 */
+						R8A7795_CLK_AUDIO_DMAC0
+						R8A7795_CLK_AUDIO_DMAC1
+						/* MSTP8 */
+						R8A7795_CLK_ETHERAVB
+						/* MSTP9 */
+						R8A7795_CLK_GPIO7
+						R8A7795_CLK_GPIO6
+						R8A7795_CLK_GPIO5
+						R8A7795_CLK_GPIO4
+						R8A7795_CLK_GPIO3
+						R8A7795_CLK_GPIO2
+						R8A7795_CLK_GPIO1
+						R8A7795_CLK_GPIO0
+						R8A7795_CLK_I2C6
+						R8A7795_CLK_I2C5
+						R8A7795_CLK_I2C4
+						R8A7795_CLK_I2C3
+						R8A7795_CLK_I2C2
+						R8A7795_CLK_I2C1
+						R8A7795_CLK_I2C0
+						/* MSTP10 */
+						R8A7795_CLK_SSI_ALL
+						R8A7795_CLK_SSI9
+						R8A7795_CLK_SSI8
+						R8A7795_CLK_SSI7
+						R8A7795_CLK_SSI6
+						R8A7795_CLK_SSI5
+						R8A7795_CLK_SSI4
+						R8A7795_CLK_SSI3
+						R8A7795_CLK_SSI2
+						R8A7795_CLK_SSI1
+						R8A7795_CLK_SSI0
+						R8A7795_CLK_SCU_ALL
+						R8A7795_CLK_SCU_DVC1
+						R8A7795_CLK_SCU_DVC0
+						R8A7795_CLK_SCU_CTU1_MIX1
+						R8A7795_CLK_SCU_CTU0_MIX0
+						R8A7795_CLK_SCU_SRC9
+						R8A7795_CLK_SCU_SRC8
+						R8A7795_CLK_SCU_SRC7
+						R8A7795_CLK_SCU_SRC6
+						R8A7795_CLK_SCU_SRC5
+						R8A7795_CLK_SCU_SRC4
+						R8A7795_CLK_SCU_SRC3
+						R8A7795_CLK_SCU_SRC2
+						R8A7795_CLK_SCU_SRC1
+						R8A7795_CLK_SCU_SRC0
 					>;
 					clock-output-names  						/* MSTP2 */
 						"scif5", "scif4", "scif3",
 						"scif1", "scif0",
 						/* MSTP3 */
-						"scif2";
-					#reset-cells = <1>;
-				};
-
-				mstp5_clks: mstp5_clks@e6150144 {
-					compatible = "renesas,r8a7795-mstp-clocks",
-						     "renesas,cpg-mstp-clocks";
-					reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
-					clocks = <&s3d4_clk>, <&s3d4_clk>;
-					#clock-cells = <1>;
-					clock-indices = <
-						R8A7795_CLK_AUDIO_DMAC0 R8A7795_CLK_AUDIO_DMAC1
-					>;
-					clock-output-names -						"audmac0", "audmac1";
-				};
-
-				mstp8_clks: mstp8_clks@e6150990 {
-					compatible = "renesas,r8a7795-mstp-clocks",
-						     "renesas,cpg-mstp-clocks";
-					reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
-					clocks =  <&s3d2_clk>;
-					#clock-cells = <1>;
-					clock-indices = <R8A7795_CLK_ETHERAVB>;
-					clock-output-names = "etheravb";
-				};
-
-				mstp9_clks: mstp9_clks@e6150994 {
-					compatible = "renesas,r8a7795-mstp-clocks",
-						     "renesas,cpg-mstp-clocks";
-					reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
-					clocks = <&cp_clk>, <&cp_clk>, <&cp_clk>,
-						 <&cp_clk>, <&cp_clk>, <&cp_clk>,
-						 <&cp_clk>, <&cp_clk>,
-						 <&s3d2_clk>, <&s3d2_clk>, <&s3d2_clk>,
-						 <&s3d2_clk>, <&s3d2_clk>, <&s3d2_clk>,
-						 <&s3d2_clk>;
-					#clock-cells = <1>;
-					clock-indices = <
-						R8A7795_CLK_GPIO7 R8A7795_CLK_GPIO6
-						R8A7795_CLK_GPIO5 R8A7795_CLK_GPIO4
-						R8A7795_CLK_GPIO3 R8A7795_CLK_GPIO2
-						R8A7795_CLK_GPIO1 R8A7795_CLK_GPIO0
-						R8A7795_CLK_I2C6  R8A7795_CLK_I2C5
-						R8A7795_CLK_I2C4  R8A7795_CLK_I2C3
-						R8A7795_CLK_I2C2  R8A7795_CLK_I2C1
-						R8A7795_CLK_I2C0
-					>;
-					clock-output-names +						"scif2",
+						/* MSTP5 */
+						"audmac0", "audmac1",
+						/* MSTP8 */
+						"etheravb",
+						/* MSTP9 */
 						"gpio7", "gpio6", "gpio5",
 						"gpio4", "gpio3", "gpio2",
-						"gpio1", "gpio0", "i2c6",
-						"i2c5", "i2c4", "i2c3", "i2c2",
-						"i2c1", "i2c0";
-				};
-
-				mstp10_clks: mstp10_clks@e6150998 {
-					compatible = "renesas,r8a7795-mstp-clocks", "renesas,cpg-mstp-clocks";
-					reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
-					#clock-cells = <1>;
-					clocks = <&s3d4_clk>,
-						<&mstp10_clks R8A7795_CLK_SSI_ALL>, <&mstp10_clks R8A7795_CLK_SSI_ALL>,
-						<&mstp10_clks R8A7795_CLK_SSI_ALL>, <&mstp10_clks R8A7795_CLK_SSI_ALL>,
-						<&mstp10_clks R8A7795_CLK_SSI_ALL>, <&mstp10_clks R8A7795_CLK_SSI_ALL>,
-						<&mstp10_clks R8A7795_CLK_SSI_ALL>, <&mstp10_clks R8A7795_CLK_SSI_ALL>,
-						<&mstp10_clks R8A7795_CLK_SSI_ALL>, <&mstp10_clks R8A7795_CLK_SSI_ALL>,
-						<&s3d4_clk>,
-						<&mstp10_clks R8A7795_CLK_SCU_ALL>, <&mstp10_clks R8A7795_CLK_SCU_ALL>,
-						<&mstp10_clks R8A7795_CLK_SCU_ALL>, <&mstp10_clks R8A7795_CLK_SCU_ALL>,
-						<&mstp10_clks R8A7795_CLK_SCU_ALL>, <&mstp10_clks R8A7795_CLK_SCU_ALL>,
-						<&mstp10_clks R8A7795_CLK_SCU_ALL>, <&mstp10_clks R8A7795_CLK_SCU_ALL>,
-						<&mstp10_clks R8A7795_CLK_SCU_ALL>, <&mstp10_clks R8A7795_CLK_SCU_ALL>,
-						<&mstp10_clks R8A7795_CLK_SCU_ALL>, <&mstp10_clks R8A7795_CLK_SCU_ALL>,
-						<&mstp10_clks R8A7795_CLK_SCU_ALL>, <&mstp10_clks R8A7795_CLK_SCU_ALL>;
-					clock-indices = <
-						R8A7795_CLK_SSI_ALL
-						R8A7795_CLK_SSI9 R8A7795_CLK_SSI8 R8A7795_CLK_SSI7 R8A7795_CLK_SSI6 R8A7795_CLK_SSI5
-						R8A7795_CLK_SSI4 R8A7795_CLK_SSI3 R8A7795_CLK_SSI2 R8A7795_CLK_SSI1 R8A7795_CLK_SSI0
-						R8A7795_CLK_SCU_ALL
-						R8A7795_CLK_SCU_DVC1 R8A7795_CLK_SCU_DVC0
-						R8A7795_CLK_SCU_CTU1_MIX1 R8A7795_CLK_SCU_CTU0_MIX0
-						R8A7795_CLK_SCU_SRC9 R8A7795_CLK_SCU_SRC8 R8A7795_CLK_SCU_SRC7 R8A7795_CLK_SCU_SRC6 R8A7795_CLK_SCU_SRC5
-						R8A7795_CLK_SCU_SRC4 R8A7795_CLK_SCU_SRC3 R8A7795_CLK_SCU_SRC2 R8A7795_CLK_SCU_SRC1 R8A7795_CLK_SCU_SRC0
-					>;
-					clock-output-names +						"gpio1", "gpio0",
+						"i2c6", "i2c5", "i2c4", "i2c3",
+						"i2c2", "i2c1", "i2c0",
+						/* MSTP10 */
 						"ssi-all",
 						"ssi9", "ssi8", "ssi7", "ssi6",
 						"ssi5", "ssi4", "ssi3", "ssi2",
@@ -525,6 +540,7 @@
 						"scu-src5", "scu-src4",
 						"scu-src3", "scu-src2",
 						"scu-src1", "scu-src0";
+					#reset-cells = <1>;
 				};
 			};
 		};
@@ -554,7 +570,7 @@
 					"ch4", "ch5", "ch6", "ch7",
 					"ch8", "ch9", "ch10", "ch11",
 					"ch12", "ch13", "ch14", "ch15";
-			clocks = <&mstp5_clks R8A7795_CLK_AUDIO_DMAC0>;
+			clocks = <&mssr R8A7795_CLK_AUDIO_DMAC0>;
 			power-domains = <&cpg_clocks>;
 			clock-names = "fck";
 			#dma-cells = <1>;
@@ -586,7 +602,7 @@
 					"ch4", "ch5", "ch6", "ch7",
 					"ch8", "ch9", "ch10", "ch11",
 					"ch12", "ch13", "ch14", "ch15";
-			clocks = <&mstp5_clks R8A7795_CLK_AUDIO_DMAC1>;
+			clocks = <&mssr R8A7795_CLK_AUDIO_DMAC1>;
 			power-domains = <&cpg_clocks>;
 			clock-names = "fck";
 			#dma-cells = <1>;
@@ -642,7 +658,7 @@
 					  "ch16", "ch17", "ch18", "ch19",
 					  "ch20", "ch21", "ch22", "ch23",
 					  "ch24";
-			clocks = <&mstp8_clks R8A7795_CLK_ETHERAVB>;
+			clocks = <&mssr R8A7795_CLK_ETHERAVB>;
 			power-domains = <&cpg_clocks>;
 			phy-mode = "rgmii-id";
 			#address-cells = <1>;
@@ -735,7 +751,7 @@
 			compatible = "renesas,i2c-r8a7795";
 			reg = <0 0xe6500000 0 0x40>;
 			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp9_clks R8A7795_CLK_I2C0>;
+			clocks = <&mssr R8A7795_CLK_I2C0>;
 			power-domains = <&cpg_clocks>;
 			status = "disabled";
 		};
@@ -746,7 +762,7 @@
 			compatible = "renesas,i2c-r8a7795";
 			reg = <0 0xe6508000 0 0x40>;
 			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp9_clks R8A7795_CLK_I2C1>;
+			clocks = <&mssr R8A7795_CLK_I2C1>;
 			power-domains = <&cpg_clocks>;
 			status = "disabled";
 		};
@@ -757,7 +773,7 @@
 			compatible = "renesas,i2c-r8a7795";
 			reg = <0 0xe6510000 0 0x40>;
 			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp9_clks R8A7795_CLK_I2C2>;
+			clocks = <&mssr R8A7795_CLK_I2C2>;
 			power-domains = <&cpg_clocks>;
 			status = "disabled";
 		};
@@ -768,7 +784,7 @@
 			compatible = "renesas,i2c-r8a7795";
 			reg = <0 0xe66d0000 0 0x40>;
 			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp9_clks R8A7795_CLK_I2C3>;
+			clocks = <&mssr R8A7795_CLK_I2C3>;
 			power-domains = <&cpg_clocks>;
 			status = "disabled";
 		};
@@ -779,7 +795,7 @@
 			compatible = "renesas,i2c-r8a7795";
 			reg = <0 0xe66d8000 0 0x40>;
 			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp9_clks R8A7795_CLK_I2C4>;
+			clocks = <&mssr R8A7795_CLK_I2C4>;
 			power-domains = <&cpg_clocks>;
 			status = "disabled";
 		};
@@ -790,7 +806,7 @@
 			compatible = "renesas,i2c-r8a7795";
 			reg = <0 0xe66e0000 0 0x40>;
 			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp9_clks R8A7795_CLK_I2C5>;
+			clocks = <&mssr R8A7795_CLK_I2C5>;
 			power-domains = <&cpg_clocks>;
 			status = "disabled";
 		};
@@ -801,7 +817,7 @@
 			compatible = "renesas,i2c-r8a7795";
 			reg = <0 0xe66e8000 0 0x40>;
 			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp9_clks R8A7795_CLK_I2C6>;
+			clocks = <&mssr R8A7795_CLK_I2C6>;
 			power-domains = <&cpg_clocks>;
 			status = "disabled";
 		};
@@ -827,20 +843,20 @@
 				<0 0xec740000 0 0x200>;  /* Audio DMAC peri peri*/
 			reg-names = "scu", "adg", "ssiu", "ssi", "audmapp";
 
-			clocks = <&mstp10_clks R8A7795_CLK_SSI_ALL>,
-				<&mstp10_clks R8A7795_CLK_SSI9>, <&mstp10_clks R8A7795_CLK_SSI8>,
-				<&mstp10_clks R8A7795_CLK_SSI7>, <&mstp10_clks R8A7795_CLK_SSI6>,
-				<&mstp10_clks R8A7795_CLK_SSI5>, <&mstp10_clks R8A7795_CLK_SSI4>,
-				<&mstp10_clks R8A7795_CLK_SSI3>, <&mstp10_clks R8A7795_CLK_SSI2>,
-				<&mstp10_clks R8A7795_CLK_SSI1>, <&mstp10_clks R8A7795_CLK_SSI0>,
-				<&mstp10_clks R8A7795_CLK_SCU_SRC9>, <&mstp10_clks R8A7795_CLK_SCU_SRC8>,
-				<&mstp10_clks R8A7795_CLK_SCU_SRC7>, <&mstp10_clks R8A7795_CLK_SCU_SRC6>,
-				<&mstp10_clks R8A7795_CLK_SCU_SRC5>, <&mstp10_clks R8A7795_CLK_SCU_SRC4>,
-				<&mstp10_clks R8A7795_CLK_SCU_SRC3>, <&mstp10_clks R8A7795_CLK_SCU_SRC2>,
-				<&mstp10_clks R8A7795_CLK_SCU_SRC1>, <&mstp10_clks R8A7795_CLK_SCU_SRC0>,
-				<&mstp10_clks R8A7795_CLK_SCU_CTU0_MIX0>, <&mstp10_clks R8A7795_CLK_SCU_CTU1_MIX1>,
-				<&mstp10_clks R8A7795_CLK_SCU_CTU0_MIX0>, <&mstp10_clks R8A7795_CLK_SCU_CTU1_MIX1>,
-				<&mstp10_clks R8A7795_CLK_SCU_DVC0>, <&mstp10_clks R8A7795_CLK_SCU_DVC1>,
+			clocks = <&mssr R8A7795_CLK_SSI_ALL>,
+				<&mssr R8A7795_CLK_SSI9>, <&mssr R8A7795_CLK_SSI8>,
+				<&mssr R8A7795_CLK_SSI7>, <&mssr R8A7795_CLK_SSI6>,
+				<&mssr R8A7795_CLK_SSI5>, <&mssr R8A7795_CLK_SSI4>,
+				<&mssr R8A7795_CLK_SSI3>, <&mssr R8A7795_CLK_SSI2>,
+				<&mssr R8A7795_CLK_SSI1>, <&mssr R8A7795_CLK_SSI0>,
+				<&mssr R8A7795_CLK_SCU_SRC9>, <&mssr R8A7795_CLK_SCU_SRC8>,
+				<&mssr R8A7795_CLK_SCU_SRC7>, <&mssr R8A7795_CLK_SCU_SRC6>,
+				<&mssr R8A7795_CLK_SCU_SRC5>, <&mssr R8A7795_CLK_SCU_SRC4>,
+				<&mssr R8A7795_CLK_SCU_SRC3>, <&mssr R8A7795_CLK_SCU_SRC2>,
+				<&mssr R8A7795_CLK_SCU_SRC1>, <&mssr R8A7795_CLK_SCU_SRC0>,
+				<&mssr R8A7795_CLK_SCU_CTU0_MIX0>, <&mssr R8A7795_CLK_SCU_CTU1_MIX1>,
+				<&mssr R8A7795_CLK_SCU_CTU0_MIX0>, <&mssr R8A7795_CLK_SCU_CTU1_MIX1>,
+				<&mssr R8A7795_CLK_SCU_DVC0>, <&mssr R8A7795_CLK_SCU_DVC1>,
 				<&audio_clk_a>, <&audio_clk_b>, <&audio_clk_c>, <&s0d4_clk>;
 			clock-names = "ssi-all",
 					"ssi.9", "ssi.8", "ssi.7", "ssi.6", "ssi.5",
diff --git a/include/dt-bindings/clock/r8a7795-clock.h b/include/dt-bindings/clock/r8a7795-clock.h
index 97247d345a08029c..46fe78a3e3eeb5cf 100644
--- a/include/dt-bindings/clock/r8a7795-clock.h
+++ b/include/dt-bindings/clock/r8a7795-clock.h
@@ -32,61 +32,57 @@
 #define R8A7795_CLK_SCIF2		310
 
 /* MSTP5 */
-#define R8A7795_CLK_AUDIO_DMAC1		1
-#define R8A7795_CLK_AUDIO_DMAC0		2
+#define R8A7795_CLK_AUDIO_DMAC1		501
+#define R8A7795_CLK_AUDIO_DMAC0		502
 
 /* MSTP7 */
 
 /* MSTP8 */
-#define R8A7795_CLK_ETHERAVB		12
-
-/* MSTP9 */
-#define R8A7795_CLK_GPIO7		5
-#define R8A7795_CLK_GPIO6		6
-#define R8A7795_CLK_GPIO5		7
-#define R8A7795_CLK_GPIO4		8
-#define R8A7795_CLK_GPIO3		9
-#define R8A7795_CLK_GPIO2		10
-#define R8A7795_CLK_GPIO1		11
-#define R8A7795_CLK_GPIO0		12
-#define R8A7795_CLK_I2C6		18
-#define R8A7795_CLK_I2C5		19
-#define R8A7795_CLK_I2C4		27
-#define R8A7795_CLK_I2C3		28
-#define R8A7795_CLK_I2C2		29
-#define R8A7795_CLK_I2C1		30
-#define R8A7795_CLK_I2C0		31
-
-/* MSTP10 */
-#define R8A7795_CLK_SSI_ALL		5
-#define R8A7795_CLK_SSI9		6
-#define R8A7795_CLK_SSI8		7
-#define R8A7795_CLK_SSI7		8
-#define R8A7795_CLK_SSI6		9
-#define R8A7795_CLK_SSI5		10
-#define R8A7795_CLK_SSI4		11
-#define R8A7795_CLK_SSI3		12
-#define R8A7795_CLK_SSI2		13
-#define R8A7795_CLK_SSI1		14
-#define R8A7795_CLK_SSI0		15
-#define R8A7795_CLK_SCU_ALL		17
-#define R8A7795_CLK_SCU_DVC1		18
-#define R8A7795_CLK_SCU_DVC0		19
-#define R8A7795_CLK_SCU_CTU1_MIX1	20
-#define R8A7795_CLK_SCU_CTU0_MIX0	21
-#define R8A7795_CLK_SCU_SRC9		22
-#define R8A7795_CLK_SCU_SRC8		23
-#define R8A7795_CLK_SCU_SRC7		24
-#define R8A7795_CLK_SCU_SRC6		25
-#define R8A7795_CLK_SCU_SRC5		26
-#define R8A7795_CLK_SCU_SRC4		27
-#define R8A7795_CLK_SCU_SRC3		28
-#define R8A7795_CLK_SCU_SRC2		29
-#define R8A7795_CLK_SCU_SRC1		30
-#define R8A7795_CLK_SCU_SRC0		31
+#define R8A7795_CLK_ETHERAVB		812
 
 /* MSTP9 */
+#define R8A7795_CLK_GPIO7		905
+#define R8A7795_CLK_GPIO6		906
+#define R8A7795_CLK_GPIO5		907
+#define R8A7795_CLK_GPIO4		908
+#define R8A7795_CLK_GPIO3		909
+#define R8A7795_CLK_GPIO2		910
+#define R8A7795_CLK_GPIO1		911
+#define R8A7795_CLK_GPIO0		912
+#define R8A7795_CLK_I2C6		918
+#define R8A7795_CLK_I2C5		919
+#define R8A7795_CLK_I2C4		927
+#define R8A7795_CLK_I2C3		928
+#define R8A7795_CLK_I2C2		929
+#define R8A7795_CLK_I2C1		930
+#define R8A7795_CLK_I2C0		931
 
 /* MSTP10 */
+#define R8A7795_CLK_SSI_ALL		1005
+#define R8A7795_CLK_SSI9		1006
+#define R8A7795_CLK_SSI8		1007
+#define R8A7795_CLK_SSI7		1008
+#define R8A7795_CLK_SSI6		1009
+#define R8A7795_CLK_SSI5		1010
+#define R8A7795_CLK_SSI4		1011
+#define R8A7795_CLK_SSI3		1012
+#define R8A7795_CLK_SSI2		1013
+#define R8A7795_CLK_SSI1		1014
+#define R8A7795_CLK_SSI0		1015
+#define R8A7795_CLK_SCU_ALL		1017
+#define R8A7795_CLK_SCU_DVC1		1018
+#define R8A7795_CLK_SCU_DVC0		1019
+#define R8A7795_CLK_SCU_CTU1_MIX1	1020
+#define R8A7795_CLK_SCU_CTU0_MIX0	1021
+#define R8A7795_CLK_SCU_SRC9		1022
+#define R8A7795_CLK_SCU_SRC8		1023
+#define R8A7795_CLK_SCU_SRC7		1024
+#define R8A7795_CLK_SCU_SRC6		1025
+#define R8A7795_CLK_SCU_SRC5		1026
+#define R8A7795_CLK_SCU_SRC4		1027
+#define R8A7795_CLK_SCU_SRC3		1028
+#define R8A7795_CLK_SCU_SRC2		1029
+#define R8A7795_CLK_SCU_SRC1		1030
+#define R8A7795_CLK_SCU_SRC0		1031
 
 #endif /* __DT_BINDINGS_CLOCK_R8A7795_H__ */
-- 
1.9.1

