From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Tue, 10 Jan 2012 21:13:59 +0000
Subject: [PATCH] PM / Domains: Fix build for CONFIG_PM_SLEEP unset
Message-Id: <201201102213.59555.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Some callback functions defined in drivers/base/power/domain.c are
only necessary if CONFIG_PM_SLEEP and they call some other functions
that are only available in that case.  For this reason, they should
not be compiled at all when CONFIG_PM_SLEEP is not set.

Reported-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/domain.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

Index: linux/drivers/base/power/domain.c
=================================--- linux.orig/drivers/base/power/domain.c
+++ linux/drivers/base/power/domain.c
@@ -1429,6 +1429,8 @@ static int pm_genpd_default_restore_stat
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+
 /**
  * pm_genpd_default_suspend - Default "device suspend" for PM domians.
  * @dev: Device to handle.
@@ -1517,6 +1519,19 @@ static int pm_genpd_default_thaw(struct
 	return cb ? cb(dev) : pm_generic_thaw(dev);
 }
 
+#else /* !CONFIG_PM_SLEEP */
+
+#define pm_genpd_default_suspend	NULL
+#define pm_genpd_default_suspend_late	NULL
+#define pm_genpd_default_resume_early	NULL
+#define pm_genpd_default_resume		NULL
+#define pm_genpd_default_freeze		NULL
+#define pm_genpd_default_freeze_late	NULL
+#define pm_genpd_default_thaw_early	NULL
+#define pm_genpd_default_thaw		NULL
+
+#endif /* !CONFIG_PM_SLEEP */
+
 /**
  * pm_genpd_init - Initialize a generic I/O PM domain object.
  * @genpd: PM domain object to initialize.
