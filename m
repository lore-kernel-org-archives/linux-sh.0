From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 20 Jan 2011 08:41:03 +0000
Subject: [PATCH] ARM: mach-shmobile: AG5EVM LCDC / MIPI-DSI platform data
Message-Id: <20110120084103.10359.64467.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add platform data for MIPI-DSI and LCDC on the AG5EVM
board. The sh73a0 clkdev bindings are also updated.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig        |    1 
 arch/arm/mach-shmobile/board-ag5evm.c |  155 ++++++++++++++++++++++++++++++++-
 arch/arm/mach-shmobile/clock-sh73a0.c |   13 ++
 3 files changed, 165 insertions(+), 4 deletions(-)

--- 0001/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2011-01-20 16:44:02.000000000 +0900
@@ -61,6 +61,7 @@ endchoice
 config MACH_AG5EVM
 	bool "AG5EVM board"
 	select ARCH_REQUIRE_GPIOLIB
+	select SH_LCD_MIPI_DSI
 	depends on ARCH_SH73A0
 
 config MACH_MACKEREL
--- 0001/arch/arm/mach-shmobile/board-ag5evm.c
+++ work/arch/arm/mach-shmobile/board-ag5evm.c	2011-01-20 17:01:50.000000000 +0900
@@ -34,9 +34,10 @@
 #include <linux/input/sh_keysc.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mmcif.h>
-
+#include <linux/sh_clk.h>
+#include <video/sh_mobile_lcdc.h>
+#include <video/sh_mipi_dsi.h>
 #include <sound/sh_fsi.h>
-
 #include <mach/hardware.h>
 #include <mach/sh73a0.h>
 #include <mach/common.h>
@@ -203,12 +203,145 @@ static struct platform_device irda_devic
 	.num_resources  = ARRAY_SIZE(irda_resources),
 };
 
+static unsigned char lcd_backlight_seq[3][2] = {
+	{ 0x04, 0x07 },
+	{ 0x23, 0x80 },
+	{ 0x03, 0x01 },
+};
+
+static void lcd_backlight_on(void)
+{
+	struct i2c_adapter *a;
+	struct i2c_msg msg;
+	int k;
+
+	a = i2c_get_adapter(1);
+	for (k = 0; a && k < 3; k++) {
+		msg.addr = 0x6d;
+		msg.buf = &lcd_backlight_seq[k][0];
+		msg.len = 2;
+		msg.flags = 0;
+		if (i2c_transfer(a, &msg, 1) != 1)
+			break;
+	}
+}
+
+static void lcd_backlight_reset(void)
+{
+	gpio_set_value(GPIO_PORT235, 0);
+	mdelay(24);
+	gpio_set_value(GPIO_PORT235, 1);
+}
+
+static void lcd_on(void *board_data, struct fb_info *info)
+{
+	lcd_backlight_on();
+}
+
+static void lcd_off(void *board_data)
+{
+	lcd_backlight_reset();
+}
+
+/* LCDC0 */
+static const struct fb_videomode lcdc0_modes[] = {
+	{
+		.name		= "R63302(QHD)",
+		.xres		= 544,
+		.yres		= 961,
+		.left_margin	= 72,
+		.right_margin	= 600,
+		.hsync_len	= 16,
+		.upper_margin	= 8,
+		.lower_margin	= 8,
+		.vsync_len	= 2,
+		.sync		= FB_SYNC_VERT_HIGH_ACT | FB_SYNC_HOR_HIGH_ACT,
+	},
+};
+
+static struct sh_mobile_lcdc_info lcdc0_info = {
+	.clock_source = LCDC_CLK_PERIPHERAL,
+	.ch[0] = {
+		.chan = LCDC_CHAN_MAINLCD,
+		.interface_type = RGB24,
+		.clock_divider = 1,
+		.flags = LCDC_FLAGS_DWPOL,
+		.lcd_size_cfg.width = 44,
+		.lcd_size_cfg.height = 79,
+		.bpp = 16,
+		.lcd_cfg = lcdc0_modes,
+		.num_cfg = ARRAY_SIZE(lcdc0_modes),
+		.board_cfg = {
+			.display_on = lcd_on,
+			.display_off = lcd_off,
+		},
+	}
+};
+
+static struct resource lcdc0_resources[] = {
+	[0] = {
+		.name	= "LCDC0",
+		.start	= 0xfe940000, /* P4-only space */
+		.end	= 0xfe943fff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= intcs_evt2irq(0x580),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device lcdc0_device = {
+	.name		= "sh_mobile_lcdc_fb",
+	.num_resources	= ARRAY_SIZE(lcdc0_resources),
+	.resource	= lcdc0_resources,
+	.id             = 0,
+	.dev	= {
+		.platform_data	= &lcdc0_info,
+		.coherent_dma_mask = ~0,
+	},
+};
+
+/* MIPI-DSI */
+static struct resource mipidsi0_resources[] = {
+	[0] = {
+		.start  = 0xfeab0000,
+		.end    = 0xfeab3fff,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = 0xfeab4000,
+		.end    = 0xfeab7fff,
+		.flags  = IORESOURCE_MEM,
+	},
+};
+
+static struct sh_mipi_dsi_info mipidsi0_info = {
+	.data_format	= MIPI_RGB888,
+	.lcd_chan	= &lcdc0_info.ch[0],
+	.vsynw_offset	= 20,
+	.clksrc		= 1,
+	.flags		= SH_MIPI_DSI_HSABM,
+};
+
+static struct platform_device mipidsi0_device = {
+	.name           = "sh-mipi-dsi",
+	.num_resources  = ARRAY_SIZE(mipidsi0_resources),
+	.resource       = mipidsi0_resources,
+	.id             = 0,
+	.dev	= {
+		.platform_data	= &mipidsi0_info,
+	},
+};
+
 static struct platform_device *ag5evm_devices[] __initdata = {
 	&eth_device,
 	&keysc_device,
 	&fsi_device,
 	&mmc_device,
 	&irda_device,
+	&lcdc0_device,
+	&mipidsi0_device,
 };
 
 static struct map_desc ag5evm_io_desc[] __initdata = {
@@ -245,6 +378,8 @@ void __init ag5evm_init_irq(void)
 	__raw_writew(__raw_readw(PINTCR0A) | (2<<10), PINTCR0A);
 }
 
+#define DSI0PHYCR	0xe615006c
+
 static void __init ag5evm_init(void)
 {
 	sh73a0_pinmux_init();
@@ -313,6 +448,20 @@ static void __init ag5evm_init(void)
 	gpio_request(GPIO_FN_PORT242_IRDA_IN,  NULL);
 	gpio_request(GPIO_FN_PORT243_IRDA_FIRSEL, NULL);
 
+	/* LCD panel */
+	gpio_request(GPIO_PORT217, NULL); /* RESET */
+	gpio_direction_output(GPIO_PORT217, 0);
+	mdelay(1);
+	gpio_set_value(GPIO_PORT217, 1);
+
+	/* LCD backlight controller */
+	gpio_request(GPIO_PORT235, NULL); /* RESET */
+	gpio_direction_output(GPIO_PORT235, 0);
+	lcd_backlight_reset();
+
+	/* MIPI-DSI clock setup */
+	__raw_writel(0x2a809010, DSI0PHYCR);
+
 #ifdef CONFIG_CACHE_L2X0
 	/* Shared attribute override enable, 64K*8way */
 	l2x0_init(__io(0xf0100000), 0x00460000, 0xc2000fff);
--- 0003/arch/arm/mach-shmobile/clock-sh73a0.c
+++ work/arch/arm/mach-shmobile/clock-sh73a0.c	2011-01-20 16:44:02.000000000 +0900
@@ -263,7 +263,7 @@ static struct clk div6_clks[DIV6_NR] = {
 };
 
 enum { MSTP001,
-	MSTP125, MSTP116,
+	MSTP125, MSTP118, MSTP116, MSTP100,
 	MSTP219,
 	MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
 	MSTP331, MSTP329, MSTP325, MSTP323, MSTP312,
@@ -276,7 +276,9 @@ enum { MSTP001,
 static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP001] = MSTP(&div4_clks[DIV4_HP], SMSTPCR0, 1, 0), /* IIC2 */
 	[MSTP125] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR1, 25, 0), /* TMU0 */
+	[MSTP118] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 18, 0), /* DSITX0 */
 	[MSTP116] = MSTP(&div4_clks[DIV4_HP], SMSTPCR1, 16, 0), /* IIC0 */
+	[MSTP100] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 0, 0), /* LCDC0 */
 	[MSTP219] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 19, 0), /* SCIFA7 */
 	[MSTP207] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 7, 0), /* SCIFA5 */
 	[MSTP206] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 6, 0), /* SCIFB */
@@ -297,16 +299,25 @@ static struct clk mstp_clks[MSTP_NR] = {
 
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
 #define CLKDEV_DEV_ID(_id, _clk) { .dev_id = _id, .clk = _clk }
+#define CLKDEV_ICK_ID(_cid, _did, _clk) { .con_id = _cid, .dev_id = _did, .clk = _clk }
 
 static struct clk_lookup lookups[] = {
 	/* main clocks */
 	CLKDEV_CON_ID("r_clk", &r_clk),
 
+	/* DIV6 clocks */
+	CLKDEV_ICK_ID("dsit_clk", "sh-mipi-dsi.0", &div6_clks[DIV6_DSIT]),
+	CLKDEV_ICK_ID("dsit_clk", "sh-mipi-dsi.1", &div6_clks[DIV6_DSIT]),
+	CLKDEV_ICK_ID("dsi0p_clk", "sh-mipi-dsi.0", &div6_clks[DIV6_DSI0P]),
+	CLKDEV_ICK_ID("dsi1p_clk", "sh-mipi-dsi.1", &div6_clks[DIV6_DSI1P]),
+
 	/* MSTP32 clocks */
 	CLKDEV_DEV_ID("i2c-sh_mobile.2", &mstp_clks[MSTP001]), /* I2C2 */
+	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.0", &mstp_clks[MSTP100]), /* LCDC0 */
 	CLKDEV_DEV_ID("sh_tmu.0", &mstp_clks[MSTP125]), /* TMU00 */
 	CLKDEV_DEV_ID("sh_tmu.1", &mstp_clks[MSTP125]), /* TMU01 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.0", &mstp_clks[MSTP116]), /* I2C0 */
+	CLKDEV_DEV_ID("sh-mipi-dsi.0", &mstp_clks[MSTP118]), /* DSITX */
 	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP219]), /* SCIFA7 */
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP207]), /* SCIFA5 */
 	CLKDEV_DEV_ID("sh-sci.8", &mstp_clks[MSTP206]), /* SCIFB */
