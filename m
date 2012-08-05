From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 05 Aug 2012 23:49:37 +0000
Subject: [PATCH 14/15] sh: MTU2: Basic runtime PM support
Message-Id: <201208060149.37972.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201207291612.43138.rjw@sisk.pl> <201208060138.03950.rjw@sisk.pl>
In-Reply-To: <201208060138.03950.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>


Modify the SH MTU2 clock event device driver to support runtime PM at
a basic level (i.e. device clocks can be disabled and enabled, but
domain power must be on, because the device has to be marked as
"irq safe").

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/clocksource/sh_mtu2.c |   28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

Index: linux/drivers/clocksource/sh_mtu2.c
=================================--- linux.orig/drivers/clocksource/sh_mtu2.c
+++ linux/drivers/clocksource/sh_mtu2.c
@@ -32,6 +32,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 
 struct sh_mtu2_priv {
 	void __iomem *mapbase;
@@ -123,6 +124,9 @@ static int sh_mtu2_enable(struct sh_mtu2
 {
 	int ret;
 
+	pm_runtime_get_sync(&p->pdev->dev);
+	dev_pm_syscore_device(&p->pdev->dev, true);
+
 	/* enable clock */
 	ret = clk_enable(p->clk);
 	if (ret) {
@@ -157,6 +161,9 @@ static void sh_mtu2_disable(struct sh_mt
 
 	/* stop clock */
 	clk_disable(p->clk);
+
+	dev_pm_syscore_device(&p->pdev->dev, false);
+	pm_runtime_put(&p->pdev->dev);
 }
 
 static irqreturn_t sh_mtu2_interrupt(int irq, void *dev_id)
@@ -320,15 +327,13 @@ static int __devinit sh_mtu2_probe(struc
 	int ret;
 
 	if (!is_early_platform_device(pdev)) {
-		struct sh_timer_config *cfg = pdev->dev.platform_data;
-
-		if (cfg->clockevent_rating)
-			dev_pm_syscore_device(&pdev->dev, true);
+		pm_runtime_set_active(&pdev->dev);
+		pm_runtime_enable(&pdev->dev);
 	}
 
 	if (p) {
 		dev_info(&pdev->dev, "kept as earlytimer\n");
-		return 0;
+		goto out;
 	}
 
 	p = kmalloc(sizeof(*p), GFP_KERNEL);
@@ -341,8 +346,19 @@ static int __devinit sh_mtu2_probe(struc
 	if (ret) {
 		kfree(p);
 		platform_set_drvdata(pdev, NULL);
+		pm_runtime_idle(&pdev->dev);
+		return ret;
 	}
-	return ret;
+	if (is_early_platform_device(pdev))
+		return 0;
+
+ out:
+	if (cfg->clockevent_rating)
+		pm_runtime_irq_safe(&pdev->dev);
+	else
+		pm_runtime_idle(&pdev->dev);
+
+	return 0;
 }
 
 static int __devexit sh_mtu2_remove(struct platform_device *pdev)

