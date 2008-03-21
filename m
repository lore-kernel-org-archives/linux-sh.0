From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 21 Mar 2008 09:43:55 +0000
Subject: [PATCH 05/06] sh: MigoR NOR flash support using physmap-flash
Message-Id: <20080321094355.10532.43880.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add NOR flash support to the MigoR board by giving board specific data
to the physmap-flash platform driver.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/renesas/migor/setup.c |   46 ++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

--- 0006/arch/sh/boards/renesas/migor/setup.c
+++ work/arch/sh/boards/renesas/migor/setup.c	2008-03-20 22:25:18.000000000 +0900
@@ -11,6 +11,7 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/input.h>
+#include <linux/mtd/physmap.h>
 #include <asm/machvec.h>
 #include <asm/io.h>
 #include <asm/sh_keysc.h>
@@ -56,8 +57,53 @@ struct sh_keysc_info sh_keysc_info = {
 	},
 };
 
+static struct mtd_partition migor_nor_flash_partitions[] +{
+	{
+		.name = "uboot",
+		.offset = 0,
+		.size = (1 * 1024 * 1024),
+		.mask_flags = MTD_WRITEABLE,	/* Read-only */
+	},
+	{
+		.name = "rootfs",
+		.offset = MTDPART_OFS_APPEND,
+		.size = (15 * 1024 * 1024),
+	},
+	{
+		.name = "other",
+		.offset = MTDPART_OFS_APPEND,
+		.size = MTDPART_SIZ_FULL,
+	},
+};
+
+static struct physmap_flash_data migor_nor_flash_data = {
+	.width		= 2,
+	.parts		= migor_nor_flash_partitions,
+	.nr_parts	= ARRAY_SIZE(migor_nor_flash_partitions),
+};
+
+static struct resource migor_nor_flash_resources[] = {
+	[0] = {
+		.name		= "NOR Flash",
+		.start		= 0x00000000,
+		.end		= 0x03ffffff,
+		.flags		= IORESOURCE_MEM,
+	}
+};
+
+static struct platform_device migor_nor_flash_device = {
+	.name		= "physmap-flash",
+	.resource	= migor_nor_flash_resources,
+	.num_resources	= ARRAY_SIZE(migor_nor_flash_resources),
+	.dev		= {
+		.platform_data = &migor_nor_flash_data,
+	},
+};
+
 static struct platform_device *migor_devices[] __initdata = {
 	&smc91x_eth_device,
+	&migor_nor_flash_device,
 };
 
 static int __init migor_devices_setup(void)
