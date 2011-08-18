From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 18 Aug 2011 05:45:00 +0000
Subject: [PATCH 07/07] ARM: mach-shmobile: Kota2 SDHI0 and SDHI1 support
Message-Id: <20110818054500.23410.44730.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add SDHI0 and SDHI1 support to the Kota2 board.

SDHI0 is hooked up to a microSD card slot and SDHI1
to a wireless module that also connects to SCIFB.

This depends on the recently merged code for
TMIO_MMC_HAS_IDLE_WAIT together with PFC support
for pull-ups on SDHI0 and SDHI1.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-kota2.c |   93 ++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

--- 0010/arch/arm/mach-shmobile/board-kota2.c
+++ work/arch/arm/mach-shmobile/board-kota2.c	2011-08-18 13:26:52.000000000 +0900
@@ -35,6 +35,8 @@
 #include <linux/leds.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mmcif.h>
+#include <linux/mfd/tmio.h>
+#include <linux/mmc/sh_mobile_sdhi.h>
 #include <mach/hardware.h>
 #include <mach/sh73a0.h>
 #include <mach/common.h>
@@ -205,12 +207,86 @@ static struct platform_device mmcif_devi
 	.resource       = mmcif_resources,
 };
 
+static struct sh_mobile_sdhi_info sdhi0_info = {
+	.tmio_caps      = MMC_CAP_SD_HIGHSPEED,
+	.tmio_flags     = TMIO_MMC_WRPROTECT_DISABLE | TMIO_MMC_HAS_IDLE_WAIT,
+};
+
+static struct resource sdhi0_resources[] = {
+	[0] = {
+		.name   = "SDHI0",
+		.start  = 0xee100000,
+		.end    = 0xee1000ff,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = gic_spi(83),
+		.flags  = IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start  = gic_spi(84),
+		.flags  = IORESOURCE_IRQ,
+	},
+	[3] = {
+		.start	= gic_spi(85),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sdhi0_device = {
+	.name           = "sh_mobile_sdhi",
+	.id             = 0,
+	.num_resources  = ARRAY_SIZE(sdhi0_resources),
+	.resource       = sdhi0_resources,
+	.dev    = {
+		.platform_data  = &sdhi0_info,
+	},
+};
+
+static struct sh_mobile_sdhi_info sdhi1_info = {
+	.tmio_caps      = MMC_CAP_NONREMOVABLE | MMC_CAP_SDIO_IRQ,
+	.tmio_flags     = TMIO_MMC_WRPROTECT_DISABLE | TMIO_MMC_HAS_IDLE_WAIT,
+};
+
+static struct resource sdhi1_resources[] = {
+	[0] = {
+		.name   = "SDHI1",
+		.start  = 0xee120000,
+		.end    = 0xee1200ff,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = gic_spi(87),
+		.flags  = IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start  = gic_spi(88),
+		.flags  = IORESOURCE_IRQ,
+	},
+	[3] = {
+		.start	= gic_spi(89),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sdhi1_device = {
+	.name           = "sh_mobile_sdhi",
+	.id             = 1,
+	.num_resources  = ARRAY_SIZE(sdhi1_resources),
+	.resource       = sdhi1_resources,
+	.dev    = {
+		.platform_data  = &sdhi1_info,
+	},
+};
+
 static struct platform_device *kota2_devices[] __initdata = {
 	&eth_device,
 	&keysc_device,
 	&gpio_keys_device,
 	&gpio_leds_device,
 	&mmcif_device,
+	&sdhi0_device,
+	&sdhi1_device,
 };
 
 static struct map_desc kota2_io_desc[] __initdata = {
@@ -319,6 +395,15 @@ static void __init kota2_init(void)
 	gpio_request(GPIO_PORT208, NULL); /* Reset */
 	gpio_direction_output(GPIO_PORT208, 1);
 
+	/* SDHI0 (microSD) */
+	gpio_request(GPIO_FN_SDHICD0_PU, NULL);
+	gpio_request(GPIO_FN_SDHICMD0_PU, NULL);
+	gpio_request(GPIO_FN_SDHICLK0, NULL);
+	gpio_request(GPIO_FN_SDHID0_3_PU, NULL);
+	gpio_request(GPIO_FN_SDHID0_2_PU, NULL);
+	gpio_request(GPIO_FN_SDHID0_1_PU, NULL);
+	gpio_request(GPIO_FN_SDHID0_0_PU, NULL);
+
 	/* SCIFB (BT) */
 	gpio_request(GPIO_FN_PORT159_SCIFB_SCK, NULL);
 	gpio_request(GPIO_FN_PORT160_SCIFB_TXD, NULL);
@@ -326,6 +411,14 @@ static void __init kota2_init(void)
 	gpio_request(GPIO_FN_PORT162_SCIFB_RXD, NULL);
 	gpio_request(GPIO_FN_PORT163_SCIFB_RTS_, NULL);
 
+	/* SDHI1 (BCM4330) */
+	gpio_request(GPIO_FN_SDHICLK1, NULL);
+	gpio_request(GPIO_FN_SDHICMD1_PU, NULL);
+	gpio_request(GPIO_FN_SDHID1_3_PU, NULL);
+	gpio_request(GPIO_FN_SDHID1_2_PU, NULL);
+	gpio_request(GPIO_FN_SDHID1_1_PU, NULL);
+	gpio_request(GPIO_FN_SDHID1_0_PU, NULL);
+
 #ifdef CONFIG_CACHE_L2X0
 	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
 	l2x0_init(__io(0xf0100000), 0x40460000, 0x82000fff);
