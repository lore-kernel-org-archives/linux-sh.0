From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Tue, 13 Mar 2012 00:27:07 +0000
Subject: [PATCH 5/6] PM / shmobile: Make CMT driver use pm_genpd_dev_always_on()
Message-Id: <201203130127.07634.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201203130123.16268.rjw@sisk.pl>
In-Reply-To: <201203130123.16268.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux-sh list <linux-sh@vger.kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Cao Minh Hiep <hiepcm@gmail.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Make the CMT clocksource driver mark its device as "always on"
using pm_genpd_dev_always_on() to protect it from surprise power
removals.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/clocksource/sh_cmt.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux/drivers/clocksource/sh_cmt.c
=================================--- linux.orig/drivers/clocksource/sh_cmt.c
+++ linux/drivers/clocksource/sh_cmt.c
@@ -32,6 +32,7 @@
 #include <linux/sh_timer.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/pm_domain.h>
 
 struct sh_cmt_priv {
 	void __iomem *mapbase;
@@ -689,6 +690,9 @@ static int __devinit sh_cmt_probe(struct
 	struct sh_cmt_priv *p = platform_get_drvdata(pdev);
 	int ret;
 
+	if (!is_early_platform_device(pdev))
+		pm_genpd_dev_always_on(&pdev->dev, true);
+
 	if (p) {
 		dev_info(&pdev->dev, "kept as earlytimer\n");
 		return 0;

