From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 12 Feb 2013 15:56:13 +0000
Subject: [PATCH] gpio: em: Use irq_domain_add_simple() to fix runtime error
Message-Id: <20130212155613.13396.44355.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Adjust the gpio-em.c driver to reconsider the pdata->irq_base
variable. Non-DT board code like for instance board-kzm9d.c
needs to operate of a static IRQ range for platform devices.

So this patch is updating the code to make use of the function
irq_domain_add_simple() instead of irq_domain_add_linear().

Fixes a EMEV2 / KZM9D runtime error caused by the following commit:
7385500 gpio/em: convert to linear IRQ domain

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---

 drivers/gpio/gpio-em.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- 0001/drivers/gpio/gpio-em.c
+++ work/drivers/gpio/gpio-em.c	2013-02-12 22:40:16.000000000 +0900
@@ -299,8 +299,9 @@ static int em_gio_probe(struct platform_
 	irq_chip->irq_set_type = em_gio_irq_set_type;
 	irq_chip->flags	= IRQCHIP_SKIP_SET_WAKE;
 
-	p->irq_domain = irq_domain_add_linear(pdev->dev.of_node,
+	p->irq_domain = irq_domain_add_simple(pdev->dev.of_node,
 					      pdata->number_of_pins,
+					      pdata->irq_base,
 					      &em_gio_irq_domain_ops, p);
 	if (!p->irq_domain) {
 		ret = -ENXIO;
