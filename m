From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Fri, 07 Nov 2014 09:22:45 +0000
Subject: [PATCH] gpio-rcar: .irq_set_wake() support to work with suspend_device_irqs()
Message-Id: <1415352165-26597-1-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-gpio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>

All IRQs in the kernel get disabled by PM core prior to .suspend_noirq()
step through kernel/irq/pm.c::suspend_device_irqs().

The SYSC hardware block in the R-Car SoCs, on the other hand, uses any
interrupt as wake-up source(es) and requires them to be unmasked during
the system is suspended.

This patch implements .irq_set_wake() which makes __disable_irq() call
a NOP when a GPIO port is claimed as a wake-up source.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on for-next branch of Linus Walleij's gpio tree.

 drivers/gpio/gpio-rcar.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index bf6c094..ef71ca8 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -38,6 +38,7 @@ struct gpio_rcar_priv {
 	struct gpio_chip gpio_chip;
 	struct irq_chip irq_chip;
 	struct irq_domain *irq_domain;
+	u32 no_suspend; /* do not disable this GPIO port during suspend */
 };
 
 #define IOINTSEL 0x00
@@ -83,6 +84,15 @@ static void gpio_rcar_irq_disable(struct irq_data *d)
 {
 	struct gpio_rcar_priv *p = irq_data_get_irq_chip_data(d);
 
+	if (p->no_suspend & BIT(irqd_to_hwirq(d))) {
+		/*
+		 * This GPIO port is claimed as a wake-up source and
+		 * currently in a no-suspend-requested state.  Don't
+		 * disable this IRQ during suspend.
+		 */
+		return;
+	}
+
 	gpio_rcar_write(p, INTMSK, ~BIT(irqd_to_hwirq(d)));
 }
 
@@ -164,6 +174,20 @@ static int gpio_rcar_irq_set_type(struct irq_data *d, unsigned int type)
 	return 0;
 }
 
+static int gpio_rcar_irq_set_wake(struct irq_data *d, unsigned int on)
+{
+	struct gpio_rcar_priv *p = irq_data_get_irq_chip_data(d);
+	unsigned int hwirq = irqd_to_hwirq(d);
+
+	dev_dbg(&p->pdev->dev, "wake irq = %u %s\n", hwirq, on ? "on" : "off");
+
+	if (on)
+		p->no_suspend |= BIT(hwirq);
+	else
+		p->no_suspend &= ~BIT(hwirq);
+	return 0;
+}
+
 static irqreturn_t gpio_rcar_irq_handler(int irq, void *dev_id)
 {
 	struct gpio_rcar_priv *p = dev_id;
@@ -416,6 +440,7 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 	irq_chip->irq_mask = gpio_rcar_irq_disable;
 	irq_chip->irq_unmask = gpio_rcar_irq_enable;
 	irq_chip->irq_set_type = gpio_rcar_irq_set_type;
+	irq_chip->irq_set_wake = gpio_rcar_irq_set_wake;
 	irq_chip->flags	= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_SET_TYPE_MASKED
 			 | IRQCHIP_MASK_ON_SUSPEND;
 
-- 
1.9.1

