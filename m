From: Rich Felker <dalias@libc.org>
Date: Fri, 12 Feb 2016 04:14:24 +0000
Subject: [PATCH] arch/sh: add device tree support and generic board option
Message-Id: <20160212041424.GA11747@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add a new pseudo-board, within the existing SH boards/machine-vectors
framework, which does not represent any actual hardware but instead
requires all hardware to be described by the device tree blob provided
by the boot loader. Changes made are thus non-invasive and do not risk
breaking support for legacy boards.

New hardware, including the open-hardware J2 and associated SoC
devices, will use device free from the outset. Legacy SH boards can
transition to device tree once all their hardware has device tree
bindings, driver support for device tree, and a dts file for the
board.

It is intented that, once all boards are supported in the new
framework, the existing machine-vectors framework should be removed
and the new device tree setup code integrated directly.

---

Yoshinori Sato also has device tree work for SH which he developed
independently before we jointly took over maintainership, and which
takes a more incremental approach. It also has support for linking the
DTB into the kernel, and partly using device tree to describe existing
legacy boards, but it is not sufficiently general in its current form
to support J2 boards with SoC hardware that's significantly different
from the Renesas hardware. Still we may wish to integrate/merge some
aspects of both versions before this goes upstream.

---
 Documentation/devicetree/booting-without-of.txt |  13 +++
 arch/sh/boards/Kconfig                          |  15 ++++
 arch/sh/boards/Makefile                         |   2 +
 arch/sh/boards/of-generic.c                     | 113 ++++++++++++++++++++++++
 arch/sh/kernel/head_32.S                        |  13 +++
 arch/sh/kernel/setup.c                          |  27 ++++++
 6 files changed, 183 insertions(+)
 create mode 100644 arch/sh/boards/of-generic.c

diff --git a/Documentation/devicetree/booting-without-of.txt b/Documentation/devicetree/booting-without-of.txt
index 04d34f6..3f1437f 100644
--- a/Documentation/devicetree/booting-without-of.txt
+++ b/Documentation/devicetree/booting-without-of.txt
@@ -16,6 +16,7 @@ Table of Contents
     2) Entry point for arch/powerpc
     3) Entry point for arch/x86
     4) Entry point for arch/mips/bmips
+    5) Entry point for arch/sh
 
   II - The DT block format
     1) Header
@@ -316,6 +317,18 @@ it with special cases.
   This convention is defined for 32-bit systems only, as there are not
   currently any 64-bit BMIPS implementations.
 
+5) Entry point for arch/sh
+--------------------------
+
+  Device-tree-compatible SH bootloaders are expected to provide the physical
+  address of the device tree blob in r4. Since legacy bootloaders did not
+  guarantee any particular initial register state, kernels built to
+  inter-operate with old bootloaders must either use a builtin DTB or
+  select a legacy board option (something other than CONFIG_SH_DEVICE_TREE)
+  that does not use device tree. Support for the latter is being phased out
+  in favor of device tree.
+
+
 II - The DT block format
 ============
 
diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index 89963d1..5e52d53 100644
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -6,6 +6,21 @@ config SOLUTION_ENGINE
 config SH_ALPHA_BOARD
 	bool
 
+config SH_DEVICE_TREE
+	bool "Board Described by Device Tree"
+	select OF
+	select OF_EARLY_FLATTREE
+	select CLKSRC_OF
+	select GENERIC_CALIBRATE_DELAY
+	help
+	  Select Board Described by Device Tree to build a kernel that
+	  does not hard-code any board-specific knowledge but instead uses
+	  a device tree blob provided by the boot-loader. You must enable
+	  drivers for any hardware you want to use separately. At this
+	  time, only boards based on the open-hardware J-Core processors
+	  have sufficient driver coverage to use this option; do not
+	  select it if you are using original SuperH hardware.
+
 config SH_SOLUTION_ENGINE
 	bool "SolutionEngine"
 	select SOLUTION_ENGINE
diff --git a/arch/sh/boards/Makefile b/arch/sh/boards/Makefile
index 975a0f6..cea3003 100644
--- a/arch/sh/boards/Makefile
+++ b/arch/sh/boards/Makefile
@@ -15,3 +15,5 @@ obj-$(CONFIG_SH_TITAN)		+= board-titan.o
 obj-$(CONFIG_SH_SH7757LCR)	+= board-sh7757lcr.o
 obj-$(CONFIG_SH_APSH4A3A)	+= board-apsh4a3a.o
 obj-$(CONFIG_SH_APSH4AD0A)	+= board-apsh4ad0a.o
+
+obj-$(CONFIG_SH_DEVICE_TREE)	+= of-generic.o
diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
new file mode 100644
index 0000000..71d8909
--- /dev/null
+++ b/arch/sh/boards/of-generic.c
@@ -0,0 +1,113 @@
+/*
+ * SH generic board support, using device tree
+ *
+ * Copyright (C) 2015-2016 Smart Energy Instruments, Inc.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/of_fdt.h>
+#include <linux/of_iommu.h>
+#include <linux/clocksource.h>
+#include <linux/irqchip.h>
+#include <linux/clk-provider.h>
+#include <asm/machvec.h>
+#include <asm/rtc.h>
+
+static void noop(void)
+{
+}
+
+static int noopi(void)
+{
+	return 0;
+}
+
+static void __init sh_of_mem_reserve(void)
+{
+	early_init_fdt_reserve_self();
+	early_init_fdt_scan_reserved_mem();
+}
+
+static void __init sh_of_time_init(void)
+{
+	pr_info("SH generic board support: scanning for clocksource devices\n");
+	clocksource_probe();
+}
+
+static void __init sh_of_setup(char **cmdline_p)
+{
+	unflatten_device_tree();
+
+	board_time_init = sh_of_time_init;
+
+	sh_mv.mv_name = of_flat_dt_get_machine_name();
+	if (!sh_mv.mv_name)
+		sh_mv.mv_name = "Unknown SH model";
+
+	/* FIXME: register smp ops to use dt to find cpus, use
+	 * cpu enable-method, and use irq controller's ipi
+	 * functions. */
+}
+
+static int sh_of_irq_demux(int irq)
+{
+	/* FIXME: eventually this should not be used at all;
+	 * the interrupt controller should set_handle_irq(). */
+	return irq;
+}
+
+static void __init sh_of_init_irq(void)
+{
+	pr_info("SH generic board support: scanning for interrupt controllers\n");
+	irqchip_init();
+}
+
+static int __init sh_of_clk_init(void)
+{
+#ifdef CONFIG_COMMON_CLK
+	/* Disabled pending move to COMMON_CLK framework. */
+	pr_info("SH generic board support: scanning for clk providers\n");
+	of_clk_init(NULL);
+#endif
+	return 0;
+}
+
+static struct sh_machine_vector __initmv sh_of_generic_mv = {
+	.mv_setup	= sh_of_setup,
+	.mv_name	= "devicetree", /* replaced by DT root's model */
+	.mv_irq_demux	= sh_of_irq_demux,
+	.mv_init_irq	= sh_of_init_irq,
+	.mv_clk_init	= sh_of_clk_init,
+	.mv_mode_pins	= noopi,
+	.mv_mem_init	= noop,
+	.mv_mem_reserve	= sh_of_mem_reserve,
+};
+
+struct sh_clk_ops;
+
+void __init arch_init_clk_ops(struct sh_clk_ops **ops, int idx)
+{
+}
+
+void __init plat_irq_setup(void)
+{
+}
+
+static int __init sh_of_device_init(void)
+{
+	pr_info("SH generic board support: populating platform devices\n");
+	if (of_have_populated_dt()) {
+		of_iommu_init();
+		of_platform_populate(NULL, of_default_bus_match_table,
+				     NULL, NULL);
+	} else {
+		pr_crit("Device tree not populated\n");
+	}
+	return 0;
+}
+arch_initcall_sync(sh_of_device_init);
diff --git a/arch/sh/kernel/head_32.S b/arch/sh/kernel/head_32.S
index 7db2489..974bc15 100644
--- a/arch/sh/kernel/head_32.S
+++ b/arch/sh/kernel/head_32.S
@@ -66,6 +66,10 @@ ENTRY(_stext)
 	mov	#0, r0
 	ldc	r0, r6_bank
 #endif
+
+#ifdef CONFIG_OF
+	mov	r4, r12		! Store device tree blob pointer in r12
+#endif
 	
 	/*
 	 * Prefetch if possible to reduce cache miss penalty.
@@ -314,6 +318,12 @@ ENTRY(_stext)
 10:		
 #endif
 
+#ifdef CONFIG_OF
+	mov.l	8f, r0		! Make flat device tree available early.
+	jsr	@r0
+	 mov	r12, r4
+#endif
+
 	!			Additional CPU initialization
 	mov.l	6f, r0
 	jsr	@r0
@@ -339,6 +349,9 @@ ENTRY(stack_start)
 5:	.long	start_kernel
 6:	.long	cpu_init
 7:	.long	init_thread_union
+#if defined(CONFIG_OF)
+8:	.long	sh_fdt_init
+#endif
 
 #ifdef CONFIG_PMB
 .LPMB_ADDR:		.long	PMB_ADDR
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index de19cfa..efb60ce 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -29,6 +29,8 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/memblock.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/page.h>
@@ -172,6 +174,7 @@ disable:
 #endif
 }
 
+#ifndef CONFIG_GENERIC_CALIBRATE_DELAY
 void calibrate_delay(void)
 {
 	struct clk *clk = clk_get(NULL, "cpu_clk");
@@ -187,6 +190,7 @@ void calibrate_delay(void)
 			 (loops_per_jiffy/(5000/HZ)) % 100,
 			 loops_per_jiffy);
 }
+#endif
 
 void __init __add_active_range(unsigned int nid, unsigned long start_pfn,
 						unsigned long end_pfn)
@@ -238,6 +242,29 @@ void __init __weak plat_early_device_setup(void)
 {
 }
 
+#ifdef CONFIG_OF
+void __ref sh_fdt_init(phys_addr_t dt_phys)
+{
+	static int done = 0;
+	void *dt_virt;
+
+	/* Avoid calling an __init function on secondary cpus. */
+	if (done) return;
+
+	dt_virt = phys_to_virt(dt_phys);
+
+	if (!dt_virt || !early_init_dt_scan(dt_virt)) {
+		pr_crit("Error: invalid device tree blob"
+			" at physical address %p\n", (void *)dt_phys);
+
+		while (true)
+			cpu_relax();
+	}
+
+	done = 1;
+}
+#endif
+
 void __init setup_arch(char **cmdline_p)
 {
 	enable_mmu();
-- 
2.7.0

