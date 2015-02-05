From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 05 Feb 2015 15:49:09 +0000
Subject: [PATCH 2/2] gpio: pcf857x: Propagate wake-up setting to parent irq controller
Message-Id: <1423151349-10579-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1423151349-10579-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1423151349-10579-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, George Cherian <george.cherian@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The pcf857x GPIO and interrupt controller uses dummy_irq_chip, which
does not implement irq_chip.irq_set_wake() and does not set
IRQCHIP_SKIP_SET_WAKE.

This causes two s2ram issues if wake-up is enabled for the pcf857x GPIO
pins:
  1. During resume from s2ram, the following warning is printed:

     WARNING: CPU: 0 PID: 1046 at kernel/irq/manage.c:537 irq_set_irq_wake+0x9c/0xf8()
     Unbalanced IRQ 113 wake disable

  2. Wake-up through the pcf857x GPIO pins may fail, as the parent
     interrupt controller may be suspended.

Migrate the pcf857x GPIO and interrupt controller from dummy_irq_chip to
its own irq_chip. This irq chip implements irq_chip.irq_set_wake() to
propagate its wake-up setting to the parent interrupt controller.

This fixes wake-up through gpio-keys on sh73a0/kzm9g, where the pcf857x
interrupt is cascaded to irq-renesas-intc-irqpin, and the latter must
not be suspended when wake-up is enabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Rebased on top of "gpio: pcf857x: Switch to use gpiolib irqchip
    helpers".
---
 drivers/gpio/gpio-pcf857x.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-pcf857x.c b/drivers/gpio/gpio-pcf857x.c
index 126c937321013445..945f0cda8529d38a 100644
--- a/drivers/gpio/gpio-pcf857x.c
+++ b/drivers/gpio/gpio-pcf857x.c
@@ -204,6 +204,36 @@ static irqreturn_t pcf857x_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/*
+ * NOP functions
+ */
+static void noop(struct irq_data *data) { }
+
+static unsigned int noop_ret(struct irq_data *data)
+{
+	return 0;
+}
+
+static int pcf857x_irq_set_wake(struct irq_data *data, unsigned int on)
+{
+	struct pcf857x *gpio = irq_data_get_irq_chip_data(data);
+
+	irq_set_irq_wake(gpio->client->irq, on);
+	return 0;
+}
+
+static struct irq_chip pcf857x_irq_chip = {
+	.name		= "pcf857x",
+	.irq_startup	= noop_ret,
+	.irq_shutdown	= noop,
+	.irq_enable	= noop,
+	.irq_disable	= noop,
+	.irq_ack	= noop,
+	.irq_mask	= noop,
+	.irq_unmask	= noop,
+	.irq_set_wake	= pcf857x_irq_set_wake,
+};
+
 /*-------------------------------------------------------------------------*/
 
 static int pcf857x_probe(struct i2c_client *client,
@@ -317,8 +347,9 @@ static int pcf857x_probe(struct i2c_client *client,
 
 	/* Enable irqchip if we have an interrupt */
 	if (client->irq) {
-		status = gpiochip_irqchip_add(&gpio->chip, &dummy_irq_chip, 0,
-					      handle_level_irq, IRQ_TYPE_NONE);
+		status = gpiochip_irqchip_add(&gpio->chip, &pcf857x_irq_chip,
+					      0, handle_level_irq,
+					      IRQ_TYPE_NONE);
 		if (status) {
 			dev_err(&client->dev, "cannot add irqchip\n");
 			goto fail_irq;
@@ -331,7 +362,7 @@ static int pcf857x_probe(struct i2c_client *client,
 		if (status)
 			goto fail_irq;
 
-		gpiochip_set_chained_irqchip(&gpio->chip, &dummy_irq_chip,
+		gpiochip_set_chained_irqchip(&gpio->chip, &pcf857x_irq_chip,
 					     client->irq, NULL);
 	}
 
-- 
1.9.1

