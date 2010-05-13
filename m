From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 13 May 2010 01:08:10 +0000
Subject: [PATCH] ARM: mach-shmobile: ap4evb: Add FSI2 support
Message-Id: <ud3x0libp.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uhbpex68f.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uhbpex68f.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
This patch needs Magnus's clock patch series

 arch/arm/mach-shmobile/board-ap4evb.c |  129 ++++++++++++++++++++++++++++++++-
 1 files changed, 126 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index d3b8ca5..a553c16 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -30,15 +30,18 @@
 #include <linux/i2c/tsc2007.h>
 #include <linux/io.h>
 #include <linux/smsc911x.h>
+#include <linux/sh_intc.h>
 #include <linux/gpio.h>
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
 #include <linux/usb/r8a66597.h>
+#include <sound/sh_fsi.h>
 #include <mach/common.h>
 #include <mach/sh7372.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/clock.h>
 
 /*
  * Address	Interface		BusWidth	note
@@ -284,12 +287,69 @@ static struct platform_device usb1_host_device = {
 	.resource	= usb1_host_resources,
 };
 
+/* FSI */
+#define IRQ_FSI		178
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
 	&keysc_device,
 	&sdhi0_device,
 	&usb1_host_device,
+	&fsi_device,
 };
 
 /* TouchScreen (Needs SW3 set to OFF) */
@@ -300,6 +360,12 @@ struct tsc2007_platform_data tsc2007_info = {
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
@@ -334,8 +400,27 @@ static void __init ap4evb_map_io(void)
 	shmobile_setup_console();
 }
 
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
@@ -400,9 +485,6 @@ static void __init ap4evb_init(void)
 	gpio_request(GPIO_FN_IRQ28_123, NULL);
 	set_irq_type(IRQ28, IRQ_TYPE_LEVEL_LOW);
 
-	i2c_register_board_info(1, i2c1_devices,
-				ARRAY_SIZE(i2c1_devices));
-
 	/* USB enable */
 	gpio_request(GPIO_FN_VBUS0_1,    NULL);
 	gpio_request(GPIO_FN_IDIN_1_18,  NULL);
@@ -414,6 +496,47 @@ static void __init ap4evb_init(void)
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
-- 
1.7.0.4

