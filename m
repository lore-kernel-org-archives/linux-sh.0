From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Fri, 27 Jul 2012 22:07:04 +0000
Subject: [PATCH] sh: pfc: Fix build issues in pinctrl.c
Message-Id: <201207280007.04480.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>


First off, drivers/sh/pfc/pinctrl.c doesn't build after commit
5d589b0 (pinctrl: remove pinctrl_remove_gpio_range), because
sh_pfc_pinctrl_remove() uses the function that has been removed by
that commit.  Fix this by removing the pinctrl_remove_gpio_range()
call, which is not necessary any more, from sh_pfc_pinctrl_remove().

Second, the compiler complains correctly that there's an unused
local variable in sh_pfc_pinconf_set().  Fix this by removing the
definition of that variable.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/sh/pfc/pinctrl.c |    2 --
 1 file changed, 2 deletions(-)

Index: linux/drivers/sh/pfc/pinctrl.c
=================================--- linux.orig/drivers/sh/pfc/pinctrl.c
+++ linux/drivers/sh/pfc/pinctrl.c
@@ -276,7 +276,6 @@ static int sh_pfc_pinconf_set(struct pin
 			      unsigned long config)
 {
 	struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
-	struct sh_pfc *pfc = pmx->pfc;
 
 	/* Validate the new type */
 	if (config >= PINMUX_FLAG_TYPE)
@@ -481,7 +480,6 @@ static int __devexit sh_pfc_pinctrl_remo
 {
 	struct sh_pfc_pinctrl *pmx = platform_get_drvdata(pdev);
 
-	pinctrl_remove_gpio_range(pmx->pctl, &sh_pfc_gpio_range);
 	pinctrl_unregister(pmx->pctl);
 
 	platform_set_drvdata(pdev, NULL);
