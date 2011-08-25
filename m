From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 25 Aug 2011 04:06:17 +0000
Subject: [PATCH 7/7] ARM: mach-shmobile: kota2: add mipi display support
Message-Id: <87sjoqt9s9.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/Kconfig       |    1 +
 arch/arm/mach-shmobile/board-kota2.c |  115 ++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index c1b4534..8739930 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -73,6 +73,7 @@ config MACH_KOTA2
 	bool "KOTA2 board"
 	select ARCH_REQUIRE_GPIOLIB
 	depends on ARCH_SH73A0
+	select SH_LCD_MIPI_DSI
 
 comment "SH-Mobile System Configuration"
 
diff --git a/arch/arm/mach-shmobile/board-kota2.c b/arch/arm/mach-shmobile/board-kota2.c
index bd9a784..913176e 100644
--- a/arch/arm/mach-shmobile/board-kota2.c
+++ b/arch/arm/mach-shmobile/board-kota2.c
@@ -47,6 +47,8 @@
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/traps.h>
+#include <video/sh_mobile_lcdc.h>
+#include <video/sh_mipi_dsi.h>
 
 /* SMSC 9220 */
 static struct resource smsc9220_resources[] = {
@@ -286,6 +288,106 @@ static struct platform_device sdhi1_device = {
 	},
 };
 
+/* LCDC0 */
+static struct fb_videomode lcdc0_modes[] = {
+	{
+		.name		= "FWVGA",
+		.xres		= 480,
+		.yres		= 864,
+		.left_margin	= 16,
+		.right_margin	= 1000,
+		.hsync_len	= 16,
+		.upper_margin	= 1,
+		.lower_margin	= 4,
+		.vsync_len	= 2,
+		.sync		= FB_SYNC_VERT_HIGH_ACT | FB_SYNC_HOR_HIGH_ACT,
+	},
+};
+
+static struct sh_mobile_lcdc_info lcdc0_info = {
+	.clock_source	= LCDC_CLK_PERIPHERAL,
+	.ch[0] = {
+		.chan = LCDC_CHAN_MAINLCD,
+		.bpp = 32,
+		.lcd_cfg = lcdc0_modes,
+		.num_cfg = ARRAY_SIZE(lcdc0_modes),
+		.interface_type		= RGB24,
+		.clock_divider		= 1,
+		.flags			= LCDC_FLAGS_DWPOL,
+		.lcd_size_cfg = {
+			.width	= 44,
+			.height	= 79,
+		},
+	},
+};
+
+static struct resource lcdc0_resources[] = {
+	[0] = {
+		.name	= "LCDC",
+		.start	= 0xfe940000,
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
+	.id	= 0,
+	.dev	= {
+		.platform_data  = &lcdc0_info,
+		.coherent_dma_mask = ~0,
+	},
+};
+
+/* MIPI DSI 0 */
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
+static u32 sh_mipi_extra_dcs[] = {
+	SH_MIPI_DCS_PARAM(0x53, 0x75),	/* turn on backlight */
+	SH_MIPI_DCS_PARAM(0x51, 0xff),	/* turn on backlight */
+	SH_MIPI_DCS(0x2c),		/* memory write on */
+};
+
+static struct sh_mipi_dsi_info mipidsi0_info = {
+	.data_format	= MIPI_RGB888,
+	.lcd_chan	= &lcdc0_info.ch[0],
+	.vsynw_offset	= 20,
+	.clksrc		= 1,
+	.flags		= SH_MIPI_DSI_HSABM |
+			  SH_MIPI_DSI_HBPBM |
+			  SH_MIPI_DSI_HFPBM |
+			  SH_MIPI_DSI_BL2E,
+	.extra_array	= sh_mipi_extra_dcs,
+	.extra_array_len= ARRAY_SIZE(sh_mipi_extra_dcs),
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
 static struct platform_device *kota2_devices[] __initdata = {
 	&eth_device,
 	&keysc_device,
@@ -294,6 +396,8 @@ static struct platform_device *kota2_devices[] __initdata = {
 	&mmcif_device,
 	&sdhi0_device,
 	&sdhi1_device,
+	&lcdc0_device,
+	&mipidsi0_device,
 };
 
 static struct map_desc kota2_io_desc[] __initdata = {
@@ -329,6 +433,9 @@ void __init kota2_init_irq(void)
 	__raw_writew(2 << 10, PINTCR0A);
 }
 
+#define DSI0PCKCR	0xe6150064
+#define DSI0PHYCR	0xe615006c
+
 static void __init kota2_init(void)
 {
 	sh73a0_pinmux_init();
@@ -426,6 +533,14 @@ static void __init kota2_init(void)
 	gpio_request(GPIO_FN_SDHID1_1_PU, NULL);
 	gpio_request(GPIO_FN_SDHID1_0_PU, NULL);
 
+	/* MIPI-DSI clock setup */
+	__raw_writel(0x00000119, DSI0PCKCR);
+	__raw_writel(0x2a8b9111, DSI0PHYCR);
+
+	/* Unreset LCD Panel */
+	gpio_request(GPIO_PORT217, NULL);
+	gpio_direction_output(GPIO_PORT217, 1);
+
 #ifdef CONFIG_CACHE_L2X0
 	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
 	l2x0_init(__io(0xf0100000), 0x40460000, 0x82000fff);
-- 
1.7.4.1

