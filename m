From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 10 May 2012 07:26:58 +0000
Subject: [PATCH 1/2 v2] mach-shmobile: sh73a0 SMP TWD boot regression fix
Message-Id: <877gwkpkch.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Fix SMP TWD boot regression on sh73a0 based platforms caused by:

4200b16 ARM: shmobile: convert to twd_local_timer_register() interface

After the merge of the above commit it has been impossible to boot
sh73a0 based SoCs with SMP enabled and CONFIG_HAVE_ARM_TWD=y. The
kernel crashes at smp_init_cpus() timing which is before the console
has been initialized, so to the user this looks like a kernel lock up
without any particular error message.

This patch fixes the regression on sh73a0 by moving the TWD
registration code from smp_init_cpus() to sys_timer->init() time.

This patch removed shmobile_twd_init() which is no longer needed

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Magnus Damm <damm@opensource.se>
---
v1 -> v2
 - removed shmobile_twd_init() from header

 Fixes 3.4-rc regression.

 Tested on the kzm9g board

 arch/arm/mach-shmobile/include/mach/common.h |    1 -
 arch/arm/mach-shmobile/setup-sh73a0.c        |    4 ++++
 arch/arm/mach-shmobile/smp-sh73a0.c          |    7 ++++++-
 arch/arm/mach-shmobile/timer.c               |    9 ---------
 4 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 18ac825..c85e6ec 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -4,7 +4,6 @@
 extern void shmobile_earlytimer_init(void);
 extern struct sys_timer shmobile_timer;
 struct twd_local_timer;
-void shmobile_twd_init(struct twd_local_timer *twd_local_timer);
 extern void shmobile_setup_console(void);
 extern void shmobile_secondary_vector(void);
 extern int shmobile_platform_cpu_kill(unsigned int cpu);
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 5bebffc..04a0dfe 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -688,10 +688,14 @@ void __init sh73a0_add_standard_devices(void)
 			    ARRAY_SIZE(sh73a0_late_devices));
 }
 
+/* do nothing for !CONFIG_SMP or !CONFIG_HAVE_TWD */
+void __init __weak sh73a0_register_twd(void) { }
+
 static void __init sh73a0_earlytimer_init(void)
 {
 	sh73a0_clock_init();
 	shmobile_earlytimer_init();
+	sh73a0_register_twd();
 }
 
 void __init sh73a0_add_early_devices(void)
diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index 14ad8b05..e36c41c 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -42,7 +42,13 @@ static void __iomem *scu_base_addr(void)
 static DEFINE_SPINLOCK(scu_lock);
 static unsigned long tmp;
 
+#ifdef CONFIG_HAVE_ARM_TWD
 static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, 0xf0000600, 29);
+void __init sh73a0_register_twd(void)
+{
+	twd_local_timer_register(&twd_local_timer);
+}
+#endif
 
 static void modify_scu_cpu_psr(unsigned long set, unsigned long clr)
 {
@@ -62,7 +68,6 @@ unsigned int __init sh73a0_get_core_count(void)
 {
 	void __iomem *scu_base = scu_base_addr();
 
-	shmobile_twd_init(&twd_local_timer);
 	return scu_get_core_count(scu_base);
 }
 
diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
index 2fba5f3..8b79e79 100644
--- a/arch/arm/mach-shmobile/timer.c
+++ b/arch/arm/mach-shmobile/timer.c
@@ -46,15 +46,6 @@ static void __init shmobile_timer_init(void)
 {
 }
 
-void __init shmobile_twd_init(struct twd_local_timer *twd_local_timer)
-{
-#ifdef CONFIG_HAVE_ARM_TWD
-	int err = twd_local_timer_register(twd_local_timer);
-	if (err)
-		pr_err("twd_local_timer_register failed %d\n", err);
-#endif
-}
-
 struct sys_timer shmobile_timer = {
 	.init		= shmobile_timer_init,
 };
-- 
1.7.5.4

