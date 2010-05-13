From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 13 May 2010 01:08:21 +0000
Subject: [PATCH] ARM: mach-shmobile: ap4evb: Add MMC support
Message-Id: <ubpcklibe.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uhbpex68f.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uhbpex68f.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
This patch is depend on Goda-san's
"Add support MMCIF for SuperH" patch

 arch/arm/mach-shmobile/board-ap4evb.c |   67 +++++++++++++++++++++++++++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index a553c16..0e74161 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -26,6 +26,8 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/sh_mmcif.h>
 #include <linux/i2c.h>
 #include <linux/i2c/tsc2007.h>
 #include <linux/io.h>
@@ -107,6 +109,18 @@
  * S39: bit2: off
  */
 
+/*
+ * MMC (CN7)
+ *
+ * J22 : 1-2: 1.8v for MMC
+ *       2-3: 3.3v for MMC
+ * SW1 : OFF
+ * SW33: bit1: OFF
+ *       bit2: ON
+ *       bit3: ON
+ *       bit4: X
+ */
+
 /* MTD */
 static struct mtd_partition nor_flash_partitions[] = {
 	{
@@ -225,6 +239,46 @@ static struct platform_device keysc_device = {
 	},
 };
 
+/* SH_MMCIF */
+static struct resource sh_mmcif_resources[] = {
+	[0] = {
+		.name	= "SH_MMCIF",
+		.start	= 0xE6BD0000,
+		.end	= 0xE6BD00FF,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		/* MMC ERR */
+		.start	= 198,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		/* MMC NOR */
+		.start	= 199,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct sh_mmcif_plat_data sh_mmcif_plat = {
+	.sup_pclk	= 0,
+	.ocr		= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
+	.caps		= MMC_CAP_4_BIT_DATA |
+			  MMC_CAP_8_BIT_DATA |
+			  MMC_CAP_NEEDS_POLL,
+};
+
+static struct platform_device sh_mmcif_device = {
+	.name		= "sh_mmcif",
+	.id		= 0,
+	.dev		= {
+		.dma_mask		= NULL,
+		.coherent_dma_mask	= 0xffffffff,
+		.platform_data		= &sh_mmcif_plat,
+	},
+	.num_resources	= ARRAY_SIZE(sh_mmcif_resources),
+	.resource	= sh_mmcif_resources,
+};
+
 /* SDHI0 */
 static struct resource sdhi0_resources[] = {
 	[0] = {
@@ -350,6 +404,7 @@ static struct platform_device *ap4evb_devices[] __initdata = {
 	&sdhi0_device,
 	&usb1_host_device,
 	&fsi_device,
+	&sh_mmcif_device
 };
 
 /* TouchScreen (Needs SW3 set to OFF) */
@@ -485,6 +540,18 @@ static void __init ap4evb_init(void)
 	gpio_request(GPIO_FN_IRQ28_123, NULL);
 	set_irq_type(IRQ28, IRQ_TYPE_LEVEL_LOW);
 
+	/* MMCIF */
+	gpio_request(GPIO_FN_MMCD0_0, NULL);
+	gpio_request(GPIO_FN_MMCD0_1, NULL);
+	gpio_request(GPIO_FN_MMCD0_2, NULL);
+	gpio_request(GPIO_FN_MMCD0_3, NULL);
+	gpio_request(GPIO_FN_MMCD0_4, NULL);
+	gpio_request(GPIO_FN_MMCD0_5, NULL);
+	gpio_request(GPIO_FN_MMCD0_6, NULL);
+	gpio_request(GPIO_FN_MMCD0_7, NULL);
+	gpio_request(GPIO_FN_MMCCMD0, NULL);
+	gpio_request(GPIO_FN_MMCCLK0, NULL);
+
 	/* USB enable */
 	gpio_request(GPIO_FN_VBUS0_1,    NULL);
 	gpio_request(GPIO_FN_IDIN_1_18,  NULL);
-- 
1.7.0.4

