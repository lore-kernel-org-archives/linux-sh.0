From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 24 Aug 2015 16:12:15 +0000
Subject: [PATCH 3/3] arm64: renesas: r8a7795 dtsi: Add all common divider clocks
Message-Id: <1440432735-9906-4-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add all clocks generated from PLL1 by the CPG common divider block.
This includes s3d4, which was modelled as a direct child from pll1
before.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 154 ++++++++++++++++++++++++++++++-
 1 file changed, 153 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 1c71c8c8a42a9a24..f3c30bd51d9a063d 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -71,11 +71,163 @@
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
 			s3d4_clk: s3d4 {
 				compatible = "fixed-factor-clock";
+				clocks = <&s3_clk>;
+				#clock-cells = <0>;
+				clock-div = <4>;
+				clock-mult = <1>;
+			};
+
+			cl_clk: cl {
+				compatible = "fixed-factor-clock";
 				clocks = <&cpg_clocks R8A7795_CLK_PLL1>;
 				#clock-cells = <0>;
-				clock-div = <24>;
+				clock-div = <48>;
 				clock-mult = <1>;
 			};
 
-- 
1.9.1

