From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 04 Mar 2013 07:19:15 +0000
Subject: [PATCH 5/5] ARM: shmobile: add R-Car M1A Bock-W platform support
Message-Id: <87r4jvpr80.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/configs/bockw_defconfig     |   95 +++++++++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig       |    6 ++
 arch/arm/mach-shmobile/Makefile      |    1 +
 arch/arm/mach-shmobile/board-bockw.c |  126 ++++++++++++++++++++++++++++++++++
 4 files changed, 228 insertions(+)
 create mode 100644 arch/arm/configs/bockw_defconfig
 create mode 100644 arch/arm/mach-shmobile/board-bockw.c

diff --git a/arch/arm/configs/bockw_defconfig b/arch/arm/configs/bockw_defconfig
new file mode 100644
index 0000000..d92384c
--- /dev/null
+++ b/arch/arm/configs/bockw_defconfig
@@ -0,0 +1,95 @@
+# CONFIG_ARM_PATCH_PHYS_VIRT is not set
+CONFIG_EXPERIMENTAL=y
+CONFIG_KERNEL_LZMA=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_EMBEDDED=y
+CONFIG_SLAB=y
+# CONFIG_IOSCHED_CFQ is not set
+CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_R8A7778=y
+CONFIG_MACH_BOCKW=y
+CONFIG_MEMORY_START=0x60000000
+CONFIG_MEMORY_SIZE=0x10000000
+CONFIG_SHMOBILE_TIMER_HZ24
+# CONFIG_SH_TIMER_CMT is not set
+# CONFIG_EM_TIMER_STI is not set
+CONFIG_ARM_ERRATA_430973=y
+CONFIG_ARM_ERRATA_458693=y
+CONFIG_ARM_ERRATA_460075=y
+CONFIG_ARM_ERRATA_743622=y
+CONFIG_ARM_ERRATA_754322=y
+CONFIG_NO_HZ=y
+CONFIG_AEABI=y
+# CONFIG_OABI_COMPAT is not set
+CONFIG_HIGHMEM=y
+CONFIG_ZBOOT_ROM_TEXT=0x0
+CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_CMDLINE="console=ttySC0,115200 earlyprintk=sh-sci.0,115200 ignore_loglevel root=/dev/nfs ip=dhcp"
+CONFIG_CMDLINE_FORCE=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_SUSPEND is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+# CONFIG_INET_DIAG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_WIRELESS is not set
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_STANDALONE is not set
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+# CONFIG_FW_LOADER is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_CHELSIO is not set
+# CONFIG_NET_VENDOR_CIRRUS is not set
+# CONFIG_NET_VENDOR_FARADAY is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+CONFIG_SMSC911X=y
+# CONFIG_NET_VENDOR_STMICRO is not set
+# CONFIG_WLAN is not set
+# CONFIG_INPUT is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_DEVKMEM is not set
+CONFIG_SERIAL_SH_SCI=y
+CONFIG_SERIAL_SH_SCI_NR_UARTS=6
+CONFIG_SERIAL_SH_SCI_CONSOLE=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_GPIO_SYSFS=y
+# CONFIG_HWMON is not set
+# CONFIG_USB_SUPPORT is not set
+CONFIG_UIO=y
+CONFIG_UIO_PDRV_GENIRQ=y
+# CONFIG_IOMMU_SUPPORT is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_INOTIFY_USER is not set
+CONFIG_TMPFS=y
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+CONFIG_NFS_V4=y
+CONFIG_ROOT_NFS=y
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_DEBUG_BUGVERBOSE is not set
+# CONFIG_FTRACE is not set
+# CONFIG_ARM_UNWIND is not set
+CONFIG_AVERAGE=y
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 6150cd8..84696c4 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -102,6 +102,12 @@ config MACH_ARMADILLO800EVA
 	select SND_SOC_WM8978 if SND_SIMPLE_CARD
 	select USE_OF
 
+config MACH_BOCKW
+	bool "BOCK-W platform"
+	depends on ARCH_R8A7778
+	select ARCH_REQUIRE_GPIOLIB
+	help
+
 config MACH_MARZEN
 	bool "MARZEN board"
 	depends on ARCH_R8A7779
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index cc3ccff..8f33255 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_MACH_AG5EVM)	+= board-ag5evm.o
 obj-$(CONFIG_MACH_MACKEREL)	+= board-mackerel.o
 obj-$(CONFIG_MACH_KOTA2)	+= board-kota2.o
 obj-$(CONFIG_MACH_BONITO)	+= board-bonito.o
+obj-$(CONFIG_MACH_BOCKW)	+= board-bockw.o
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen.o
 obj-$(CONFIG_MACH_MARZEN_REFERENCE)	+= board-marzen-reference.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA)	+= board-armadillo800eva.o
diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
new file mode 100644
index 0000000..4f46ebd
--- /dev/null
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -0,0 +1,126 @@
+/*
+ * Bock-W board support
+ *
+ * Copyright (C) 2013  Renesas Solutions Corp.
+ * Copyright (C) 2013  Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/gpio.h>
+#include <linux/platform_device.h>
+#include <linux/smsc911x.h>
+#include <mach/irqs.h>
+#include <mach/common.h>
+#include <mach/r8a7778.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+/* FPGA is mapped to 0xe0000000 */
+#define FPGA(x) (((x) & 0x0FFFFFFF) + 0xe0000000)
+
+static struct map_desc bockw_io_desc[] __initdata = {
+	/* FPGA / AREA0 from 0x18200000 */
+	{
+		.virtual	= FPGA(0x18200000),
+		.pfn		= __phys_to_pfn(0x18200000),
+		.length		= SZ_1M,
+		.type		= MT_DEVICE_NONSHARED
+	},
+};
+
+static void __init bockw_map_io(void)
+{
+	iotable_init(bockw_io_desc, ARRAY_SIZE(bockw_io_desc));
+
+	r8a7778_map_io();
+}
+
+static struct smsc911x_platform_config bockw_smsc911x_config = {
+	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
+	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
+	.flags		= SMSC911X_USE_32BIT,
+	.phy_interface	= PHY_INTERFACE_MODE_MII,
+};
+
+static struct resource bockw_smsc911x_resources[] = {
+	{
+		.start	= 0x18300000,
+		.end	= 0x18301000 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= gic_iid(0x3B), /* IRQ 0 */
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device smsc911x_device = {
+	.name		= "smsc911x",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &bockw_smsc911x_config,
+	},
+	.num_resources	= ARRAY_SIZE(bockw_smsc911x_resources),
+	.resource	= bockw_smsc911x_resources,
+};
+
+static struct platform_device *bockw_devices[] __initdata = {
+	&smsc911x_device,
+};
+
+#define IRQ0MR		IOMEM(FPGA(0x18200030))
+static void __init bockw_init(void)
+{
+	u16 val;
+
+	r8a7778_pinmux_init();
+
+	/* SCIF 0 */
+	gpio_request(GPIO_FN_SCIF_CLK,	NULL);
+	gpio_request(GPIO_FN_TX0_A,	NULL);
+	gpio_request(GPIO_FN_RX0_A,	NULL);
+	gpio_request(GPIO_FN_RTS0_A,	NULL);
+	gpio_request(GPIO_FN_CTS0_A,	NULL);
+
+	/*
+	 * CAUTION
+	 *
+	 * IRQ0/1 is cascaded interrupt from FPGA.
+	 * it should be cared in the future
+	 * Now, it is assuming IRQ0 was used only from SMSC.
+	 */
+
+	/* interrupt mask on IRQ0 */
+	val = ioread16(IRQ0MR);
+	val &= ~(1 << 4); /* enable SMSC911x */
+	iowrite16(val, IRQ0MR);
+
+	r8a7778_add_standard_devices();
+	platform_add_devices(bockw_devices, ARRAY_SIZE(bockw_devices));
+}
+
+MACHINE_START(BOCKW, "bockw")
+	.map_io		= bockw_map_io,
+	.init_early	= r8a7778_add_early_devices,
+	.nr_irqs	= NR_IRQS_LEGACY,
+	.init_irq	= r8a7778_init_irq,
+	.init_machine	= bockw_init,
+	.init_late	= shmobile_init_late,
+	.init_time	= r8a7778_earlytimer_init,
+MACHINE_END
-- 
1.7.9.5

