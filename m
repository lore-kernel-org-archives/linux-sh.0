From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 10 Jun 2016 10:05:03 +0000
Subject: [PATCH 3/3] pinctrl: sh-pfc: Convert to devm_gpiochip_add_data()
Message-Id: <1465553103-6345-4-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1465553103-6345-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1465553103-6345-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Ben Dooks <ben.dooks@codethink.co.uk>, Laxman Dewangan <ldewangan@nvidia.com>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

This allows to remove the .remove() callback, and all functions and data
it needed for its own bookkeeping.

Suggested-by: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/core.c   | 10 ----------
 drivers/pinctrl/sh-pfc/core.h   |  1 -
 drivers/pinctrl/sh-pfc/gpio.c   | 13 +------------
 drivers/pinctrl/sh-pfc/sh_pfc.h |  3 ---
 4 files changed, 1 insertion(+), 26 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 9b9cee06ec59aad3..a3b82041b6a22b13 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -598,15 +598,6 @@ static int sh_pfc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int sh_pfc_remove(struct platform_device *pdev)
-{
-#ifdef CONFIG_PINCTRL_SH_PFC_GPIO
-	sh_pfc_unregister_gpiochip(platform_get_drvdata(pdev));
-#endif
-
-	return 0;
-}
-
 static const struct platform_device_id sh_pfc_id_table[] = {
 #ifdef CONFIG_PINCTRL_PFC_SH7203
 	{ "pfc-sh7203", (kernel_ulong_t)&sh7203_pinmux_info },
@@ -650,7 +641,6 @@ static const struct platform_device_id sh_pfc_id_table[] = {
 
 static struct platform_driver sh_pfc_driver = {
 	.probe		= sh_pfc_probe,
-	.remove		= sh_pfc_remove,
 	.id_table	= sh_pfc_id_table,
 	.driver		= {
 		.name	= DRV_NAME,
diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
index 9dde6ea5e28f3a1b..0bbdea5849f41713 100644
--- a/drivers/pinctrl/sh-pfc/core.h
+++ b/drivers/pinctrl/sh-pfc/core.h
@@ -20,7 +20,6 @@ struct sh_pfc_pin_range {
 };
 
 int sh_pfc_register_gpiochip(struct sh_pfc *pfc);
-int sh_pfc_unregister_gpiochip(struct sh_pfc *pfc);
 
 int sh_pfc_register_pinctrl(struct sh_pfc *pfc);
 
diff --git a/drivers/pinctrl/sh-pfc/gpio.c b/drivers/pinctrl/sh-pfc/gpio.c
index 97dff6a09ff08115..6b5422766f13d7f8 100644
--- a/drivers/pinctrl/sh-pfc/gpio.c
+++ b/drivers/pinctrl/sh-pfc/gpio.c
@@ -318,7 +318,7 @@ sh_pfc_add_gpiochip(struct sh_pfc *pfc, int(*setup)(struct sh_pfc_chip *),
 	if (ret < 0)
 		return ERR_PTR(ret);
 
-	ret = gpiochip_add_data(&chip->gpio_chip, chip);
+	ret = devm_gpiochip_add_data(pfc->dev, &chip->gpio_chip, chip);
 	if (unlikely(ret < 0))
 		return ERR_PTR(ret);
 
@@ -399,18 +399,7 @@ int sh_pfc_register_gpiochip(struct sh_pfc *pfc)
 	chip = sh_pfc_add_gpiochip(pfc, gpio_function_setup, NULL);
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
-
-	pfc->func = chip;
 #endif /* CONFIG_SUPERH */
 
 	return 0;
 }
-
-int sh_pfc_unregister_gpiochip(struct sh_pfc *pfc)
-{
-	gpiochip_remove(&pfc->gpio->gpio_chip);
-#ifdef CONFIG_SUPERH
-	gpiochip_remove(&pfc->func->gpio_chip);
-#endif
-	return 0;
-}
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 5732752667e2654a..5e966c09434d969c 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -207,9 +207,6 @@ struct sh_pfc {
 	unsigned int nr_gpio_pins;
 
 	struct sh_pfc_chip *gpio;
-#ifdef CONFIG_SUPERH
-	struct sh_pfc_chip *func;
-#endif
 };
 
 struct sh_pfc_soc_operations {
-- 
1.9.1

