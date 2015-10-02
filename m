From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 02 Oct 2015 02:55:30 +0000
Subject: [PATCH v10 02/07] arm64: renesas: r8a7795 dtsi: Add all common divider clocks
Message-Id: <20151002025530.28158.35032.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add all clocks generated from PLL1 by the CPG common divider block.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V9: (Magnus Damm <damm+renesas@opensource.se>)
 - Introduce pll1_div2 by folding in earlier posted patch:
  [PATCH][RFC] arm64: renesas: r8a7795 dtsi: Update common divider clocks

 Changes since V8: (Magnus Damm <damm+renesas@opensource.se>)
 - Updated commit message.

 Changes since V7: (Magnus Damm <damm+renesas@opensource.se>)
 - Folded in s3d4_clk
 - Reordered to apply without SCIF bits

 Based on:
  [PATCH 3/3] arm64: renesas: r8a7795 dtsi: Add all common divider clocks

 arch/arm64/boot/dts/renesas/r8a7795.dtsi |  169 ++++++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)

--- 0008/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ work/arch/arm64/boot/dts/renesas/r8a7795.dtsi	2015-10-01 22:59:10.390513000 +0900
@@ -70,6 +70,175 @@
 			#clock-cells = <1>;
 			ranges;
 
+			/* Fixed factor clocks */
+			pll1_div2_clk: pll1_div2 {
+				compatible = "fixed-factor-clock";
+				clocks = <&cpg_clocks R8A7795_CLK_PLL1>;
+				#clock-cells = <0>;
+				clock-div = <2>;
+				clock-mult = <1>;
+			};
+
+			zt_clk: zt {
+				compatible = "fixed-factor-clock";
+				clocks = <&pll1_div2_clk>;
+				#clock-cells = <0>;
+				clock-div = <4>;
+				clock-mult = <1>;
+			};
+
+			ztr_clk: ztr {
+				compatible = "fixed-factor-clock";
+				clocks = <&pll1_div2_clk>;
+				#clock-cells = <0>;
+				clock-div = <6>;
+				clock-mult = <1>;
+			};
+
+			ztrd2_clk: ztrd2 {
+				compatible = "fixed-factor-clock";
+				clocks = <&pll1_div2_clk>;
+				#clock-cells = <0>;
+				clock-div = <12>;
+				clock-mult = <1>;
+			};
+
+			zx_clk: zx {
+				compatible = "fixed-factor-clock";
+				clocks = <&pll1_div2_clk>;
+				#clock-cells = <0>;
+				clock-div = <2>;
+				clock-mult = <1>;
+			};
+
+			s0_clk: s0 {
+				compatible = "fixed-factor-clock";
+				clocks = <&pll1_div2_clk>;
+				#clock-cells = <0>;
+				clock-div = <2>;
+				clock-mult = <1>;
+			};
+
+			s0d1_clk: s0d1 {
+				compatible = "fixed-factor-clock";
+				clocks = <&s0_clk>;
+				#clock-cells = <0>;
+				clock-div = <1>;
+				clock-mult = <1>;
+			};
+
+			s0d4_clk: s0d4 {
+				compatible = "fixed-factor-clock";
+				clocks = <&s0_clk>;
+				#clock-cells = <0>;
+				clock-div = <4>;
+				clock-mult = <1>;
+			};
+
+			s1_clk: s1 {
+				compatible = "fixed-factor-clock";
+				clocks = <&pll1_div2_clk>;
+				#clock-cells = <0>;
+				clock-div = <3>;
+				clock-mult = <1>;
+			};
+
+			s1d1_clk: s1d1 {
+				compatible = "fixed-factor-clock";
+				clocks = <&s1_clk>;
+				#clock-cells = <0>;
+				clock-div = <1>;
+				clock-mult = <1>;
+			};
+
+			s1d2_clk: s1d2 {
+				compatible = "fixed-factor-clock";
+				clocks = <&s1_clk>;
+				#clock-cells = <0>;
+				clock-div = <2>;
+				clock-mult = <1>;
+			};
+
+			s1d4_clk: s1d4 {
+				compatible = "fixed-factor-clock";
+				clocks = <&s1_clk>;
+				#clock-cells = <0>;
+				clock-div = <4>;
+				clock-mult = <1>;
+			};
+
+			s2_clk: s2 {
+				compatible = "fixed-factor-clock";
+				clocks = <&pll1_div2_clk>;
+				#clock-cells = <0>;
+				clock-div = <4>;
+				clock-mult = <1>;
+			};
+
+			s2d1_clk: s2d1 {
+				compatible = "fixed-factor-clock";
+				clocks = <&s2_clk>;
+				#clock-cells = <0>;
+				clock-div = <1>;
+				clock-mult = <1>;
+			};
+
+			s2d2_clk: s2d2 {
+				compatible = "fixed-factor-clock";
+				clocks = <&s2_clk>;
+				#clock-cells = <0>;
+				clock-div = <2>;
+				clock-mult = <1>;
+			};
+
+			s2d4_clk: s2d4 {
+				compatible = "fixed-factor-clock";
+				clocks = <&s2_clk>;
+				#clock-cells = <0>;
+				clock-div = <4>;
+				clock-mult = <1>;
+			};
+
+			s3_clk: s3 {
+				compatible = "fixed-factor-clock";
+				clocks = <&pll1_div2_clk>;
+				#clock-cells = <0>;
+				clock-div = <6>;
+				clock-mult = <1>;
+			};
+
+			s3d1_clk: s3d1 {
+				compatible = "fixed-factor-clock";
+				clocks = <&s3_clk>;
+				#clock-cells = <0>;
+				clock-div = <1>;
+				clock-mult = <1>;
+			};
+
+			s3d2_clk: s3d2 {
+				compatible = "fixed-factor-clock";
+				clocks = <&s3_clk>;
+				#clock-cells = <0>;
+				clock-div = <2>;
+				clock-mult = <1>;
+			};
+
+			s3d4_clk: s3d4 {
+				compatible = "fixed-factor-clock";
+				clocks = <&s3_clk>;
+				#clock-cells = <0>;
+				clock-div = <4>;
+				clock-mult = <1>;
+			};
+
+			cl_clk: cl {
+				compatible = "fixed-factor-clock";
+				clocks = <&pll1_div2_clk>;
+				#clock-cells = <0>;
+				clock-div = <48>;
+				clock-mult = <1>;
+			};
+
 			cpg_clocks: cpg_clocks@e6150000 {
 				compatible = "renesas,r8a7795-cpg-clocks",
 					     "renesas,rcar-gen3-cpg-clocks";
