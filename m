From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 10 Mar 2013 18:58:38 +0000
Subject: [PATCH/RFC 02/12] gpio-rcar: Add pinctrl support
Message-Id: <1362941928-18115-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Register the GPIO pin range, and request and free GPIO pins using the
pinctrl API.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpio/gpio-rcar.c                | 23 +++++++++++++++++++++++
 include/linux/platform_data/gpio-rcar.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 68569cf..c402440 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -30,6 +30,7 @@
 #include <linux/gpio.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_data/gpio-rcar.h>
 
 struct gpio_rcar_priv {
@@ -205,6 +206,21 @@ static void gpio_rcar_config_general_input_output_mode(struct gpio_chip *chip,
 	spin_unlock_irqrestore(&p->lock, flags);
 }
 
+static int gpio_rcar_request(struct gpio_chip *chip, unsigned offset)
+{
+	return pinctrl_request_gpio(chip->base + offset);
+}
+
+static void gpio_rcar_free(struct gpio_chip *chip, unsigned offset)
+{
+	pinctrl_free_gpio(chip->base + offset);
+
+	/* Set the GPIO as an input to ensure that the next GPIO request won't
+	 * drive the GPIO pin as an output.
+	 */
+	gpio_rcar_config_general_input_output_mode(chip, offset, false);
+}
+
 static int gpio_rcar_direction_input(struct gpio_chip *chip, unsigned offset)
 {
 	gpio_rcar_config_general_input_output_mode(chip, offset, false);
@@ -307,6 +323,8 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 	}
 
 	gpio_chip = &p->gpio_chip;
+	gpio_chip->request = gpio_rcar_request;
+	gpio_chip->free = gpio_rcar_free;
 	gpio_chip->direction_input = gpio_rcar_direction_input;
 	gpio_chip->get = gpio_rcar_get;
 	gpio_chip->direction_output = gpio_rcar_direction_output;
@@ -358,6 +376,11 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 				 p->config.irq_base, ret);
 	}
 
+	ret = gpiochip_add_pin_range(gpio_chip, p->config.pctl_name, 0,
+				     gpio_chip->base, gpio_chip->ngpio);
+	if (ret < 0)
+		dev_warn(&pdev->dev, "failed to add pin range\n");
+
 	return 0;
 
 err4:
diff --git a/include/linux/platform_data/gpio-rcar.h b/include/linux/platform_data/gpio-rcar.h
index f457562..f3257ec 100644
--- a/include/linux/platform_data/gpio-rcar.h
+++ b/include/linux/platform_data/gpio-rcar.h
@@ -24,6 +24,7 @@ struct gpio_rcar_config {
 	unsigned int gpio_base;
 	unsigned int irq_base;
 	unsigned int number_of_pins;
+	const char *pctl_name;
 };
 
 #endif /* __GPIO_RCAR_H__ */
-- 
1.8.1.5

