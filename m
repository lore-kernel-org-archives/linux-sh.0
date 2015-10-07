From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 07 Oct 2015 10:51:34 +0000
Subject: [PATCH 2/2] irqchip/renesas-intc-irqpin: Remove intc_irqpin_priv.number_of_irqs
Message-Id: <1444215094-27159-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1444215094-27159-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1444215094-27159-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

intc_irqpin_priv.number_of_irqs is used inside intc_irqpin_probe() only,
so it can just become a local variable.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/irqchip/irq-renesas-intc-irqpin.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index 75285ba0edee..1b4e5cc9f7df 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -75,7 +75,6 @@ struct intc_irqpin_priv {
 	struct intc_irqpin_iomem iomem[INTC_IRQPIN_REG_NR];
 	struct intc_irqpin_irq irq[INTC_IRQPIN_MAX];
 	unsigned int sense_bitfield_width;
-	unsigned int number_of_irqs;
 	struct platform_device *pdev;
 	struct irq_chip irq_chip;
 	struct irq_domain *irq_domain;
@@ -385,6 +384,7 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 	void (*disable_fn)(struct irq_data *d);
 	const char *name = dev_name(dev);
 	bool control_parent;
+	unsigned int nirqs;
 	int ref_irq;
 	int ret;
 	int k;
@@ -435,8 +435,8 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 		p->irq[k].requested_irq = irq->start;
 	}
 
-	p->number_of_irqs = k;
-	if (p->number_of_irqs < 1) {
+	nirqs = k;
+	if (nirqs < 1) {
 		dev_err(dev, "not enough IRQ resources\n");
 		ret = -EINVAL;
 		goto err0;
@@ -490,7 +490,7 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 	}
 
 	/* mask all interrupts using priority */
-	for (k = 0; k < p->number_of_irqs; k++)
+	for (k = 0; k < nirqs; k++)
 		intc_irqpin_mask_unmask_prio(p, k, 1);
 
 	/* clear all pending interrupts */
@@ -499,7 +499,7 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 	/* scan for shared interrupt lines */
 	ref_irq = p->irq[0].requested_irq;
 	p->shared_irqs = true;
-	for (k = 1; k < p->number_of_irqs; k++) {
+	for (k = 1; k < nirqs; k++) {
 		if (ref_irq != p->irq[k].requested_irq) {
 			p->shared_irqs = false;
 			break;
@@ -526,9 +526,8 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 	irq_chip->irq_set_wake = intc_irqpin_irq_set_wake;
 	irq_chip->flags	= IRQCHIP_MASK_ON_SUSPEND;
 
-	p->irq_domain = irq_domain_add_simple(dev->of_node, p->number_of_irqs,
-					      0, &intc_irqpin_irq_domain_ops,
-					      p);
+	p->irq_domain = irq_domain_add_simple(dev->of_node, nirqs, 0,
+					      &intc_irqpin_irq_domain_ops, p);
 	if (!p->irq_domain) {
 		ret = -ENXIO;
 		dev_err(dev, "cannot initialize irq domain\n");
@@ -546,7 +545,7 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 		}
 	} else {
 		/* request interrupts one by one */
-		for (k = 0; k < p->number_of_irqs; k++) {
+		for (k = 0; k < nirqs; k++) {
 			if (devm_request_irq(dev, p->irq[k].requested_irq,
 					     intc_irqpin_irq_handler, 0, name,
 					     &p->irq[k])) {
@@ -558,10 +557,10 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 	}
 
 	/* unmask all interrupts on prio level */
-	for (k = 0; k < p->number_of_irqs; k++)
+	for (k = 0; k < nirqs; k++)
 		intc_irqpin_mask_unmask_prio(p, k, 0);
 
-	dev_info(dev, "driving %d irqs\n", p->number_of_irqs);
+	dev_info(dev, "driving %d irqs\n", nirqs);
 
 	return 0;
 
-- 
1.9.1

