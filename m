From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 14 Sep 2013 14:15:34 +0000
Subject: [PATCH 01/02] ARM: shmobile: Extend SCU CPU notifier to handle CPUIdle
Message-Id: <20130914141534.19348.12232.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Register CPUIdle boot vector via CPU notifiers in the
mach-shmobile SCU SMP code.

Not-Yet-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/platsmp-scu.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

--- 0008/arch/arm/mach-shmobile/platsmp-scu.c
+++ work/arch/arm/mach-shmobile/platsmp-scu.c	2013-09-14 22:21:14.000000000 +0900
@@ -22,12 +22,27 @@ static int shmobile_smp_scu_notifier_cal
 {
 	unsigned int cpu = (long)hcpu;
 
+	/* During SMP boot and for CPU Hotplug, use CPU_UP_PREPARE
+	 * to register boot vector. Runtime CPU power management
+	 * via a separate CPUIdle driver requires a different boot
+	 * vector which is installed at CPU_ONLINE time.
+	 */
+
 	switch (action) {
 	case CPU_UP_PREPARE:
 		/* For this particular CPU register SCU SMP boot vector */
 		shmobile_smp_hook(cpu, virt_to_phys(shmobile_boot_scu),
 				  (unsigned long)shmobile_scu_base);
 		break;
+ 	case CPU_UP_CANCELED:
+ 	case CPU_POST_DEAD:
+		/* Unregister boot vector */
+		shmobile_smp_hook(cpu, 0, 0);
+ 		break;
+ 	case CPU_ONLINE:
+		/* Register CPUIdle boot vector */
+		shmobile_smp_hook(cpu, virt_to_phys(cpu_resume), 0);
+ 		break;
 	};
 
 	return NOTIFY_OK;
@@ -49,14 +64,14 @@ void __init shmobile_smp_scu_prepare_cpu
 
 	/* Use CPU notifier for reset vector control */
 	register_cpu_notifier(&shmobile_smp_scu_notifier);
+
+	/* Make sure boot CPU also gets CPUIdle initialized */
+	shmobile_smp_scu_notifier_call(NULL, CPU_ONLINE, 0);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
 void shmobile_smp_scu_cpu_die(unsigned int cpu)
 {
-	/* For this particular CPU deregister boot vector */
-	shmobile_smp_hook(cpu, 0, 0);
-
 	dsb();
 	flush_cache_all();
 
