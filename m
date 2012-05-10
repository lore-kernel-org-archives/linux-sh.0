From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 10 May 2012 05:57:22 +0000
Subject: [PATCH] mach-shmobile: r8a7779 SMP TWD boot regression fix
Message-Id: <20120510055722.29862.28709.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Fix SMP TWD boot regression on r8a7779 based platforms caused by:

4200b16 ARM: shmobile: convert to twd_local_timer_register() interface

After the merge of the above commit it has been impossible to boot
r8a7779 based SoCs with SMP enabled and CONFIG_HAVE_ARM_TWD=y. The
kernel crashes at smp_init_cpus() timing which is before the console
has been initialized, so to the user this looks like a kernel lock up
without any particular error message.

This patch fixes the regression on r8a7779 by moving the TWD
registration code from smp_init_cpus() to sys_timer->init() time. 

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Fixes 3.4-rc regression.

 Tested on the r8a7779 Marzen board on top of post v3.4-rc6:
 7ee94d97aafacf5a019b3578e0eae6daa2e2bcd5

 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 arch/arm/mach-shmobile/setup-r8a7779.c       |    4 ++++
 arch/arm/mach-shmobile/smp-r8a7779.c         |    8 +++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2012-05-10 14:27:12.000000000 +0900
@@ -82,5 +82,6 @@ extern int r8a7779_platform_cpu_kill(uns
 extern void r8a7779_secondary_init(unsigned int cpu);
 extern int r8a7779_boot_secondary(unsigned int cpu);
 extern void r8a7779_smp_prepare_cpus(void);
+extern void r8a7779_register_twd(void);
 
 #endif /* __ARCH_MACH_COMMON_H */
--- 0001/arch/arm/mach-shmobile/setup-r8a7779.c
+++ work/arch/arm/mach-shmobile/setup-r8a7779.c	2012-05-10 14:33:41.000000000 +0900
@@ -262,10 +262,14 @@ void __init r8a7779_add_standard_devices
 			    ARRAY_SIZE(r8a7779_late_devices));
 }
 
+/* do nothing for !CONFIG_SMP or !CONFIG_HAVE_TWD */
+void __init __weak r8a7779_register_twd(void) { }
+
 static void __init r8a7779_earlytimer_init(void)
 {
 	r8a7779_clock_init();
 	shmobile_earlytimer_init();
+	r8a7779_register_twd();
 }
 
 void __init r8a7779_add_early_devices(void)
--- 0001/arch/arm/mach-shmobile/smp-r8a7779.c
+++ work/arch/arm/mach-shmobile/smp-r8a7779.c	2012-05-10 14:31:32.000000000 +0900
@@ -64,8 +64,15 @@ static void __iomem *scu_base_addr(void)
 static DEFINE_SPINLOCK(scu_lock);
 static unsigned long tmp;
 
+#ifdef CONFIG_HAVE_ARM_TWD
 static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, 0xf0000600, 29);
 
+void __init r8a7779_register_twd(void)
+{
+	twd_local_timer_register(&twd_local_timer);
+}
+#endif
+
 static void modify_scu_cpu_psr(unsigned long set, unsigned long clr)
 {
 	void __iomem *scu_base = scu_base_addr();
@@ -84,7 +91,6 @@ unsigned int __init r8a7779_get_core_cou
 {
 	void __iomem *scu_base = scu_base_addr();
 
-	shmobile_twd_init(&twd_local_timer);
 	return scu_get_core_count(scu_base);
 }
 
