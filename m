From: Rich Felker <dalias@libc.org>
Date: Fri, 20 May 2016 02:53:04 +0000
Subject: [PATCH v2 06/12] sh: add support for J-Core J2 processor
Message-Id: <4e405c44d2f963c5baefe6cb881c3425fb7db1dd.1463708766.git.dalias@libc.org>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1463708766.git.dalias@libc.org>
In-Reply-To: <cover.1463708766.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Rich Felker <dalias@libc.org>
---
This revision of the patch is less invasive than the previous one,
moving J2-specific cache init from  arch/sh/kernel/cpu/init.c to
arch/sh/kernel/cpu/sh2/probe.c. Unnecessary variable cpu-offset for
CCR register has also been removed.

 arch/sh/Kconfig                 |  8 ++++++
 arch/sh/Makefile                |  1 +
 arch/sh/include/asm/processor.h |  2 +-
 arch/sh/kernel/cpu/init.c       |  2 +-
 arch/sh/kernel/cpu/proc.c       |  1 +
 arch/sh/kernel/cpu/sh2/entry.S  |  5 ++++
 arch/sh/kernel/cpu/sh2/probe.c  | 34 +++++++++++++++++++++++-
 arch/sh/mm/Makefile             |  3 ++-
 arch/sh/mm/cache-j2.c           | 58 +++++++++++++++++++++++++++++++++++++++++
 arch/sh/mm/cache.c              |  6 ++++-
 10 files changed, 115 insertions(+), 5 deletions(-)
 create mode 100644 arch/sh/mm/cache-j2.c

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 4fa5894..efb0af4 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -182,6 +182,10 @@ config CPU_SH2A
 	select CPU_SH2
 	select UNCACHED_MAPPING
 
+config CPU_J2
+	bool
+	select CPU_SH2
+
 config CPU_SH3
 	bool
 	select CPU_HAS_INTEVT
@@ -248,6 +252,10 @@ config CPU_SUBTYPE_SH7619
 	select CPU_SH2
 	select SYS_SUPPORTS_SH_CMT
 
+config CPU_SUBTYPE_J2
+	bool "Support J2 processor"
+	select CPU_J2
+
 # SH-2A Processor Support
 
 config CPU_SUBTYPE_SH7201
diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index 3b2c8b4..0047666 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -31,6 +31,7 @@ isa-y					:= $(isa-y)-up
 endif
 
 cflags-$(CONFIG_CPU_SH2)		:= $(call cc-option,-m2,)
+cflags-$(CONFIG_CPU_J2)			:= $(call cc-option,-mj2,)
 cflags-$(CONFIG_CPU_SH2A)		+= $(call cc-option,-m2a,) \
 					   $(call cc-option,-m2a-nofpu,) \
 					   $(call cc-option,-m4-nofpu,)
diff --git a/arch/sh/include/asm/processor.h b/arch/sh/include/asm/processor.h
index 1506897..f9a0994 100644
--- a/arch/sh/include/asm/processor.h
+++ b/arch/sh/include/asm/processor.h
@@ -15,7 +15,7 @@
  */
 enum cpu_type {
 	/* SH-2 types */
-	CPU_SH7619,
+	CPU_SH7619, CPU_J2,
 
 	/* SH-2A types */
 	CPU_SH7201, CPU_SH7203, CPU_SH7206, CPU_SH7263, CPU_SH7264, CPU_SH7269,
diff --git a/arch/sh/kernel/cpu/init.c b/arch/sh/kernel/cpu/init.c
index bfd9e27..c8b3be1 100644
--- a/arch/sh/kernel/cpu/init.c
+++ b/arch/sh/kernel/cpu/init.c
@@ -106,7 +106,7 @@ void __attribute__ ((weak)) l2_cache_init(void)
 /*
  * Generic first-level cache init
  */
-#ifdef CONFIG_SUPERH32
+#if defined(CONFIG_SUPERH32) && !defined(CONFIG_CPU_J2)
 static void cache_init(void)
 {
 	unsigned long ccr, flags;
diff --git a/arch/sh/kernel/cpu/proc.c b/arch/sh/kernel/cpu/proc.c
index 9e6624c..4df4b28 100644
--- a/arch/sh/kernel/cpu/proc.c
+++ b/arch/sh/kernel/cpu/proc.c
@@ -27,6 +27,7 @@ static const char *cpu_name[] = {
 	[CPU_MXG]	= "MX-G",	[CPU_SH7723]	= "SH7723",
 	[CPU_SH7366]	= "SH7366",	[CPU_SH7724]	= "SH7724",
 	[CPU_SH7372]	= "SH7372",	[CPU_SH7734]	= "SH7734",
+	[CPU_J2]	= "J2",
 	[CPU_SH_NONE]	= "Unknown"
 };
 
diff --git a/arch/sh/kernel/cpu/sh2/entry.S b/arch/sh/kernel/cpu/sh2/entry.S
index a150595..354f344 100644
--- a/arch/sh/kernel/cpu/sh2/entry.S
+++ b/arch/sh/kernel/cpu/sh2/entry.S
@@ -147,6 +147,11 @@ ENTRY(exception_handler)
 	mov	#31,r8
 	cmp/hs	r8,r9
 	bt	trap_entry	! 64 > vec >= 31  is trap
+	mov	#16,r8
+#ifdef CONFIG_CPU_J2
+	cmp/hs	r8,r9
+	bt	interrupt_entry	! 31 > vec >= 16 is interrupt
+#endif
 
 	mov.l	4f,r8
 	mov	r9,r4
diff --git a/arch/sh/kernel/cpu/sh2/probe.c b/arch/sh/kernel/cpu/sh2/probe.c
index 6c687ae..3dd8187 100644
--- a/arch/sh/kernel/cpu/sh2/probe.c
+++ b/arch/sh/kernel/cpu/sh2/probe.c
@@ -10,10 +10,27 @@
  * for more details.
  */
 #include <linux/init.h>
+#include <linux/of_fdt.h>
+#include <linux/smp.h>
+#include <linux/io.h>
 #include <asm/processor.h>
 #include <asm/cache.h>
 
-void cpu_probe(void)
+#if defined(CONFIG_CPU_J2)
+extern u32 j2_ccr_base;
+static int __init scan_cache(unsigned long node, const char *uname,
+			     int depth, void *data)
+{
+	if (!of_flat_dt_is_compatible(node, "jcore,cache"))
+		return 0;
+
+	j2_ccr_base = of_flat_dt_translate_address(node);
+
+	return 1;
+}
+#endif
+
+void __ref cpu_probe(void)
 {
 #if defined(CONFIG_CPU_SUBTYPE_SH7619)
 	boot_cpu_data.type			= CPU_SH7619;
@@ -24,10 +41,25 @@ void cpu_probe(void)
 	boot_cpu_data.dcache.linesz		= L1_CACHE_BYTES;
 	boot_cpu_data.dcache.flags		= 0;
 #endif
+
+#if defined(CONFIG_CPU_J2)
+	unsigned cpu = hard_smp_processor_id();
+	if (cpu = 0) of_scan_flat_dt(scan_cache, NULL);
+	if (j2_ccr_base) __raw_writel(0x80000303, j2_ccr_base + 4*cpu);
+	if (cpu != 0) return;
+	boot_cpu_data.type			= CPU_J2;
+	/* FIXME: cache properties should come from device tree. */
+	boot_cpu_data.dcache.ways		= 1;
+	boot_cpu_data.dcache.sets		= 256;
+	boot_cpu_data.dcache.entry_shift	= 5;
+	boot_cpu_data.dcache.linesz		= 32;
+	boot_cpu_data.dcache.flags		= 0;
+#else
 	/*
 	 * SH-2 doesn't have separate caches
 	 */
 	boot_cpu_data.dcache.flags |= SH_CACHE_COMBINED;
+#endif
 	boot_cpu_data.icache = boot_cpu_data.dcache;
 	boot_cpu_data.family = CPU_FAMILY_SH2;
 }
diff --git a/arch/sh/mm/Makefile b/arch/sh/mm/Makefile
index cee6b99..92c3bd9 100644
--- a/arch/sh/mm/Makefile
+++ b/arch/sh/mm/Makefile
@@ -4,7 +4,8 @@
 
 obj-y			:= alignment.o cache.o init.o consistent.o mmap.o
 
-cacheops-$(CONFIG_CPU_SH2)		:= cache-sh2.o
+cacheops-$(CONFIG_CPU_J2)		:= cache-j2.o
+cacheops-$(CONFIG_CPU_SUBTYPE_SH7619)	:= cache-sh2.o
 cacheops-$(CONFIG_CPU_SH2A)		:= cache-sh2a.o
 cacheops-$(CONFIG_CPU_SH3)		:= cache-sh3.o
 cacheops-$(CONFIG_CPU_SH4)		:= cache-sh4.o flush-sh4.o
diff --git a/arch/sh/mm/cache-j2.c b/arch/sh/mm/cache-j2.c
new file mode 100644
index 0000000..baf36d3
--- /dev/null
+++ b/arch/sh/mm/cache-j2.c
@@ -0,0 +1,58 @@
+/*
+ * arch/sh/mm/cache-j2.c
+ *
+ * Copyright (C) 2015 SEI
+ *
+ * Released under the terms of the GNU GPL v2.0.
+ */
+
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/cpumask.h>
+
+#include <asm/cache.h>
+#include <asm/addrspace.h>
+#include <asm/processor.h>
+#include <asm/cacheflush.h>
+#include <asm/io.h>
+
+u32 j2_ccr_base;
+
+static void j2_flush_icache(void *args)
+{
+	unsigned cpu;
+	for_each_possible_cpu(cpu)
+		__raw_writel(0x80000103, j2_ccr_base + 4*cpu);
+}
+
+static void j2_flush_dcache(void *args)
+{
+	unsigned cpu;
+	for_each_possible_cpu(cpu)
+		__raw_writel(0x80000203, j2_ccr_base + 4*cpu);
+}
+
+static void j2_flush_both(void *args)
+{
+	unsigned cpu;
+	for_each_possible_cpu(cpu)
+		__raw_writel(0x80000303, j2_ccr_base + 4*cpu);
+}
+
+void __init j2_cache_init(void)
+{
+	if (!j2_ccr_base)
+		return;
+
+	local_flush_cache_all = j2_flush_both;
+	local_flush_cache_mm = j2_flush_both;
+	local_flush_cache_dup_mm = j2_flush_both;
+	local_flush_cache_page = j2_flush_both;
+	local_flush_cache_range = j2_flush_both;
+	local_flush_dcache_page = j2_flush_dcache;
+	local_flush_icache_range = j2_flush_icache;
+	local_flush_icache_page = j2_flush_icache;
+	local_flush_cache_sigtramp = j2_flush_icache;
+
+	pr_info("Initial J2 CCR is %.8x\n", __raw_readl(j2_ccr_base));
+}
diff --git a/arch/sh/mm/cache.c b/arch/sh/mm/cache.c
index 776d664..70cc52f 100644
--- a/arch/sh/mm/cache.c
+++ b/arch/sh/mm/cache.c
@@ -309,7 +309,11 @@ void __init cpu_cache_init(void)
 	if (unlikely(cache_disabled))
 		goto skip;
 
-	if (boot_cpu_data.family = CPU_FAMILY_SH2) {
+	if (boot_cpu_data.type = CPU_J2) {
+		extern void __weak j2_cache_init(void);
+
+		j2_cache_init();
+	} else if (boot_cpu_data.family = CPU_FAMILY_SH2) {
 		extern void __weak sh2_cache_init(void);
 
 		sh2_cache_init();
-- 
2.8.1


