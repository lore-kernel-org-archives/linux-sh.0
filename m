From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 15 Oct 2010 05:15:05 +0000
Subject: [PATCH 2/3] ARM: mach-shmobile: clock-sh7372: FSI parent select support
Message-Id: <w3plj6011gm.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c        |   70 +++++++++++++++-----------
 arch/arm/mach-shmobile/clock-sh7372.c        |   45 ++++++++++++++---
 arch/arm/mach-shmobile/include/mach/sh7372.h |    2 +
 3 files changed, 80 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index f879eb3..1e7beee 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -546,27 +546,6 @@ static struct platform_device *qhd_devices[] __initdata = {
 
 /* FSI */
 #define IRQ_FSI		evt2irq(0x1840)
-#define FSIACKCR	0xE6150018
-static void fsiackcr_init(struct clk *clk)
-{
-	u32 status = __raw_readl(clk->enable_reg);
-
-	/* use external clock */
-	status &= ~0x000000ff;
-	status |= 0x00000080;
-	__raw_writel(status, clk->enable_reg);
-}
-
-static struct clk_ops fsiackcr_clk_ops = {
-	.init = fsiackcr_init,
-};
-
-static struct clk fsiackcr_clk = {
-	.ops		= &fsiackcr_clk_ops,
-	.enable_reg	= (void __iomem *)FSIACKCR,
-	.rate		= 0, /* unknown */
-};
-
 static struct sh_fsi_platform_info fsi_info = {
 	.porta_flags = SH_FSI_BRS_INV |
 		       SH_FSI_OUT_SLAVE_MODE |
@@ -817,6 +796,47 @@ out:
 
 device_initcall(hdmi_init_pm_clock);
 
+#define FSIACK_DUMMY_RATE 48000
+static int __init fsi_init_pm_clock(void)
+{
+	struct clk *fsia_ick;
+	int ret;
+
+	/*
+	 * FSIACK is connected to AK4642,
+	 * and the rate is depend on playing sound rate.
+	 * So, set dummy rate (= 48k) here
+	 */
+	ret = clk_set_rate(&sh7372_fsiack_clk, FSIACK_DUMMY_RATE);
+	if (ret < 0) {
+		pr_err("Cannot set FSIACK dummy rate: %d\n", ret);
+		return ret;
+	}
+
+	fsia_ick = clk_get(&fsi_device.dev, "icka");
+	if (IS_ERR(fsia_ick)) {
+		ret = PTR_ERR(fsia_ick);
+		pr_err("Cannot get FSI ICK: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_set_parent(fsia_ick, &sh7372_fsiack_clk);
+	if (ret < 0) {
+		pr_err("Cannot set FSI-A parent: %d\n", ret);
+		goto out;
+	}
+
+	ret = clk_set_rate(fsia_ick, FSIACK_DUMMY_RATE);
+	if (ret < 0)
+		pr_err("Cannot set FSI-A rate: %d\n", ret);
+
+out:
+	clk_put(fsia_ick);
+
+	return ret;
+}
+device_initcall(fsi_init_pm_clock);
+
 /*
  * FIXME !!
  *
@@ -1007,14 +1027,6 @@ static void __init ap4evb_init(void)
 		clk_put(clk);
 	}
 
-	/* change parent of FSI A */
-	clk = clk_get(NULL, "fsia_clk");
-	if (!IS_ERR(clk)) {
-		clk_register(&fsiackcr_clk);
-		clk_set_parent(clk, &fsiackcr_clk);
-		clk_put(clk);
-	}
-
 	/*
 	 * set irq priority, to avoid sound chopping
 	 * when NFS rootfs is used
diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index 50c3971..4557084 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -292,6 +292,13 @@ struct clk sh7372_pllc2_clk = {
 	.parent_num	= ARRAY_SIZE(pllc2_parent),
 };
 
+/* External input clock (pin name: FSIACK/FSIBCK ) */
+struct clk sh7372_fsiack_clk = {
+};
+
+struct clk sh7372_fsibck_clk = {
+};
+
 static struct clk *main_clks[] = {
 	&sh7372_dv_clki_clk,
 	&r_clk,
@@ -305,6 +312,8 @@ static struct clk *main_clks[] = {
 	&pllc1_clk,
 	&pllc1_div2_clk,
 	&sh7372_pllc2_clk,
+	&sh7372_fsiack_clk,
+	&sh7372_fsibck_clk,
 };
 
 static void div4_kick(struct clk *clk)
@@ -357,7 +366,7 @@ static struct clk div4_clks[DIV4_NR] = {
 };
 
 enum { DIV6_VCK1, DIV6_VCK2, DIV6_VCK3, DIV6_FMSI, DIV6_FMSO,
-       DIV6_FSIA, DIV6_FSIB, DIV6_SUB, DIV6_SPU,
+       DIV6_SUB, DIV6_SPU,
        DIV6_VOU, DIV6_DSIT, DIV6_DSI0P, DIV6_DSI1P,
        DIV6_NR };
 
@@ -367,8 +376,6 @@ static struct clk div6_clks[DIV6_NR] = {
 	[DIV6_VCK3] = SH_CLK_DIV6(&pllc1_div2_clk, VCLKCR3, 0),
 	[DIV6_FMSI] = SH_CLK_DIV6(&pllc1_div2_clk, FMSICKCR, 0),
 	[DIV6_FMSO] = SH_CLK_DIV6(&pllc1_div2_clk, FMSOCKCR, 0),
-	[DIV6_FSIA] = SH_CLK_DIV6(&pllc1_div2_clk, FSIACKCR, 0),
-	[DIV6_FSIB] = SH_CLK_DIV6(&pllc1_div2_clk, FSIBCKCR, 0),
 	[DIV6_SUB] = SH_CLK_DIV6(&sh7372_extal2_clk, SUBCKCR, 0),
 	[DIV6_SPU] = SH_CLK_DIV6(&pllc1_div2_clk, SPUCKCR, 0),
 	[DIV6_VOU] = SH_CLK_DIV6(&pllc1_div2_clk, VOUCKCR, 0),
@@ -377,7 +384,7 @@ static struct clk div6_clks[DIV6_NR] = {
 	[DIV6_DSI1P] = SH_CLK_DIV6(&pllc1_div2_clk, DSI1PCKCR, 0),
 };
 
-enum { DIV6_HDMI, DIV6_REPARENT_NR };
+enum { DIV6_HDMI, DIV6_FSIA, DIV6_FSIB, DIV6_REPARENT_NR };
 
 /* Indices are important - they are the actual src selecting values */
 static struct clk *hdmi_parent[] = {
@@ -387,9 +394,27 @@ static struct clk *hdmi_parent[] = {
 	[3] = NULL,	/* pllc2_div4 not implemented yet */
 };
 
+static struct clk *fsiackcr_parent[] = {
+	[0] = &pllc1_div2_clk,
+	[1] = &sh7372_pllc2_clk,
+	[2] = &sh7372_fsiack_clk, /* external input for FSI A */
+	[3] = NULL,	/* setting prohibited */
+};
+
+static struct clk *fsibckcr_parent[] = {
+	[0] = &pllc1_div2_clk,
+	[1] = &sh7372_pllc2_clk,
+	[2] = &sh7372_fsibck_clk, /* external input for FSI B */
+	[3] = NULL,	/* setting prohibited */
+};
+
 static struct clk div6_reparent_clks[DIV6_REPARENT_NR] = {
 	[DIV6_HDMI] = SH_CLK_DIV6_EXT(&pllc1_div2_clk, HDMICKCR, 0,
 				      hdmi_parent, ARRAY_SIZE(hdmi_parent), 6, 2),
+	[DIV6_FSIA] = SH_CLK_DIV6_EXT(&pllc1_div2_clk, FSIACKCR, 0,
+				      fsiackcr_parent, ARRAY_SIZE(fsiackcr_parent), 6, 2),
+	[DIV6_FSIB] = SH_CLK_DIV6_EXT(&pllc1_div2_clk, FSIBCKCR, 0,
+				      fsibckcr_parent, ARRAY_SIZE(fsibckcr_parent), 6, 2),
 };
 
 enum { MSTP001,
@@ -429,7 +454,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP201] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 1, 0), /* SCIFA3 */
 	[MSTP200] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 0, 0), /* SCIFA4 */
 	[MSTP329] = MSTP(&r_clk, SMSTPCR3, 29, 0), /* CMT10 */
-	[MSTP328] = MSTP(&div6_clks[DIV6_SPU], SMSTPCR3, 28, 0), /* FSIA */
+	[MSTP328] = MSTP(&div6_clks[DIV6_SPU], SMSTPCR3, 28, 0), /* FSI2 */
 	[MSTP323] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR3, 23, 0), /* IIC1 */
 	[MSTP322] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR3, 22, 0), /* USB0 */
 	[MSTP314] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 14, 0), /* SDHI0 */
@@ -445,6 +470,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
 #define CLKDEV_DEV_ID(_id, _clk) { .dev_id = _id, .clk = _clk }
+#define CLKDEV_ICK_ID(_cid, _did, _clk) { .con_id = _cid, .dev_id = _did, .clk = _clk }
 
 static struct clk_lookup lookups[] = {
 	/* main clocks */
@@ -483,8 +509,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("vck3_clk", &div6_clks[DIV6_VCK3]),
 	CLKDEV_CON_ID("fmsi_clk", &div6_clks[DIV6_FMSI]),
 	CLKDEV_CON_ID("fmso_clk", &div6_clks[DIV6_FMSO]),
-	CLKDEV_CON_ID("fsia_clk", &div6_clks[DIV6_FSIA]),
-	CLKDEV_CON_ID("fsib_clk", &div6_clks[DIV6_FSIB]),
+	CLKDEV_CON_ID("fsia_clk", &div6_reparent_clks[DIV6_FSIA]),
+	CLKDEV_CON_ID("fsib_clk", &div6_reparent_clks[DIV6_FSIB]),
 	CLKDEV_CON_ID("sub_clk", &div6_clks[DIV6_SUB]),
 	CLKDEV_CON_ID("spu_clk", &div6_clks[DIV6_SPU]),
 	CLKDEV_CON_ID("vou_clk", &div6_clks[DIV6_VOU]),
@@ -531,7 +557,10 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("r8a66597_hcd.1", &mstp_clks[MSTP406]), /* USB1 */
 	CLKDEV_DEV_ID("r8a66597_udc.1", &mstp_clks[MSTP406]), /* USB1 */
 	CLKDEV_DEV_ID("sh_keysc.0", &mstp_clks[MSTP403]), /* KEYSC */
-	{.con_id = "ick", .dev_id = "sh-mobile-hdmi", .clk = &div6_reparent_clks[DIV6_HDMI]},
+
+	CLKDEV_ICK_ID("ick", "sh-mobile-hdmi", &div6_reparent_clks[DIV6_HDMI]),
+	CLKDEV_ICK_ID("icka", "sh_fsi2", &div6_reparent_clks[DIV6_FSIA]),
+	CLKDEV_ICK_ID("ickb", "sh_fsi2", &div6_reparent_clks[DIV6_FSIB]),
 };
 
 void __init sh7372_clock_init(void)
diff --git a/arch/arm/mach-shmobile/include/mach/sh7372.h b/arch/arm/mach-shmobile/include/mach/sh7372.h
index 9838fcf..147775a 100644
--- a/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ b/arch/arm/mach-shmobile/include/mach/sh7372.h
@@ -462,5 +462,7 @@ extern struct clk sh7372_extal2_clk;
 extern struct clk sh7372_dv_clki_clk;
 extern struct clk sh7372_dv_clki_div2_clk;
 extern struct clk sh7372_pllc2_clk;
+extern struct clk sh7372_fsiack_clk;
+extern struct clk sh7372_fsibck_clk;
 
 #endif /* __ASM_SH7372_H__ */
-- 
1.7.0.4

