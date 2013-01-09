From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 09 Jan 2013 00:52:24 +0000
Subject: [PATCH v2 04/29] sh-pfc: Drop the sh_pfc_pinctrl spinlock
Message-Id: <1357692769-1432-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The spinlock is used to protect data that is only accessed sequentially
during initialization. Remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/pinctrl.c |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
index 11e0e13..472fcf5 100644
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -34,8 +34,6 @@ struct sh_pfc_pinctrl {
 
 	struct pinctrl_pin_desc *pads;
 	unsigned int nr_pads;
-
-	spinlock_t lock;
 };
 
 static int sh_pfc_get_groups_count(struct pinctrl_dev *pctldev)
@@ -331,7 +329,6 @@ static void sh_pfc_map_one_gpio(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx,
 				struct pinmux_gpio *gpio, unsigned offset)
 {
 	struct pinmux_data_reg *dummy;
-	unsigned long flags;
 	int bit;
 
 	gpio->flags &= ~PINMUX_FLAG_TYPE;
@@ -340,10 +337,7 @@ static void sh_pfc_map_one_gpio(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx,
 		gpio->flags |= PINMUX_TYPE_GPIO;
 	else {
 		gpio->flags |= PINMUX_TYPE_FUNCTION;
-
-		spin_lock_irqsave(&pmx->lock, flags);
 		pmx->nr_functions++;
-		spin_unlock_irqrestore(&pmx->lock, flags);
 	}
 }
 
@@ -394,7 +388,6 @@ static int sh_pfc_map_gpios(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 
 static int sh_pfc_map_functions(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 {
-	unsigned long flags;
 	int i, fn;
 
 	pmx->functions = devm_kzalloc(pfc->dev, pmx->nr_functions *
@@ -402,8 +395,6 @@ static int sh_pfc_map_functions(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 	if (unlikely(!pmx->functions))
 		return -ENOMEM;
 
-	spin_lock_irqsave(&pmx->lock, flags);
-
 	for (i = fn = 0; i < pmx->nr_pads; i++) {
 		struct pinmux_gpio *gpio = pfc->info->gpios + i;
 
@@ -411,8 +402,6 @@ static int sh_pfc_map_functions(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 			pmx->functions[fn++] = gpio;
 	}
 
-	spin_unlock_irqrestore(&pmx->lock, flags);
-
 	return 0;
 }
 
@@ -425,8 +414,6 @@ int sh_pfc_register_pinctrl(struct sh_pfc *pfc)
 	if (unlikely(!pmx))
 		return -ENOMEM;
 
-	spin_lock_init(&pmx->lock);
-
 	pmx->pfc = pfc;
 	pfc->pinctrl = pmx;
 
-- 
1.7.8.6

