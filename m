From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 28 Dec 2011 07:53:16 +0000
Subject: [PATCH] ARM: mach-shmobile: Flush caches in platform_cpu_die()
Message-Id: <20111228075316.14252.77646.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add cache flushing code to the SH-Mobile specific CPU hotplug
implementation. While at it, add a cpu mask to make sure the
cache flushing code is finished in platform_cpu_die() before
letting the SoC-specific code in shmobile_platform_cpu_kill()
proceed with turning off power.

Without this code CPU hotplug offline fails when cache is
enabled on Cortex-A9 based SoCs.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/hotplug.c |   31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

--- 0024/arch/arm/mach-shmobile/hotplug.c
+++ work/arch/arm/mach-shmobile/hotplug.c	2011-12-28 16:07:12.000000000 +0900
@@ -12,15 +12,43 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/smp.h>
+#include <linux/cpumask.h>
+#include <linux/delay.h>
 #include <mach/common.h>
+#include <asm/cacheflush.h>
+
+static cpumask_t dead_cpus;
 
 int platform_cpu_kill(unsigned int cpu)
 {
-	return shmobile_platform_cpu_kill(cpu);
+	int k;
+
+	/* this function is running on another CPU than the offline target,
+	 * here we need wait for shutdown code in platform_cpu_die() to
+	 * finish before asking SoC-specific code to power off the CPU core.
+	 */
+	for (k = 0; k < 1000; k++) {
+		if (cpumask_test_cpu(cpu, &dead_cpus))
+			return shmobile_platform_cpu_kill(cpu);
+
+		mdelay(1);
+	}
+
+	return 0;
 }
 
 void platform_cpu_die(unsigned int cpu)
 {
+	/* hardware shutdown code running on the CPU that is being offlined */
+	flush_cache_all();
+	dsb();
+
+	/* notify platform_cpu_kill() that hardware shutdown is finished */
+	cpumask_set_cpu(cpu, &dead_cpus);
+
+	/* wait for SoC code in platform_cpu_kill() to shut off CPU core
+	 * power. CPU bring up starts from the reset vector.
+	 */
 	while (1) {
 		/*
 		 * here's the WFI
@@ -34,6 +62,7 @@ void platform_cpu_die(unsigned int cpu)
 
 int platform_cpu_disable(unsigned int cpu)
 {
+	cpumask_clear_cpu(cpu, &dead_cpus);
 	/*
 	 * we don't allow CPU 0 to be shutdown (it is still too special
 	 * e.g. clock tick interrupts)
