From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 22 Jul 2013 16:21:44 +0000
Subject: [PATCH v2 2/3] irqchip: intc-irqpin: pre-map all interrupts in the DT case
Message-Id: <1374510105-21896-3-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

In the DT case interrupts in the irq-renesas-intc-irqpin.c driver are
mapped dynamically only if requested by a user. This works fine, except
on sh73a0, where masking of IRQPIN interrupts on the irqpin controller
is broken and interrupts have to be masked on the parent instead. This
forced masking can only be done, if interrupts are also mapped without
being requested. This patch pre-maps interrupts in such a case during
probing.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

v2: in v1 spurious interrupts were mapped in the interrupt handler upon
their first occurrence. This version maps them all during probing instead.

 drivers/irqchip/irq-renesas-intc-irqpin.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index 82cec63..ca5a8b63 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -336,7 +336,7 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 	void (*enable_fn)(struct irq_data *d);
 	void (*disable_fn)(struct irq_data *d);
 	const char *name = dev_name(&pdev->dev);
-	int ref_irq;
+	int ref_irq, min_irq = INT_MAX;
 	int ret;
 	int k;
 
@@ -380,6 +380,8 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 
 		p->irq[k].p = p;
 		p->irq[k].requested_irq = irq->start;
+		if (min_irq > irq->start)
+			min_irq = irq->start;
 	}
 
 	p->number_of_irqs = k;
@@ -467,6 +469,12 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
+	if (pdev->dev.of_node && p->config.control_parent &&
+	    !p->config.irq_base)
+		for (k = 0; k < p->number_of_irqs; k++)
+			irq_create_mapping(p->irq_domain,
+					   p->irq[k].requested_irq - min_irq);
+
 	if (p->shared_irqs) {
 		/* request one shared interrupt */
 		if (devm_request_irq(&pdev->dev, p->irq[0].requested_irq,
-- 
1.7.2.5

