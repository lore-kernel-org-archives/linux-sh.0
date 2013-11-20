From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 Nov 2013 00:23:08 +0000
Subject: [PATCH 01/05 v2] gpio: rcar: Use lazy disable
Message-Id: <20131120002308.27342.34176.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20131120002259.27342.35575.sendpatchset@w520>
In-Reply-To: <20131120002259.27342.35575.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linus.walleij@linaro.org, grant.likely@secretlab.ca, horms@verge.net.au, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm@opensource.se>

Set the ->irq_enable() and ->irq_disable() methods to NULL
to enable lazy disable of interrupts. This by itself provides
some level of optimization, but is mainly enabled as ground
work for future Suspend-to-RAM wake up support.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/gpio/gpio-rcar.c |    2 --
 1 file changed, 2 deletions(-)

--- 0001/drivers/gpio/gpio-rcar.c
+++ work/drivers/gpio/gpio-rcar.c	2013-11-20 08:28:20.000000000 +0900
@@ -368,8 +368,6 @@ static int gpio_rcar_probe(struct platfo
 	irq_chip->name = name;
 	irq_chip->irq_mask = gpio_rcar_irq_disable;
 	irq_chip->irq_unmask = gpio_rcar_irq_enable;
-	irq_chip->irq_enable = gpio_rcar_irq_enable;
-	irq_chip->irq_disable = gpio_rcar_irq_disable;
 	irq_chip->irq_set_type = gpio_rcar_irq_set_type;
 	irq_chip->flags	= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_SET_TYPE_MASKED;
 
