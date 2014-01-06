From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 06 Jan 2014 08:18:31 +0000
Subject: [PATCH] ARM: shmobile: r8a7790: add audio clocks
Message-Id: <8738l1jzfv.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
>> Laurent

Could you please check this patch ?

>> Simon

This patch is based on renesas-devel-v3.13-rc5-20131230 tag

 arch/arm/boot/dts/r8a7790.dtsi         |   29 +++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7790.c |   16 ++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index f48487c..abe68b9 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -312,6 +312,27 @@
 			clock-frequency = <0>;
 			clock-output-names = "extal";
 		};
+		audio_clk_a: audio_clk_a {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			/* This value can be overriden by the board if exist */
+			clock-frequency = <0>;
+			clock-output-names = "audio_clk_a";
+		};
+		audio_clk_b: audio_clk_b {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			/* This value can be overriden by the board if exist */
+			clock-frequency = <0>;
+			clock-output-names = "audio_clk_b";
+		};
+		audio_clk_c: audio_clk_c {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			/* This value can be overriden by the board if exist */
+			clock-frequency = <0>;
+			clock-output-names = "audio_clk_c";
+		};
 
 		/* Special CPG clocks */
 		cpg_clocks: cpg_clocks@e6150000 {
@@ -522,6 +543,14 @@
 			clock-mult = <1>;
 			clock-output-names = "cp";
 		};
+		audio_clk_internal: audio_clk_internal {
+			compatible = "fixed-factor-clock";
+			clocks = <&m2_clk>;
+			#clock-cells = <0>;
+			clock-div = <1>;
+			clock-mult = <1>;
+			clock-output-names = "audio_clk_internal";
+		};
 
 		/* Gate clocks */
 		mstp0_clks: mstp0_clks@e6150130 {
diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index c5c60ec..9dd5499b4 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -82,6 +82,15 @@ static struct clk main_clk = {
 	.ops	= &followparent_clk_ops,
 };
 
+static struct clk audio_clk_a = {
+};
+
+static struct clk audio_clk_b = {
+};
+
+static struct clk audio_clk_c = {
+};
+
 /*
  * clock ratio of these clock will be updated
  * on r8a7790_clock_init()
@@ -115,6 +124,9 @@ SH_FIXED_RATIO_CLK_SET(ddr_clk,			pll3_clk,	1, 8);
 SH_FIXED_RATIO_CLK_SET(mp_clk,			pll1_div2_clk,	1, 15);
 
 static struct clk *main_clks[] = {
+	&audio_clk_a,
+	&audio_clk_b,
+	&audio_clk_c,
 	&extal_clk,
 	&extal_div2_clk,
 	&main_clk,
@@ -246,6 +258,10 @@ static struct clk mstp_clks[MSTP_NR] = {
 static struct clk_lookup lookups[] = {
 
 	/* main clocks */
+	CLKDEV_CON_ID("audio_clk_a",	&audio_clk_a),
+	CLKDEV_CON_ID("audio_clk_b",	&audio_clk_b),
+	CLKDEV_CON_ID("audio_clk_c",	&audio_clk_c),
+	CLKDEV_CON_ID("audio_clk_internal",	&m2_clk),
 	CLKDEV_CON_ID("extal",		&extal_clk),
 	CLKDEV_CON_ID("extal_div2",	&extal_div2_clk),
 	CLKDEV_CON_ID("main",		&main_clk),
-- 
1.7.9.5

