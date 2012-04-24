From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 24 Apr 2012 09:09:42 +0000
Subject: [PATCH 7/8] ARM: mach-shmobile: armadillo800eva: add MMCIF support
Message-Id: <871undfqct.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |   57 ++++++++++++++++++++++++
 1 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 5f62428..0cfaec5 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -33,6 +33,7 @@
 #include <linux/usb/renesas_usbhs.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/sh_mmcif.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
@@ -492,6 +493,44 @@ static struct platform_device sdhi1_device = {
 	.resource	= sdhi1_resources,
 };
 
+/* MMCIF */
+static struct sh_mmcif_plat_data sh_mmcif_plat = {
+	.sup_pclk	= 0,
+	.ocr		= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
+	.caps		= MMC_CAP_4_BIT_DATA |
+			  MMC_CAP_8_BIT_DATA |
+			  MMC_CAP_NONREMOVABLE,
+};
+
+static struct resource sh_mmcif_resources[] = {
+	[0] = {
+		.name	= "MMCIF",
+		.start	= 0xe6bd0000,
+		.end	= 0xe6bd0100 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		/* MMC ERR */
+		.start	= evt2irq(0x1AC0),
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		/* MMC NOR */
+		.start	= evt2irq(0x1AE0),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sh_mmcif_device = {
+	.name		= "sh_mmcif",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &sh_mmcif_plat,
+	},
+	.num_resources	= ARRAY_SIZE(sh_mmcif_resources),
+	.resource	= sh_mmcif_resources,
+};
+
 /* I2C */
 static struct i2c_board_info i2c0_devices[] = {
 	{
@@ -508,6 +547,7 @@ static struct platform_device *eva_devices[] __initdata = {
 	&gpio_keys_device,
 	&sh_eth_device,
 	&sdhi0_device,
+	&sh_mmcif_device,
 };
 
 static void __init eva_clock_init(void)
@@ -649,6 +689,23 @@ static void __init eva_init(void)
 	/* we can use GPIO_FN_IRQ31_PORT167 here for SDHI0 CD irq */
 
 	/*
+	 * MMCIF
+	 *
+	 * Here doesn't care SW1.4 status,
+	 * since CON2 is not mounted.
+	 */
+	gpio_request(GPIO_FN_MMC1_CLK_PORT103,	NULL);
+	gpio_request(GPIO_FN_MMC1_CMD_PORT104,	NULL);
+	gpio_request(GPIO_FN_MMC1_D0_PORT149,	NULL);
+	gpio_request(GPIO_FN_MMC1_D1_PORT148,	NULL);
+	gpio_request(GPIO_FN_MMC1_D2_PORT147,	NULL);
+	gpio_request(GPIO_FN_MMC1_D3_PORT146,	NULL);
+	gpio_request(GPIO_FN_MMC1_D4_PORT145,	NULL);
+	gpio_request(GPIO_FN_MMC1_D5_PORT144,	NULL);
+	gpio_request(GPIO_FN_MMC1_D6_PORT143,	NULL);
+	gpio_request(GPIO_FN_MMC1_D7_PORT142,	NULL);
+
+	/*
 	 * CAUTION
 	 *
 	 * DBGMD/LCDC0/FSIA MUX
-- 
1.7.5.4

