From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Thu, 26 Jul 2012 02:58:42 +0000
Subject: [PATCH] sh: pfc: remove pinctrl_remove_gpio_range function
Message-Id: <1343271522-3060-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The pinctrl_remove_gpio_range was removed form pinctrl framework.
And the ranges of GPIO will be automatically removed when the pinctrl
driver is unregistered.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 drivers/sh/pfc/pinctrl.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/sh/pfc/pinctrl.c b/drivers/sh/pfc/pinctrl.c
index 0802b6c..10a56d7 100644
--- a/drivers/sh/pfc/pinctrl.c
+++ b/drivers/sh/pfc/pinctrl.c
@@ -481,7 +481,6 @@ static int __devexit sh_pfc_pinctrl_remove(struct platform_device *pdev)
 {
 	struct sh_pfc_pinctrl *pmx = platform_get_drvdata(pdev);
 
-	pinctrl_remove_gpio_range(pmx->pctl, &sh_pfc_gpio_range);
 	pinctrl_unregister(pmx->pctl);
 
 	platform_set_drvdata(pdev, NULL);
-- 
1.7.10

