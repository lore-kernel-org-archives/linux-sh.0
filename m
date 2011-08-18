From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 18 Aug 2011 05:44:42 +0000
Subject: [PATCH 05/07] ARM: mach-shmobile: Kota2 MMCIF support
Message-Id: <20110818054442.23410.20182.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add support for sh73a0 MMCIF hardware block on the
Kota2 board. A non-removable eMMC chip is used with
8 data bits on the MMC bus.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-kota2.c |   49 ++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

--- 0008/arch/arm/mach-shmobile/board-kota2.c
+++ work/arch/arm/mach-shmobile/board-kota2.c	2011-08-18 13:34:11.000000000 +0900
@@ -33,6 +33,8 @@
 #include <linux/input/sh_keysc.h>
 #include <linux/gpio_keys.h>
 #include <linux/leds.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/sh_mmcif.h>
 #include <mach/hardware.h>
 #include <mach/sh73a0.h>
 #include <mach/common.h>
@@ -171,11 +173,44 @@ static struct platform_device gpio_leds_
 	},
 };
 
+static struct resource mmcif_resources[] = {
+	[0] = {
+		.name   = "MMCIF",
+		.start  = 0xe6bd0000,
+		.end    = 0xe6bd00ff,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = gic_spi(140),
+		.flags  = IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start  = gic_spi(141),
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct sh_mmcif_plat_data mmcif_info = {
+	.ocr            = MMC_VDD_165_195,
+	.caps           = MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
+};
+
+static struct platform_device mmcif_device = {
+	.name           = "sh_mmcif",
+	.id             = 0,
+	.dev            = {
+		.platform_data          = &mmcif_info,
+	},
+	.num_resources  = ARRAY_SIZE(mmcif_resources),
+	.resource       = mmcif_resources,
+};
+
 static struct platform_device *kota2_devices[] __initdata = {
 	&eth_device,
 	&keysc_device,
 	&gpio_keys_device,
 	&gpio_leds_device,
+	&mmcif_device,
 };
 
 static struct map_desc kota2_io_desc[] __initdata = {
@@ -264,6 +299,20 @@ static void __init kota2_init(void)
 	gpio_request(GPIO_FN_PORT58_KEYOUT7, NULL);
 	gpio_request(GPIO_FN_KEYOUT8, NULL);
 
+	/* MMCIF */
+	gpio_request(GPIO_FN_MMCCLK0, NULL);
+	gpio_request(GPIO_FN_MMCD0_0, NULL);
+	gpio_request(GPIO_FN_MMCD0_1, NULL);
+	gpio_request(GPIO_FN_MMCD0_2, NULL);
+	gpio_request(GPIO_FN_MMCD0_3, NULL);
+	gpio_request(GPIO_FN_MMCD0_4, NULL);
+	gpio_request(GPIO_FN_MMCD0_5, NULL);
+	gpio_request(GPIO_FN_MMCD0_6, NULL);
+	gpio_request(GPIO_FN_MMCD0_7, NULL);
+	gpio_request(GPIO_FN_MMCCMD0, NULL);
+	gpio_request(GPIO_PORT208, NULL); /* Reset */
+	gpio_direction_output(GPIO_PORT208, 1);
+
 #ifdef CONFIG_CACHE_L2X0
 	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
 	l2x0_init(__io(0xf0100000), 0x40460000, 0x82000fff);
