From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Fri, 29 Nov 2013 13:32:20 +0000
Subject: [PATCH] gpio: rcar: Fix level interrupt handling
Message-Id: <1385731940-25359-1-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>

According to the manual, if a port is set for level detection using
the corresponding bit in the edge/level select register and an external
level interrupt signal is asserted, the corresponding bit in INTDT
does not use the FF to hold the input.
Thus, writing 1 to the corresponding bits in INTCLR cannot clear the
corresponding bits in the INTDT register. Instead, when an external
input signal is stopped, the corresponding bit in INTDT is cleared
automatically.

Since the INTDT bit cannot be cleared for the level interrupts until
the interrupt signal is stopped, we end up with the infinite loop
when using deferred (threaded) IRQ handling.

Workaround the issue by dropping level interrupts from the pending
mask once the interrupt is handled. If the IRQ is not cleared by the
handler, it will be invoked again when the interrupt is re-enabled.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 drivers/gpio/gpio-rcar.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index d3f15ae..918a1de 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -166,12 +166,18 @@ static int gpio_rcar_irq_set_type(struct irq_data *d, unsigned int type)
 static irqreturn_t gpio_rcar_irq_handler(int irq, void *dev_id)
 {
 	struct gpio_rcar_priv *p = dev_id;
-	u32 pending;
+	u32 pending, mask = 0;
 	unsigned int offset, irqs_handled = 0;
 
-	while ((pending = gpio_rcar_read(p, INTDT))) {
+	/*
+	 * Level interrupts cannot be cleared in the INTDT,
+	 * so we just drop them from the pending mask when
+	 * the interrupt is handled.
+	 */
+	while ((pending = gpio_rcar_read(p, INTDT) & ~mask)) {
 		offset = __ffs(pending);
 		gpio_rcar_write(p, INTCLR, BIT(offset));
+		mask |= BIT(offset) & ~gpio_rcar_read(p, EDGLEVEL);
 		generic_handle_irq(irq_find_mapping(p->irq_domain, offset));
 		irqs_handled++;
 	}
-- 
1.8.3.1

