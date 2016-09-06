From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Tue, 06 Sep 2016 17:04:41 +0000
Subject: [PATCH 05/21] sh: SH-X3 SMP: Convert to hotplug state machine
Message-Id: <20160906170457.32393-6-bigeasy@linutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20160906170457.32393-1-bigeasy@linutronix.de>
In-Reply-To: <20160906170457.32393-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, rt@linutronix.de, tglx@linutronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-sh@vger.kernel.org

Install the callbacks via the state machine.

Cc: linux-sh@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/sh/kernel/cpu/sh4a/smp-shx3.c | 26 +++++---------------------
 include/linux/cpuhotplug.h         |  1 +
 2 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/smp-shx3.c b/arch/sh/kernel/cpu/sh4a/smp-shx3.c
index 839612c8a0a0..0d3637c494bf 100644
--- a/arch/sh/kernel/cpu/sh4a/smp-shx3.c
+++ b/arch/sh/kernel/cpu/sh4a/smp-shx3.c
@@ -122,32 +122,16 @@ static void shx3_update_boot_vector(unsigned int cpu)
 	__raw_writel(STBCR_RESET, STBCR_REG(cpu));
 }
 
-static int
-shx3_cpu_callback(struct notifier_block *nfb, unsigned long action, void *hcpu)
+static int shx3_cpu_prepare(unsigned int cpu)
 {
-	unsigned int cpu = (unsigned int)hcpu;
-
-	switch (action) {
-	case CPU_UP_PREPARE:
-		shx3_update_boot_vector(cpu);
-		break;
-	case CPU_ONLINE:
-		pr_info("CPU %u is now online\n", cpu);
-		break;
-	case CPU_DEAD:
-		break;
-	}
-
-	return NOTIFY_OK;
+	shx3_update_boot_vector(cpu);
+	return 0;
 }
 
-static struct notifier_block shx3_cpu_notifier = {
-	.notifier_call		= shx3_cpu_callback,
-};
-
 static int register_shx3_cpu_notifier(void)
 {
-	register_hotcpu_notifier(&shx3_cpu_notifier);
+	cpuhp_setup_state_nocalls(CPUHP_SH_SH3X_PREPARE, "sh/shx3:prepare",
+				  shx3_cpu_prepare, NULL);
 	return 0;
 }
 late_initcall(register_shx3_cpu_notifier);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 35859aafbbfc..8dec2a236af3 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -37,6 +37,7 @@ enum cpuhp_state {
 	CPUHP_POWERPC_MMU_CTX_PREPARE,
 	CPUHP_NOTIFY_PREPARE,
 	CPUHP_ARM_SHMOBILE_SCU_PREPARE,
+	CPUHP_SH_SH3X_PREPARE,
 	CPUHP_TIMERS_DEAD,
 	CPUHP_BRINGUP_CPU,
 	CPUHP_AP_IDLE_DEAD,
-- 
2.9.3

