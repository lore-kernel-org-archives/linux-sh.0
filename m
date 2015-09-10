From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 10 Sep 2015 07:15:41 +0000
Subject: [PATCH 04/14][RFC] arm64: renesas: r8a7795: add SSI sound support
Message-Id: <87lhcen3yw.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch adds SSI PIO sound support

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 87 ++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index f27b8d2..235f266 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -361,6 +361,24 @@
 				clock-mult = <1>;
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
@@ -632,5 +650,74 @@
 			clocks = <&mstp9_clks R8A7795_CLK_I2C6>;
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
+
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
-- 
1.9.1

