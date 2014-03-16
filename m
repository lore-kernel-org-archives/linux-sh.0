From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 16 Mar 2014 21:35:39 +0000
Subject: [PATCH 02/06] ARM: shmobile: Install CPUIdle reset vector
Message-Id: <20140316213539.15598.7228.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Install CPU reset vector for CPUIdle operation.

Not-Yet-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/cpuidle.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

--- 0001/arch/arm/mach-shmobile/cpuidle.c
+++ work/arch/arm/mach-shmobile/cpuidle.c
@@ -8,6 +8,7 @@
  * for more details.
  */
 
+#include <linux/cpu.h>
 #include <linux/pm.h>
 #include <linux/cpuidle.h>
 #include <linux/suspend.h>
@@ -15,6 +16,26 @@
 #include <linux/err.h>
 #include <asm/cpuidle.h>
 #include <asm/io.h>
+#include <mach/common.h>
+
+static int shmobile_cpuidle_notifier_call(struct notifier_block *nfb,
+					  unsigned long action, void *hcpu)
+{
+	unsigned int cpu = (long)hcpu;
+
+	switch (action) {
+	case CPU_ONLINE:
+		/* For this particular CPU register CPUIdle boot vector */
+		shmobile_smp_hook(cpu, virt_to_phys(cpu_resume), 0);
+		break;
+	};
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block shmobile_cpuidle_notifier = {
+	.notifier_call = shmobile_cpuidle_notifier_call,
+};
 
 static struct cpuidle_driver shmobile_cpuidle_default_driver = {
 	.name			= "shmobile_cpuidle",
@@ -33,5 +54,11 @@ void __init shmobile_cpuidle_set_driver(
 
 int __init shmobile_cpuidle_init(void)
 {
+	/* Use CPU notifier for reset vector control */
+	register_cpu_notifier(&shmobile_cpuidle_notifier);
+
+	/* Make sure boot CPU also gets CPUIdle initialized */
+	shmobile_cpuidle_notifier_call(NULL, CPU_ONLINE, 0);
+
 	return cpuidle_register(cpuidle_drv, NULL);
 }
