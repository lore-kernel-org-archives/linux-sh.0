From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Tue, 13 Mar 2012 00:28:05 +0000
Subject: [PATCH 6/6] PM / shmobile: Make MTU2 driver use pm_genpd_dev_always_on()
Message-Id: <201203130128.05357.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201203130123.16268.rjw@sisk.pl>
In-Reply-To: <201203130123.16268.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux-sh list <linux-sh@vger.kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Cao Minh Hiep <hiepcm@gmail.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Make the MTU2 clocksource driver mark its device as "always on"
using pm_genpd_dev_always_on() to protect it from surprise power
removals.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/clocksource/sh_mtu2.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux/drivers/clocksource/sh_mtu2.c
=================================--- linux.orig/drivers/clocksource/sh_mtu2.c
+++ linux/drivers/clocksource/sh_mtu2.c
@@ -31,6 +31,7 @@
 #include <linux/sh_timer.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/pm_domain.h>
 
 struct sh_mtu2_priv {
 	void __iomem *mapbase;
@@ -306,6 +307,9 @@ static int __devinit sh_mtu2_probe(struc
 	struct sh_mtu2_priv *p = platform_get_drvdata(pdev);
 	int ret;
 
+	if (!is_early_platform_device(pdev))
+		pm_genpd_dev_always_on(&pdev->dev, true);
+
 	if (p) {
 		dev_info(&pdev->dev, "kept as earlytimer\n");
 		return 0;

