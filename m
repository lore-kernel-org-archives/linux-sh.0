From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 18 Mar 2015 18:41:09 +0000
Subject: [PATCH 3/3] gpio: rcar: Prevent module clock disable when wake-up is enabled
Message-Id: <1426704069-26389-4-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1426704069-26389-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1426704069-26389-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

When the GPIO module is needed for wake-up, it's module clock must not
be disabled. Hence implement irq_chip.irq_set_wake(), which
increments/decrements the clock's enable_count when needed, and forwards
the wake-up state to the upstream interrupt controller.

This fixes wake-up from s2ram using gpio-keys when using a PM Domain to
manage the module clock.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
To avoid ugly warning messages during resume, this depends on the GIC
driver setting "gic_chip.flags = IRQCHIP_SKIP_SET_WAKE".
(cfr. http://marc.info/?l=linux-sh&m2669263324586&w=2).
---
 drivers/gpio/gpio-rcar.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index d96166ca1b42f93e..fd39774659484fa6 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -14,6 +14,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
@@ -37,6 +38,8 @@ struct gpio_rcar_priv {
 	struct platform_device *pdev;
 	struct gpio_chip gpio_chip;
 	struct irq_chip irq_chip;
+	unsigned int irq_parent;
+	struct clk *clk;
 };
 
 #define IOINTSEL 0x00	/* General IO/Interrupt Switching Register */
@@ -169,6 +172,25 @@ static int gpio_rcar_irq_set_type(struct irq_data *d, unsigned int type)
 	return 0;
 }
 
+static int gpio_rcar_irq_set_wake(struct irq_data *d, unsigned int on)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct gpio_rcar_priv *p = container_of(gc, struct gpio_rcar_priv,
+						gpio_chip);
+
+	irq_set_irq_wake(p->irq_parent, on);
+
+	if (!p->clk)
+		return 0;
+
+	if (on)
+		clk_enable(p->clk);
+	else
+		clk_disable(p->clk);
+
+	return 0;
+}
+
 static irqreturn_t gpio_rcar_irq_handler(int irq, void *dev_id)
 {
 	struct gpio_rcar_priv *p = dev_id;
@@ -367,6 +389,12 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, p);
 
+	p->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(p->clk)) {
+		dev_warn(dev, "unable to get clock\n");
+		p->clk = NULL;
+	}
+
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
@@ -404,8 +432,8 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 	irq_chip->irq_mask = gpio_rcar_irq_disable;
 	irq_chip->irq_unmask = gpio_rcar_irq_enable;
 	irq_chip->irq_set_type = gpio_rcar_irq_set_type;
-	irq_chip->flags	= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_SET_TYPE_MASKED
-			 | IRQCHIP_MASK_ON_SUSPEND;
+	irq_chip->irq_set_wake = gpio_rcar_irq_set_wake;
+	irq_chip->flags	= IRQCHIP_SET_TYPE_MASKED | IRQCHIP_MASK_ON_SUSPEND;
 
 	ret = gpiochip_add(gpio_chip);
 	if (ret) {
@@ -420,6 +448,7 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
+	p->irq_parent = irq->start;
 	if (devm_request_irq(dev, irq->start, gpio_rcar_irq_handler,
 			     IRQF_SHARED, name, p)) {
 		dev_err(dev, "failed to request IRQ\n");
-- 
1.9.1

