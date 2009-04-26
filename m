From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Sun, 26 Apr 2009 16:42:42 +0000
Subject: [PATCH 1/1] r2dplus: add cfi flash support and enable it
Message-Id: <1240764162-24117-1-git-send-email-plagnioj@jcrosoft.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/sh/boards/mach-r2d/setup.c          |   49 ++++++++++++++++
 arch/sh/configs/rts7751r2dplus_defconfig |   91 +++++++++++++++++++++++++++++-
 2 files changed, 137 insertions(+), 3 deletions(-)

diff --git a/arch/sh/boards/mach-r2d/setup.c b/arch/sh/boards/mach-r2d/setup.c
index c585be0..1582d4e 100644
--- a/arch/sh/boards/mach-r2d/setup.c
+++ b/arch/sh/boards/mach-r2d/setup.c
@@ -10,6 +10,10 @@
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
+#include <linux/mtd/map.h>
 #include <linux/ata_platform.h>
 #include <linux/sm501.h>
 #include <linux/sm501-regs.h>
@@ -181,10 +185,55 @@ static struct platform_device sm501_device = {
 	.resource	= sm501_resources,
 };
 
+static struct mtd_partition r2d_partitions[] = {
+	{
+		.name		= "U-Boot",
+		.offset		= 0x00000000,
+		.size		= 0x00040000,
+		.mask_flags	= MTD_WRITEABLE,
+	}, {
+		.name		= "Environment",
+		.offset		= MTDPART_OFS_NXTBLK,
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
+	.nr_parts	= ARRAY_SIZE(r2d_partitions),
+	.parts		= r2d_partitions,
+};
+
+static struct resource flash_resource = {
+	.start		= 0x00000000,
+	.end		= 0x02000000,
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
 static struct platform_device *rts7751r2d_devices[] __initdata = {
 	&sm501_device,
 	&heartbeat_device,
 	&spi_sh_sci_device,
+	&flash_device,
 };
 
 /*
diff --git a/arch/sh/configs/rts7751r2dplus_defconfig b/arch/sh/configs/rts7751r2dplus_defconfig
index 8feef62..4f7fa32 100644
--- a/arch/sh/configs/rts7751r2dplus_defconfig
+++ b/arch/sh/configs/rts7751r2dplus_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.29
-# Thu Apr  2 18:34:12 2009
+# Linux kernel version: 2.6.30-rc3
+# Sun Apr 26 17:56:14 2009
 #
 CONFIG_SUPERH=y
 CONFIG_SUPERH32=y
@@ -424,7 +424,92 @@ CONFIG_FIRMWARE_IN_KERNEL=y
 CONFIG_EXTRA_FIRMWARE=""
 # CONFIG_SYS_HYPERVISOR is not set
 # CONFIG_CONNECTOR is not set
-# CONFIG_MTD is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+CONFIG_MTD_CONCAT=y
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_TESTS is not set
+# CONFIG_MTD_REDBOOT_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=y
+# CONFIG_MTD_AR7_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+# CONFIG_MTD_BLKDEVS is not set
+# CONFIG_MTD_BLOCK is not set
+# CONFIG_MTD_BLOCK_RO is not set
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_CFI_INTELEXT is not set
+CONFIG_MTD_CFI_AMDSTD=y
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+CONFIG_MTD_PHYSMAP=y
+# CONFIG_MTD_PHYSMAP_COMPAT is not set
+# CONFIG_MTD_INTEL_VR_NOR is not set
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_DATAFLASH is not set
+# CONFIG_MTD_M25P80 is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+# CONFIG_MTD_NAND is not set
+# CONFIG_MTD_ONENAND is not set
+
+#
+# LPDDR flash memory drivers
+#
+# CONFIG_MTD_LPDDR is not set
+
+#
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
 # CONFIG_BLK_CPQ_CISS_DA is not set
-- 
1.6.1.3

