From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 28 Dec 2011 08:00:48 +0000
Subject: [PATCH] ARM: mach-shmobile: r8a7779 SMP support V2
Message-Id: <20111228080048.14276.91770.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20111222081730.12133.61045.sendpatchset@w520>
In-Reply-To: <20111222081730.12133.61045.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch contains r8a7779 SMP support V2 - now including
CPU hotplug offine and online support. The r8a7779 power
domain code is tied together with SMP glue code which allows
us to control the power domains via CPU hotplug.

At this point the kernel boots with the 4 Cortex-A9 cores in
SMP mode and all CPU cores except CPU0 can be hotplugged.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on the r8a7779 base plus the power domain code:
 [PATCH] ARM: mach-shmobile: r8a7779 power domain support

 Also needs the following SH-Mobile SMP / CPU hotplug changes:
 [PATCH] ARM: mach-shmobile: Fix headsmp.S code to use CPUINIT
 [PATCH] ARM: mach-shmobile: Allow SoC specific CPU kill code
 [PATCH] ARM: mach-shmobile: Flush caches in platform_cpu_die() 

 arch/arm/mach-shmobile/Makefile               |    1 
 arch/arm/mach-shmobile/include/mach/common.h  |    6 
 arch/arm/mach-shmobile/include/mach/r8a7779.h |    3 
 arch/arm/mach-shmobile/platsmp.c              |   16 ++
 arch/arm/mach-shmobile/pm-r8a7779.c           |   30 +++-
 arch/arm/mach-shmobile/smp-r8a7779.c          |  153 +++++++++++++++++++++++++
 6 files changed, 201 insertions(+), 8 deletions(-)

--- 0022/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2011-12-28 14:52:24.000000000 +0900
@@ -17,6 +17,7 @@ smp-y				:= platsmp.o headsmp.o
 smp-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
 smp-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
 smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o
+smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o
 
 # Pinmux setup
 pfc-y				:--- 0024/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2011-12-28 14:54:31.000000000 +0900
@@ -61,4 +61,10 @@ extern void r8a7779_clock_init(void);
 extern void r8a7779_pinmux_init(void);
 extern void r8a7779_pm_init(void);
 
+extern unsigned int r8a7779_get_core_count(void);
+extern int r8a7779_platform_cpu_kill(unsigned int cpu);
+extern void r8a7779_secondary_init(unsigned int cpu);
+extern int r8a7779_boot_secondary(unsigned int cpu);
+extern void r8a7779_smp_prepare_cpus(void);
+
 #endif /* __ARCH_MACH_COMMON_H */
--- 0022/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a7779.h	2011-12-28 14:52:24.000000000 +0900
@@ -343,6 +343,9 @@ static inline struct r8a7779_pm_ch *to_r
 	return &container_of(d, struct r8a7779_pm_domain, genpd)->ch;
 }
 
+extern int r8a7779_sysc_power_down(struct r8a7779_pm_ch *r8a7779_ch);
+extern int r8a7779_sysc_power_up(struct r8a7779_pm_ch *r8a7779_ch);
+
 #ifdef CONFIG_PM
 extern struct r8a7779_pm_domain r8a7779_sh4a;
 extern struct r8a7779_pm_domain r8a7779_sgx;
--- 0024/arch/arm/mach-shmobile/platsmp.c
+++ work/arch/arm/mach-shmobile/platsmp.c	2011-12-28 14:53:23.000000000 +0900
@@ -22,12 +22,16 @@
 #include <mach/common.h>
 
 #define is_sh73a0() (machine_is_ag5evm() || machine_is_kota2())
+#define is_r8a7779() machine_is_marzen()
 
 static unsigned int __init shmobile_smp_get_core_count(void)
 {
 	if (is_sh73a0())
 		return sh73a0_get_core_count();
 
+	if (is_r8a7779())
+		return r8a7779_get_core_count();
+
 	return 1;
 }
 
@@ -35,10 +39,16 @@ static void __init shmobile_smp_prepare_
 {
 	if (is_sh73a0())
 		sh73a0_smp_prepare_cpus();
+
+	if (is_r8a7779())
+		r8a7779_smp_prepare_cpus();
 }
 
 int shmobile_platform_cpu_kill(unsigned int cpu)
 {
+	if (is_r8a7779())
+		return r8a7779_platform_cpu_kill(cpu);
+
 	return 1;
 }
 
@@ -48,6 +58,9 @@ void __cpuinit platform_secondary_init(u
 
 	if (is_sh73a0())
 		sh73a0_secondary_init(cpu);
+
+	if (is_r8a7779())
+		r8a7779_secondary_init(cpu);
 }
 
 int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
@@ -55,6 +68,9 @@ int __cpuinit boot_secondary(unsigned in
 	if (is_sh73a0())
 		return sh73a0_boot_secondary(cpu);
 
+	if (is_r8a7779())
+		return r8a7779_boot_secondary(cpu);
+
 	return -ENOSYS;
 }
 
--- 0022/arch/arm/mach-shmobile/pm-r8a7779.c
+++ work/arch/arm/mach-shmobile/pm-r8a7779.c	2011-12-28 15:06:42.000000000 +0900
@@ -48,7 +48,9 @@ static void __iomem *r8a7779_sysc_base;
 #define SYSCISR_RETRIES 1000
 #define SYSCISR_DELAY_US 1
 
-#ifdef CONFIG_PM
+#if defined(CONFIG_PM) || defined(CONFIG_SMP)
+
+static DEFINE_SPINLOCK(r8a7779_sysc_lock); /* SMP CPUs + I/O devices */
 
 static int r8a7779_sysc_pwr_on_off(struct r8a7779_pm_ch *r8a7779_ch,
 				   int sr_bit, int reg_offs)
@@ -86,9 +88,12 @@ static int r8a7779_sysc_update(struct r8
 	unsigned int isr_mask = 1 << r8a7779_ch->isr_bit;
 	unsigned int chan_mask = 1 << r8a7779_ch->chan_bit;
 	unsigned int status;
+	unsigned long flags;
 	int ret = 0;
 	int k;
 
+	spin_lock_irqsave(&r8a7779_sysc_lock, flags);
+
 	iowrite32(isr_mask, r8a7779_sysc_base + SYSCISCR);
 
 	do {
@@ -112,6 +117,8 @@ static int r8a7779_sysc_update(struct r8
 	iowrite32(isr_mask, r8a7779_sysc_base + SYSCISCR);
 
  out:
+	spin_unlock_irqrestore(&r8a7779_sysc_lock, flags);
+
 	pr_debug("r8a7779 power domain %d: %02x %02x %02x %02x %02x -> %d\n",
 		 r8a7779_ch->isr_bit, ioread32(r8a7779_sysc_base + PWRSR0),
 		 ioread32(r8a7779_sysc_base + PWRSR1),
@@ -121,12 +128,12 @@ static int r8a7779_sysc_update(struct r8
 	return ret;
 }
 
-static int r8a7779_sysc_power_down(struct r8a7779_pm_ch *r8a7779_ch)
+int r8a7779_sysc_power_down(struct r8a7779_pm_ch *r8a7779_ch)
 {
 	return r8a7779_sysc_update(r8a7779_ch, r8a7779_sysc_pwr_off);
 }
 
-static int r8a7779_sysc_power_up(struct r8a7779_pm_ch *r8a7779_ch)
+int r8a7779_sysc_power_up(struct r8a7779_pm_ch *r8a7779_ch)
 {
 	return r8a7779_sysc_update(r8a7779_ch, r8a7779_sysc_pwr_on);
 }
@@ -142,6 +149,14 @@ static void __init r8a7779_sysc_init(voi
 	iowrite32(0, r8a7779_sysc_base + SYSCIMR);
 }
 
+#else /* CONFIG_PM || CONFIG_SMP */
+
+static inline void r8a7779_sysc_init(void) {}
+
+#endif /* CONFIG_PM || CONFIG_SMP */
+
+#ifdef CONFIG_PM
+
 static int pd_power_down(struct generic_pm_domain *genpd)
 {
 	return r8a7779_sysc_power_down(to_r8a7779_ch(genpd));
@@ -223,13 +238,12 @@ struct r8a7779_pm_domain r8a7779_impx3  	}
 };
 
-#else /* CONFIG_PM */
-
-static inline void r8a7779_sysc_init(void) {}
-
 #endif /* CONFIG_PM */
 
 void __init r8a7779_pm_init(void)
 {
-	r8a7779_sysc_init();
+	static int once;
+
+	if (!once++)
+		r8a7779_sysc_init();
 }
--- /dev/null
+++ work/arch/arm/mach-shmobile/smp-r8a7779.c	2011-12-28 15:01:40.000000000 +0900
@@ -0,0 +1,153 @@
+/*
+ * SMP support for R-Mobile / SH-Mobile - r8a7779 portion
+ *
+ * Copyright (C) 2011  Renesas Solutions Corp.
+ * Copyright (C) 2011  Magnus Damm
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
+#include <linux/smp.h>
+#include <linux/spinlock.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <mach/common.h>
+#include <mach/r8a7779.h>
+#include <asm/smp_scu.h>
+#include <asm/smp_twd.h>
+#include <asm/hardware/gic.h>
+
+#define AVECR 0xfe700040
+
+static struct r8a7779_pm_ch r8a7779_ch_cpu1 = {
+	.chan_offs = 0x40, /* PWRSR0 .. PWRER0 */
+	.chan_bit = 1, /* ARM1 */
+	.isr_bit = 1, /* ARM1 */
+};
+
+static struct r8a7779_pm_ch r8a7779_ch_cpu2 = {
+	.chan_offs = 0x40, /* PWRSR0 .. PWRER0 */
+	.chan_bit = 2, /* ARM2 */
+	.isr_bit = 2, /* ARM2 */
+};
+
+static struct r8a7779_pm_ch r8a7779_ch_cpu3 = {
+	.chan_offs = 0x40, /* PWRSR0 .. PWRER0 */
+	.chan_bit = 3, /* ARM3 */
+	.isr_bit = 3, /* ARM3 */
+};
+
+static struct r8a7779_pm_ch *r8a7779_ch_cpu[4] = {
+	[1] = &r8a7779_ch_cpu1,
+	[2] = &r8a7779_ch_cpu2,
+	[3] = &r8a7779_ch_cpu3,
+};
+
+static void __iomem *scu_base_addr(void)
+{
+	return (void __iomem *)0xf0000000;
+}
+
+static DEFINE_SPINLOCK(scu_lock);
+static unsigned long tmp;
+
+static void modify_scu_cpu_psr(unsigned long set, unsigned long clr)
+{
+	void __iomem *scu_base = scu_base_addr();
+
+	spin_lock(&scu_lock);
+	tmp = __raw_readl(scu_base + 8);
+	tmp &= ~clr;
+	tmp |= set;
+	spin_unlock(&scu_lock);
+
+	/* disable cache coherency after releasing the lock */
+	__raw_writel(tmp, scu_base + 8);
+}
+
+unsigned int __init r8a7779_get_core_count(void)
+{
+	void __iomem *scu_base = scu_base_addr();
+
+#ifdef CONFIG_HAVE_ARM_TWD
+	/* twd_base needs to be initialized before percpu_timer_setup() */
+	twd_base = (void __iomem *)0xf0000600;
+#endif
+
+	return scu_get_core_count(scu_base);
+}
+
+int r8a7779_platform_cpu_kill(unsigned int cpu)
+{
+	struct r8a7779_pm_ch *ch = NULL;
+	int ret = -EIO;
+
+	cpu = cpu_logical_map(cpu);
+
+	/* disable cache coherency */
+	modify_scu_cpu_psr(3 << (cpu * 8), 0);
+
+	if (cpu < ARRAY_SIZE(r8a7779_ch_cpu))
+		ch = r8a7779_ch_cpu[cpu];
+
+	if (ch)
+		ret = r8a7779_sysc_power_down(ch);
+
+	return ret ? ret : 1;
+}
+
+void __cpuinit r8a7779_secondary_init(unsigned int cpu)
+{
+	gic_secondary_init(0);
+}
+
+int __cpuinit r8a7779_boot_secondary(unsigned int cpu)
+{
+	struct r8a7779_pm_ch *ch = NULL;
+	int ret = -EIO;
+
+	cpu = cpu_logical_map(cpu);
+
+	/* enable cache coherency */
+	modify_scu_cpu_psr(0, 3 << (cpu * 8));
+
+	if (cpu < ARRAY_SIZE(r8a7779_ch_cpu))
+		ch = r8a7779_ch_cpu[cpu];
+
+	if (ch)
+		ret = r8a7779_sysc_power_up(ch);
+
+	return ret;
+}
+
+void __init r8a7779_smp_prepare_cpus(void)
+{
+	int cpu = cpu_logical_map(0);
+
+	scu_enable(scu_base_addr());
+
+	/* Map the reset vector (in headsmp.S) */
+	__raw_writel(__pa(shmobile_secondary_vector), __io(AVECR));
+
+	/* enable cache coherency on CPU0 */
+	modify_scu_cpu_psr(0, 3 << (cpu * 8));
+
+	r8a7779_pm_init();
+
+	/* power off secondary CPUs */
+	r8a7779_platform_cpu_kill(1);
+	r8a7779_platform_cpu_kill(2);
+	r8a7779_platform_cpu_kill(3);
+}
