From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 02 Apr 2008 01:49:15 +0000
Subject: [PATCH] sh: cpuvec prototype for sh7722
Message-Id: <20080402014915.21660.4184.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch contains my cpuvec prototype for sh7722. The idea behind
cpuvec is that we need something similar to machvec, but cpu specific.

Commonly used data structures such as platform device lists and intc
controller data are pointed out directly by the cpuvec struct. This
is convenient since it allows us to locate cpu specific platform data
early in the boot process. Think serial port data for early printk,
tmu information for the timers, pci bridge base addresses and so on.

Matching is done by comparing the detected cpu_type enum with the
one present in the cpuvec. Seems to work well.

I'd be happy to convert the rest of the cpu code, just let me know
if the currect struct sh_cpu_vector is good enough.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/Makefile_32             |    2 
 arch/sh/kernel/Makefile_64             |    2 
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   24 +++++------
 arch/sh/kernel/cpuvec.c                |   65 ++++++++++++++++++++++++++++++++
 arch/sh/kernel/irq.c                   |   14 ++++++
 arch/sh/kernel/setup.c                 |   36 +++++++----------
 arch/sh/kernel/vmlinux_32.lds.S        |    5 ++
 arch/sh/kernel/vmlinux_64.lds.S        |    5 ++
 arch/sh/mm/numa.c                      |    4 +
 include/asm-sh/cpuvec.h                |   37 ++++++++++++++++++
 include/asm-sh/hw_irq.h                |    2 
 include/asm-sh/mmzone.h                |    3 -
 include/asm-sh/sections.h              |    1 
 include/asm-sh/setup.h                 |    1 
 14 files changed, 158 insertions(+), 43 deletions(-)

--- 0001/arch/sh/kernel/Makefile_32
+++ work/arch/sh/kernel/Makefile_32	2008-04-01 17:50:29.000000000 +0900
@@ -6,7 +6,7 @@ extra-y	:= head_32.o init_task.o vmlinux
 
 obj-y	:= debugtraps.o io.o io_generic.o irq.o machvec.o process_32.o \
 	   ptrace_32.o semaphore.o setup.o signal_32.o sys_sh.o sys_sh32.o \
-	   syscalls_32.o time_32.o topology.o traps.o traps_32.o
+	   syscalls_32.o time_32.o topology.o traps.o traps_32.o cpuvec.o
 
 obj-y				+= cpu/ timers/
 obj-$(CONFIG_VSYSCALL)		+= vsyscall/
--- 0001/arch/sh/kernel/Makefile_64
+++ work/arch/sh/kernel/Makefile_64	2008-04-01 17:50:42.000000000 +0900
@@ -2,7 +2,7 @@ extra-y	:= head_64.o init_task.o vmlinux
 
 obj-y	:= debugtraps.o io.o io_generic.o irq.o machvec.o process_64.o \
 	   ptrace_64.o semaphore.o setup.o signal_64.o sys_sh.o sys_sh64.o \
-	   syscalls_64.o time_64.o topology.o traps.o traps_64.o
+	   syscalls_64.o time_64.o topology.o traps.o traps_64.o cpuvec.o
 
 obj-y				+= cpu/ timers/
 obj-$(CONFIG_VSYSCALL)		+= vsyscall/
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7722.c	2008-04-01 18:01:33.000000000 +0900
@@ -12,6 +12,7 @@
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
 #include <linux/mm.h>
+#include <asm/cpuvec.h>
 #include <asm/mmzone.h>
 
 static struct resource usbf_resources[] = {
@@ -97,13 +98,6 @@ static struct platform_device *sh7722_de
 	&sci_device,
 };
 
-static int __init sh7722_devices_setup(void)
-{
-	return platform_add_devices(sh7722_devices,
-				    ARRAY_SIZE(sh7722_devices));
-}
-__initcall(sh7722_devices_setup);
-
 enum {
 	UNUSED=0,
 
@@ -232,13 +226,17 @@ static struct intc_sense_reg sense_regis
 static DECLARE_INTC_DESC(intc_desc, "sh7722", vectors, groups,
 			 mask_registers, prio_registers, sense_registers);
 
-void __init plat_irq_setup(void)
-{
-	register_intc_controller(&intc_desc);
-}
-
-void __init plat_mem_setup(void)
+static void __init sh7722_setup_mem(void)
 {
 	/* Register the URAM space as Node 1 */
 	setup_bootmem_node(1, 0x055f0000, 0x05610000);
 }
+
+static struct sh_cpu_vector cv_sh7722 __initcv = {
+	.type = CPU_SH7722,
+	.name = "SH7722",
+	.devices = sh7722_devices,
+	.nr_devices = ARRAY_SIZE(sh7722_devices),
+	.intc = &intc_desc,
+	.setup_mem = sh7722_setup_mem,
+};
--- /dev/null
+++ work/arch/sh/kernel/cpuvec.c	2008-04-01 18:33:06.000000000 +0900
@@ -0,0 +1,65 @@
+/*
+ * arch/sh/kernel/cpuvec.c
+ *
+ * SuperH cpu vector setup code, yanked from machvec.c
+ *
+ *  Copyright (C) 1999 Niibe Yutaka
+ *  Copyright (C) 2002 - 2007 Paul Mundt
+ *  Copyright (C) 2008 Magnus Damm
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <asm/processor.h>
+#include <asm/cpuvec.h>
+#include <asm/sections.h>
+
+struct sh_cpu_vector sh_cv;
+
+#define for_each_cv(cv) \
+	for ((cv) = (struct sh_cpu_vector *)&__cpuvec_start; \
+	     (cv) && (unsigned long)(cv) < (unsigned long)&__cpuvec_end; \
+	     (cv)++)
+
+static struct sh_cpu_vector * __init get_cv(enum cpu_type type)
+{
+	struct sh_cpu_vector *cv;
+
+	for_each_cv(cv)
+		if (cv->type = type)
+			return cv;
+
+	return NULL;
+}
+
+void __init sh_cv_setup(void)
+{
+	unsigned long cpuvec_size;
+	struct sh_cpu_vector *cv;
+
+	cpuvec_size = ((unsigned long)&__cpuvec_end -
+			(unsigned long)&__cpuvec_start);
+
+	/*
+	 * Sanity check for cpuvec section alignment. Ensure
+	 * __initcv hasn't been misused.
+	 */
+	if (cpuvec_size % sizeof(struct sh_cpu_vector))
+		panic("cpuvec misaligned, invalid __initcv use?");
+
+	cv = get_cv(current_cpu_data.type);
+
+	if (!cv) {
+		pr_err("Available vectors: ");
+		for_each_cv(cv)
+			pr_err("%s", cv->name);
+		pr_err("\n");
+		panic("Failed to select cpuvec -- halting.\n");
+	}
+
+	printk(KERN_NOTICE "Booting cpuvec: %s\n", cv->name);
+
+	memcpy(&sh_cv, cv, sizeof(sh_cv));
+}
--- 0001/arch/sh/kernel/irq.c
+++ work/arch/sh/kernel/irq.c	2008-04-01 18:16:31.000000000 +0900
@@ -12,6 +12,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/seq_file.h>
 #include <asm/processor.h>
+#include <asm/cpuvec.h>
 #include <asm/machvec.h>
 #include <asm/uaccess.h>
 #include <asm/thread_info.h>
@@ -246,9 +247,20 @@ asmlinkage void do_softirq(void)
 }
 #endif
 
+void __init plat_irq_setup_pins(int mode)
+{
+	if (sh_cv.setup_irq_pins)
+		sh_cv.setup_irq_pins(mode);
+}
+
 void __init init_IRQ(void)
 {
-	plat_irq_setup();
+	/* Cpu-specific setup first */
+	if (sh_cv.intc)
+		register_intc_controller(sh_cv.intc);
+
+	if (sh_cv.setup_irq)
+		sh_cv.setup_irq();
 
 	/* Perform the machine specific initialisation */
 	if (sh_mv.mv_init_irq)
--- 0001/arch/sh/kernel/setup.c
+++ work/arch/sh/kernel/setup.c	2008-04-01 18:26:31.000000000 +0900
@@ -34,6 +34,7 @@
 #include <asm/setup.h>
 #include <asm/clock.h>
 #include <asm/mmu_context.h>
+#include <asm/cpuvec.h>
 
 /*
  * Initialize loops_per_jiffy as 10000000 (1000MIPS).
@@ -284,6 +285,7 @@ void __init setup_arch(char **cmdline_p)
 
 	parse_early_param();
 
+	sh_cv_setup();
 	sh_mv_setup();
 
 	/*
@@ -318,30 +320,22 @@ void __init setup_arch(char **cmdline_p)
 #endif
 }
 
-static const char *cpu_name[] = {
-	[CPU_SH7203]	= "SH7203",	[CPU_SH7263]	= "SH7263",
-	[CPU_SH7206]	= "SH7206",	[CPU_SH7619]	= "SH7619",
-	[CPU_SH7705]	= "SH7705",	[CPU_SH7706]	= "SH7706",
-	[CPU_SH7707]	= "SH7707",	[CPU_SH7708]	= "SH7708",
-	[CPU_SH7709]	= "SH7709",	[CPU_SH7710]	= "SH7710",
-	[CPU_SH7712]	= "SH7712",	[CPU_SH7720]	= "SH7720",
-	[CPU_SH7721]	= "SH7721",	[CPU_SH7729]	= "SH7729",
-	[CPU_SH7750]	= "SH7750",	[CPU_SH7750S]	= "SH7750S",
-	[CPU_SH7750R]	= "SH7750R",	[CPU_SH7751]	= "SH7751",
-	[CPU_SH7751R]	= "SH7751R",	[CPU_SH7760]	= "SH7760",
-	[CPU_SH4_202]	= "SH4-202",	[CPU_SH4_501]	= "SH4-501",
-	[CPU_SH7763]	= "SH7763",	[CPU_SH7770]	= "SH7770",
-	[CPU_SH7780]	= "SH7780",	[CPU_SH7781]	= "SH7781",
-	[CPU_SH7343]	= "SH7343",	[CPU_SH7785]	= "SH7785",
-	[CPU_SH7722]	= "SH7722",	[CPU_SHX3]	= "SH-X3",
-	[CPU_SH5_101]	= "SH5-101",	[CPU_SH5_103]	= "SH5-103",
-	[CPU_MXG]	= "MX-G",
-	[CPU_SH7366]	= "SH7366",	[CPU_SH_NONE]	= "Unknown"
-};
+static int __init devices_setup(void)
+{
+	int ret = 0;
+
+	if (sh_cv.devices)
+		ret = platform_add_devices(sh_cv.devices, sh_cv.nr_devices);
+	if (!ret && sh_cv.setup_devices)
+		ret = sh_cv.setup_devices();
+
+	return ret;
+}
+__initcall(devices_setup);
 
 const char *get_cpu_subtype(struct sh_cpuinfo *c)
 {
-	return cpu_name[c->type];
+	return sh_cv.name;
 }
 
 #ifdef CONFIG_PROC_FS
--- 0001/arch/sh/kernel/vmlinux_32.lds.S
+++ work/arch/sh/kernel/vmlinux_32.lds.S	2008-04-01 17:57:19.000000000 +0900
@@ -112,6 +112,11 @@ SECTIONS
 #endif
 
 	. = ALIGN(4);
+	__cpuvec_start = .;
+	.cpuvec.init : { *(.cpuvec.init) }
+	__cpuvec_end = .;
+
+	. = ALIGN(4);
 	__machvec_start = .;
 	.machvec.init : { *(.machvec.init) }
 	__machvec_end = .;
--- 0001/arch/sh/kernel/vmlinux_64.lds.S
+++ work/arch/sh/kernel/vmlinux_64.lds.S	2008-04-01 18:12:41.000000000 +0900
@@ -124,6 +124,11 @@ SECTIONS
 #endif
 
 	. = ALIGN(8);
+	__cpuvec_start = .;
+	.cpuvec.init : C_PHYS(.cpuvec.init) { *(.cpuvec.init) }
+	__cpuvec_end = .;
+
+	. = ALIGN(8);
 	__machvec_start = .;
 	.machvec.init : C_PHYS(.machvec.init) { *(.machvec.init) }
 	__machvec_end = .;
--- 0001/arch/sh/mm/numa.c
+++ work/arch/sh/mm/numa.c	2008-04-01 17:04:31.000000000 +0900
@@ -13,6 +13,7 @@
 #include <linux/numa.h>
 #include <linux/pfn.h>
 #include <asm/sections.h>
+#include <asm/cpuvec.h>
 
 static bootmem_data_t plat_node_bdata[MAX_NUMNODES];
 struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
@@ -41,7 +42,8 @@ void __init setup_memory(void)
 	setup_bootmem_allocator(free_pfn);
 
 	/* Give the platforms a chance to hook up their nodes */
-	plat_mem_setup();
+	if (sh_cv.setup_mem)
+		sh_cv.setup_mem();
 }
 
 void __init setup_bootmem_node(int nid, unsigned long start, unsigned long end)
--- /dev/null
+++ work/include/asm-sh/cpuvec.h	2008-04-01 18:27:33.000000000 +0900
@@ -0,0 +1,37 @@
+/*
+ * include/asm-sh/cpuhvec.h
+ *
+ * Copyright 2008 Magnus Damm
+ *
+ * May be copied or modified under the terms of the GNU General Public
+ * License.  See linux/COPYING for more information.
+ */
+
+#ifndef _ASM_SH_CPUVEC_H
+#define _ASM_SH_CPUVEC_H
+
+#include <linux/types.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <asm/processor.h>
+
+struct sh_cpu_vector {
+	enum cpu_type type;
+	char name[8];
+
+	struct platform_device **devices;
+	unsigned int nr_devices;
+	struct intc_desc *intc;
+
+	int (*setup_devices)(void);
+	int (*setup_irq)(void);
+	void (*setup_irq_pins)(int mode);
+	void (*setup_mem)(void);
+};
+
+extern struct sh_cpu_vector sh_cv;
+
+#define __initcv \
+	__used __section(.cpuvec.init)
+
+#endif /* _ASM_SH_CPUVEC_H */
--- 0001/include/asm-sh/hw_irq.h
+++ work/include/asm-sh/hw_irq.h	2008-04-01 18:16:16.000000000 +0900
@@ -94,8 +94,6 @@ struct intc_desc symbol __initdata = {		
 void __init register_intc_controller(struct intc_desc *desc);
 int intc_set_priority(unsigned int irq, unsigned int prio);
 
-void __init plat_irq_setup(void);
-
 enum { IRQ_MODE_IRQ, IRQ_MODE_IRQ7654, IRQ_MODE_IRQ3210,
        IRQ_MODE_IRL7654_MASK, IRQ_MODE_IRL3210_MASK,
        IRQ_MODE_IRL7654, IRQ_MODE_IRL3210 };
--- 0001/include/asm-sh/mmzone.h
+++ work/include/asm-sh/mmzone.h	2008-04-01 16:51:04.000000000 +0900
@@ -36,9 +36,6 @@ setup_bootmem_node(int nid, unsigned lon
 }
 #endif /* CONFIG_NEED_MULTIPLE_NODES */
 
-/* Platform specific mem init */
-void __init plat_mem_setup(void);
-
 /* arch/sh/kernel/setup.c */
 void __init setup_bootmem_allocator(unsigned long start_pfn);
 
--- 0001/include/asm-sh/sections.h
+++ work/include/asm-sh/sections.h	2008-04-01 17:58:36.000000000 +0900
@@ -3,6 +3,7 @@
 
 #include <asm-generic/sections.h>
 
+extern long __cpuvec_start, __cpuvec_end;
 extern long __machvec_start, __machvec_end;
 extern char __uncached_start, __uncached_end;
 extern char _ebss[];
--- 0001/include/asm-sh/setup.h
+++ work/include/asm-sh/setup.h	2008-04-01 17:29:34.000000000 +0900
@@ -20,6 +20,7 @@
 #define COMMAND_LINE ((char *) (PARAM+0x100))
 
 int setup_early_printk(char *);
+void sh_cv_setup(void);
 void sh_mv_setup(void);
 
 #endif /* __KERNEL__ */
