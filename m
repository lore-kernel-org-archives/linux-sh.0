From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 22 Jul 2009 16:22:28 +0000
Subject: [PATCH] sh: kfr2r09 board support - NOR flash
Message-Id: <20090722162228.18182.95719.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds NOR flash support to the kfr2r09 board.

NOR flash support is added by describing the NOR flash
chip hooked up to CS0 as platform device data for the
physmap-flash MTD driver.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Applies on top of the SCIF patch.

 arch/sh/boards/mach-kfr2r09/setup.c |   54 ++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

--- 0009/arch/sh/boards/mach-kfr2r09/setup.c
+++ work/arch/sh/boards/mach-kfr2r09/setup.c	2009-07-23 00:36:29.000000000 +0900
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
+#include <linux/mtd/physmap.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/gpio.h>
@@ -18,13 +19,64 @@
 #include <asm/io.h>
 #include <cpu/sh7724.h>
 
+static struct mtd_partition kfr2r09_nor_flash_partitions[] +{
+	{
+		.name = "boot",
+		.offset = 0,
+		.size = (4 * 1024 * 1024),
+		.mask_flags = MTD_WRITEABLE,	/* Read-only */
+	},
+	{
+		.name = "other",
+		.offset = MTDPART_OFS_APPEND,
+		.size = MTDPART_SIZ_FULL,
+	},
+};
+
+static struct physmap_flash_data kfr2r09_nor_flash_data = {
+	.width		= 2,
+	.parts		= kfr2r09_nor_flash_partitions,
+	.nr_parts	= ARRAY_SIZE(kfr2r09_nor_flash_partitions),
+};
+
+static struct resource kfr2r09_nor_flash_resources[] = {
+	[0] = {
+		.name		= "NOR Flash",
+		.start		= 0x00000000,
+		.end		= 0x03ffffff,
+		.flags		= IORESOURCE_MEM,
+	}
+};
+
+static struct platform_device kfr2r09_nor_flash_device = {
+	.name		= "physmap-flash",
+	.resource	= kfr2r09_nor_flash_resources,
+	.num_resources	= ARRAY_SIZE(kfr2r09_nor_flash_resources),
+	.dev		= {
+		.platform_data = &kfr2r09_nor_flash_data,
+	},
+};
+
+static struct platform_device *kfr2r09_devices[] __initdata = {
+	&kfr2r09_nor_flash_device,
+};
+
+#define BSC_CS0BCR 0xfec10004
+#define BSC_CS0WCR 0xfec10024
+
 static int __init kfr2r09_devices_setup(void)
 {
 	/* enable SCIF1 serial port for YC401 console support */
 	gpio_request(GPIO_FN_SCIF1_RXD, NULL);
 	gpio_request(GPIO_FN_SCIF1_TXD, NULL);
 
-	return 0;
+	/* setup NOR flash at CS0 */
+	ctrl_outl(0x36db0400, BSC_CS0BCR);
+	ctrl_outl(0x00000500, BSC_CS0WCR);
+
+	return platform_add_devices(kfr2r09_devices,
+				    ARRAY_SIZE(kfr2r09_devices));
 }
 device_initcall(kfr2r09_devices_setup);
 
