From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 05 Feb 2015 15:49:08 +0000
Subject: [PATCH 1/2] [RFC] gpio: pcf857x: Switch to use gpiolib irqchip helpers
Message-Id: <1423151349-10579-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1423151349-10579-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1423151349-10579-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, George Cherian <george.cherian@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Switch the PCF857x GPIO driver to use the gpiolib irqchip helpers.
This driver uses a nested threaded interrupt, hence handle_nested_irq()
and gpiochip_set_chained_irqchip() must be used.

Note that this removes the checks added in commit 21fd3cd1874a2ac8
("gpio: pcf857x: call the gpio user handler iff gpio_to_irq is done"),
as the interrupt mappings are no longer created on-demand by the driver,
but by gpiochip_irqchip_add() during initialization.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Does the removal of the checks cause problems for anyone?
---
 drivers/gpio/Kconfig        |   1 +
 drivers/gpio/gpio-pcf857x.c | 121 ++++++++++----------------------------------
 2 files changed, 28 insertions(+), 94 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index ae5cb4d517c69885..9343b4cd20b459c6 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -604,6 +604,7 @@ config GPIO_PCA953X_IRQ
 config GPIO_PCF857X
 	tristate "PCF857x, PCA{85,96}7x, and MAX732[89] I2C GPIO expanders"
 	depends on I2C
+	select GPIOLIB_IRQCHIP
 	select IRQ_DOMAIN
 	help
 	  Say yes here to provide access to most "quasi-bidirectional" I2C
diff --git a/drivers/gpio/gpio-pcf857x.c b/drivers/gpio/gpio-pcf857x.c
index 236708ad0a5ba0ab..126c937321013445 100644
--- a/drivers/gpio/gpio-pcf857x.c
+++ b/drivers/gpio/gpio-pcf857x.c
@@ -88,11 +88,9 @@ struct pcf857x {
 	struct gpio_chip	chip;
 	struct i2c_client	*client;
 	struct mutex		lock;		/* protect 'out' */
-	struct irq_domain	*irq_domain;	/* for irq demux  */
 	spinlock_t		slock;		/* protect irq demux */
 	unsigned		out;		/* software latch */
 	unsigned		status;		/* current status */
-	unsigned		irq_mapped;	/* mapped gpio irqs */
 
 	int (*write)(struct i2c_client *client, unsigned data);
 	int (*read)(struct i2c_client *client);
@@ -182,18 +180,6 @@ static void pcf857x_set(struct gpio_chip *chip, unsigned offset, int value)
 
 /*-------------------------------------------------------------------------*/
 
-static int pcf857x_to_irq(struct gpio_chip *chip, unsigned offset)
-{
-	struct pcf857x *gpio = container_of(chip, struct pcf857x, chip);
-	int ret;
-
-	ret = irq_create_mapping(gpio->irq_domain, offset);
-	if (ret > 0)
-		gpio->irq_mapped |= (1 << offset);
-
-	return ret;
-}
-
 static irqreturn_t pcf857x_irq(int irq, void *data)
 {
 	struct pcf857x  *gpio = data;
@@ -208,9 +194,9 @@ static irqreturn_t pcf857x_irq(int irq, void *data)
 	 * interrupt source, just to avoid bad irqs
 	 */
 
-	change = ((gpio->status ^ status) & gpio->irq_mapped);
+	change = (gpio->status ^ status);
 	for_each_set_bit(i, &change, gpio->chip.ngpio)
-		generic_handle_irq(irq_find_mapping(gpio->irq_domain, i));
+		handle_nested_irq(irq_find_mapping(gpio->chip.irqdomain, i));
 	gpio->status = status;
 
 	spin_unlock_irqrestore(&gpio->slock, flags);
@@ -218,66 +204,6 @@ static irqreturn_t pcf857x_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int pcf857x_irq_domain_map(struct irq_domain *domain, unsigned int irq,
-				 irq_hw_number_t hw)
-{
-	struct pcf857x *gpio = domain->host_data;
-
-	irq_set_chip_and_handler(irq,
-				 &dummy_irq_chip,
-				 handle_level_irq);
-#ifdef CONFIG_ARM
-	set_irq_flags(irq, IRQF_VALID);
-#else
-	irq_set_noprobe(irq);
-#endif
-	gpio->irq_mapped |= (1 << hw);
-
-	return 0;
-}
-
-static struct irq_domain_ops pcf857x_irq_domain_ops = {
-	.map	= pcf857x_irq_domain_map,
-};
-
-static void pcf857x_irq_domain_cleanup(struct pcf857x *gpio)
-{
-	if (gpio->irq_domain)
-		irq_domain_remove(gpio->irq_domain);
-
-}
-
-static int pcf857x_irq_domain_init(struct pcf857x *gpio,
-				   struct i2c_client *client)
-{
-	int status;
-
-	gpio->irq_domain = irq_domain_add_linear(client->dev.of_node,
-						 gpio->chip.ngpio,
-						 &pcf857x_irq_domain_ops,
-						 gpio);
-	if (!gpio->irq_domain)
-		goto fail;
-
-	/* enable real irq */
-	status = devm_request_threaded_irq(&client->dev, client->irq,
-				NULL, pcf857x_irq, IRQF_ONESHOT |
-				IRQF_TRIGGER_FALLING | IRQF_SHARED,
-				dev_name(&client->dev), gpio);
-
-	if (status)
-		goto fail;
-
-	/* enable gpio_to_irq() */
-	gpio->chip.to_irq	= pcf857x_to_irq;
-
-	return 0;
-
-fail:
-	pcf857x_irq_domain_cleanup(gpio);
-	return -EINVAL;
-}
-
 /*-------------------------------------------------------------------------*/
 
 static int pcf857x_probe(struct i2c_client *client,
@@ -314,15 +240,6 @@ static int pcf857x_probe(struct i2c_client *client,
 	gpio->chip.direction_output	= pcf857x_output;
 	gpio->chip.ngpio		= id->driver_data;
 
-	/* enable gpio_to_irq() if platform has settings */
-	if (client->irq) {
-		status = pcf857x_irq_domain_init(gpio, client);
-		if (status < 0) {
-			dev_err(&client->dev, "irq_domain init failed\n");
-			goto fail_irq_domain;
-		}
-	}
-
 	/* NOTE:  the OnSemi jlc1562b is also largely compatible with
 	 * these parts, notably for output.  It has a low-resolution
 	 * DAC instead of pin change IRQs; and its inputs can be the
@@ -398,6 +315,26 @@ static int pcf857x_probe(struct i2c_client *client,
 	if (status < 0)
 		goto fail;
 
+	/* Enable irqchip if we have an interrupt */
+	if (client->irq) {
+		status = gpiochip_irqchip_add(&gpio->chip, &dummy_irq_chip, 0,
+					      handle_level_irq, IRQ_TYPE_NONE);
+		if (status) {
+			dev_err(&client->dev, "cannot add irqchip\n");
+			goto fail_irq;
+		}
+
+		status = devm_request_threaded_irq(&client->dev, client->irq,
+					NULL, pcf857x_irq, IRQF_ONESHOT |
+					IRQF_TRIGGER_FALLING | IRQF_SHARED,
+					dev_name(&client->dev), gpio);
+		if (status)
+			goto fail_irq;
+
+		gpiochip_set_chained_irqchip(&gpio->chip, &dummy_irq_chip,
+					     client->irq, NULL);
+	}
+
 	/* Let platform code set up the GPIOs and their users.
 	 * Now is the first time anyone could use them.
 	 */
@@ -413,13 +350,12 @@ static int pcf857x_probe(struct i2c_client *client,
 
 	return 0;
 
-fail:
-	if (client->irq)
-		pcf857x_irq_domain_cleanup(gpio);
+fail_irq:
+	gpiochip_remove(&gpio->chip);
 
-fail_irq_domain:
-	dev_dbg(&client->dev, "probe error %d for '%s'\n",
-		status, client->name);
+fail:
+	dev_dbg(&client->dev, "probe error %d for '%s'\n", status,
+		client->name);
 
 	return status;
 }
@@ -441,9 +377,6 @@ static int pcf857x_remove(struct i2c_client *client)
 		}
 	}
 
-	if (client->irq)
-		pcf857x_irq_domain_cleanup(gpio);
-
 	gpiochip_remove(&gpio->chip);
 	return status;
 }
-- 
1.9.1

