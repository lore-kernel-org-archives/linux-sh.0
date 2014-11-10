From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Nov 2014 09:25:27 +0000
Subject: Re: [PATCH v4 0/6] sh73a0 common clock framework implementation
Message-Id: <alpine.DEB.2.10.1411101020290.11544@ayla.of.borg>
List-Id: <linux-sh.vger.kernel.org>
References: <1415292641-30331-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1415292641-30331-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

	Hi Ulrich,

On Thu, 6 Nov 2014, Ulrich Hecht wrote:
> This integrates the consistency fixes suggested by Laurent and omits the
> ethernet clock hack.

Thanks for your updated series!

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
in combination with:

  - your patch "[PATCH v3 7/7] ARM: shmobile: kzm9g-reference: require ZB clock
    for Ethernet controller", else the Ethernet doesn't work,
  - your series "[PATCH v7 0/2] clk: shmobile: DIV6 clock variable parent
    support",
  - your patch "[PATCH] ARM: shmobile: sh73a0: add selectable sources to
    DIV6", which I updated for the series above, result below.

From a93dfe32b2ed92048d812b000c7b80fcf6d87c42 Mon Sep 17 00:00:00 2001
From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 2 Sep 2014 11:13:06 +0200
Subject: [PATCH] ARM: shmobile: sh73a0: add selectable sources to DIV6
 clocks

Specifies clock sources and register bits.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
[geert: Drop renesas,src-shift/renesas,src-width, pad to 4 or 8 parents]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/sh73a0.dtsi | 64 ++++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 31332c662a409bf2..ccb2b2c54d4711c4 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -410,133 +410,159 @@
 		vclk1_clk: vclk1_clk@e6150008 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150008 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&extcki_clk>, <&extal2_clk>, <&main_div2_clk>,
+				 <&extalr_clk>, <&cpg_clocks SH73A0_CLK_MAIN>,
+				 <0>;
 			#clock-cells = <0>;
 			clock-output-names = "vclk1";
 		};
 		vclk2_clk: vclk2_clk@e615000c {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe615000c 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&extcki_clk>, <&extal2_clk>, <&main_div2_clk>,
+				 <&extalr_clk>, <&cpg_clocks SH73A0_CLK_MAIN>,
+				 <0>;
 			#clock-cells = <0>;
 			clock-output-names = "vclk2";
 		};
 		vclk3_clk: vclk3_clk@e615001c {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe615001c 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&extcki_clk>, <&extal2_clk>, <&main_div2_clk>,
+				 <&extalr_clk>, <&cpg_clocks SH73A0_CLK_MAIN>,
+				 <0>;
 			#clock-cells = <0>;
 			clock-output-names = "vclk3";
 		};
 		zb_clk: zb_clk@e6150010 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150010 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>,
+				 <&cpg_clocks SH73A0_CLK_PLL2>, <0>, <0>;
 			#clock-cells = <0>;
 			clock-output-names = "zb";
 		};
 		flctl_clk: flctl_clk@e6150014 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150014 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>,
+				 <&cpg_clocks SH73A0_CLK_PLL2>, <0>, <0>;
 			#clock-cells = <0>;
 			clock-output-names = "flctlck";
 		};
 		sdhi0_clk: sdhi0_clk@e6150074 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150074 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&pll1_div13_clk>, <0>;
 			#clock-cells = <0>;
 			clock-output-names = "sdhi0ck";
 		};
 		sdhi1_clk: sdhi1_clk@e6150078 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150078 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&pll1_div13_clk>, <0>;
 			#clock-cells = <0>;
 			clock-output-names = "sdhi1ck";
 		};
 		sdhi2_clk: sdhi2_clk@e615007c {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe615007c 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&pll1_div13_clk>, <0>;
 			#clock-cells = <0>;
 			clock-output-names = "sdhi2ck";
 		};
 		fsia_clk: fsia_clk@e6150018 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150018 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&fsiack_clk>, <&fsiack_clk>;
 			#clock-cells = <0>;
 			clock-output-names = "fsia";
 		};
 		fsib_clk: fsib_clk@e6150090 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150090 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&fsibck_clk>, <&fsibck_clk>;
 			#clock-cells = <0>;
 			clock-output-names = "fsib";
 		};
 		sub_clk: sub_clk@e6150080 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150080 4>;
-			clocks = <&extal2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&extal2_clk>, <&extal2_clk>;
 			#clock-cells = <0>;
 			clock-output-names = "sub";
 		};
 		spua_clk: spua_clk@e6150084 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150084 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&extal2_clk>, <&extal2_clk>;
 			#clock-cells = <0>;
 			clock-output-names = "spua";
 		};
 		spuv_clk: spuv_clk@e6150094 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150094 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&extal2_clk>, <&extal2_clk>;
 			#clock-cells = <0>;
 			clock-output-names = "spuv";
 		};
 		msu_clk: msu_clk@e6150088 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150088 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <0>, <0>;
 			#clock-cells = <0>;
 			clock-output-names = "msu";
 		};
 		hsi_clk: hsi_clk@e615008c {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe615008c 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&pll1_div7_clk>, <0>;
 			#clock-cells = <0>;
 			clock-output-names = "hsi";
 		};
 		mfg1_clk: mfg1_clk@e6150098 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150098 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <0>, <0>;
 			#clock-cells = <0>;
 			clock-output-names = "mfg1";
 		};
 		mfg2_clk: mfg2_clk@e615009c {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe615009c 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <0>, <0>;
 			#clock-cells = <0>;
 			clock-output-names = "mfg2";
 		};
 		dsit_clk: dsit_clk@e6150060 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150060 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <0>, <0>;
 			#clock-cells = <0>;
 			clock-output-names = "dsit";
 		};
 		dsi0p_clk: dsi0p_clk@e6150064 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150064 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&cpg_clocks SH73A0_CLK_MAIN>, <&extal2_clk>,
+				 <&extcki_clk>, <0>, <0>, <0>;
 			#clock-cells = <0>;
 			clock-output-names = "dsi0pck";
 		};
-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
