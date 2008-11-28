From: Peter Griffin <pgriffin@mpc-data.co.uk>
Date: Fri, 28 Nov 2008 12:31:16 +0000
Subject: [PATCH 2 / 3] sh: SH7201, board support
Message-Id: <492FE494.50100@mpc-data.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Peter Griffin <pgriffin@mpc-data.co.uk>

sh: SH7201, board support

This patch adds RSK+ 7201 board support.

Signed-off-by: Peter Griffin <pgriffin@mpc-data.co.uk>
---
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -126,6 +126,10 @@ config SH_RTS7751R2D
  	  Select RTS7751R2D if configuring for a Renesas Technology
  	  Sales SH-Graphics board.

+config SH_RSK7201
+	bool "RSK7201"
+	depends on CPU_SUBTYPE_SH7201
+
  config SH_RSK7203
  	bool "RSK7203"
  	select GENERIC_GPIO
diff --git a/arch/sh/boards/Makefile b/arch/sh/boards/Makefile
index d9efa39..ce4d4d4 100644
--- a/arch/sh/boards/Makefile
+++ b/arch/sh/boards/Makefile
@@ -3,6 +3,7 @@
  #
  obj-$(CONFIG_SH_AP325RXA)	+= board-ap325rxa.o
  obj-$(CONFIG_SH_MAGIC_PANEL_R2)	+= board-magicpanelr2.o
+obj-$(CONFIG_SH_RSK7201)	+= board-rsk7201.o
  obj-$(CONFIG_SH_RSK7203)	+= board-rsk7203.o
  obj-$(CONFIG_SH_SH7785LCR)	+= board-sh7785lcr.o
  obj-$(CONFIG_SH_SHMIN)		+= board-shmin.o
diff --git a/arch/sh/boards/board-rsk7201.c b/arch/sh/boards/board-rsk7201.c
new file mode 100644
index 0000000..47a843d
--- /dev/null
+++ b/arch/sh/boards/board-rsk7201.c
@@ -0,0 +1,106 @@
+/*
+ * Renesas Technology Europe RSK+ 7201 Support.
+ *
+ * Copyright (C) 2008 Peter Griffin <pgriffin@mpc-data.co.uk>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
+#include <linux/mtd/map.h>
+#include <asm/machvec.h>
+#include <asm/io.h>
+
+static const char *probes[] = { "cmdlinepart", NULL };
+
+static struct mtd_partition *parsed_partitions;
+
+static struct mtd_partition rsk7201_partitions[] = {
+	{
+		.name		= "Bootloader",
+		.offset		= 0x00000000,
+		.size		= 0x00040000,
+		.mask_flags	= MTD_WRITEABLE,
+	}, {
+		.name		= "Kernel",
+		.offset		= MTDPART_OFS_NXTBLK,
+		.size		= 0x001c0000,
+	}, {
+		.name		= "Flash_FS",
+		.offset		= MTDPART_OFS_NXTBLK,
+		.size		= MTDPART_SIZ_FULL,
+	}
+};
+
+static struct physmap_flash_data flash_data = {
+	.width		= 2,
+};
+
+static struct resource flash_resource = {
+	.start		= 0x20000000,
+	.end		= 0x20400000,
+	.flags		= IORESOURCE_MEM,
+};
+
+static struct platform_device flash_device = {
+	.name		= "physmap-flash",
+	.id		= -1,
+	.resource	= &flash_resource,
+	.num_resources	= 1,
+	.dev		= {
+		.platform_data = &flash_data,
+	},
+};
+
+static struct mtd_info *flash_mtd;
+
+static struct map_info rsk7201_flash_map = {
+	.name		= "RSK+ Flash",
+	.size		= 0x400000,
+	.bankwidth	= 2,
+};
+
+static void __init set_mtd_partitions(void)
+{
+	int nr_parts = 0;
+
+	simple_map_init(&rsk7201_flash_map);
+	flash_mtd = do_map_probe("cfi_probe", &rsk7201_flash_map);
+	nr_parts = parse_mtd_partitions(flash_mtd, probes,
+					&parsed_partitions, 0);
+	/* If there is no partition table, used the hard coded table */
+	if (nr_parts <= 0) {
+		flash_data.parts = rsk7201_partitions;
+		flash_data.nr_parts = ARRAY_SIZE(rsk7201_partitions);
+	} else {
+		flash_data.nr_parts = nr_parts;
+		flash_data.parts = parsed_partitions;
+	}
+}
+
+
+static struct platform_device *rsk7201_devices[] __initdata = {
+	&flash_device,
+};
+
+static int __init rsk7201_devices_setup(void)
+{
+	set_mtd_partitions();
+	return platform_add_devices(rsk7201_devices,
+				    ARRAY_SIZE(rsk7201_devices));
+}
+device_initcall(rsk7201_devices_setup);
+
+/*
+ * The Machine Vector
+ */
+static struct sh_machine_vector mv_rsk7201 __initmv = {
+	.mv_name        = "RSK+7201",
+};
