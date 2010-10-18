From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 18 Oct 2010 10:13:05 +0000
Subject: [PATCH] ARM: mach-shmobile: ap4evb: Add HDMI sound support
Message-Id: <w3plj5vu7v2.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uhbpex68f.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uhbpex68f.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
This patch is depend on my FSIDIV support patch and ALSA tree

 arch/arm/mach-shmobile/board-ap4evb.c |   46 ++++++++++++++++++++++++++++++++-
 1 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index efbdbdf..9ba8f8a 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -517,12 +517,50 @@ static struct platform_device *qhd_devices[] __initdata = {
 
 /* FSI */
 #define IRQ_FSI		evt2irq(0x1840)
+
+static int fsi_set_rate(int is_porta, int rate)
+{
+	struct clk *fsib_clk;
+	struct clk *fdiv_clk = &sh7372_fsidivb_clk;
+	int ret;
+
+	/* set_rate is not needed if port A */
+	if (is_porta)
+		return 0;
+
+	fsib_clk = clk_get(NULL, "fsib_clk");
+	if (IS_ERR(fsib_clk))
+		return -EINVAL;
+
+	switch (rate) {
+	case 48000:
+		clk_set_rate(fsib_clk, clk_round_rate(fsib_clk, 85428000));
+		clk_set_rate(fdiv_clk, clk_round_rate(fdiv_clk, 12204000));
+		ret = SH_FSI_ACKMD_256 | SH_FSI_BPFMD_64;
+		break;
+	default:
+		pr_err("unsupported rate in FSI2 port B\n");
+		ret = -EINVAL;
+		break;
+	}
+
+	clk_put(fsib_clk);
+
+	return ret;
+}
+
 static struct sh_fsi_platform_info fsi_info = {
 	.porta_flags = SH_FSI_BRS_INV |
 		       SH_FSI_OUT_SLAVE_MODE |
 		       SH_FSI_IN_SLAVE_MODE |
 		       SH_FSI_OFMT(PCM) |
 		       SH_FSI_IFMT(PCM),
+
+	.portb_flags = SH_FSI_BRS_INV |
+		       SH_FSI_BRM_INV |
+		       SH_FSI_LRS_INV |
+		       SH_FSI_OFMT(SPDIF),
+	.set_rate = fsi_set_rate,
 };
 
 static struct resource fsi_resources[] = {
@@ -606,6 +644,7 @@ static struct platform_device lcdc1_device = {
 static struct sh_mobile_hdmi_info hdmi_info = {
 	.lcd_chan = &sh_mobile_lcdc1_info.ch[0],
 	.lcd_dev = &lcdc1_device.dev,
+	.flags = HDMI_SND_SRC_SPDIF,
 };
 
 static struct resource hdmi_resources[] = {
@@ -838,6 +877,7 @@ static void __init ap4evb_map_io(void)
 
 #define GPIO_PORT9CR	0xE6051009
 #define GPIO_PORT10CR	0xE605100A
+#define USCCR1		0xE6058144
 static void __init ap4evb_init(void)
 {
 	u32 srcr4;
@@ -908,7 +948,7 @@ static void __init ap4evb_init(void)
 	/* setup USB phy */
 	__raw_writew(0x8a0a, 0xE6058130);	/* USBCR2 */
 
-	/* enable FSI2 */
+	/* enable FSI2 port A (ak4643) */
 	gpio_request(GPIO_FN_FSIAIBT,	NULL);
 	gpio_request(GPIO_FN_FSIAILR,	NULL);
 	gpio_request(GPIO_FN_FSIAISLD,	NULL);
@@ -921,6 +961,10 @@ static void __init ap4evb_init(void)
 	gpio_no_direction(GPIO_PORT9CR);  /* FSIAOBT needs no direction */
 	gpio_no_direction(GPIO_PORT10CR); /* FSIAOLR needs no direction */
 
+	/* setup FSI2 port B (HDMI) */
+	gpio_request(GPIO_FN_FSIBCK, NULL);
+	__raw_writew(__raw_readw(USCCR1) & ~(1 << 6), USCCR1); /* use SPDIF */
+
 	/* set SPU2 clock to 119.6 MHz */
 	clk = clk_get(NULL, "spu_clk");
 	if (!IS_ERR(clk)) {
-- 
1.7.0.4

