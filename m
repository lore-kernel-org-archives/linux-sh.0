From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Thu, 10 May 2012 08:26:53 +0000
Subject: [PATCH 2/3] sh: Add RSK2+SH7269 board
Message-Id: <1336638414-3251-3-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The RSK2+SH7269 board uses the SH7269 processor. It is often
referred to as just rsk7269. NOR Flash, SDRAM, serial, USB Host and
ethernet are working.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/sh/boards/Kconfig                    |    3 +-
 arch/sh/boards/mach-rsk/Kconfig           |    5 ++
 arch/sh/boards/mach-rsk/Makefile          |    1 +
 arch/sh/boards/mach-rsk/devices-rsk7269.c |   60 ++++++++++++++++++++++++++
 arch/sh/configs/rsk7269_defconfig         |   65 +++++++++++++++++++++++++++++
 arch/sh/tools/mach-types                  |    1 +
 6 files changed, 134 insertions(+), 1 deletions(-)
 create mode 100644 arch/sh/boards/mach-rsk/devices-rsk7269.c
 create mode 100644 arch/sh/configs/rsk7269_defconfig

diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index 414a797..3a74b10 100644
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -133,7 +133,8 @@ config SH_RTS7751R2D
 
 config SH_RSK
 	bool "Renesas Starter Kit"
-	depends on CPU_SUBTYPE_SH7201 || CPU_SUBTYPE_SH7203 || CPU_SUBTYPE_SH7264
+	depends on CPU_SUBTYPE_SH7201 || CPU_SUBTYPE_SH7203 || \
+	  CPU_SUBTYPE_SH7264 || CPU_SUBTYPE_SH7269
 	help
 	 Select this option if configuring for any of the RSK+ MCU
 	 evaluation platforms.
diff --git a/arch/sh/boards/mach-rsk/Kconfig b/arch/sh/boards/mach-rsk/Kconfig
index 4315af5..458a11f 100644
--- a/arch/sh/boards/mach-rsk/Kconfig
+++ b/arch/sh/boards/mach-rsk/Kconfig
@@ -18,6 +18,11 @@ config SH_RSK7264
 	select ARCH_REQUIRE_GPIOLIB
 	depends on CPU_SUBTYPE_SH7264
 
+config SH_RSK7269
+	bool "RSK2+SH7269"
+	select ARCH_REQUIRE_GPIOLIB
+	depends on CPU_SUBTYPE_SH7269
+
 endchoice
 
 endif
diff --git a/arch/sh/boards/mach-rsk/Makefile b/arch/sh/boards/mach-rsk/Makefile
index bae6ae4..6a4e1b5 100644
--- a/arch/sh/boards/mach-rsk/Makefile
+++ b/arch/sh/boards/mach-rsk/Makefile
@@ -1,3 +1,4 @@
 obj-y				:= setup.o
 obj-$(CONFIG_SH_RSK7203)	+= devices-rsk7203.o
 obj-$(CONFIG_SH_RSK7264)	+= devices-rsk7264.o
+obj-$(CONFIG_SH_RSK7269)	+= devices-rsk7269.o
diff --git a/arch/sh/boards/mach-rsk/devices-rsk7269.c b/arch/sh/boards/mach-rsk/devices-rsk7269.c
new file mode 100644
index 0000000..4a54459
--- /dev/null
+++ b/arch/sh/boards/mach-rsk/devices-rsk7269.c
@@ -0,0 +1,60 @@
+/*
+ * RSK+SH7269 Support
+ *
+ * Copyright (C) 2012  Renesas Electronics Europe Ltd
+ * Copyright (C) 2012  Phil Edworthy
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+#include <linux/smsc911x.h>
+#include <linux/gpio.h>
+#include <asm/machvec.h>
+#include <asm/io.h>
+
+static struct smsc911x_platform_config smsc911x_config = {
+	.phy_interface	= PHY_INTERFACE_MODE_MII,
+	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
+	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
+	.flags		= SMSC911X_USE_16BIT | SMSC911X_SWAP_FIFO,
+};
+
+static struct resource smsc911x_resources[] = {
+	[0] = {
+		.start		= 0x24000000,
+		.end		= 0x240000ff,
+		.flags		= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= 85,
+		.end		= 85,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device smsc911x_device = {
+	.name		= "smsc911x",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(smsc911x_resources),
+	.resource	= smsc911x_resources,
+	.dev		= {
+		.platform_data = &smsc911x_config,
+	},
+};
+
+static struct platform_device *rsk7269_devices[] __initdata = {
+	&smsc911x_device,
+};
+
+static int __init rsk7269_devices_setup(void)
+{
+	return platform_add_devices(rsk7269_devices,
+				    ARRAY_SIZE(rsk7269_devices));
+}
+device_initcall(rsk7269_devices_setup);
diff --git a/arch/sh/configs/rsk7269_defconfig b/arch/sh/configs/rsk7269_defconfig
new file mode 100644
index 0000000..9f062b5
--- /dev/null
+++ b/arch/sh/configs/rsk7269_defconfig
@@ -0,0 +1,65 @@
+CONFIG_LOG_BUF_SHIFT
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_EMBEDDED=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+CONFIG_SLAB=y
+# CONFIG_LBDAF is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+CONFIG_SWAP_IO_SPACE=y
+CONFIG_CPU_SUBTYPE_SH7269=y
+CONFIG_MEMORY_START=0x0c000000
+CONFIG_MEMORY_SIZE=0x02000000
+CONFIG_FLATMEM_MANUAL=y
+CONFIG_CPU_BIG_ENDIAN=y
+CONFIG_SH_RSK=y
+# CONFIG_SH_TIMER_MTU2 is not set
+CONFIG_SH_PCLK_FREQf700000
+CONFIG_BINFMT_FLAT=y
+CONFIG_NET=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+# CONFIG_INET_DIAG is not set
+# CONFIG_IPV6 is not set
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+# CONFIG_FW_LOADER is not set
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_NETDEVICES=y
+CONFIG_SMSC911X=y
+CONFIG_SMSC_PHY=y
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_SERIO is not set
+CONFIG_SERIAL_SH_SCI=y
+CONFIG_SERIAL_SH_SCI_NR_UARTS=8
+CONFIG_SERIAL_SH_SCI_CONSOLE=y
+# CONFIG_HWMON is not set
+CONFIG_USB=y
+CONFIG_USB_DEBUG=y
+CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
+# CONFIG_USB_DEVICE_CLASS is not set
+CONFIG_USB_R8A66597_HCD=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_STORAGE_DEBUG=y
+CONFIG_USB_LIBUSUAL=y
+CONFIG_EXT2_FS=y
+CONFIG_EXT3_FS=y
+# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_VFAT_FS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+CONFIG_ROOT_NFS=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_SYSCTL_SYSCALL_CHECK=y
+# CONFIG_FTRACE is not set
diff --git a/arch/sh/tools/mach-types b/arch/sh/tools/mach-types
index d007c81..569977e 100644
--- a/arch/sh/tools/mach-types
+++ b/arch/sh/tools/mach-types
@@ -52,6 +52,7 @@ MIGOR			SH_MIGOR
 RSK7201			SH_RSK7201
 RSK7203			SH_RSK7203
 RSK7264			SH_RSK7264
+RSK7269			SH_RSK7269
 AP325RXA		SH_AP325RXA
 SH2007			SH_SH2007
 SH7757LCR		SH_SH7757LCR
-- 
1.7.5.4

