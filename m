From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 23 Jun 2015 13:48:02 +0000
Subject: [PATCH] gpio: em: Remove obsolete platform data support
Message-Id: <1435067282-17314-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Since commit 59032702ead90562 ("ARM: shmobile: Remove legacy platform
devices from EMEV2 SoC code"), EMMA Mobile SoCs are only supported in
generic DT-only ARM multi-platform builds.  The driver doesn't need to
use platform data anymore, hence remove platform data configuration.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only due to lack of hardware.

 drivers/gpio/gpio-em.c                | 34 ++++++++--------------------------
 include/linux/platform_data/gpio-em.h | 11 -----------
 2 files changed, 8 insertions(+), 37 deletions(-)
 delete mode 100644 include/linux/platform_data/gpio-em.h

diff --git a/drivers/gpio/gpio-em.c b/drivers/gpio/gpio-em.c
index fbf287307c4cc736..a77f16c8d1422db3 100644
--- a/drivers/gpio/gpio-em.c
+++ b/drivers/gpio/gpio-em.c
@@ -31,7 +31,6 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/pinctrl/consumer.h>
-#include <linux/platform_data/gpio-em.h>
 
 struct em_gio_priv {
 	void __iomem *base0;
@@ -273,13 +272,12 @@ static const struct irq_domain_ops em_gio_irq_domain_ops = {
 
 static int em_gio_probe(struct platform_device *pdev)
 {
-	struct gpio_em_config pdata_dt;
-	struct gpio_em_config *pdata = dev_get_platdata(&pdev->dev);
 	struct em_gio_priv *p;
 	struct resource *io[2], *irq[2];
 	struct gpio_chip *gpio_chip;
 	struct irq_chip *irq_chip;
 	const char *name = dev_name(&pdev->dev);
+	unsigned int ngpios;
 	int ret;
 
 	p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
@@ -319,18 +317,10 @@ static int em_gio_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
-	if (!pdata) {
-		memset(&pdata_dt, 0, sizeof(pdata_dt));
-		pdata = &pdata_dt;
-
-		if (of_property_read_u32(pdev->dev.of_node, "ngpios",
-					 &pdata->number_of_pins)) {
-			dev_err(&pdev->dev, "Missing ngpios OF property\n");
-			ret = -EINVAL;
-			goto err0;
-		}
-
-		pdata->gpio_base = -1;
+	if (of_property_read_u32(pdev->dev.of_node, "ngpios", &ngpios)) {
+		dev_err(&pdev->dev, "Missing ngpios OF property\n");
+		ret = -EINVAL;
+		goto err0;
 	}
 
 	gpio_chip = &p->gpio_chip;
@@ -345,8 +335,8 @@ static int em_gio_probe(struct platform_device *pdev)
 	gpio_chip->label = name;
 	gpio_chip->dev = &pdev->dev;
 	gpio_chip->owner = THIS_MODULE;
-	gpio_chip->base = pdata->gpio_base;
-	gpio_chip->ngpio = pdata->number_of_pins;
+	gpio_chip->base = -1;
+	gpio_chip->ngpio = ngpios;
 
 	irq_chip = &p->irq_chip;
 	irq_chip->name = name;
@@ -357,9 +347,7 @@ static int em_gio_probe(struct platform_device *pdev)
 	irq_chip->irq_release_resources = em_gio_irq_relres;
 	irq_chip->flags	= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND;
 
-	p->irq_domain = irq_domain_add_simple(pdev->dev.of_node,
-					      pdata->number_of_pins,
-					      pdata->irq_base,
+	p->irq_domain = irq_domain_add_simple(pdev->dev.of_node, ngpios, 0,
 					      &em_gio_irq_domain_ops, p);
 	if (!p->irq_domain) {
 		ret = -ENXIO;
@@ -387,12 +375,6 @@ static int em_gio_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
-	if (pdata->pctl_name) {
-		ret = gpiochip_add_pin_range(gpio_chip, pdata->pctl_name, 0,
-					     gpio_chip->base, gpio_chip->ngpio);
-		if (ret < 0)
-			dev_warn(&pdev->dev, "failed to add pin range\n");
-	}
 	return 0;
 
 err1:
diff --git a/include/linux/platform_data/gpio-em.h b/include/linux/platform_data/gpio-em.h
deleted file mode 100644
index 7c5a519d2dcde2bd..0000000000000000
--- a/include/linux/platform_data/gpio-em.h
+++ /dev/null
@@ -1,11 +0,0 @@
-#ifndef __GPIO_EM_H__
-#define __GPIO_EM_H__
-
-struct gpio_em_config {
-	unsigned int gpio_base;
-	unsigned int irq_base;
-	unsigned int number_of_pins;
-	const char *pctl_name;
-};
-
-#endif /* __GPIO_EM_H__ */
-- 
1.9.1

