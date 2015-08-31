From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 31 Aug 2015 06:29:30 +0000
Subject: [PATCH v8 02/07] arm64: renesas: r8a7795 dtsi: Add all common divider clocks
Message-Id: <20150831062930.24004.93722.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add all clocks generated from PLL1 by the CPG common divider block.
This includes s3d4, which was modelled as a direct child from pll1
before.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Based on:
  [PATCH 3/3] arm64: renesas: r8a7795 dtsi: Add all common divider clocks

 Changes: (Magnus Damm <damm+renesas@opensource.se>)
 - Folded in s3d4_clk
 - Reordered to apply without SCIF bits

 arch/arm64/boot/dts/renesas/r8a7795.dtsi |  160 ++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

--- 0012/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ work/arch/arm64/boot/dts/renesas/r8a7795.dtsi	2015-08-29 17:10:36.532366518 +0900
@@ -70,6 +70,166 @@
 			#clock-cells = <1>;
 			ranges;
 
+			zt_clk: zt {
+				compatible = "fixed-factor-clock";
+				clocks = <&cpg_clocks R8A7795_CLK_PLL1>;
+				#clock-cells = <0>;
+				clock-div = <4>;
+				clock-mult = <1>;
+			};
+
+			ztr_clk: ztr {
+				compatible = "fixed-factor-clock";
+				clocks = <&cpg_clocks R8A7795_CLK_PLL1>;
+				#clock-cells = <0>;
+				clock-div = <6>;
+				clock-mult = <1>;
+			};
+
+			ztrd2_clk: ztrd2 {
+				compatible = "fixed-factor-clock";
+				clocks = <&cpg_clocks R8A7795_CLK_PLL1>;
+				#clock-cells = <0>;
+				clock-div = <12>;
+				clock-mult = <1>;
+			};
+
+			zx_clk: zx {
+				compatible = "fixed-factor-clock";
+				clocks = <&cpg_clocks R8A7795_CLK_PLL1>;
+				#clock-cells = <0>;
+				clock-div = <2>;
+				clock-mult = <1>;
+			};
+
+			s0_clk: s0 {
+				compatible = "fixed-factor-clock";
+				clocks = <&cpg_clocks R8A7795_CLK_PLL1>;
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
+				clocks = <&cpg_clocks R8A7795_CLK_PLL1>;
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
+				clocks = <&cpg_clocks R8A7795_CLK_PLL1>;
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
+				clocks = <&cpg_clocks R8A7795_CLK_PLL1>;
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
+				clocks = <&cpg_clocks R8A7795_CLK_PLL1>;
+				#clock-cells = <0>;
+				clock-div = <48>;
+				clock-mult = <1>;
+			};
+
 			cpg_clocks: cpg_clocks@e6150000 {
 				compatible = "renesas,r8a7795-cpg-clocks",
 					     "renesas,rcar-gen3-cpg-clocks";
