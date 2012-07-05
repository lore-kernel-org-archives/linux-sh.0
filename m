From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 05 Jul 2012 05:46:07 +0000
Subject: [PATCH] ARM: shmobile: Use INTCA with sh7372 A3SM power domain
Message-Id: <20120705054607.29735.71129.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert the sh7372 A3SM power domain code to allow
waking up through INTCA and SYSC instead of only
relying on SYSC for wakeups. This allows us to
enter A3SM more or less regardless of the state
of the rest of the system.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written on top of the sh7372 topic branch in renesas.git

 arch/arm/mach-shmobile/pm-sh7372.c |   57 +++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 29 deletions(-)

--- 0001/arch/arm/mach-shmobile/pm-sh7372.c
+++ work/arch/arm/mach-shmobile/pm-sh7372.c	2012-07-05 14:33:34.000000000 +0900
@@ -293,12 +293,6 @@ struct sh7372_pm_domain sh7372_a3sg = {
 #endif /* CONFIG_PM */
 
 #if defined(CONFIG_SUSPEND) || defined(CONFIG_CPU_IDLE)
-static int sh7372_do_idle_core_standby(unsigned long unused)
-{
-	cpu_do_idle(); /* WFI when SYSTBCR = 0x10 -> Core Standby */
-	return 0;
-}
-
 static void sh7372_set_reset_vector(unsigned long address)
 {
 	/* set reset vector, translate 4k */
@@ -306,18 +300,6 @@ static void sh7372_set_reset_vector(unsi
 	__raw_writel(0, APARMBAREA);
 }
 
-static void sh7372_enter_core_standby(void)
-{
-	sh7372_set_reset_vector(__pa(sh7372_resume_core_standby_sysc));
-
-	/* enter sleep mode with SYSTBCR to 0x10 */
-	__raw_writel(0x10, SYSTBCR);
-	cpu_suspend(0, sh7372_do_idle_core_standby);
-	__raw_writel(0, SYSTBCR);
-
-	 /* disable reset vector translation */
-	__raw_writel(0, SBAR);
-}
 #endif
 
 #ifdef CONFIG_SUSPEND
@@ -460,6 +442,8 @@ static void sh7372_setup_sysc(unsigned l
 
 static void sh7372_enter_a3sm_common(int pllc0_on)
 {
+	/* use INTCA together with SYSC for wakeup */
+	sh7372_setup_sysc(1 << 0, 0);
 	sh7372_set_reset_vector(__pa(sh7372_resume_core_standby_sysc));
 	sh7372_enter_sysc(pllc0_on, 1 << 12);
 }
@@ -476,6 +460,24 @@ static void sh7372_enter_a4s_common(int
 #endif
 
 #ifdef CONFIG_CPU_IDLE
+static int sh7372_do_idle_core_standby(unsigned long unused)
+{
+	cpu_do_idle(); /* WFI when SYSTBCR = 0x10 -> Core Standby */
+	return 0;
+}
+
+static void sh7372_enter_core_standby(void)
+{
+	sh7372_set_reset_vector(__pa(sh7372_resume_core_standby_sysc));
+
+	/* enter sleep mode with SYSTBCR to 0x10 */
+	__raw_writel(0x10, SYSTBCR);
+	cpu_suspend(0, sh7372_do_idle_core_standby);
+	__raw_writel(0, SYSTBCR);
+
+	 /* disable reset vector translation */
+	__raw_writel(0, SBAR);
+}
 
 static void sh7372_cpuidle_setup(struct cpuidle_driver *drv)
 {
@@ -507,24 +509,21 @@ static int sh7372_enter_suspend(suspend_
 
 	/* check active clocks to determine potential wakeup sources */
 	if (sh7372_sysc_valid(&msk, &msk2)) {
-		/* convert INTC mask and sense to SYSC mask and sense */
-		sh7372_setup_sysc(msk, msk2);
-
 		if (!console_suspend_enabled &&
 		    sh7372_a4s.genpd.status = GPD_STATE_POWER_OFF) {
+			/* convert INTC mask/sense to SYSC mask/sense */
+			sh7372_setup_sysc(msk, msk2);
+
 			/* enter A4S sleep with PLLC0 off */
 			pr_debug("entering A4S\n");
 			sh7372_enter_a4s_common(0);
-		} else {
-			/* enter A3SM sleep with PLLC0 off */
-			pr_debug("entering A3SM\n");
-			sh7372_enter_a3sm_common(0);
+			return 0;
 		}
-	} else {
-		/* default to Core Standby that supports all wakeup sources */
-		pr_debug("entering Core Standby\n");
-		sh7372_enter_core_standby();
 	}
+
+	/* default to enter A3SM sleep with PLLC0 off */
+	pr_debug("entering A3SM\n");
+	sh7372_enter_a3sm_common(0);
 	return 0;
 }
 
