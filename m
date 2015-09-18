From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 18 Sep 2015 02:03:58 +0000
Subject: [PATCH 04/18 v3] arm64: renesas: r8a7795: Sound SSI PIO support
Message-Id: <877fno1o8i.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch adds SSI for PIO sound support

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v2 -> v3

 - no change

 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 104 ++++++++++++++++++++++++++++++
 include/dt-bindings/clock/r8a7795-clock.h |  11 ++++
 2 files changed, 115 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index a87c4be..b7ee56b 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -377,6 +377,24 @@
 				clock-output-names = "lvds";
 			};
 
+			audio_clk_a: audio_clk_a {
+				compatible = "fixed-clock";
+				#clock-cells = <0>;
+				clock-frequency = <0>;
+			};
+
+			audio_clk_b: audio_clk_b {
+				compatible = "fixed-clock";
+				#clock-cells = <0>;
+				clock-frequency = <0>;
+			};
+
+			audio_clk_c: audio_clk_c {
+				compatible = "fixed-clock";
+				#clock-cells = <0>;
+				clock-frequency = <0>;
+			};
+
 			cpg_clocks: cpg_clocks@e6150000 {
 				#address-cells = <2>;
 				#size-cells = <2>;
@@ -501,6 +519,23 @@
 						R8A7795_CLK_I2C0
 					>;
 				};
+
+				mstp10_clks: mstp10_clks@e6150998 {
+					compatible = "renesas,r8a7795-mstp-clocks", "renesas,cpg-mstp-clocks";
+					reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
+					#clock-cells = <1>;
+					clocks = <&s3d4_clk>,
+						<&mstp10_clks R8A7795_CLK_SSI_ALL>, <&mstp10_clks R8A7795_CLK_SSI_ALL>,
+						<&mstp10_clks R8A7795_CLK_SSI_ALL>, <&mstp10_clks R8A7795_CLK_SSI_ALL>,
+						<&mstp10_clks R8A7795_CLK_SSI_ALL>, <&mstp10_clks R8A7795_CLK_SSI_ALL>,
+						<&mstp10_clks R8A7795_CLK_SSI_ALL>, <&mstp10_clks R8A7795_CLK_SSI_ALL>,
+						<&mstp10_clks R8A7795_CLK_SSI_ALL>, <&mstp10_clks R8A7795_CLK_SSI_ALL>;
+					clock-indices = <
+						R8A7795_CLK_SSI_ALL
+						R8A7795_CLK_SSI9 R8A7795_CLK_SSI8 R8A7795_CLK_SSI7 R8A7795_CLK_SSI6 R8A7795_CLK_SSI5
+						R8A7795_CLK_SSI4 R8A7795_CLK_SSI3 R8A7795_CLK_SSI2 R8A7795_CLK_SSI1 R8A7795_CLK_SSI0
+					>;
+				};
 			};
 		};
 
@@ -936,6 +971,75 @@
 			power-domains = <&cpg_clocks>;
 			status = "disabled";
 		};
+
+		rcar_sound: sound@ec500000 {
+			/*
+			 * #sound-dai-cells is required
+			 *
+			 * Single DAI : #sound-dai-cells = <0>;	<&rcar_sound>;
+			 * Multi  DAI : #sound-dai-cells = <1>;	<&rcar_sound N>;
+			 */
+			/*
+			 * #clock-cells is required for audio_clkout0/1/2/3
+			 *
+			 * clkout	: #clock-cells = <0>;	<&rcar_sound>;
+			 * clkout0/1/2/3: #clock-cells = <1>;	<&rcar_sound N>;
+			 */
+			compatible =  "renesas,rcar_sound-r8a7795", "renesas,rcar_sound-gen3";
+			reg =	<0 0xec500000 0 0x1000>, /* SCU */
+				<0 0xec5a0000 0 0x100>,  /* ADG */
+				<0 0xec540000 0 0x1000>, /* SSIU */
+				<0 0xec541000 0 0x280>,  /* SSI */
+				<0 0xec740000 0 0x200>;  /* Audio DMAC peri peri*/
+			reg-names = "scu", "adg", "ssiu", "ssi", "audmapp";
+
+			clocks = <&mstp10_clks R8A7795_CLK_SSI_ALL>,
+				<&mstp10_clks R8A7795_CLK_SSI9>, <&mstp10_clks R8A7795_CLK_SSI8>,
+				<&mstp10_clks R8A7795_CLK_SSI7>, <&mstp10_clks R8A7795_CLK_SSI6>,
+				<&mstp10_clks R8A7795_CLK_SSI5>, <&mstp10_clks R8A7795_CLK_SSI4>,
+				<&mstp10_clks R8A7795_CLK_SSI3>, <&mstp10_clks R8A7795_CLK_SSI2>,
+				<&mstp10_clks R8A7795_CLK_SSI1>, <&mstp10_clks R8A7795_CLK_SSI0>,
+				<&audio_clk_a>, <&audio_clk_b>, <&audio_clk_c>, <&s0d4_clk>;
+			clock-names = "ssi-all",
+					"ssi.9", "ssi.8", "ssi.7", "ssi.6", "ssi.5",
+					"ssi.4", "ssi.3", "ssi.2", "ssi.1", "ssi.0",
+					"clk_a", "clk_b", "clk_c", "clk_i";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+
+			rcar_sound,ssi {
+				ssi0: ssi@0 {
+					interrupts = <0 370 IRQ_TYPE_LEVEL_HIGH>;
+				};
+				ssi1: ssi@1 {
+					 interrupts = <0 371 IRQ_TYPE_LEVEL_HIGH>;
+				};
+				ssi2: ssi@2 {
+					interrupts = <0 372 IRQ_TYPE_LEVEL_HIGH>;
+				};
+				ssi3: ssi@3 {
+					interrupts = <0 373 IRQ_TYPE_LEVEL_HIGH>;
+				};
+				ssi4: ssi@4 {
+					interrupts = <0 374 IRQ_TYPE_LEVEL_HIGH>;
+				};
+				ssi5: ssi@5 {
+					interrupts = <0 375 IRQ_TYPE_LEVEL_HIGH>;
+				};
+				ssi6: ssi@6 {
+					interrupts = <0 376 IRQ_TYPE_LEVEL_HIGH>;
+				};
+				ssi7: ssi@7 {
+					interrupts = <0 377 IRQ_TYPE_LEVEL_HIGH>;
+				};
+				ssi8: ssi@8 {
+					interrupts = <0 378 IRQ_TYPE_LEVEL_HIGH>;
+				};
+				ssi9: ssi@9 {
+					interrupts = <0 379 IRQ_TYPE_LEVEL_HIGH>;
+				};
+			};
+		};
 	};
 
 };
diff --git a/include/dt-bindings/clock/r8a7795-clock.h b/include/dt-bindings/clock/r8a7795-clock.h
index ca370c7..c4cacd9 100644
--- a/include/dt-bindings/clock/r8a7795-clock.h
+++ b/include/dt-bindings/clock/r8a7795-clock.h
@@ -76,5 +76,16 @@
 #define R8A7795_CLK_I2C0		31
 
 /* MSTP10 */
+#define R8A7795_CLK_SSI_ALL		5
+#define R8A7795_CLK_SSI9		6
+#define R8A7795_CLK_SSI8		7
+#define R8A7795_CLK_SSI7		8
+#define R8A7795_CLK_SSI6		9
+#define R8A7795_CLK_SSI5		10
+#define R8A7795_CLK_SSI4		11
+#define R8A7795_CLK_SSI3		12
+#define R8A7795_CLK_SSI2		13
+#define R8A7795_CLK_SSI1		14
+#define R8A7795_CLK_SSI0		15
 
 #endif /* __DT_BINDINGS_CLOCK_R8A7795_H__ */
-- 
1.9.1

