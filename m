From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 08 Mar 2013 10:55:54 +0000
Subject: [PATCH v4 13/29] sh-pfc: Don't needlessly check GPIO type in sh_gpio_free()
Message-Id: <1362740170-19073-14-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The GPIO type is always PINMUX_TYPE_FUNCTION when freeing a function
GPIO. Hardcode the type value.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/gpio.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/gpio.c b/drivers/pinctrl/sh-pfc/gpio.c
index 80a50d8..8f01113 100644
--- a/drivers/pinctrl/sh-pfc/gpio.c
+++ b/drivers/pinctrl/sh-pfc/gpio.c
@@ -71,16 +71,13 @@ static void sh_gpio_free(struct gpio_chip *gc, unsigned offset)
 {
 	struct sh_pfc *pfc = gpio_to_pfc(gc);
 	unsigned long flags;
-	int pinmux_type;
 
 	if (offset < pfc->info->nr_pins)
 		return pinctrl_free_gpio(offset);
 
 	spin_lock_irqsave(&pfc->lock, flags);
 
-	pinmux_type = pfc->info->gpios[offset].flags & PINMUX_FLAG_TYPE;
-
-	sh_pfc_config_gpio(pfc, offset, pinmux_type, GPIO_CFG_FREE);
+	sh_pfc_config_gpio(pfc, offset, PINMUX_TYPE_FUNCTION, GPIO_CFG_FREE);
 
 	spin_unlock_irqrestore(&pfc->lock, flags);
 }
-- 
1.8.1.5

