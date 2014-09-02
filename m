From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 02 Sep 2014 09:13:06 +0000
Subject: [PATCH v2 10/10] ARM: shmobile: sh73a0: add selectable sources to DIV6 clocks
Message-Id: <1409649186-1046-11-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Specifies clock sources and register bits.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/sh73a0.dtsi | 93 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 74 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 39cb4cf..9c11b5c 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -411,133 +411,188 @@
 		vclk1_clk: vclk1_clk@e6150008 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150008 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&extcki_clk>, <&extal2_clk>, <&main_div2_clk>,
+				 <&extalr_clk>, <&cpg_clocks SH73A0_CLK_MAIN>;
+			renesas,src-shift = <12>;
+			renesas,src-width = <3>;
 			#clock-cells = <0>;
 			clock-output-names = "vclk1";
 		};
 		vclk2_clk: vclk2_clk@e615000c {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe615000c 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&extcki_clk>, <&extal2_clk>, <&main_div2_clk>,
+				 <&extalr_clk>, <&cpg_clocks SH73A0_CLK_MAIN>;
+			renesas,src-shift = <12>;
+			renesas,src-width = <3>;
 			#clock-cells = <0>;
 			clock-output-names = "vclk2";
 		};
 		vclk3_clk: vclk3_clk@e615001c {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe615001c 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&extcki_clk>, <&extal2_clk>, <&main_div2_clk>,
+				 <&extalr_clk>, <&cpg_clocks SH73A0_CLK_MAIN>;
+			renesas,src-shift = <12>;
+			renesas,src-width = <3>;
 			#clock-cells = <0>;
 			clock-output-names = "vclk3";
 		};
 		zb1_clk: zb1_clk@e6150010 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150010 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>;
+			renesas,src-shift = <7>;
+			renesas,src-width = <1>;
 			#clock-cells = <0>;
 			clock-output-names = "zb1";
 		};
 		flctl_clk: flctl_clk@e6150014 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150014 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>;
+			renesas,src-shift = <7>;
+			renesas,src-width = <1>;
 			#clock-cells = <0>;
 			clock-output-names = "flctlck";
 		};
 		sdhi0_clk: sdhi0_clk@e6150074 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150074 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&pll1_div13_clk>;
+			renesas,src-shift = <6>;
+			renesas,src-width = <2>;
 			#clock-cells = <0>;
 			clock-output-names = "sdhi0ck";
 		};
 		sdhi1_clk: sdhi1_clk@e6150078 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150078 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&pll1_div13_clk>;
+			renesas,src-shift = <6>;
+			renesas,src-width = <2>;
 			#clock-cells = <0>;
 			clock-output-names = "sdhi1ck";
 		};
 		sdhi2_clk: sdhi2_clk@e615007c {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe615007c 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&pll1_div13_clk>;
+			renesas,src-shift = <6>;
+			renesas,src-width = <2>;
 			#clock-cells = <0>;
 			clock-output-names = "sdhi2ck";
 		};
 		fsia_clk: fsia_clk@e6150018 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150018 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&fsiack_clk>, <&fsiack_clk>;
+			renesas,src-shift = <6>;
+			renesas,src-width = <2>;
 			#clock-cells = <0>;
 			clock-output-names = "fsia";
 		};
 		fsib_clk: fsib_clk@e6150090 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150090 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&fsibck_clk>, <&fsibck_clk>;
+			renesas,src-shift = <6>;
+			renesas,src-width = <2>;
 			#clock-cells = <0>;
 			clock-output-names = "fsib";
 		};
 		sub_clk: sub_clk@e6150080 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150080 4>;
-			clocks = <&extal2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&extal2_clk>, <&extal2_clk>;
+			renesas,src-shift = <6>;
+			renesas,src-width = <2>;
 			#clock-cells = <0>;
 			clock-output-names = "sub";
 		};
 		spua_clk: spua_clk@e6150084 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150084 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&extal2_clk>, <&extal2_clk>;
+			renesas,src-shift = <6>;
+			renesas,src-width = <2>;
 			#clock-cells = <0>;
 			clock-output-names = "spua";
 		};
 		spuv_clk: spuv_clk@e6150094 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150094 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&extal2_clk>, <&extal2_clk>;
+			renesas,src-shift = <6>;
+			renesas,src-width = <2>;
 			#clock-cells = <0>;
 			clock-output-names = "spuv";
 		};
 		msu_clk: msu_clk@e6150088 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150088 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>;
+			renesas,src-shift = <7>;
+			renesas,src-width = <1>;
 			#clock-cells = <0>;
 			clock-output-names = "msu";
 		};
 		hsi_clk: hsi_clk@e615008c {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe615008c 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&pll1_div7_clk>;
+			renesas,src-shift = <6>;
+			renesas,src-width = <2>;
 			#clock-cells = <0>;
 			clock-output-names = "hsi";
 		};
 		mfg1_clk: mfg1_clk@e6150098 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150098 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>;
+			renesas,src-shift = <7>;
+			renesas,src-width = <1>;
 			#clock-cells = <0>;
 			clock-output-names = "mfg1";
 		};
 		mfg2_clk: mfg2_clk@e615009c {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe615009c 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>;
+			renesas,src-shift = <7>;
+			renesas,src-width = <1>;
 			#clock-cells = <0>;
 			clock-output-names = "mfg2";
 		};
 		dsit_clk: dsit_clk@e6150060 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150060 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>;
+			renesas,src-shift = <7>;
+			renesas,src-width = <1>;
 			#clock-cells = <0>;
 			clock-output-names = "dsit";
 		};
 		dsi0p_clk: dsi0p_clk@e6150064 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150064 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&cpg_clocks SH73A0_CLK_MAIN>, <&extal2_clk>,
+				 <&extcki_clk>;
+			renesas,src-shift = <12>;
+			renesas,src-width = <3>;
 			#clock-cells = <0>;
 			clock-output-names = "dsi0pck";
 		};
-- 
1.8.4.5

