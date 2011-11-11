From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 11 Nov 2011 05:01:30 +0000
Subject: [PATCH] ARM: mach-shmobile: cpuidle single/global and last_state fixes
Message-Id: <20111111050130.9104.12599.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

The following commits break cpuidle on SH-Mobile ARM:

46bcfad cpuidle: Single/Global registration of idle states
e978aa7 cpuidle: Move dev->last_residency update to driver enter routine; remove dev->last_state

This patch remedies these issues by up-porting the SH-Mobile
code to fit with the above introduced framework changes.

It is worth noting that the new code becomes significantly cleaner,
so these framework changes are very welcome. At the same time this
breakage could probably have been avoided by grepping for "last_state"
and "cpuidle_register_driver".

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/cpuidle.c             |   52 +++++++++++---------------
 arch/arm/mach-shmobile/include/mach/common.h |    4 +-
 arch/arm/mach-shmobile/pm-sh7372.c           |   14 ++-----
 3 files changed, 30 insertions(+), 40 deletions(-)

--- 0001/arch/arm/mach-shmobile/cpuidle.c
+++ work/arch/arm/mach-shmobile/cpuidle.c	2011-11-11 13:48:36.000000000 +0900
@@ -26,65 +26,59 @@ void (*shmobile_cpuidle_modes[CPUIDLE_ST
 };
 
 static int shmobile_cpuidle_enter(struct cpuidle_device *dev,
-				  struct cpuidle_state *state)
+				  struct cpuidle_driver *drv,
+				  int index)
 {
 	ktime_t before, after;
-	int requested_state = state - &dev->states[0];
 
-	dev->last_state = &dev->states[requested_state];
 	before = ktime_get();
 
 	local_irq_disable();
 	local_fiq_disable();
 
-	shmobile_cpuidle_modes[requested_state]();
+	shmobile_cpuidle_modes[index]();
 
 	local_irq_enable();
 	local_fiq_enable();
 
 	after = ktime_get();
-	return ktime_to_ns(ktime_sub(after, before)) >> 10;
+	dev->last_residency = ktime_to_ns(ktime_sub(after, before)) >> 10;
+
+	return index;
 }
 
 static struct cpuidle_device shmobile_cpuidle_dev;
 static struct cpuidle_driver shmobile_cpuidle_driver = {
 	.name =		"shmobile_cpuidle",
 	.owner =	THIS_MODULE,
+	.states[0] = {
+		.name = "C1",
+		.desc = "WFI",
+		.exit_latency = 1,
+		.target_residency = 1 * 2,
+		.flags = CPUIDLE_FLAG_TIME_VALID,
+	},
+	.safe_state_index = 0, /* C1 */
+	.state_count = 1,
 };
 
-void (*shmobile_cpuidle_setup)(struct cpuidle_device *dev);
+void (*shmobile_cpuidle_setup)(struct cpuidle_driver *drv);
 
 static int shmobile_cpuidle_init(void)
 {
 	struct cpuidle_device *dev = &shmobile_cpuidle_dev;
-	struct cpuidle_state *state;
+	struct cpuidle_driver *drv = &shmobile_cpuidle_driver;
 	int i;
 
-	cpuidle_register_driver(&shmobile_cpuidle_driver);
-
-	for (i = 0; i < CPUIDLE_STATE_MAX; i++) {
-		dev->states[i].name[0] = '\0';
-		dev->states[i].desc[0] = '\0';
-		dev->states[i].enter = shmobile_cpuidle_enter;
-	}
-
-	i = CPUIDLE_DRIVER_STATE_START;
-
-	state = &dev->states[i++];
-	snprintf(state->name, CPUIDLE_NAME_LEN, "C1");
-	strncpy(state->desc, "WFI", CPUIDLE_DESC_LEN);
-	state->exit_latency = 1;
-	state->target_residency = 1 * 2;
-	state->power_usage = 3;
-	state->flags = 0;
-	state->flags |= CPUIDLE_FLAG_TIME_VALID;
-
-	dev->safe_state = state;
-	dev->state_count = i;
+	for (i = 0; i < CPUIDLE_STATE_MAX; i++)
+		drv->states[i].enter = shmobile_cpuidle_enter;
 
 	if (shmobile_cpuidle_setup)
-		shmobile_cpuidle_setup(dev);
+		shmobile_cpuidle_setup(drv);
+
+	cpuidle_register_driver(drv);
 
+	dev->state_count = drv->state_count;
 	cpuidle_register_device(dev);
 
 	return 0;
--- 0001/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2011-11-11 13:44:15.000000000 +0900
@@ -9,9 +9,9 @@ extern int clk_init(void);
 extern void shmobile_handle_irq_intc(struct pt_regs *);
 extern void shmobile_handle_irq_gic(struct pt_regs *);
 extern struct platform_suspend_ops shmobile_suspend_ops;
-struct cpuidle_device;
+struct cpuidle_driver;
 extern void (*shmobile_cpuidle_modes[])(void);
-extern void (*shmobile_cpuidle_setup)(struct cpuidle_device *dev);
+extern void (*shmobile_cpuidle_setup)(struct cpuidle_driver *drv);
 
 extern void sh7367_init_irq(void);
 extern void sh7367_add_early_devices(void);
--- 0004/arch/arm/mach-shmobile/pm-sh7372.c
+++ work/arch/arm/mach-shmobile/pm-sh7372.c	2011-11-11 13:44:15.000000000 +0900
@@ -405,22 +405,18 @@ static void sh7372_setup_a3sm(unsigned l
 
 #ifdef CONFIG_CPU_IDLE
 
-static void sh7372_cpuidle_setup(struct cpuidle_device *dev)
+static void sh7372_cpuidle_setup(struct cpuidle_driver *drv)
 {
-	struct cpuidle_state *state;
-	int i = dev->state_count;
+	struct cpuidle_state *state = &drv->states[drv->state_count];
 
-	state = &dev->states[i];
 	snprintf(state->name, CPUIDLE_NAME_LEN, "C2");
 	strncpy(state->desc, "Core Standby Mode", CPUIDLE_DESC_LEN);
 	state->exit_latency = 10;
 	state->target_residency = 20 + 10;
-	state->power_usage = 1; /* perhaps not */
-	state->flags = 0;
-	state->flags |= CPUIDLE_FLAG_TIME_VALID;
-	shmobile_cpuidle_modes[i] = sh7372_enter_core_standby;
+	state->flags = CPUIDLE_FLAG_TIME_VALID;
+	shmobile_cpuidle_modes[drv->state_count] = sh7372_enter_core_standby;
 
-	dev->state_count = i + 1;
+	drv->state_count++;
 }
 
 static void sh7372_cpuidle_init(void)
