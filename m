From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sat, 11 Aug 2012 22:18:45 +0000
Subject: [PATCH 2/2] ARM: shmobile: Make sh7372 cpuidle handling more straightforward
Message-Id: <201208120018.45935.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


The sh7372 cpuidle code uses the same artificially designed routine
shmobile_cpuidle_enter() as the .enter() callback for all of its
cpuidle states.  However, shmobile_cpuidle_enter() calls a different
"enter" function for each state using an array of function pointers
populated by the sh7372 PM initialization code.  Moreover, the
states[] array of the shmobile cpuidle driver is populated by that
code as well, although in principle it just might have been filled
with static data.

All of that complexity goes away if the sh7372 cpuidle code is
allowed to define its own cpuidle driver structure that can be passed
for registration to the common shmobile cpuidle initialization
routine, so modify the code accordingly.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/arm/mach-shmobile/cpuidle.c             |   39 ++++---------
 arch/arm/mach-shmobile/include/mach/common.h |    6 +-
 arch/arm/mach-shmobile/pm-sh7372.c           |   79 +++++++++++++++------------
 3 files changed, 62 insertions(+), 62 deletions(-)

Index: linux/arch/arm/mach-shmobile/cpuidle.c
=================================--- linux.orig/arch/arm/mach-shmobile/cpuidle.c
+++ linux/arch/arm/mach-shmobile/cpuidle.c
@@ -16,51 +16,38 @@
 #include <asm/cpuidle.h>
 #include <asm/io.h>
 
-static void shmobile_enter_wfi(void)
+int shmobile_enter_wfi(struct cpuidle_device *dev, struct cpuidle_driver *drv,
+		       int index)
 {
 	cpu_do_idle();
-}
-
-void (*shmobile_cpuidle_modes[CPUIDLE_STATE_MAX])(void) = {
-	shmobile_enter_wfi, /* regular sleep mode */
-};
-
-static int shmobile_cpuidle_enter(struct cpuidle_device *dev,
-				  struct cpuidle_driver *drv,
-				  int index)
-{
-	shmobile_cpuidle_modes[index]();
-
-	return index;
+	return 0;
 }
 
 static struct cpuidle_device shmobile_cpuidle_dev;
-static struct cpuidle_driver shmobile_cpuidle_driver = {
+static struct cpuidle_driver shmobile_cpuidle_default_driver = {
 	.name			= "shmobile_cpuidle",
 	.owner			= THIS_MODULE,
 	.en_core_tk_irqen	= 1,
 	.states[0]		= ARM_CPUIDLE_WFI_STATE,
+	.states[0].enter	= shmobile_enter_wfi,
 	.safe_state_index	= 0, /* C1 */
 	.state_count		= 1,
 };
 
-void (*shmobile_cpuidle_setup)(struct cpuidle_driver *drv);
+static struct cpuidle_driver *cpuidle_drv = &shmobile_cpuidle_default_driver;
+
+void shmobile_cpuidle_set_driver(struct cpuidle_driver *drv)
+{
+	cpuidle_drv = drv;
+}
 
 int shmobile_cpuidle_init(void)
 {
 	struct cpuidle_device *dev = &shmobile_cpuidle_dev;
-	struct cpuidle_driver *drv = &shmobile_cpuidle_driver;
-	int i;
-
-	for (i = 0; i < CPUIDLE_STATE_MAX; i++)
-		drv->states[i].enter = shmobile_cpuidle_enter;
-
-	if (shmobile_cpuidle_setup)
-		shmobile_cpuidle_setup(drv);
 
-	cpuidle_register_driver(drv);
+	cpuidle_register_driver(cpuidle_drv);
 
-	dev->state_count = drv->state_count;
+	dev->state_count = cpuidle_drv->state_count;
 	cpuidle_register_device(dev);
 
 	return 0;
Index: linux/arch/arm/mach-shmobile/include/mach/common.h
=================================--- linux.orig/arch/arm/mach-shmobile/include/mach/common.h
+++ linux/arch/arm/mach-shmobile/include/mach/common.h
@@ -14,8 +14,10 @@ extern int shmobile_clk_init(void);
 extern void shmobile_handle_irq_intc(struct pt_regs *);
 extern struct platform_suspend_ops shmobile_suspend_ops;
 struct cpuidle_driver;
-extern void (*shmobile_cpuidle_modes[])(void);
-extern void (*shmobile_cpuidle_setup)(struct cpuidle_driver *drv);
+struct cpuidle_device;
+extern int shmobile_enter_wfi(struct cpuidle_device *dev,
+			      struct cpuidle_driver *drv, int index);
+extern void shmobile_cpuidle_set_driver(struct cpuidle_driver *drv);
 
 extern void sh7367_init_irq(void);
 extern void sh7367_map_io(void);
Index: linux/arch/arm/mach-shmobile/pm-sh7372.c
=================================--- linux.orig/arch/arm/mach-shmobile/pm-sh7372.c
+++ linux/arch/arm/mach-shmobile/pm-sh7372.c
@@ -21,6 +21,7 @@
 #include <linux/irq.h>
 #include <linux/bitrev.h>
 #include <linux/console.h>
+#include <asm/cpuidle.h>
 #include <asm/io.h>
 #include <asm/tlbflush.h>
 #include <asm/suspend.h>
@@ -347,7 +348,8 @@ static int sh7372_do_idle_core_standby(u
 	return 0;
 }
 
-static void sh7372_enter_core_standby(void)
+static int sh7372_enter_core_standby(struct cpuidle_device *dev,
+				     struct cpuidle_driver *drv, int index)
 {
 	sh7372_set_reset_vector(__pa(sh7372_resume_core_standby_sysc));
 
@@ -358,52 +360,61 @@ static void sh7372_enter_core_standby(vo
 
 	 /* disable reset vector translation */
 	__raw_writel(0, SBAR);
+
+	return 1;
 }
 
-static void sh7372_enter_a3sm_pll_on(void)
+static int sh7372_enter_a3sm_pll_on(struct cpuidle_device *dev,
+				    struct cpuidle_driver *drv, int index)
 {
 	sh7372_enter_a3sm_common(1);
+	return 2;
 }
 
-static void sh7372_enter_a3sm_pll_off(void)
+static int sh7372_enter_a3sm_pll_off(struct cpuidle_device *dev,
+				     struct cpuidle_driver *drv, int index)
 {
 	sh7372_enter_a3sm_common(0);
+	return 3;
 }
 
-static void sh7372_cpuidle_setup(struct cpuidle_driver *drv)
-{
-	struct cpuidle_state *state = &drv->states[drv->state_count];
-
-	snprintf(state->name, CPUIDLE_NAME_LEN, "C2");
-	strncpy(state->desc, "Core Standby Mode", CPUIDLE_DESC_LEN);
-	state->exit_latency = 10;
-	state->target_residency = 20 + 10;
-	state->flags = CPUIDLE_FLAG_TIME_VALID;
-	shmobile_cpuidle_modes[drv->state_count] = sh7372_enter_core_standby;
-	drv->state_count++;
-
-	state = &drv->states[drv->state_count];
-	snprintf(state->name, CPUIDLE_NAME_LEN, "C3");
-	strncpy(state->desc, "A3SM PLL ON", CPUIDLE_DESC_LEN);
-	state->exit_latency = 20;
-	state->target_residency = 30 + 20;
-	state->flags = CPUIDLE_FLAG_TIME_VALID;
-	shmobile_cpuidle_modes[drv->state_count] = sh7372_enter_a3sm_pll_on;
-	drv->state_count++;
-
-	state = &drv->states[drv->state_count];
-	snprintf(state->name, CPUIDLE_NAME_LEN, "C4");
-	strncpy(state->desc, "A3SM PLL OFF", CPUIDLE_DESC_LEN);
-	state->exit_latency = 120;
-	state->target_residency = 30 + 120;
-	state->flags = CPUIDLE_FLAG_TIME_VALID;
-	shmobile_cpuidle_modes[drv->state_count] = sh7372_enter_a3sm_pll_off;
-	drv->state_count++;
-}
+static struct cpuidle_driver sh7372_cpuidle_driver = {
+	.name			= "sh7372_cpuidle",
+	.owner			= THIS_MODULE,
+	.en_core_tk_irqen	= 1,
+	.state_count		= 4,
+	.safe_state_index	= 0, /* C1 */
+	.states[0] = ARM_CPUIDLE_WFI_STATE,
+	.states[0].enter = shmobile_enter_wfi,
+	.states[1] = {
+		.name = "C2",
+		.desc = "Core Standby Mode",
+		.exit_latency = 10,
+		.target_residency = 20 + 10,
+		.flags = CPUIDLE_FLAG_TIME_VALID,
+		.enter = sh7372_enter_core_standby,
+	},
+	.states[2] = {
+		.name = "C3",
+		.desc = "A3SM PLL ON",
+		.exit_latency = 20,
+		.target_residency = 30 + 20,
+		.flags = CPUIDLE_FLAG_TIME_VALID,
+		.enter = sh7372_enter_a3sm_pll_on,
+	},
+	.states[3] = {
+		.name = "C4",
+		.desc = "A3SM PLL OFF",
+		.exit_latency = 120,
+		.target_residency = 30 + 120,
+		.flags = CPUIDLE_FLAG_TIME_VALID,
+		.enter = sh7372_enter_a3sm_pll_off,
+	},
+};
 
 static void sh7372_cpuidle_init(void)
 {
-	shmobile_cpuidle_setup = sh7372_cpuidle_setup;
+	shmobile_cpuidle_set_driver(&sh7372_cpuidle_driver);
 }
 #else
 static void sh7372_cpuidle_init(void) {}

