From: Anna-Maria Gleixner <anna-maria@linutronix.de>
Date: Mon, 11 Jul 2016 12:28:37 +0000
Subject: [patch 20/66] sh: perf: Convert the hotplug notifiers to state machine callbacks
Message-Id: <20160711122532.298565041@linutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20160711122450.923603742@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, linux-sh@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Anna-Maria Gleixner <anna-maria@linutronix.de>

From: Thomas Gleixner <tglx@linutronix.de>

Install the callbacks via the state machine and let the core invoke
the callbacks on the already online CPUs.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-sh@vger.kernel.org
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>

---
 arch/sh/kernel/perf_event.c |   23 ++++-------------------
 include/linux/cpuhotplug.h  |    1 +
 2 files changed, 5 insertions(+), 19 deletions(-)

--- a/arch/sh/kernel/perf_event.c
+++ b/arch/sh/kernel/perf_event.c
@@ -352,28 +352,12 @@ static struct pmu pmu = {
 	.read		= sh_pmu_read,
 };
 
-static void sh_pmu_setup(int cpu)
+static int sh_pmu_prepare_cpu(unsigned int cpu)
 {
 	struct cpu_hw_events *cpuhw = &per_cpu(cpu_hw_events, cpu);
 
 	memset(cpuhw, 0, sizeof(struct cpu_hw_events));
-}
-
-static int
-sh_pmu_notifier(struct notifier_block *self, unsigned long action, void *hcpu)
-{
-	unsigned int cpu = (long)hcpu;
-
-	switch (action & ~CPU_TASKS_FROZEN) {
-	case CPU_UP_PREPARE:
-		sh_pmu_setup(cpu);
-		break;
-
-	default:
-		break;
-	}
-
-	return NOTIFY_OK;
+	return 0;
 }
 
 int register_sh_pmu(struct sh_pmu *_pmu)
@@ -394,6 +378,7 @@ int register_sh_pmu(struct sh_pmu *_pmu)
 	WARN_ON(_pmu->num_events > MAX_HWEVENTS);
 
 	perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
-	perf_cpu_notifier(sh_pmu_notifier);
+	cpuhp_setup_state(CPUHP_PERF_SUPERH, "PERF_SUPERH", sh_pmu_prepare_cpu,
+			  NULL);
 	return 0;
 }
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -11,6 +11,7 @@ enum cpuhp_state {
 	CPUHP_PERF_X86_RAPL_PREP,
 	CPUHP_PERF_BFIN,
 	CPUHP_PERF_POWER,
+	CPUHP_PERF_SUPERH,
 	CPUHP_NOTIFY_PREPARE,
 	CPUHP_BRINGUP_CPU,
 	CPUHP_AP_IDLE_DEAD,


