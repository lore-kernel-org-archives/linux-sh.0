From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 26 Aug 2009 11:04:22 +0000
Subject: [PATCH 1/6] sh: modify to enable boot for EcoVec24
Message-Id: <ud46ihm4p.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |   33 ++++++++++++++-------------------
 arch/sh/configs/ecovec24_defconfig   |   20 ++++++++++++++------
 2 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index b634a72..e555b92 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -19,14 +19,14 @@
 #include <cpu/sh7724.h>
 
 /*
- * Area   Address                    Interface     size  BusWidth
- * 0      0x0000_0000 ~ 0x03FF_FFFF  FROM          64MB  16bit
- * 1      0x0400_0000 ~ 0x07FF_FFFF  Internal I/O  64MB  16/32bit
- * 2      0x0800_0000 ~ 0x0BFF_FFFF  DRAM 2        64MB  32bit
- * 3      0x0C00_0000 ~ 0x0FFF_FFFF  DRAM 3        64MB  32bit
- * 4      0x1000_0000 ~ 0x13FF_FFFF  DRAM 4        64MB  32bit
- * 5      0x1400_0000 ~ 0x17FF_FFFF  DRAM 5        64MB  32bit
- * 6      0x1800_0000 ~ 0x1BFF_FFFF  MFI           64MB  16bit
+ *  Address      Interface        BusWidth
+ *-----------------------------------------
+ *  0x0000_0000  uboot            16bit
+ *  0x0004_0000  Linux romImage   16bit
+ *  0x0014_0000  MTD for Linux    16bit
+ *  0x0400_0000  Internal I/O     16/32bit
+ *  0x0800_0000  DRAM             32bit
+ *  0x1800_0000  MFI              16bit
  */
 
 /* Heartbeat */
@@ -58,15 +58,11 @@ static struct platform_device heartbeat_device = {
 /* MTD */
 static struct mtd_partition nor_flash_partitions[] = {
 	{
-		.name = "uboot",
+		.name = "boot loader",
 		.offset = 0,
-		.size = (256 * 1024),
+		.size = (5 * 1024 * 1024),
 		.mask_flags = MTD_CAP_ROM,
 	}, {
-		.name = "kernel",
-		.offset = MTDPART_OFS_APPEND,
-		.size = (2 * 1024 * 1024),
-	}, {
 		.name = "free-area",
 		.offset = MTDPART_OFS_APPEND,
 		.size = MTDPART_SIZ_FULL,
@@ -107,17 +103,16 @@ static int __init devices_setup(void)
 	/* enable SCIFA0 */
 	gpio_request(GPIO_FN_SCIF0_TXD, NULL);
 	gpio_request(GPIO_FN_SCIF0_RXD, NULL);
-	gpio_request(GPIO_FN_SCIF0_SCK, NULL);
 
 	/* enable debug LED */
 	gpio_request(GPIO_PTG0, NULL);
 	gpio_request(GPIO_PTG1, NULL);
 	gpio_request(GPIO_PTG2, NULL);
 	gpio_request(GPIO_PTG3, NULL);
-	gpio_direction_output(GPIO_PTT0, 0);
-	gpio_direction_output(GPIO_PTT1, 0);
-	gpio_direction_output(GPIO_PTT2, 0);
-	gpio_direction_output(GPIO_PTT3, 0);
+	gpio_direction_output(GPIO_PTG0, 0);
+	gpio_direction_output(GPIO_PTG1, 0);
+	gpio_direction_output(GPIO_PTG2, 0);
+	gpio_direction_output(GPIO_PTG3, 0);
 
 	return platform_add_devices(ecovec_devices,
 				    ARRAY_SIZE(ecovec_devices));
diff --git a/arch/sh/configs/ecovec24_defconfig b/arch/sh/configs/ecovec24_defconfig
index 6d983f6..2050a76 100644
--- a/arch/sh/configs/ecovec24_defconfig
+++ b/arch/sh/configs/ecovec24_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.31-rc6
-# Tue Aug 18 11:32:44 2009
+# Linux kernel version: 2.6.31-rc7
+# Wed Aug 26 09:09:07 2009
 #
 CONFIG_SUPERH=y
 CONFIG_SUPERH32=y
@@ -151,7 +151,7 @@ CONFIG_IOSCHED_CFQ=y
 CONFIG_DEFAULT_CFQ=y
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="cfq"
-# CONFIG_FREEZER is not set
+CONFIG_FREEZER=y
 
 #
 # System type
@@ -185,6 +185,7 @@ CONFIG_ARCH_SHMOBILE=y
 # CONFIG_CPU_SUBTYPE_SH4_202 is not set
 # CONFIG_CPU_SUBTYPE_SH7723 is not set
 CONFIG_CPU_SUBTYPE_SH7724=y
+# CONFIG_CPU_SUBTYPE_SH7757 is not set
 # CONFIG_CPU_SUBTYPE_SH7763 is not set
 # CONFIG_CPU_SUBTYPE_SH7770 is not set
 # CONFIG_CPU_SUBTYPE_SH7780 is not set
@@ -314,7 +315,7 @@ CONFIG_ZERO_PAGE_OFFSET=0x00001000
 CONFIG_BOOT_LINK_OFFSET=0x00800000
 CONFIG_ENTRY_OFFSET=0x00001000
 CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="console=tty0, console=ttySC3,115200 root=/dev/nfs ip=dhcp mem0M memchunk.vpu=4m"
+CONFIG_CMDLINE="console=tty0, console=ttySC0,115200 root=/dev/nfs ip=dhcp mem0M memchunk.vpu=4m"
 
 #
 # Bus options
@@ -333,7 +334,13 @@ CONFIG_BINFMT_ELF=y
 #
 # Power management options (EXPERIMENTAL)
 #
-# CONFIG_PM is not set
+CONFIG_PM=y
+# CONFIG_PM_DEBUG is not set
+CONFIG_PM_SLEEP=y
+CONFIG_SUSPEND=y
+CONFIG_SUSPEND_FREEZER=y
+# CONFIG_HIBERNATION is not set
+CONFIG_PM_RUNTIME=y
 # CONFIG_CPU_IDLE is not set
 CONFIG_NET=y
 
@@ -641,7 +648,7 @@ CONFIG_MII=y
 # CONFIG_AX88796 is not set
 # CONFIG_STNIC is not set
 CONFIG_SH_ETH=y
-CONFIG_SMC91X=y
+# CONFIG_SMC91X is not set
 # CONFIG_ENC28J60 is not set
 # CONFIG_ETHOC is not set
 # CONFIG_SMC911X is not set
@@ -1048,6 +1055,7 @@ CONFIG_USB=y
 CONFIG_USB_DEVICEFS=y
 CONFIG_USB_DEVICE_CLASS=y
 # CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_SUSPEND is not set
 # CONFIG_USB_OTG is not set
 # CONFIG_USB_OTG_WHITELIST is not set
 # CONFIG_USB_OTG_BLACKLIST_HUB is not set
-- 
1.6.0.4

