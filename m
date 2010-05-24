From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 24 May 2010 01:55:35 +0000
Subject: [PATCH v2] ARM: mach-shmobile: ap4evb: Add FSI2 support
Message-Id: <w3pd3wmt65q.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

o <asm/clock.h> -> <linux/sh_clk.h>
o use evt2irq for IRQ number
o modify clock-sh7372.c for FSI
o add tiny document

 arch/arm/mach-shmobile/board-ap4evb.c |  138 ++++++++++++++++++++++++++++++++-
 arch/arm/mach-shmobile/clock-sh7372.c |    7 +-
 2 files changed, 139 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 353ff8d..12673d9 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -31,11 +31,15 @@
 #include <linux/i2c/tsc2007.h>
 #include <linux/io.h>
 #include <linux/smsc911x.h>
+#include <linux/sh_intc.h>
+#include <linux/sh_clk.h>
 #include <linux/gpio.h>
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
 #include <linux/usb/r8a66597.h>
 
+#include <sound/sh_fsi.h>
+
 #include <video/sh_mobile_lcdc.h>
 #include <video/sh_mipi_dsi.h>
 
@@ -112,6 +116,13 @@
  * S39: bit2: off
  */
 
+/*
+ * FSI/FSMI
+ *
+ * SW41	:  ON : SH-Mobile AP4 Audio Mode
+ *	: OFF : Bluetooth Audio Mode
+ */
+
 /* MTD */
 static struct mtd_partition nor_flash_partitions[] = {
 	{
@@ -364,6 +375,62 @@ static struct platform_device mipidsi0_device = {
 	},
 };
 
+/* FSI */
+#define IRQ_FSI		evt2irq(0x1840)
+#define FSIACKCR	0xE6150018
+static void fsiackcr_init(struct clk *clk)
+{
+	u32 status = __raw_readl(clk->enable_reg);
+
+	/* use external clock */
+	status &= ~0x000000ff;
+	status |= 0x00000080;
+	__raw_writel(status, clk->enable_reg);
+}
+
+static struct clk_ops fsiackcr_clk_ops = {
+	.init = fsiackcr_init,
+};
+
+static struct clk fsiackcr_clk = {
+	.name		= "fsiackcr_clk",
+	.id		= -1,
+	.ops		= &fsiackcr_clk_ops,
+	.enable_reg	= (void __iomem *)FSIACKCR,
+	.rate		= 0, /* unknown */
+};
+
+struct sh_fsi_platform_info fsi_info = {
+	.porta_flags = SH_FSI_BRS_INV |
+		       SH_FSI_OUT_SLAVE_MODE |
+		       SH_FSI_IN_SLAVE_MODE |
+		       SH_FSI_OFMT(PCM) |
+		       SH_FSI_IFMT(PCM),
+};
+
+static struct resource fsi_resources[] = {
+	[0] = {
+		.name	= "FSI",
+		.start	= 0xFE3C0000,
+		.end	= 0xFE3C0400 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = IRQ_FSI,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device fsi_device = {
+	.name		= "sh_fsi2",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(fsi_resources),
+	.resource	= fsi_resources,
+	.dev	= {
+		.platform_data	= &fsi_info,
+	},
+};
+
 static struct platform_device *ap4evb_devices[] __initdata = {
 	&nor_flash_device,
 	&smc911x_device,
@@ -372,6 +439,7 @@ static struct platform_device *ap4evb_devices[] __initdata = {
 	&usb1_host_device,
 	&lcdc_device,
 	&mipidsi0_device,
+	&fsi_device,
 };
 
 /* TouchScreen (Needs SW3 set to OFF) */
@@ -382,6 +450,12 @@ struct tsc2007_platform_data tsc2007_info = {
 };
 
 /* I2C */
+static struct i2c_board_info i2c0_devices[] = {
+	{
+		I2C_BOARD_INFO("ak4643", 0x13),
+	},
+};
+
 static struct i2c_board_info i2c1_devices[] = {
 	{
 		I2C_BOARD_INFO("r2025sd", 0x32),
@@ -454,8 +528,27 @@ eclkdsitxget:
 
 device_initcall(ap4evb_init_display_clk);
 
+/*
+ * FIXME !!
+ *
+ * gpio_no_direction is quick_hack.
+ *
+ * current gpio frame work doesn't have
+ * the method to control only pull up/down/free.
+ * this function should be replaced by correct gpio function
+ */
+static void __init gpio_no_direction(u32 addr)
+{
+	__raw_writeb(0x00, addr);
+}
+
+#define GPIO_PORT9CR	0xE6051009
+#define GPIO_PORT10CR	0xE605100A
+
 static void __init ap4evb_init(void)
 {
+	struct clk *clk;
+
 	sh7372_pinmux_init();
 
 	/* enable SCIFA0 */
@@ -520,9 +613,6 @@ static void __init ap4evb_init(void)
 	gpio_request(GPIO_FN_IRQ28_123, NULL);
 	set_irq_type(IRQ28, IRQ_TYPE_LEVEL_LOW);
 
-	i2c_register_board_info(1, i2c1_devices,
-				ARRAY_SIZE(i2c1_devices));
-
 	/* USB enable */
 	gpio_request(GPIO_FN_VBUS0_1,    NULL);
 	gpio_request(GPIO_FN_IDIN_1_18,  NULL);
@@ -534,6 +624,48 @@ static void __init ap4evb_init(void)
 	/* setup USB phy */
 	__raw_writew(0x8a0a, 0xE6058130);	/* USBCR2 */
 
+	/* enable FSI2 */
+	gpio_request(GPIO_FN_FSIAIBT,	NULL);
+	gpio_request(GPIO_FN_FSIAILR,	NULL);
+	gpio_request(GPIO_FN_FSIAISLD,	NULL);
+	gpio_request(GPIO_FN_FSIAOSLD,	NULL);
+	gpio_request(GPIO_PORT161,	NULL);
+	gpio_direction_output(GPIO_PORT161, 0); /* slave */
+
+	gpio_request(GPIO_PORT9, NULL);
+	gpio_request(GPIO_PORT10, NULL);
+	gpio_no_direction(GPIO_PORT9CR);  /* FSIAOBT needs no direction */
+	gpio_no_direction(GPIO_PORT10CR); /* FSIAOLR needs no direction */
+
+	/* set SPU2 clock to 119.6 MHz */
+	clk = clk_get(NULL, "spu_clk");
+	if (clk) {
+		clk_set_rate(clk, clk_round_rate(clk, 119600000));
+		clk_put(clk);
+	}
+
+	/* change parent of FSI A */
+	clk = clk_get(NULL, "fsia_clk");
+	if (clk) {
+		clk_register(&fsiackcr_clk);
+		clk_set_parent(clk, &fsiackcr_clk);
+		clk_enable(clk);
+		clk_put(clk);
+	}
+
+	/*
+	 * set irq priority, to avoid sound chopping
+	 * when NFS rootfs is used
+	 *  FSI(3) > SMSC911X(2)
+	 */
+	intc_set_priority(IRQ_FSI, 3);
+
+	i2c_register_board_info(0, i2c0_devices,
+				ARRAY_SIZE(i2c0_devices));
+
+	i2c_register_board_info(1, i2c1_devices,
+				ARRAY_SIZE(i2c1_devices));
+
 	sh7372_add_standard_devices();
 
 	platform_add_devices(ap4evb_devices, ARRAY_SIZE(ap4evb_devices));
diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index f2f9a4a..b8194c1 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -246,7 +246,7 @@ enum { MSTP001,
        MSTP106, MSTP101, MSTP100,
        MSTP223,
        MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
-       MSTP329, MSTP323, MSTP322, MSTP314, MSTP313,
+       MSTP329, MSTP328, MSTP323, MSTP322, MSTP314, MSTP313,
        MSTP415, MSTP410, MSTP411, MSTP406, MSTP403,
        MSTP_NR };
 
@@ -274,6 +274,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP201] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 1, 0), /* SCIFA3 */
 	[MSTP200] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 0, 0), /* SCIFA4 */
 	[MSTP329] = MSTP(&r_clk, SMSTPCR3, 29, 0), /* CMT10 */
+	[MSTP328] = MSTP(&div6_clks[DIV6_FSIA], SMSTPCR3, 28, 0), /* FSIA */
 	[MSTP323] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR3, 23, 0), /* IIC1 */
 	[MSTP322] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR3, 22, 0), /* USB0 */
 	[MSTP314] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 14, 0), /* SDHI0 */
@@ -324,8 +325,6 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("vck3_clk", &div6_clks[DIV6_VCK3]),
 	CLKDEV_CON_ID("fmsi_clk", &div6_clks[DIV6_FMSI]),
 	CLKDEV_CON_ID("fmso_clk", &div6_clks[DIV6_FMSO]),
-	CLKDEV_CON_ID("fsia_clk", &div6_clks[DIV6_FSIA]),
-	CLKDEV_CON_ID("fsib_clk", &div6_clks[DIV6_FSIB]),
 	CLKDEV_CON_ID("sub_clk", &div6_clks[DIV6_SUB]),
 	CLKDEV_CON_ID("spu_clk", &div6_clks[DIV6_SPU]),
 	CLKDEV_CON_ID("vou_clk", &div6_clks[DIV6_VOU]),
@@ -356,6 +355,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.3", &mstp_clks[MSTP201]), /* SCIFA3 */
 	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP200]), /* SCIFA4 */
 	CLKDEV_CON_ID("cmt1", &mstp_clks[MSTP329]), /* CMT10 */
+	CLKDEV_CON_ID("fsia_clk", &mstp_clks[MSTP328]), /* FSI-A */
+	CLKDEV_CON_ID("fsib_clk", &mstp_clks[MSTP328]), /* FSI-B */
 	CLKDEV_DEV_ID("i2c-sh_mobile.1", &mstp_clks[MSTP323]), /* IIC1 */
 	CLKDEV_DEV_ID("r8a66597_hcd.0", &mstp_clks[MSTP323]), /* USB0 */
 	CLKDEV_DEV_ID("r8a66597_udc.0", &mstp_clks[MSTP323]), /* USB0 */
-- 
1.7.0.4

