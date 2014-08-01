From: keita kobayashi <keita.kobayashi.ym@renesas.com>
Date: Fri, 01 Aug 2014 09:48:52 +0000
Subject: [PATCH 5/6] ARM: shmobile: Add CPU notifier for CPUIdle boot vector
Message-Id: <53DB6284.3090506@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org
Cc: horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, rjw@rjwysocki.net

Add CPU notifiers for the shared mach-shmobile cpuidle code.

Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
---
 arch/arm/mach-shmobile/cpuidle.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/mach-shmobile/cpuidle.c b/arch/arm/mach-shmobile/cpuidle.c
index 19c0c98..1771dd3 100644
--- a/arch/arm/mach-shmobile/cpuidle.c
+++ b/arch/arm/mach-shmobile/cpuidle.c
@@ -20,6 +20,27 @@
 #include <asm/io.h>
 #include "common.h"

+static int shmobile_cpuidle_notifier_call(struct notifier_block *nfb,
+					  unsigned long action, void *hcpu)
+{
+	unsigned int cpu = (long)hcpu;
+
+	switch (action) {
+	case CPU_ONLINE:
+	case CPU_STARTING:
+	case CPU_STARTING_FROZEN:
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
+
 static struct cpuidle_driver shmobile_cpuidle_default_driver = {
 	.name			= "shmobile_cpuidle",
 	.owner			= THIS_MODULE,
@@ -51,6 +72,9 @@ int __init shmobile_cpuidle_init(void)
 	}

 #ifdef CONFIG_ARCH_SHMOBILE_MULTI
+	/* Use CPU notifier for reset vector control */
+	register_cpu_notifier(&shmobile_cpuidle_notifier);
+
 	platform_device_register(&shmobile_cpuidle);
 	return 0;
 #else
-- 
1.7.9.5
