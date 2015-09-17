From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Sep 2015 07:12:48 +0000
Subject: [PATCH 02/03] irqchip: renesas-irqc: Move over to generic chip
Message-Id: <20150917071248.29299.14240.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150917071230.29299.32326.sendpatchset@little-apple>
In-Reply-To: <20150917071230.29299.32326.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: jason@lakedaemon.net, geert+renesas@glider.be, linux-kernel@vger.kernel.org, horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

From: Magnus Damm <damm+renesas@opensource.se>

Convert the IRQC driver to rely on GENERIC_IRQ_CHIP.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/irqchip/Kconfig            |    1 
 drivers/irqchip/irq-renesas-irqc.c |   79 +++++++++++++-----------------------
 2 files changed, 31 insertions(+), 49 deletions(-)

--- 0001/drivers/irqchip/Kconfig
+++ work/drivers/irqchip/Kconfig	2015-09-15 20:15:00.880513000 +0900
@@ -123,6 +123,7 @@ config RENESAS_INTC_IRQPIN
 
 config RENESAS_IRQC
 	bool
+	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 
 config ST_IRQCHIP
--- 0001/drivers/irqchip/irq-renesas-irqc.c
+++ work/drivers/irqchip/irq-renesas-irqc.c	2015-09-15 20:17:18.200513000 +0900
@@ -62,33 +62,20 @@ struct irqc_priv {
 	struct irqc_irq irq[IRQC_IRQ_MAX];
 	unsigned int number_of_irqs;
 	struct platform_device *pdev;
-	struct irq_chip irq_chip;
+	struct irq_chip_generic *gc;
 	struct irq_domain *irq_domain;
 	struct clk *clk;
 };
 
-static void irqc_dbg(struct irqc_irq *i, char *str)
-{
-	dev_dbg(&i->p->pdev->dev, "%s (%d:%d)\n",
-		str, i->requested_irq, i->hw_irq);
-}
-
-static void irqc_irq_enable(struct irq_data *d)
+static struct irqc_priv *irq_data_to_priv(struct irq_data *data)
 {
-	struct irqc_priv *p = irq_data_get_irq_chip_data(d);
-	int hw_irq = irqd_to_hwirq(d);
-
-	irqc_dbg(&p->irq[hw_irq], "enable");
-	iowrite32(BIT(hw_irq), p->cpu_int_base + IRQC_EN_SET);
+	return data->domain->host_data;
 }
 
-static void irqc_irq_disable(struct irq_data *d)
+static void irqc_dbg(struct irqc_irq *i, char *str)
 {
-	struct irqc_priv *p = irq_data_get_irq_chip_data(d);
-	int hw_irq = irqd_to_hwirq(d);
-
-	irqc_dbg(&p->irq[hw_irq], "disable");
-	iowrite32(BIT(hw_irq), p->cpu_int_base + IRQC_EN_STS);
+	dev_dbg(&i->p->pdev->dev, "%s (%d:%d)\n",
+		str, i->requested_irq, i->hw_irq);
 }
 
 static unsigned char irqc_sense[IRQ_TYPE_SENSE_MASK + 1] = {
@@ -101,7 +88,7 @@ static unsigned char irqc_sense[IRQ_TYPE
 
 static int irqc_irq_set_type(struct irq_data *d, unsigned int type)
 {
-	struct irqc_priv *p = irq_data_get_irq_chip_data(d);
+	struct irqc_priv *p = irq_data_to_priv(d);
 	int hw_irq = irqd_to_hwirq(d);
 	unsigned char value = irqc_sense[type & IRQ_TYPE_SENSE_MASK];
 	u32 tmp;
@@ -120,7 +107,7 @@ static int irqc_irq_set_type(struct irq_
 
 static int irqc_irq_set_wake(struct irq_data *d, unsigned int on)
 {
-	struct irqc_priv *p = irq_data_get_irq_chip_data(d);
+	struct irqc_priv *p = irq_data_to_priv(d);
 
 	if (!p->clk)
 		return 0;
@@ -150,28 +137,11 @@ static irqreturn_t irqc_irq_handler(int
 	return IRQ_NONE;
 }
 
-static int irqc_irq_domain_map(struct irq_domain *h, unsigned int virq,
-			       irq_hw_number_t hw)
-{
-	struct irqc_priv *p = h->host_data;
-
-	irqc_dbg(&p->irq[hw], "map");
-	irq_set_chip_data(virq, h->host_data);
-	irq_set_chip_and_handler(virq, &p->irq_chip, handle_level_irq);
-	return 0;
-}
-
-static const struct irq_domain_ops irqc_irq_domain_ops = {
-	.map	= irqc_irq_domain_map,
-	.xlate  = irq_domain_xlate_twocell,
-};
-
 static int irqc_probe(struct platform_device *pdev)
 {
 	struct irqc_priv *p;
 	struct resource *io;
 	struct resource *irq;
-	struct irq_chip *irq_chip;
 	const char *name = dev_name(&pdev->dev);
 	int ret;
 	int k;
@@ -231,40 +201,51 @@ static int irqc_probe(struct platform_de
 
 	p->cpu_int_base = p->iomem + IRQC_INT_CPU_BASE(0); /* SYS-SPI */
 
-	irq_chip = &p->irq_chip;
-	irq_chip->name = name;
-	irq_chip->irq_mask = irqc_irq_disable;
-	irq_chip->irq_unmask = irqc_irq_enable;
-	irq_chip->irq_set_type = irqc_irq_set_type;
-	irq_chip->irq_set_wake = irqc_irq_set_wake;
-	irq_chip->flags	= IRQCHIP_MASK_ON_SUSPEND;
-
 	p->irq_domain = irq_domain_add_linear(pdev->dev.of_node,
 					      p->number_of_irqs,
-					      &irqc_irq_domain_ops, p);
+					      &irq_generic_chip_ops, p);
 	if (!p->irq_domain) {
 		ret = -ENXIO;
 		dev_err(&pdev->dev, "cannot initialize irq domain\n");
 		goto err2;
 	}
 
+	ret = irq_alloc_domain_generic_chips(p->irq_domain, p->number_of_irqs,
+					     1, name, handle_level_irq,
+					     0, 0, 0);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot allocate generic chip\n");
+		goto err3;
+	}
+
+	p->gc = irq_get_domain_generic_chip(p->irq_domain, 0);
+	p->gc->reg_base = p->cpu_int_base;
+	p->gc->chip_types[0].regs.enable = IRQC_EN_SET;
+	p->gc->chip_types[0].regs.disable = IRQC_EN_STS;
+	p->gc->chip_types[0].chip.irq_mask = irq_gc_mask_disable_reg;
+	p->gc->chip_types[0].chip.irq_unmask = irq_gc_unmask_enable_reg;
+	p->gc->chip_types[0].chip.irq_set_type	= irqc_irq_set_type;
+	p->gc->chip_types[0].chip.irq_set_wake	= irqc_irq_set_wake;
+	p->gc->chip_types[0].chip.flags	= IRQCHIP_MASK_ON_SUSPEND;
+
 	/* request interrupts one by one */
 	for (k = 0; k < p->number_of_irqs; k++) {
 		if (request_irq(p->irq[k].requested_irq, irqc_irq_handler,
 				0, name, &p->irq[k])) {
 			dev_err(&pdev->dev, "failed to request IRQ\n");
 			ret = -ENOENT;
-			goto err3;
+			goto err4;
 		}
 	}
 
 	dev_info(&pdev->dev, "driving %d irqs\n", p->number_of_irqs);
 
 	return 0;
-err3:
+err4:
 	while (--k >= 0)
 		free_irq(p->irq[k].requested_irq, &p->irq[k]);
 
+err3:
 	irq_domain_remove(p->irq_domain);
 err2:
 	iounmap(p->iomem);
