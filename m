From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Nov 2010 02:21:21 +0000
Subject: [PATCH 1/5] ARM: mach-shmobile: Add mackerel board support
Message-Id: <w3phbf050pq.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/Kconfig          |    7 +-
 arch/arm/mach-shmobile/Makefile         |    1 +
 arch/arm/mach-shmobile/board-mackerel.c |  165 +++++++++++++++++++++++++++++++
 3 files changed, 172 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/board-mackerel.c

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index cc54343..7b2edd7 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -51,6 +51,11 @@ config AP4EVB_WVGA
 
 endchoice
 
+config MACH_MACKEREL
+	bool "mackerel board"
+	depends on ARCH_SH7372
+	select ARCH_REQUIRE_GPIOLIB
+
 comment "SH-Mobile System Configuration"
 
 menu "Memory configuration"
@@ -59,7 +64,7 @@ config MEMORY_START
 	hex "Physical memory start address"
 	default "0x50000000" if MACH_G3EVM
 	default "0x40000000" if MACH_G4EVM
-	default "0x40000000" if MACH_AP4EVB
+	default "0x40000000" if MACH_AP4EVB || MACH_MACKEREL
 	default "0x00000000"
 	---help---
 	  Tweak this only when porting to a new machine which does not
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index ae416fe..11f3242 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_GENERIC_GPIO)	+= $(pfc-y)
 obj-$(CONFIG_MACH_G3EVM)	+= board-g3evm.o
 obj-$(CONFIG_MACH_G4EVM)	+= board-g4evm.o
 obj-$(CONFIG_MACH_AP4EVB)	+= board-ap4evb.o
+obj-$(CONFIG_MACH_MACKEREL)	+= board-mackerel.o
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
new file mode 100644
index 0000000..b8df709
--- /dev/null
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -0,0 +1,165 @@
+/*
+ * mackerel board support
+ *
+ * Copyright (C) 2010 Renesas Solutions Corp.
+ * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+ *
+ * based on ap4evb
+ * Copyright (C) 2010  Magnus Damm
+ * Copyright (C) 2008  Yoshihiro Shimoda
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
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <linux/input.h>
+#include <linux/io.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/physmap.h>
+
+#include <mach/common.h>
+#include <mach/sh7372.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+#include <asm/mach/map.h>
+#include <asm/mach-types.h>
+
+/*
+ * Address	Interface		BusWidth	note
+ * ------------------------------------------------------------------
+ * 0x0000_0000	NOR Flash ROM (MCP)	16bit		SW7 : bit1 = ON
+ * 0x0800_0000	user area		-
+ * 0x1000_0000	NOR Flash ROM (MCP)	16bit		SW7 : bit1 = OFF
+ * 0x1400_0000	Ether (LAN9220)		16bit
+ * 0x1600_0000	user area		-		cannot use with NAND
+ * 0x1800_0000	user area		-
+ * 0x1A00_0000	-
+ * 0x4000_0000	LPDDR2-SDRAM (POP)	32bit
+ */
+
+/* MTD */
+static struct mtd_partition nor_flash_partitions[] = {
+	{
+		.name		= "loader",
+		.offset		= 0x00000000,
+		.size		= 512 * 1024,
+		.mask_flags	= MTD_WRITEABLE,
+	},
+	{
+		.name		= "bootenv",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 512 * 1024,
+		.mask_flags	= MTD_WRITEABLE,
+	},
+	{
+		.name		= "kernel_ro",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 8 * 1024 * 1024,
+		.mask_flags	= MTD_WRITEABLE,
+	},
+	{
+		.name		= "kernel",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 8 * 1024 * 1024,
+	},
+	{
+		.name		= "data",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= MTDPART_SIZ_FULL,
+	},
+};
+
+static struct physmap_flash_data nor_flash_data = {
+	.width		= 2,
+	.parts		= nor_flash_partitions,
+	.nr_parts	= ARRAY_SIZE(nor_flash_partitions),
+};
+
+static struct resource nor_flash_resources[] = {
+	[0]	= {
+		.start	= 0x00000000,
+		.end	= 0x08000000 - 1,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
+static struct platform_device nor_flash_device = {
+	.name		= "physmap-flash",
+	.dev		= {
+		.platform_data	= &nor_flash_data,
+	},
+	.num_resources	= ARRAY_SIZE(nor_flash_resources),
+	.resource	= nor_flash_resources,
+};
+
+static struct platform_device *mackerel_devices[] __initdata = {
+	&nor_flash_device,
+};
+
+static struct map_desc mackerel_io_desc[] __initdata = {
+	/* create a 1:1 entity map for 0xe6xxxxxx
+	 * used by CPGA, INTC and PFC.
+	 */
+	{
+		.virtual	= 0xe6000000,
+		.pfn		= __phys_to_pfn(0xe6000000),
+		.length		= 256 << 20,
+		.type		= MT_DEVICE_NONSHARED
+	},
+};
+
+static void __init mackerel_map_io(void)
+{
+	iotable_init(mackerel_io_desc, ARRAY_SIZE(mackerel_io_desc));
+
+	/* setup early devices and console here as well */
+	sh7372_add_early_devices();
+	shmobile_setup_console();
+}
+
+static void __init mackerel_init(void)
+{
+	sh7372_pinmux_init();
+
+	/* enable SCIFA0 */
+	gpio_request(GPIO_FN_SCIFA0_TXD, NULL);
+	gpio_request(GPIO_FN_SCIFA0_RXD, NULL);
+
+	sh7372_add_standard_devices();
+
+	platform_add_devices(mackerel_devices, ARRAY_SIZE(mackerel_devices));
+}
+
+static void __init mackerel_timer_init(void)
+{
+	sh7372_clock_init();
+	shmobile_timer.init();
+}
+
+static struct sys_timer mackerel_timer = {
+	.init		= mackerel_timer_init,
+};
+
+MACHINE_START(MACKEREL, "mackerel")
+	.map_io		= mackerel_map_io,
+	.init_irq	= sh7372_init_irq,
+	.init_machine	= mackerel_init,
+	.timer		= &mackerel_timer,
+MACHINE_END
-- 
1.7.0.4

