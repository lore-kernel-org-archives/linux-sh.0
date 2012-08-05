From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 05 Aug 2012 23:43:41 +0000
Subject: [PATCH 6/15] sh: MTU2: Introduce clock events suspend/resume routines
Message-Id: <201208060143.42216.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201207291612.43138.rjw@sisk.pl> <201208060138.03950.rjw@sisk.pl>
In-Reply-To: <201208060138.03950.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>


Introduce suspend/resume routines for SH MTU2 clock event devices
such that if those devices belong to a PM domain, the generic PM
domains framework will be notified that the given domain may be
turned off (during system suspend) or that it has to be turned on
(during system resume).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/clocksource/sh_mtu2.c |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

Index: linux/drivers/clocksource/sh_mtu2.c
=================================--- linux.orig/drivers/clocksource/sh_mtu2.c
+++ linux/drivers/clocksource/sh_mtu2.c
@@ -208,6 +208,16 @@ static void sh_mtu2_clock_event_mode(enu
 	}
 }
 
+static void sh_mtu2_clock_event_suspend(struct clock_event_device *ced)
+{
+	pm_genpd_syscore_poweroff(&ced_to_sh_mtu2(ced)->pdev->dev);
+}
+
+static void sh_mtu2_clock_event_resume(struct clock_event_device *ced)
+{
+	pm_genpd_syscore_poweron(&ced_to_sh_mtu2(ced)->pdev->dev);
+}
+
 static void sh_mtu2_register_clockevent(struct sh_mtu2_priv *p,
 				       char *name, unsigned long rating)
 {
@@ -221,6 +231,8 @@ static void sh_mtu2_register_clockevent(
 	ced->rating = rating;
 	ced->cpumask = cpumask_of(0);
 	ced->set_mode = sh_mtu2_clock_event_mode;
+	ced->suspend = sh_mtu2_clock_event_suspend;
+	ced->resume = sh_mtu2_clock_event_resume;
 
 	dev_info(&p->pdev->dev, "used for clock events\n");
 	clockevents_register_device(ced);
@@ -307,8 +319,12 @@ static int __devinit sh_mtu2_probe(struc
 	struct sh_mtu2_priv *p = platform_get_drvdata(pdev);
 	int ret;
 
-	if (!is_early_platform_device(pdev))
-		pm_genpd_dev_always_on(&pdev->dev, true);
+	if (!is_early_platform_device(pdev)) {
+		struct sh_timer_config *cfg = pdev->dev.platform_data;
+
+		if (cfg->clockevent_rating)
+			pm_genpd_dev_always_on(&pdev->dev, true);
+	}
 
 	if (p) {
 		dev_info(&pdev->dev, "kept as earlytimer\n");

