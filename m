From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 26 May 2015 11:34:02 +0000
Subject: [PATCH] gpio: pcf857x: Check for irq_set_irq_wake() failures
Message-Id: <1432640042-16650-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

If an interrupt controller doesn't support wake-up configuration,
irq_set_irq_wake() returns an error code.  Then any subsequent call
trying to deconfigure wake-up will cause an imbalance, and a warning
will be printed:

    WARNING: CPU: 1 PID: 1341 at kernel/irq/manage.c:540 irq_set_irq_wake+0x
    Unbalanced IRQ 26 wake disable

To fix this, refrain from any further parent interrupt controller
(de)configuration if irq_set_irq_wake() failed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpio/gpio-pcf857x.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-pcf857x.c b/drivers/gpio/gpio-pcf857x.c
index 945f0cda8529d38a..83db0e19ec7e6b49 100644
--- a/drivers/gpio/gpio-pcf857x.c
+++ b/drivers/gpio/gpio-pcf857x.c
@@ -91,6 +91,7 @@ struct pcf857x {
 	spinlock_t		slock;		/* protect irq demux */
 	unsigned		out;		/* software latch */
 	unsigned		status;		/* current status */
+	unsigned int		irq_parent;
 
 	int (*write)(struct i2c_client *client, unsigned data);
 	int (*read)(struct i2c_client *client);
@@ -217,9 +218,19 @@ static unsigned int noop_ret(struct irq_data *data)
 static int pcf857x_irq_set_wake(struct irq_data *data, unsigned int on)
 {
 	struct pcf857x *gpio = irq_data_get_irq_chip_data(data);
+	int error = 0;
+
+	if (gpio->irq_parent) {
+		error = irq_set_irq_wake(gpio->irq_parent, on);
+		if (error) {
+			dev_dbg(&gpio->client->dev,
+				"irq %u doesn't support irq_set_wake\n",
+				gpio->irq_parent);
+			gpio->irq_parent = 0;
+		}
+	}
 
-	irq_set_irq_wake(gpio->client->irq, on);
-	return 0;
+	return error;
 }
 
 static struct irq_chip pcf857x_irq_chip = {
@@ -364,6 +375,7 @@ static int pcf857x_probe(struct i2c_client *client,
 
 		gpiochip_set_chained_irqchip(&gpio->chip, &pcf857x_irq_chip,
 					     client->irq, NULL);
+		gpio->irq_parent = client->irq;
 	}
 
 	/* Let platform code set up the GPIOs and their users.
-- 
1.9.1

