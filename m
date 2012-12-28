From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 28 Dec 2012 22:53:57 +0000
Subject: [PATCH v4 15/81] sh-pfc: Use devm_ioremap_nocache()
Message-Id: <1356735303-29474-16-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace probe-time ioremap_nocache() call with devm_ioremap_nocache()
and get rid of the corresponding iounmap() call.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/sh/pfc/core.c |   25 ++++---------------------
 1 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/sh/pfc/core.c b/drivers/sh/pfc/core.c
index 5491902..8ec57bd 100644
--- a/drivers/sh/pfc/core.c
+++ b/drivers/sh/pfc/core.c
@@ -26,15 +26,6 @@
 
 #include "core.h"
 
-static void pfc_iounmap(struct sh_pfc *pfc)
-{
-	int k;
-
-	for (k = 0; k < pfc->pdata->num_resources; k++)
-		if (pfc->window[k].virt)
-			iounmap(pfc->window[k].virt);
-}
-
 static int pfc_ioremap(struct sh_pfc *pfc)
 {
 	struct resource *res;
@@ -53,12 +44,10 @@ static int pfc_ioremap(struct sh_pfc *pfc)
 		WARN_ON(resource_type(res) != IORESOURCE_MEM);
 		pfc->window[k].phys = res->start;
 		pfc->window[k].size = resource_size(res);
-		pfc->window[k].virt = ioremap_nocache(res->start,
-							 resource_size(res));
-		if (!pfc->window[k].virt) {
-			pfc_iounmap(pfc);
+		pfc->window[k].virt = devm_ioremap_nocache(pfc->dev, res->start,
+							   resource_size(res));
+		if (!pfc->window[k].virt)
 			return -ENOMEM;
-		}
 	}
 
 	return 0;
@@ -524,7 +513,7 @@ static int sh_pfc_probe(struct platform_device *pdev)
 	 */
 	ret = sh_pfc_register_pinctrl(pfc);
 	if (unlikely(ret != 0))
-		goto err;
+		return ret;
 
 #ifdef CONFIG_GPIO_SH_PFC
 	/*
@@ -546,10 +535,6 @@ static int sh_pfc_probe(struct platform_device *pdev)
 	pr_info("%s support registered\n", pdata->name);
 
 	return 0;
-
-err:
-	pfc_iounmap(pfc);
-	return ret;
 }
 
 static int sh_pfc_remove(struct platform_device *pdev)
@@ -561,8 +546,6 @@ static int sh_pfc_remove(struct platform_device *pdev)
 #endif
 	sh_pfc_unregister_pinctrl(pfc);
 
-	pfc_iounmap(pfc);
-
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
-- 
1.7.8.6

