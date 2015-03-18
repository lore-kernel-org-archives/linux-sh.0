From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 18 Mar 2015 18:41:07 +0000
Subject: [PATCH 1/3] gpio: rcar: Use local variable gpio_chip in gpio_rcar_probe()
Message-Id: <1426704069-26389-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1426704069-26389-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1426704069-26389-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The existing variable gpio_chip already points to the gpiochip instance,
hence use it everywhere.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpio/gpio-rcar.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index c49522efa7b3bce4..e67d578ac07c45d5 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -413,7 +413,7 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
-	ret = gpiochip_irqchip_add(&p->gpio_chip, irq_chip, p->config.irq_base,
+	ret = gpiochip_irqchip_add(gpio_chip, irq_chip, p->config.irq_base,
 				   handle_level_irq, IRQ_TYPE_NONE);
 	if (ret) {
 		dev_err(dev, "cannot add irqchip\n");
@@ -431,7 +431,7 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 
 	/* warn in case of mismatch if irq base is specified */
 	if (p->config.irq_base) {
-		ret = irq_find_mapping(p->gpio_chip.irqdomain, 0);
+		ret = irq_find_mapping(gpio_chip->irqdomain, 0);
 		if (p->config.irq_base != ret)
 			dev_warn(dev, "irq base mismatch (%u/%u)\n",
 				 p->config.irq_base, ret);
@@ -447,7 +447,7 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 	return 0;
 
 err1:
-	gpiochip_remove(&p->gpio_chip);
+	gpiochip_remove(gpio_chip);
 err0:
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
-- 
1.9.1

