From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Thu, 10 Jan 2013 10:16:43 +0000
Subject: [PATCH 1/2] ARM: mach-shmobile: add shmobile_cpu_disable_any()
Message-Id: <1357813004-9549-2-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Method to disable any core to be used on platforms where CPU0 does not
need special treatment.

Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
---
 arch/arm/mach-shmobile/hotplug.c             |    6 ++++++
 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/mach-shmobile/hotplug.c b/arch/arm/mach-shmobile/hotplug.c
index b09a0bd..a1524e3 100644
--- a/arch/arm/mach-shmobile/hotplug.c
+++ b/arch/arm/mach-shmobile/hotplug.c
@@ -56,6 +56,12 @@ int shmobile_cpu_disable(unsigned int cpu)
 	return cpu = 0 ? -EPERM : 0;
 }
 
+int shmobile_cpu_disable_any(unsigned int cpu)
+{
+	cpumask_clear_cpu(cpu, &dead_cpus);
+	return 0;
+}
+
 int shmobile_cpu_is_dead(unsigned int cpu)
 {
 	return cpumask_test_cpu(cpu, &dead_cpus);
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index dfeca79..d22ea86 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -73,6 +73,7 @@ static inline int shmobile_cpuidle_init(void) { return 0; }
 
 extern void shmobile_cpu_die(unsigned int cpu);
 extern int shmobile_cpu_disable(unsigned int cpu);
+extern int shmobile_cpu_disable_any(unsigned int cpu);
 
 #ifdef CONFIG_HOTPLUG_CPU
 extern int shmobile_cpu_is_dead(unsigned int cpu);
-- 
1.7.10.4

