From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 08 Sep 2015 04:43:42 +0000
Subject: [PATCH][RFC] arm64: renesas: r8a7795 dtsi: Update common divider clocks
Message-Id: <20150908044342.21900.84407.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Update the r8a7795 CPG DTS to include pll1_div2. In older r8a7795 CPG
CCF driver implementations the output of PLL1 was divided by two.

To support r8a7795 clocks like RPCSRC the PLL1 has now been converted
to not divide by two in the V7 CPG series, so when that series is used
we have to divide by two using a fixed divider outside the CPG.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 This fixes the PLL1 output in the V9 integration series:
 [PATCH v9 00/07][RFC] Renesas R-Car H3 (r8a7795) integration patches V9

 With this patch V9 integration series below will work with V7 CPG:
 [PATCH v7 00/05] Renesas R-Car Gen3 CPG support V7

 arch/arm64/boot/dts/renesas/r8a7795.dtsi |   27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

--- 0006/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ work/arch/arm64/boot/dts/renesas/r8a7795.dtsi	2015-09-08 13:35:42.752366518 +0900
@@ -70,17 +70,26 @@
 			#clock-cells = <1>;
 			ranges;
 
-			zt_clk: zt {
+			/* Fixed factor clocks */
+			pll1_div2_clk: pll1_div2 {
 				compatible = "fixed-factor-clock";
 				clocks = <&cpg_clocks R8A7795_CLK_PLL1>;
 				#clock-cells = <0>;
+				clock-div = <2>;
+				clock-mult = <1>;
+			};
+
+			zt_clk: zt {
+				compatible = "fixed-factor-clock";
+				clocks = <&pll1_div2_clk>;
+				#clock-cells = <0>;
 				clock-div = <4>;
 				clock-mult = <1>;
 			};
 
 			ztr_clk: ztr {
 				compatible = "fixed-factor-clock";
-				clocks = <&cpg_clocks R8A7795_CLK_PLL1>;
+				clocks = <&pll1_div2_clk>;
 				#clock-cells = <0>;
 				clock-div = <6>;
 				clock-mult = <1>;
@@ -88,7 +97,7 @@
 
 			ztrd2_clk: ztrd2 {
 				compatible = "fixed-factor-clock";
-				clocks = <&cpg_clocks R8A7795_CLK_PLL1>;
+				clocks = <&pll1_div2_clk>;
 				#clock-cells = <0>;
 				clock-div = <12>;
 				clock-mult = <1>;
@@ -96,7 +105,7 @@
 
 			zx_clk: zx {
 				compatible = "fixed-factor-clock";
-				clocks = <&cpg_clocks R8A7795_CLK_PLL1>;
+				clocks = <&pll1_div2_clk>;
 				#clock-cells = <0>;
 				clock-div = <2>;
 				clock-mult = <1>;
@@ -104,7 +113,7 @@
 
 			s0_clk: s0 {
 				compatible = "fixed-factor-clock";
-				clocks = <&cpg_clocks R8A7795_CLK_PLL1>;
+				clocks = <&pll1_div2_clk>;
 				#clock-cells = <0>;
 				clock-div = <2>;
 				clock-mult = <1>;
@@ -128,7 +137,7 @@
 
 			s1_clk: s1 {
 				compatible = "fixed-factor-clock";
-				clocks = <&cpg_clocks R8A7795_CLK_PLL1>;
+				clocks = <&pll1_div2_clk>;
 				#clock-cells = <0>;
 				clock-div = <3>;
 				clock-mult = <1>;
@@ -160,7 +169,7 @@
 
 			s2_clk: s2 {
 				compatible = "fixed-factor-clock";
-				clocks = <&cpg_clocks R8A7795_CLK_PLL1>;
+				clocks = <&pll1_div2_clk>;
 				#clock-cells = <0>;
 				clock-div = <4>;
 				clock-mult = <1>;
@@ -192,7 +201,7 @@
 
 			s3_clk: s3 {
 				compatible = "fixed-factor-clock";
-				clocks = <&cpg_clocks R8A7795_CLK_PLL1>;
+				clocks = <&pll1_div2_clk>;
 				#clock-cells = <0>;
 				clock-div = <6>;
 				clock-mult = <1>;
@@ -224,7 +233,7 @@
 
 			cl_clk: cl {
 				compatible = "fixed-factor-clock";
-				clocks = <&cpg_clocks R8A7795_CLK_PLL1>;
+				clocks = <&pll1_div2_clk>;
 				#clock-cells = <0>;
 				clock-div = <48>;
 				clock-mult = <1>;
