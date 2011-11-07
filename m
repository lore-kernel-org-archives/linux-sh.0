From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 07 Nov 2011 09:53:29 +0000
Subject: [PATCH 2.3/5 v3] ARM: mach-shmobile: add bonito board support.
Message-Id: <87hb2gqmwa.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds basic bonito board (R-Mobile A1) support

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v2 -> v3

- rename fpga_xx() -> bonito_fpga_xxx()
- reduced bonito defconfig by c2330e286f68f1c408b4aa6515ba49d57f05beae script

 arch/arm/configs/bonito_defconfig     |   72 +++++++++++
 arch/arm/mach-shmobile/Kconfig        |    9 +-
 arch/arm/mach-shmobile/Makefile       |    1 +
 arch/arm/mach-shmobile/board-bonito.c |  208 +++++++++++++++++++++++++++++++++
 4 files changed, 288 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/configs/bonito_defconfig
 create mode 100644 arch/arm/mach-shmobile/board-bonito.c

diff --git a/arch/arm/configs/bonito_defconfig b/arch/arm/configs/bonito_defconfig
new file mode 100644
index 0000000..635bd69
--- /dev/null
+++ b/arch/arm/configs/bonito_defconfig
@@ -0,0 +1,72 @@
+CONFIG_EXPERIMENTAL=y
+CONFIG_SYSVIPC=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT
+# CONFIG_UTS_NS is not set
+# CONFIG_IPC_NS is not set
+# CONFIG_USER_NS is not set
+# CONFIG_PID_NS is not set
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE="/your/initramfs/"
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SLAB=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_R8A7740=y
+CONFIG_MACH_BONITO=y
+# CONFIG_SH_TIMER_TMU is not set
+CONFIG_AEABI=y
+# CONFIG_OABI_COMPAT is not set
+CONFIG_FORCE_MAX_ZONEORDER
+CONFIG_ZBOOT_ROM_TEXT=0x0
+CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_CMDLINE="console=ttySC5,115200 earlyprintk=sh-sci.5,115200 ignore_loglevel"
+CONFIG_KEXEC=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_SUSPEND is not set
+CONFIG_PM_RUNTIME=y
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+# CONFIG_FIRMWARE_IN_KERNEL is not set
+CONFIG_MTD=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_CFI_ADV_OPTIONS=y
+CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_ARM_INTEGRATOR=y
+CONFIG_MTD_BLOCK2MTD=y
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
+# CONFIG_SCSI_LOWLEVEL is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_LEGACY_PTYS is not set
+CONFIG_SERIAL_SH_SCI=y
+CONFIG_SERIAL_SH_SCI_NR_UARTS=9
+CONFIG_SERIAL_SH_SCI_CONSOLE=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_SH_MOBILE=y
+CONFIG_GPIO_SYSFS=y
+# CONFIG_HWMON is not set
+# CONFIG_MFD_SUPPORT is not set
+# CONFIG_HID_SUPPORT is not set
+# CONFIG_USB_SUPPORT is not set
+CONFIG_UIO=y
+CONFIG_UIO_PDRV=y
+CONFIG_UIO_PDRV_GENIRQ=y
+# CONFIG_DNOTIFY is not set
+# CONFIG_INOTIFY_USER is not set
+CONFIG_TMPFS=y
+# CONFIG_MISC_FILESYSTEMS is not set
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
+# CONFIG_ARM_UNWIND is not set
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 4f95bb9..37a13e2 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -82,6 +82,11 @@ config MACH_KOTA2
 	depends on ARCH_SH73A0
 	select SH_LCD_MIPI_DSI
 
+config MACH_BONITO
+	bool "bonito board"
+	select ARCH_REQUIRE_GPIOLIB
+	depends on ARCH_R8A7740
+
 comment "SH-Mobile System Configuration"
 
 menu "Memory configuration"
@@ -90,7 +95,7 @@ config MEMORY_START
 	hex "Physical memory start address"
 	default "0x50000000" if MACH_G3EVM
 	default "0x40000000" if MACH_G4EVM || MACH_AP4EVB || MACH_AG5EVM || \
-				MACH_MACKEREL
+				MACH_MACKEREL || MACH_BONITO
 	default "0x41000000" if MACH_KOTA2
 	default "0x00000000"
 	---help---
@@ -102,7 +107,7 @@ config MEMORY_SIZE
 	hex "Physical memory size"
 	default "0x08000000" if MACH_G3EVM
 	default "0x08000000" if MACH_G4EVM
-	default "0x20000000" if MACH_AG5EVM
+	default "0x20000000" if MACH_AG5EVM || MACH_BONITO
 	default "0x1e000000" if MACH_KOTA2
 	default "0x10000000" if MACH_AP4EVB || MACH_MACKEREL
 	default "0x04000000"
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 2bd2d3b..1dd1eb9 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_MACH_AP4EVB)	+= board-ap4evb.o
 obj-$(CONFIG_MACH_AG5EVM)	+= board-ag5evm.o
 obj-$(CONFIG_MACH_MACKEREL)	+= board-mackerel.o
 obj-$(CONFIG_MACH_KOTA2)	+= board-kota2.o
+obj-$(CONFIG_MACH_BONITO)	+= board-bonito.o
 
 # Framework support
 obj-$(CONFIG_SMP)		+= $(smp-y)
diff --git a/arch/arm/mach-shmobile/board-bonito.c b/arch/arm/mach-shmobile/board-bonito.c
new file mode 100644
index 0000000..5536ead
--- /dev/null
+++ b/arch/arm/mach-shmobile/board-bonito.c
@@ -0,0 +1,208 @@
+/*
+ * bonito board support
+ *
+ * Copyright (C) 2011 Renesas Solutions Corp.
+ * Copyright (C) 2011 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <mach/common.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/time.h>
+#include <asm/hardware/cache-l2x0.h>
+#include <mach/r8a7740.h>
+
+/*
+ * CS	Address		device			note
+ *----------------------------------------------------------------
+ * 0	0x0000_0000	NOR Flash (64MB)	SW12 : bit3 = OFF
+ * 2	0x0800_0000	ExtNOR (64MB)		SW12 : bit3 = OFF
+ * 4			-
+ * 5A			-
+ * 5B	0x1600_0000	SRAM (8MB)
+ * 6	0x1800_0000	FPGA (64K)
+ *	0x1801_0000	Ether (4KB)
+ *	0x1801_1000	USB (4KB)
+ */
+
+/*
+ * SW12
+ *
+ *	bit1			bit2			bit3
+ *----------------------------------------------------------------------------
+ * ON	NOR WriteProtect	NAND WriteProtect	CS0 ExtNOR / CS2 NOR
+ * OFF	NOR Not WriteProtect	NAND Not WriteProtect	CS0 NOR    / CS2 ExtNOR
+ */
+
+/*
+ * FPGA
+ */
+#define A1MDSR		0x10E0
+#define BVERR		0x1100
+static u16 bonito_fpga_read(u32 offset)
+{
+	return __raw_readw(0xf0003000 + offset);
+}
+
+static void bonito_fpga_write(u32 offset, u16 val, u16 mask)
+{
+	u16 tmp;
+
+	tmp = bonito_fpga_read(offset);
+	tmp = (tmp & ~mask) | (val & mask);
+	__raw_writew(tmp, 0xf0003000 + offset);
+}
+
+/*
+ * devices
+ */
+static struct platform_device *bonito_devices[] __initdata = {
+};
+
+/*
+ * map I/O
+ */
+static struct map_desc bonito_io_desc[] __initdata = {
+	 /*
+	  * for CPGA/INTC/PFC
+	  * 0xe6000000-0xefffffff -> 0xe6000000-0xefffffff
+	  */
+	{
+		.virtual	= 0xe6000000,
+		.pfn		= __phys_to_pfn(0xe6000000),
+		.length		= 160 << 20,
+		.type		= MT_DEVICE_NONSHARED
+	},
+	/*
+	 * for gic_dist_base/gic_cpu_base
+	 * 0xc2000000-0xc2001000 -> 0xf0000000-0xf0001000
+	 * 0xc2800000-0xc2801000 -> 0xf0001000-0xf0002000
+	 * */
+	{
+		.virtual	= 0xf0000000,
+		.pfn		= __phys_to_pfn(0xc2000000),
+		.length		= PAGE_SIZE,
+		.type		= MT_DEVICE_NONSHARED
+	},
+	{
+		.virtual	= 0xf0001000,
+		.pfn		= __phys_to_pfn(0xc2800000),
+		.length		= PAGE_SIZE,
+		.type		= MT_DEVICE_NONSHARED
+	},
+#ifdef CONFIG_CACHE_L2X0
+	/*
+	 * for l2x0_init()
+	 * 0xf0100000-0xf0101000 -> 0xf0002000-0xf0003000
+	 */
+	{
+		.virtual	= 0xf0002000,
+		.pfn		= __phys_to_pfn(0xf0100000),
+		.length		= PAGE_SIZE,
+		.type		= MT_DEVICE_NONSHARED
+	},
+#endif
+	/*
+	 * for FPGA (0x1800000-0x19ffffff)
+	 * 0x18000000-0x18002000 -> 0xf0003000-0xf0005000
+	 */
+	{
+		.virtual	= 0xf0003000,
+		.pfn		= __phys_to_pfn(0x18000000),
+		.length		= PAGE_SIZE * 2,
+		.type		= MT_DEVICE_NONSHARED
+	}
+};
+
+static void __init bonito_map_io(void)
+{
+	iotable_init(bonito_io_desc, ARRAY_SIZE(bonito_io_desc));
+
+	/* setup early devices and console here as well */
+	r8a7740_add_early_devices();
+	shmobile_setup_console();
+}
+
+/*
+ * board init
+ */
+static void __init bonito_init(void)
+{
+	u16 val;
+
+	r8a7740_pinmux_init();
+
+	/* FPGA */
+	gpio_request(GPIO_FN_CS5B, NULL);
+	gpio_request(GPIO_FN_CS6A, NULL);
+	gpio_request(GPIO_FN_CS5A_PORT105,  NULL);
+	gpio_request(GPIO_FN_IRQ10, NULL);
+
+	val = bonito_fpga_read(BVERR);
+	pr_info("bonito version: cpu %02x, base %02x\n",
+		((val >> 8) & 0xFF),
+		((val >> 0) & 0xFF));
+
+	/* SCIFA5 */
+	gpio_request(GPIO_FN_SCIFA5_TXD_PORT91, NULL);
+	gpio_request(GPIO_FN_SCIFA5_RXD_PORT92, NULL);
+
+#ifdef CONFIG_CACHE_L2X0
+	/* Early BRESP enable, Shared attribute override enable, 32K*8way */
+	l2x0_init(__io(0xf0002000), 0x40440000, 0x82000fff);
+#endif
+
+	r8a7740_add_standard_devices();
+	platform_add_devices(bonito_devices, ARRAY_SIZE(bonito_devices));
+}
+
+static void __init bonito_timer_init(void)
+{
+	u16 val;
+	u8 md_ck = 0;
+
+	/* read MD_CK value */
+	val = bonito_fpga_read(A1MDSR);
+	if (val & (1 << 10))
+		md_ck |= MD_CK2;
+	if (val & (1 << 9))
+		md_ck |= MD_CK1;
+	if (val & (1 << 8))
+		md_ck |= MD_CK0;
+
+	r8a7740_clock_init(md_ck);
+	shmobile_timer.init();
+}
+
+struct sys_timer bonito_timer = {
+	.init	= bonito_timer_init,
+};
+
+MACHINE_START(BONITO, "bonito")
+	.map_io		= bonito_map_io,
+	.init_irq	= r8a7740_init_irq,
+	.handle_irq	= shmobile_handle_irq_gic,
+	.init_machine	= bonito_init,
+	.timer		= &bonito_timer,
+MACHINE_END
-- 
1.7.5.4

