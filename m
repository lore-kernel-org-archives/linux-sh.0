From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 15 Oct 2010 05:14:54 +0000
Subject: [PATCH 1/3] ARM: mach-shmobile: clock-sh7372: add sh7372_ prefix to
Message-Id: <w3pmxqg11gx.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch also registered global extal clocks to sh7372.h

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c        |   14 +++++++-------
 arch/arm/mach-shmobile/clock-sh7372.c        |   24 ++++++++++++------------
 arch/arm/mach-shmobile/include/mach/sh7372.h |    8 +++++---
 3 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index aaac8b0..f879eb3 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -780,22 +780,22 @@ static int __init hdmi_init_pm_clock(void)
 		goto out;
 	}
 
-	ret = clk_set_parent(&pllc2_clk, &dv_clki_div2_clk);
+	ret = clk_set_parent(&sh7372_pllc2_clk, &sh7372_dv_clki_div2_clk);
 	if (ret < 0) {
-		pr_err("Cannot set PLLC2 parent: %d, %d users\n", ret, pllc2_clk.usecount);
+		pr_err("Cannot set PLLC2 parent: %d, %d users\n", ret, sh7372_pllc2_clk.usecount);
 		goto out;
 	}
 
-	pr_debug("PLLC2 initial frequency %lu\n", clk_get_rate(&pllc2_clk));
+	pr_debug("PLLC2 initial frequency %lu\n", clk_get_rate(&sh7372_pllc2_clk));
 
-	rate = clk_round_rate(&pllc2_clk, 594000000);
+	rate = clk_round_rate(&sh7372_pllc2_clk, 594000000);
 	if (rate < 0) {
 		pr_err("Cannot get suitable rate: %ld\n", rate);
 		ret = rate;
 		goto out;
 	}
 
-	ret = clk_set_rate(&pllc2_clk, rate);
+	ret = clk_set_rate(&sh7372_pllc2_clk, rate);
 	if (ret < 0) {
 		pr_err("Cannot set rate %ld: %d\n", rate, ret);
 		goto out;
@@ -803,7 +803,7 @@ static int __init hdmi_init_pm_clock(void)
 
 	pr_debug("PLLC2 set frequency %lu\n", rate);
 
-	ret = clk_set_parent(hdmi_ick, &pllc2_clk);
+	ret = clk_set_parent(hdmi_ick, &sh7372_pllc2_clk);
 	if (ret < 0) {
 		pr_err("Cannot set HDMI parent: %d\n", ret);
 		goto out;
@@ -1132,7 +1132,7 @@ static void __init ap4evb_timer_init(void)
 	shmobile_timer.init();
 
 	/* External clock source */
-	clk_set_rate(&dv_clki_clk, 27000000);
+	clk_set_rate(&sh7372_dv_clki_clk, 27000000);
 }
 
 static struct sys_timer ap4evb_timer = {
diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index 3ab190a..50c3971 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -51,7 +51,7 @@
 #define SMSTPCR4	0xe6150140
 
 /* Platforms must set frequency on their DV_CLKI pin */
-struct clk dv_clki_clk = {
+struct clk sh7372_dv_clki_clk = {
 };
 
 /* Fixed 32 KHz root clock from EXTALR pin */
@@ -86,9 +86,9 @@ static struct clk_ops div2_clk_ops = {
 };
 
 /* Divide dv_clki by two */
-struct clk dv_clki_div2_clk = {
+struct clk sh7372_dv_clki_div2_clk = {
 	.ops		= &div2_clk_ops,
-	.parent		= &dv_clki_clk,
+	.parent		= &sh7372_dv_clki_clk,
 };
 
 /* Divide extal1 by two */
@@ -150,7 +150,7 @@ static struct clk pllc1_div2_clk = {
 static struct clk *pllc2_parent[] = {
 	[0] = &extal1_div2_clk,
 	[1] = &extal2_div2_clk,
-	[2] = &dv_clki_div2_clk,
+	[2] = &sh7372_dv_clki_div2_clk,
 };
 
 /* Only multipliers 20 * 2 to 46 * 2 are valid, last entry for CPUFREQ_TABLE_END */
@@ -284,7 +284,7 @@ static struct clk_ops pllc2_clk_ops = {
 	.set_parent	= pllc2_set_parent,
 };
 
-struct clk pllc2_clk = {
+struct clk sh7372_pllc2_clk = {
 	.ops		= &pllc2_clk_ops,
 	.parent		= &extal1_div2_clk,
 	.freq_table	= pllc2_freq_table,
@@ -293,18 +293,18 @@ struct clk pllc2_clk = {
 };
 
 static struct clk *main_clks[] = {
-	&dv_clki_clk,
+	&sh7372_dv_clki_clk,
 	&r_clk,
 	&sh7372_extal1_clk,
 	&sh7372_extal2_clk,
-	&dv_clki_div2_clk,
+	&sh7372_dv_clki_div2_clk,
 	&extal1_div2_clk,
 	&extal2_div2_clk,
 	&extal2_div4_clk,
 	&pllc0_clk,
 	&pllc1_clk,
 	&pllc1_div2_clk,
-	&pllc2_clk,
+	&sh7372_pllc2_clk,
 };
 
 static void div4_kick(struct clk *clk)
@@ -382,8 +382,8 @@ enum { DIV6_HDMI, DIV6_REPARENT_NR };
 /* Indices are important - they are the actual src selecting values */
 static struct clk *hdmi_parent[] = {
 	[0] = &pllc1_div2_clk,
-	[1] = &pllc2_clk,
-	[2] = &dv_clki_clk,
+	[1] = &sh7372_pllc2_clk,
+	[2] = &sh7372_dv_clki_clk,
 	[3] = NULL,	/* pllc2_div4 not implemented yet */
 };
 
@@ -448,7 +448,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 
 static struct clk_lookup lookups[] = {
 	/* main clocks */
-	CLKDEV_CON_ID("dv_clki_div2_clk", &dv_clki_div2_clk),
+	CLKDEV_CON_ID("dv_clki_div2_clk", &sh7372_dv_clki_div2_clk),
 	CLKDEV_CON_ID("r_clk", &r_clk),
 	CLKDEV_CON_ID("extal1", &sh7372_extal1_clk),
 	CLKDEV_CON_ID("extal2", &sh7372_extal2_clk),
@@ -458,7 +458,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("pllc0_clk", &pllc0_clk),
 	CLKDEV_CON_ID("pllc1_clk", &pllc1_clk),
 	CLKDEV_CON_ID("pllc1_div2_clk", &pllc1_div2_clk),
-	CLKDEV_CON_ID("pllc2_clk", &pllc2_clk),
+	CLKDEV_CON_ID("pllc2_clk", &sh7372_pllc2_clk),
 
 	/* DIV4 clocks */
 	CLKDEV_CON_ID("i_clk", &div4_clks[DIV4_I]),
diff --git a/arch/arm/mach-shmobile/include/mach/sh7372.h b/arch/arm/mach-shmobile/include/mach/sh7372.h
index 33e9700..9838fcf 100644
--- a/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ b/arch/arm/mach-shmobile/include/mach/sh7372.h
@@ -457,8 +457,10 @@ enum {
 	SHDMA_SLAVE_SDHI2_TX,
 };
 
-extern struct clk dv_clki_clk;
-extern struct clk dv_clki_div2_clk;
-extern struct clk pllc2_clk;
+extern struct clk sh7372_extal1_clk;
+extern struct clk sh7372_extal2_clk;
+extern struct clk sh7372_dv_clki_clk;
+extern struct clk sh7372_dv_clki_div2_clk;
+extern struct clk sh7372_pllc2_clk;
 
 #endif /* __ASM_SH7372_H__ */
-- 
1.7.0.4

