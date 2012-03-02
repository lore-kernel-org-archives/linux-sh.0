From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Fri, 02 Mar 2012 23:41:30 +0000
Subject: [PATCH] sh_tmu / PM: Prevent power from being removed from TMU devices
Message-Id: <201203030041.30244.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

To prevent TMU devices from losing power define a fake "always busy"
suspend callback in the sh_tmu driver that will cause all attempts to
suspend the system to fail.  In addition to that, make the driver
change the runtime PM settings of TMU devices so that they appear to
be always "active" and make SH7372 add them to the A4R domain (where
they physically belong), to make the PM domains core take those
settings into consideration when attempting to remove power from A4R.

Proprer power management support will be added to the sh_tmu driver
in the future.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/arm/mach-shmobile/setup-sh7372.c |    2 ++
 drivers/clocksource/sh_tmu.c          |   12 ++++++++++++
 2 files changed, 14 insertions(+)

Index: linux/drivers/clocksource/sh_tmu.c
=================================--- linux.orig/drivers/clocksource/sh_tmu.c
+++ linux/drivers/clocksource/sh_tmu.c
@@ -426,6 +426,10 @@ static int __devinit sh_tmu_probe(struct
 		kfree(p);
 		platform_set_drvdata(pdev, NULL);
 	}
+#ifdef CONFIG_PM_RUNTIME
+	pdev->dev.power.disable_depth = 0;
+	pdev->dev.power.runtime_status = RPM_ACTIVE;
+#endif
 	return ret;
 }
 
@@ -434,11 +438,19 @@ static int __devexit sh_tmu_remove(struc
 	return -EBUSY; /* cannot unregister clockevent and clocksource */
 }
 
+static int sh_tmu_no_suspend(struct device *dev)
+{
+	return -EBUSY;
+}
+
+static SIMPLE_DEV_PM_OPS(sh_tmu_pm_ops, sh_tmu_no_suspend, NULL);
+
 static struct platform_driver sh_tmu_device_driver = {
 	.probe		= sh_tmu_probe,
 	.remove		= __devexit_p(sh_tmu_remove),
 	.driver		= {
 		.name	= "sh_tmu",
+		.pm	= &sh_tmu_pm_ops,
 	}
 };
 
Index: linux/arch/arm/mach-shmobile/setup-sh7372.c
=================================--- linux.orig/arch/arm/mach-shmobile/setup-sh7372.c
+++ linux/arch/arm/mach-shmobile/setup-sh7372.c
@@ -1043,6 +1043,8 @@ void __init sh7372_add_standard_devices(
 	sh7372_add_device_to_domain(&sh7372_a4r, &veu2_device);
 	sh7372_add_device_to_domain(&sh7372_a4r, &veu3_device);
 	sh7372_add_device_to_domain(&sh7372_a4r, &jpu_device);
+	sh7372_add_device_to_domain(&sh7372_a4r, &tmu00_device);
+	sh7372_add_device_to_domain(&sh7372_a4r, &tmu01_device);
 }
 
 void __init sh7372_add_early_devices(void)
