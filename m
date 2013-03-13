From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 13 Mar 2013 22:39:31 +0000
Subject: [PATCH 12/25] sh-pfc: Fix return value check in sh_pfc_register_pinctrl()
Message-Id: <1363214384-3870-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function pinctrl_register() returns NULL not
ERR_PTR(). The IS_ERR() test in the return value check should be
replaced with NULL test.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/pinctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
index c7f3c40..3e49bf0 100644
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -395,8 +395,8 @@ int sh_pfc_register_pinctrl(struct sh_pfc *pfc)
 	pmx->pctl_desc.npins = pfc->info->nr_pins;
 
 	pmx->pctl = pinctrl_register(&pmx->pctl_desc, pfc->dev, pmx);
-	if (IS_ERR(pmx->pctl))
-		return PTR_ERR(pmx->pctl);
+	if (pmx->pctl = NULL)
+		return -EINVAL;
 
 	return 0;
 }
-- 
1.8.1.5

