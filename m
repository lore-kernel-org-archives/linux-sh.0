From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Wed, 21 Jan 2015 16:17:39 +0000
Subject: [PATCH] ARM: shmobile: r8a7740 dtsi: add remaining DIV6 clocks
Message-Id: <1421857059-16472-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds the remaining DIV6 clocks and all possible parents for the SUB
clock.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a7740.dtsi | 79 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 8a09260..83c1c3c 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -431,6 +431,18 @@
 			clock-frequency = <27000000>;
 			clock-output-names = "dv";
 		};
+		fmsick_clk: fmsick_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+			clock-output-names = "fmsick";
+		};
+		fmsock_clk: fmsock_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+			clock-output-names = "fmsock";
+		};
 		fsiack_clk: fsiack_clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
@@ -459,13 +471,78 @@
 		};
 
 		/* Variable factor clocks (DIV6) */
+		vclk1_clk: vclk1_clk@e6150008 {
+			compatible = "renesas,r8a7740-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe6150008 4>;
+			clocks = <&pllc1_div2_clk>, <0>, <&dv_clk>,
+				 <&cpg_clocks R8A7740_CLK_USB24S>,
+				 <&extal1_div2_clk>, <&extalr_clk>, <0>,
+				 <0>;
+			#clock-cells = <0>;
+			clock-output-names = "vclk1";
+		};
+		vclk2_clk: vclk2_clk@e615000c {
+			compatible = "renesas,r8a7740-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe615000c 4>;
+			clocks = <&pllc1_div2_clk>, <0>, <&dv_clk>,
+				 <&cpg_clocks R8A7740_CLK_USB24S>,
+				 <&extal1_div2_clk>, <&extalr_clk>, <0>,
+				 <0>;
+			#clock-cells = <0>;
+			clock-output-names = "vclk2";
+		};
+		fmsi_clk: fmsi_clk@e6150010 {
+			compatible = "renesas,r8a7740-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe6150010 4>;
+			clocks = <&pllc1_div2_clk>, <&fmsick_clk>, <0>, <0>;
+			#clock-cells = <0>;
+			clock-output-names = "fmsi";
+		};
+		fmso_clk: fmso_clk@e6150014 {
+			compatible = "renesas,r8a7740-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe6150014 4>;
+			clocks = <&pllc1_div2_clk>, <&fmsock_clk>, <0>, <0>;
+			#clock-cells = <0>;
+			clock-output-names = "fmso";
+		};
+		fsia_clk: fsia_clk@e6150018 {
+			compatible = "renesas,r8a7740-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe6150018 4>;
+			clocks = <&pllc1_div2_clk>, <&fsiack_clk>, <0>, <0>;
+			#clock-cells = <0>;
+			clock-output-names = "fsia";
+		};
 		sub_clk: sub_clk@e6150080 {
 			compatible = "renesas,r8a7740-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150080 4>;
-			clocks = <&pllc1_div2_clk>;
+			clocks = <&pllc1_div2_clk>,
+				 <&cpg_clocks R8A7740_CLK_USB24S>, <0>, <0>;
 			#clock-cells = <0>;
 			clock-output-names = "sub";
 		};
+		spu_clk: spu_clk@e6150084 {
+			compatible = "renesas,r8a7740-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe6150084 4>;
+			clocks = <&pllc1_div2_clk>,
+				 <&cpg_clocks R8A7740_CLK_USB24S>, <0>, <0>;
+			#clock-cells = <0>;
+			clock-output-names = "spu";
+		};
+		vou_clk: vou_clk@e6150088 {
+			compatible = "renesas,r8a7740-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe6150088 4>;
+			clocks = <&pllc1_div2_clk>, <&extal1_clk>, <&dv_clk>,
+				 <0>;
+			#clock-cells = <0>;
+			clock-output-names = "vou";
+		};
+		stpro_clk: stpro_clk@e615009c {
+			compatible = "renesas,r8a7740-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe615009c 4>;
+			clocks = <&cpg_clocks R8A7740_CLK_PLLC0>;
+			#clock-cells = <0>;
+			clock-output-names = "stpro";
+		};
 
 		/* Fixed factor clocks */
 		pllc1_div2_clk: pllc1_div2_clk {
-- 
2.2.2

