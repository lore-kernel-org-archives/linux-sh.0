From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 04 Dec 2011 22:08:14 +0000
Subject: [PATCH] PM / sh7372: Make domain stay_on bit only affect system suspend
Message-Id: <201112042308.14255.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

From: Rafael J. Wysocki <rjw@sisk.pl>

SH7372 uses two independent mechanisms for ensuring that power
domains will never be turned off: the stay_on flag and the "always
on" domain governor.  However, the "always on" governor is only taken
into accout by runtime PM code paths, while the stay_on flag affects
all attempts to turn the given domain off.  This is a problem for
domains that only need to stay in the "power on" state during system
sleep, but may be turned off by runtime PM if specific conditions are
satisfied.  For this reason, make SH7372 register a PM notifier that
will enable the checking of the domain stay_on flag on during system
suspend and disable it during system resume.  This way, the stay_on
flag will only affect system sleep states, while the "always on"
governor will only affect runtime PM.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---

This patch is on top of linux-pm/pm-domains.

Thanks,
Rafael

---
 arch/arm/mach-shmobile/pm-sh7372.c |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

Index: linux/arch/arm/mach-shmobile/pm-sh7372.c
=================================--- linux.orig/arch/arm/mach-shmobile/pm-sh7372.c
+++ linux/arch/arm/mach-shmobile/pm-sh7372.c
@@ -77,6 +77,8 @@
 
 #ifdef CONFIG_PM
 
+static bool system_pm_transition;
+
 static int pd_power_down(struct generic_pm_domain *genpd)
 {
 	struct sh7372_pm_domain *sh7372_pd = to_sh7372_pd(genpd);
@@ -85,7 +87,7 @@ static int pd_power_down(struct generic_
 	if (sh7372_pd->suspend)
 		sh7372_pd->suspend();
 
-	if (sh7372_pd->stay_on)
+	if (system_pm_transition && sh7372_pd->stay_on)
 		return 0;
 
 	if (__raw_readl(PSTR) & mask) {
@@ -286,6 +288,21 @@ struct sh7372_pm_domain sh7372_a3sg = {
 	.bit_shift = 13,
 };
 
+static int sh7372_pm_notifier_fn(struct notifier_block *notifier,
+				 unsigned long pm_event, void *unused)
+{
+	switch (pm_event) {
+	case PM_SUSPEND_PREPARE:
+		system_pm_transition = true;
+		break;
+	case PM_POST_SUSPEND:
+		system_pm_transition = false;
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
 #else /* !CONFIG_PM */
 
 static inline void sh7372_a3sp_init(void) {}
@@ -509,6 +526,7 @@ static int sh7372_enter_suspend(suspend_
 static void sh7372_suspend_init(void)
 {
 	shmobile_suspend_ops.enter = sh7372_enter_suspend;
+	pm_notifier(sh7372_pm_notifier_fn, 0);
 }
 #else
 static void sh7372_suspend_init(void) {}
