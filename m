From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 07 Jul 2011 13:32:29 +0000
Subject: [PATCH 02/05] ARM: mach-shmobile: Runtime PM late init callback
Message-Id: <20110707133229.22347.51430.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add a mach-shmobile specific callback for SoC-specific code
to hook into. By having the late_initcall() in a common place
we can have multi-SoC/board support in the same kernel binary.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 arch/arm/mach-shmobile/pm_runtime.c          |   10 ++++++++++
 2 files changed, 11 insertions(+)

--- 0001/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2011-07-07 19:39:49.000000000 +0900
@@ -12,6 +12,7 @@ extern struct platform_suspend_ops shmob
 struct cpuidle_device;
 extern void (*shmobile_cpuidle_modes[])(void);
 extern void (*shmobile_cpuidle_setup)(struct cpuidle_device *dev);
+extern void (*shmobile_runtime_pm_late_init)(void);
 
 extern void sh7367_init_irq(void);
 extern void sh7367_add_early_devices(void);
--- 0001/arch/arm/mach-shmobile/pm_runtime.c
+++ work/arch/arm/mach-shmobile/pm_runtime.c	2011-07-07 19:39:28.000000000 +0900
@@ -56,3 +56,13 @@ static int __init sh_pm_runtime_init(voi
 	return 0;
 }
 core_initcall(sh_pm_runtime_init);
+
+void (*shmobile_runtime_pm_late_init)(void);
+
+static int __init sh_pm_runtime_late_init(void)
+{
+	if (shmobile_runtime_pm_late_init)
+		shmobile_runtime_pm_late_init();
+	return 0;
+}
+late_initcall(sh_pm_runtime_late_init);
