From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Tue, 17 Mar 2009 05:54:37 +0000
Subject: [PATCH] sh: espt-giga board support
Message-Id: <49BF3B1D.5010107@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Espt-giga is the board which used SH7763.
This supports serial, Gigabit ether, USB host and MTD.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 arch/sh/boards/Kconfig      |    7 +++
 arch/sh/boards/Makefile     |    1 +
 arch/sh/boards/board-espt.c |  105 +++++++++++++++++++++++++++++++++++++++++++
 arch/sh/tools/mach-types    |    1 +
 4 files changed, 114 insertions(+), 0 deletions(-)
 create mode 100644 arch/sh/boards/board-espt.c

diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index bd3569a..48c043b 100644
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -190,6 +190,13 @@ config SH_SH7763RDP
 	  Select SH7763RDP if configuring for a Renesas SH7763
 	  evaluation board.

+config SH_ESPT
+	bool "ESPT"
+	depends on CPU_SUBTYPE_SH7763
+	help
+	  Select ESPT if configuring for a Renesas SH7763
+	  with gigabit ether evaluation board.
+
 config SH_EDOSK7705
 	bool "EDOSK7705"
 	depends on CPU_SUBTYPE_SH7705
diff --git a/arch/sh/boards/Makefile b/arch/sh/boards/Makefile
index 6f101a8..d0daebc 100644
--- a/arch/sh/boards/Makefile
+++ b/arch/sh/boards/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_SH_SH7785LCR)	+= board-sh7785lcr.o
 obj-$(CONFIG_SH_URQUELL)	+= board-urquell.o
 obj-$(CONFIG_SH_SHMIN)		+= board-shmin.o
 obj-$(CONFIG_SH_EDOSK7760)	+= board-edosk7760.o
+obj-$(CONFIG_SH_ESPT)		+= board-espt.o
diff --git a/arch/sh/boards/board-espt.c b/arch/sh/boards/board-espt.c
new file mode 100644
index 0000000..ff7a0e1
--- /dev/null
+++ b/arch/sh/boards/board-espt.c
@@ -0,0 +1,105 @@
+/*
+ * linux/arch/sh/boards/renesas/espt/setup.c
+ *
+ * Data Technology Inc. ESPT-GIGA board suport
+ *
+ * Copyright (C) 2008, 2009 Renesas Solutions Corp.
+ * Copyright (C) 2008, 2009 Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/mtd/physmap.h>
+#include <linux/io.h>
+#include <asm/machvec.h>
+#include <asm/sizes.h>
+#include <asm/sh_eth.h>
+//#include <mach/espt.h>
+
+/* NOR Flash */
+static struct mtd_partition espt_nor_flash_partitions[] = {
+	{
+		.name = "U-Boot",
+		.offset = 0,
+		.size = (2 * SZ_128K),
+		.mask_flags = MTD_WRITEABLE,	/* Read-only */
+	}, {
+		.name = "Linux-Kernel",
+		.offset = MTDPART_OFS_APPEND,
+		.size = (20 * SZ_128K),
+	}, {
+		.name = "Root Filesystem",
+		.offset = MTDPART_OFS_APPEND,
+		.size = MTDPART_SIZ_FULL,
+	},
+};
+
+static struct physmap_flash_data espt_nor_flash_data = {
+	.width = 2,
+	.parts = espt_nor_flash_partitions,
+	.nr_parts = ARRAY_SIZE(espt_nor_flash_partitions),
+};
+
+static struct resource espt_nor_flash_resources[] = {
+	[0] = {
+		.name = "NOR Flash",
+		.start = 0,
+		.end = SZ_8M - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device espt_nor_flash_device = {
+	.name = "physmap-flash",
+	.resource = espt_nor_flash_resources,
+	.num_resources = ARRAY_SIZE(espt_nor_flash_resources),
+	.dev = {
+		.platform_data = &espt_nor_flash_data,
+	},
+};
+
+/* SH-Ether */
+static struct resource sh_eth_resources[] = {
+	{
+		.start  = 0xFEE00800,   /* use eth1 */
+		.end    = 0xFEE00F7C - 1,
+		.flags  = IORESOURCE_MEM,
+	}, {
+		.start  = 57,   /* irq number */
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct sh_eth_plat_data sh7763_eth_pdata = {
+	.phy = 0,
+	.edmac_endian = EDMAC_LITTLE_ENDIAN,
+};
+
+static struct platform_device espt_eth_device = {
+	.name       = "sh-eth",
+	.resource   = sh_eth_resources,
+	.num_resources  = ARRAY_SIZE(sh_eth_resources),
+	.dev        = {
+		.platform_data = &sh7763_eth_pdata,
+	},
+};
+
+static struct platform_device *espt_devices[] __initdata = {
+	&espt_nor_flash_device,
+	&espt_eth_device,
+};
+
+static int __init espt_devices_setup(void)
+{
+	return platform_add_devices(espt_devices,
+				    ARRAY_SIZE(espt_devices));
+}
+device_initcall(espt_devices_setup);
+
+static struct sh_machine_vector mv_espt __initmv = {
+	.mv_name = "ESPT-GIGA",
+};
diff --git a/arch/sh/tools/mach-types b/arch/sh/tools/mach-types
index 8f9e166..4932705 100644
--- a/arch/sh/tools/mach-types
+++ b/arch/sh/tools/mach-types
@@ -53,3 +53,4 @@ AP325RXA		SH_AP325RXA
 SH7763RDP		SH_SH7763RDP
 SH7785LCR		SH_SH7785LCR
 URQUELL			SH_URQUELL
+ESPT			SH_ESPT
-- 
1.6.2


