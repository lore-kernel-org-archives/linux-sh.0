From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 23 Apr 2012 06:53:40 +0000
Subject: [PATCH 4/6] ARM: mach-shmobile: kzm9g: add MMCIF support
Message-Id: <8762cr9bwv.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878vi23ooh.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878vi23ooh.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-kzm9g.c |   49 ++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 545d633..57c391a 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -22,6 +22,8 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/i2c.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/sh_mmcif.h>
 #include <linux/platform_device.h>
 #include <linux/smsc911x.h>
 #include <linux/usb/r8a66597.h>
@@ -147,6 +149,40 @@ static struct platform_device lcdc_device = {
 	},
 };
 
+/* MMCIF */
+static struct resource sh_mmcif_resources[] = {
+	[0] = {
+		.name	= "MMCIF",
+		.start	= 0xe6bd0000,
+		.end	= 0xe6bd00ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= gic_spi(141),
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= gic_spi(140),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct sh_mmcif_plat_data sh_mmcif_platdata = {
+	.ocr		= MMC_VDD_165_195,
+	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
+};
+
+static struct platform_device mmc_device = {
+	.name		= "sh_mmcif",
+	.dev		= {
+		.dma_mask		= NULL,
+		.coherent_dma_mask	= 0xffffffff,
+		.platform_data		= &sh_mmcif_platdata,
+	},
+	.num_resources	= ARRAY_SIZE(sh_mmcif_resources),
+	.resource	= sh_mmcif_resources,
+};
+
 static struct i2c_board_info i2c1_devices[] = {
 	{
 		I2C_BOARD_INFO("st1232-ts", 0x55),
@@ -158,6 +194,7 @@ static struct platform_device *kzm_devices[] __initdata = {
 	&smsc_device,
 	&usb_host_device,
 	&lcdc_device,
+	&mmc_device,
 };
 
 /*
@@ -267,6 +304,18 @@ static void __init kzm_init(void)
 	gpio_request(GPIO_PORT223, NULL); /* IRQ8 */
 	gpio_direction_input(GPIO_PORT223);
 
+	/* enable MMCIF */
+	gpio_request(GPIO_FN_MMCCLK0,		NULL);
+	gpio_request(GPIO_FN_MMCCMD0_PU,	NULL);
+	gpio_request(GPIO_FN_MMCD0_0_PU,	NULL);
+	gpio_request(GPIO_FN_MMCD0_1_PU,	NULL);
+	gpio_request(GPIO_FN_MMCD0_2_PU,	NULL);
+	gpio_request(GPIO_FN_MMCD0_3_PU,	NULL);
+	gpio_request(GPIO_FN_MMCD0_4_PU,	NULL);
+	gpio_request(GPIO_FN_MMCD0_5_PU,	NULL);
+	gpio_request(GPIO_FN_MMCD0_6_PU,	NULL);
+	gpio_request(GPIO_FN_MMCD0_7_PU,	NULL);
+
 #ifdef CONFIG_CACHE_L2X0
 	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
 	l2x0_init(IOMEM(0xf0100000), 0x40460000, 0x82000fff);
-- 
1.7.5.4

