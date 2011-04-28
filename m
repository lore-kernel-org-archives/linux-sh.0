From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 28 Apr 2011 17:39:32 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7372 Core Standby CPUIdle
Message-Id: <20110428173932.3811.2688.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
References: <20110428172808.3636.13888.sendpatchset@t400s>
In-Reply-To: <20110428172808.3636.13888.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch ties in the previously added sh7372 sleep
mode known as Core Standby together with the shared
SH-Mobile ARM CPUIdle implementation.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/pm-sh7372.c |   33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

--- 0003/arch/arm/mach-shmobile/pm-sh7372.c
+++ work/arch/arm/mach-shmobile/pm-sh7372.c	2011-04-29 02:09:33.000000000 +0900
@@ -10,6 +10,7 @@
 
 #include <linux/pm.h>
 #include <linux/suspend.h>
+#include <linux/cpuidle.h>
 #include <linux/module.h>
 #include <linux/list.h>
 #include <linux/err.h>
@@ -24,8 +25,7 @@
 #define SBAR 0xe6180020
 #define APARMBAREA 0xe6f10020
 
-#ifdef CONFIG_SUSPEND
-static void sh7372_enter_core_standby(void)
+void sh7372_enter_core_standby(void)
 {
 	void __iomem *smfram = (void __iomem *)SMFRAM;
 
@@ -51,6 +51,34 @@ static void sh7372_enter_core_standby(vo
 	__raw_writel(0, SBAR); /* disable reset vector translation */
 }
 
+#ifdef CONFIG_CPU_IDLE
+static void sh7372_cpuidle_setup(struct cpuidle_device *dev)
+{
+	struct cpuidle_state *state;
+	int i = dev->state_count;
+
+	state = &dev->states[i];
+	snprintf(state->name, CPUIDLE_NAME_LEN, "C2");
+	strncpy(state->desc, "Core Standby Mode", CPUIDLE_DESC_LEN);
+	state->exit_latency = 10;
+	state->target_residency = 20 + 10;
+	state->power_usage = 1; /* perhaps not */
+	state->flags = 0;
+	state->flags |= CPUIDLE_FLAG_TIME_VALID;
+	shmobile_cpuidle_modes[i] = sh7372_enter_core_standby;
+
+	dev->state_count = i + 1;
+}
+
+static void sh7372_cpuidle_init(void)
+{
+	shmobile_cpuidle_setup = sh7372_cpuidle_setup;
+}
+#else
+static void sh7372_cpuidle_init(void) {}
+#endif
+
+#ifdef CONFIG_SUSPEND
 static int sh7372_enter_suspend(suspend_state_t suspend_state)
 {
 	sh7372_enter_core_standby();
@@ -76,4 +104,5 @@ void __init sh7372_pm_init(void)
 	__raw_writel(0x00000000, DBGREG1);
 
 	sh7372_suspend_init();
+	sh7372_cpuidle_init();
 }
