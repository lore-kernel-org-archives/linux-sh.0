From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Date: Thu, 04 Dec 2014 01:24:22 +0000
Subject: [PATCH] drivers: sh / PM: Replace CONFIG_PM_RUNTIME with CONFIG_PM
Message-Id: <3463511.sXIeyHdjYI@vostro.rjw.lan>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
selected) PM_RUNTIME is always set if PM is set, so #ifdef blocks
depending on CONFIG_PM_RUNTIME may now be changed to depend on
CONFIG_PM.

Replace CONFIG_PM_RUNTIME with CONFIG_PM in drivers/sh/pm_runtime.c.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Note: This depends on commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if
PM_SLEEP is selected) which is only in linux-next at the moment (via the
linux-pm tree).

Please let me know if it is OK to take this one into linux-pm.

---
 drivers/sh/pm_runtime.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/sh/pm_runtime.c
=================================--- linux-pm.orig/drivers/sh/pm_runtime.c
+++ linux-pm/drivers/sh/pm_runtime.c
@@ -20,7 +20,7 @@
 #include <linux/bitmap.h>
 #include <linux/slab.h>
 
-#ifdef CONFIG_PM_RUNTIME
+#ifdef CONFIG_PM
 static int sh_pm_runtime_suspend(struct device *dev)
 {
 	int ret;
@@ -68,7 +68,7 @@ static struct dev_pm_domain default_pm_d
 
 #define DEFAULT_PM_DOMAIN_PTR	NULL
 
-#endif /* CONFIG_PM_RUNTIME */
+#endif /* CONFIG_PM */
 
 static struct pm_clk_notifier_block platform_bus_notifier = {
 	.pm_domain = DEFAULT_PM_DOMAIN_PTR,

