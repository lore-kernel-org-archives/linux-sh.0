From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 18 Aug 2011 05:44:07 +0000
Subject: [PATCH 01/07] ARM: mach-shmobile: Kota2 SCIFA2 and SMSC911X support
Message-Id: <20110818054407.23410.98641.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Kota2 base board support including the on-chip SCIFA2
serial console and the on-board SMSC911X ethernet port.

The s73a0 SMP bits are also updated to include Kota2.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Needs the mach-type entry for Kota2 to build.

 arch/arm/mach-shmobile/Kconfig       |    7 +
 arch/arm/mach-shmobile/Makefile      |    1 
 arch/arm/mach-shmobile/board-kota2.c |  168 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/platsmp.c     |   10 +-
 4 files changed, 182 insertions(+), 4 deletions(-)

--- 0001/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2011-08-18 14:16:17.000000000 +0900
@@ -69,6 +69,11 @@ config MACH_MACKEREL
 	depends on ARCH_SH7372
 	select ARCH_REQUIRE_GPIOLIB
 
+config MACH_KOTA2
+	bool "KOTA2 board"
+	select ARCH_REQUIRE_GPIOLIB
+	depends on ARCH_SH73A0
+
 comment "SH-Mobile System Configuration"
 
 menu "Memory configuration"
@@ -78,6 +83,7 @@ config MEMORY_START
 	default "0x50000000" if MACH_G3EVM
 	default "0x40000000" if MACH_G4EVM || MACH_AP4EVB || MACH_AG5EVM || \
 				MACH_MACKEREL
+	default "0x41000000" if MACH_KOTA2
 	default "0x00000000"
 	---help---
 	  Tweak this only when porting to a new machine which does not
@@ -89,6 +95,7 @@ config MEMORY_SIZE
 	default "0x08000000" if MACH_G3EVM
 	default "0x08000000" if MACH_G4EVM
 	default "0x20000000" if MACH_AG5EVM
+	default "0x1e000000" if MACH_KOTA2
 	default "0x10000000" if MACH_AP4EVB || MACH_MACKEREL
 	default "0x04000000"
 	help
--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2011-08-18 13:38:02.000000000 +0900
@@ -41,6 +41,7 @@ obj-$(CONFIG_MACH_G4EVM)	+= board-g4evm.
 obj-$(CONFIG_MACH_AP4EVB)	+= board-ap4evb.o
 obj-$(CONFIG_MACH_AG5EVM)	+= board-ag5evm.o
 obj-$(CONFIG_MACH_MACKEREL)	+= board-mackerel.o
+obj-$(CONFIG_MACH_KOTA2)	+= board-kota2.o
 
 # Framework support
 obj-$(CONFIG_SMP)		+= $(smp-y)
--- /dev/null
+++ work/arch/arm/mach-shmobile/board-kota2.c	2011-08-18 13:38:03.000000000 +0900
@@ -0,0 +1,168 @@
+/*
+ * kota2 board support
+ *
+ * Copyright (C) 2011  Renesas Solutions Corp.
+ * Copyright (C) 2011  Magnus Damm
+ * Copyright (C) 2010  Takashi Yoshii <yoshii.takashi.zj@renesas.com>
+ * Copyright (C) 2009  Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
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
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/smsc911x.h>
+#include <linux/gpio.h>
+#include <mach/hardware.h>
+#include <mach/sh73a0.h>
+#include <mach/common.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/time.h>
+#include <asm/hardware/gic.h>
+#include <asm/hardware/cache-l2x0.h>
+#include <asm/traps.h>
+
+static struct resource smsc9220_resources[] = {
+	[0] = {
+		.start		= 0x14000000, /* CS5A */
+		.end		= 0x140000ff, /* A1->A7 */
+		.flags		= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= gic_spi(33), /* PINTA2 @ PORT144 */
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct smsc911x_platform_config smsc9220_platdata = {
+	.flags		= SMSC911X_USE_32BIT, /* 32-bit SW on 16-bit HW bus */
+	.phy_interface	= PHY_INTERFACE_MODE_MII,
+	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
+	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
+};
+
+static struct platform_device eth_device = {
+	.name		= "smsc911x",
+	.id		= 0,
+	.dev  = {
+		.platform_data = &smsc9220_platdata,
+	},
+	.resource	= smsc9220_resources,
+	.num_resources	= ARRAY_SIZE(smsc9220_resources),
+};
+
+static struct platform_device *kota2_devices[] __initdata = {
+	&eth_device,
+};
+
+static struct map_desc kota2_io_desc[] __initdata = {
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
+static void __init kota2_map_io(void)
+{
+	iotable_init(kota2_io_desc, ARRAY_SIZE(kota2_io_desc));
+
+	/* setup early devices and console here as well */
+	sh73a0_add_early_devices();
+	shmobile_setup_console();
+}
+
+#define PINTER0A	0xe69000a0
+#define PINTCR0A	0xe69000b0
+
+void __init kota2_init_irq(void)
+{
+	sh73a0_init_irq();
+
+	/* setup PINT: enable PINTA2 as active low */
+	__raw_writel(1 << 29, PINTER0A);
+	__raw_writew(2 << 10, PINTCR0A);
+}
+
+static void __init kota2_init(void)
+{
+	sh73a0_pinmux_init();
+
+	/* SCIFA2 (UART2) */
+	gpio_request(GPIO_FN_SCIFA2_TXD1, NULL);
+	gpio_request(GPIO_FN_SCIFA2_RXD1, NULL);
+	gpio_request(GPIO_FN_SCIFA2_RTS1_, NULL);
+	gpio_request(GPIO_FN_SCIFA2_CTS1_, NULL);
+
+	/* SMSC911X */
+	gpio_request(GPIO_FN_D0_NAF0, NULL);
+	gpio_request(GPIO_FN_D1_NAF1, NULL);
+	gpio_request(GPIO_FN_D2_NAF2, NULL);
+	gpio_request(GPIO_FN_D3_NAF3, NULL);
+	gpio_request(GPIO_FN_D4_NAF4, NULL);
+	gpio_request(GPIO_FN_D5_NAF5, NULL);
+	gpio_request(GPIO_FN_D6_NAF6, NULL);
+	gpio_request(GPIO_FN_D7_NAF7, NULL);
+	gpio_request(GPIO_FN_D8_NAF8, NULL);
+	gpio_request(GPIO_FN_D9_NAF9, NULL);
+	gpio_request(GPIO_FN_D10_NAF10, NULL);
+	gpio_request(GPIO_FN_D11_NAF11, NULL);
+	gpio_request(GPIO_FN_D12_NAF12, NULL);
+	gpio_request(GPIO_FN_D13_NAF13, NULL);
+	gpio_request(GPIO_FN_D14_NAF14, NULL);
+	gpio_request(GPIO_FN_D15_NAF15, NULL);
+	gpio_request(GPIO_FN_CS5A_, NULL);
+	gpio_request(GPIO_FN_WE0__FWE, NULL);
+	gpio_request(GPIO_PORT144, NULL); /* PINTA2 */
+	gpio_direction_input(GPIO_PORT144);
+	gpio_request(GPIO_PORT145, NULL); /* RESET */
+	gpio_direction_output(GPIO_PORT145, 1);
+
+#ifdef CONFIG_CACHE_L2X0
+	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
+	l2x0_init(__io(0xf0100000), 0x40460000, 0x82000fff);
+#endif
+	sh73a0_add_standard_devices();
+	platform_add_devices(kota2_devices, ARRAY_SIZE(kota2_devices));
+}
+
+static void __init kota2_timer_init(void)
+{
+	sh73a0_clock_init();
+	shmobile_timer.init();
+	return;
+}
+
+struct sys_timer kota2_timer = {
+	.init	= kota2_timer_init,
+};
+
+MACHINE_START(KOTA2, "kota2")
+	.map_io		= kota2_map_io,
+	.init_irq	= kota2_init_irq,
+	.handle_irq	= shmobile_handle_irq_gic,
+	.init_machine	= kota2_init,
+	.timer		= &kota2_timer,
+MACHINE_END
--- 0001/arch/arm/mach-shmobile/platsmp.c
+++ work/arch/arm/mach-shmobile/platsmp.c	2011-08-18 13:38:02.000000000 +0900
@@ -21,9 +21,11 @@
 #include <asm/mach-types.h>
 #include <mach/common.h>
 
+#define is_sh73a0() (machine_is_ag5evm() || machine_is_kota2())
+
 static unsigned int __init shmobile_smp_get_core_count(void)
 {
-	if (machine_is_ag5evm())
+	if (is_sh73a0())
 		return sh73a0_get_core_count();
 
 	return 1;
@@ -31,7 +33,7 @@ static unsigned int __init shmobile_smp_
 
 static void __init shmobile_smp_prepare_cpus(void)
 {
-	if (machine_is_ag5evm())
+	if (is_sh73a0())
 		sh73a0_smp_prepare_cpus();
 }
 
@@ -39,13 +41,13 @@ void __cpuinit platform_secondary_init(u
 {
 	trace_hardirqs_off();
 
-	if (machine_is_ag5evm())
+	if (is_sh73a0())
 		sh73a0_secondary_init(cpu);
 }
 
 int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	if (machine_is_ag5evm())
+	if (is_sh73a0())
 		return sh73a0_boot_secondary(cpu);
 
 	return -ENOSYS;
