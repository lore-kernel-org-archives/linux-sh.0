From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 Nov 2013 00:23:17 +0000
Subject: [PATCH 02/05 v2] gpio: rcar: Enable mask on suspend
Message-Id: <20131120002317.27342.34257.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20131120002259.27342.35575.sendpatchset@w520>
In-Reply-To: <20131120002259.27342.35575.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linus.walleij@linaro.org, grant.likely@secretlab.ca, horms@verge.net.au, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm@opensource.se>

Now when lazy interrupt disable has been enabled in the driver
then extend the code to set IRQCHIP_MASK_ON_SUSPEND which tells
the core that only IRQs marked as wakeups need to stay enabled
during Suspend-to-RAM.

Tested on the Lager board with GPIO-keys and Suspend-to-RAM.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/gpio/gpio-rcar.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- 0008/drivers/gpio/gpio-rcar.c
+++ work/drivers/gpio/gpio-rcar.c	2013-11-20 08:30:28.000000000 +0900
@@ -369,7 +369,8 @@ static int gpio_rcar_probe(struct platfo
 	irq_chip->irq_mask = gpio_rcar_irq_disable;
 	irq_chip->irq_unmask = gpio_rcar_irq_enable;
 	irq_chip->irq_set_type = gpio_rcar_irq_set_type;
-	irq_chip->flags	= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_SET_TYPE_MASKED;
+	irq_chip->flags	= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_SET_TYPE_MASKED
+			 | IRQCHIP_MASK_ON_SUSPEND;
 
 	p->irq_domain = irq_domain_add_simple(pdev->dev.of_node,
 					      p->config.number_of_pins,
