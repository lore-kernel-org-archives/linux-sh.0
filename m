From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 06 Mar 2013 06:16:08 +0000
Subject: [PATCH] irqchip: intc-irqpin: Initial DT support
Message-Id: <20130306061608.5231.23213.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, benh@kernel.crashing.org, grant.likely@secretlab.ca, horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

From: Magnus Damm <damm@opensource.se>

Add initial DT support to the INTC External IRQ Pin
driver. At this point only hardware with 4-bit wide
sense registers is supported via DT.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/irqchip/irq-renesas-intc-irqpin.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- 0001/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ work/drivers/irqchip/irq-renesas-intc-irqpin.c	2013-03-06 14:59:58.000000000 +0900
@@ -278,6 +278,7 @@ static int intc_irqpin_irq_domain_map(st
 
 static struct irq_domain_ops intc_irqpin_irq_domain_ops = {
 	.map	= intc_irqpin_irq_domain_map,
+	.xlate  = irq_domain_xlate_twocell,
 };
 
 static int intc_irqpin_probe(struct platform_device *pdev)
@@ -437,11 +438,19 @@ static int intc_irqpin_remove(struct pla
 	return 0;
 }
 
+static const struct of_device_id intc_irqpin_dt_ids[] = {
+	{ .compatible = "renesas,intc-irqpin", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, intc_irqpin_dt_ids);
+
 static struct platform_driver intc_irqpin_device_driver = {
 	.probe		= intc_irqpin_probe,
 	.remove		= intc_irqpin_remove,
 	.driver		= {
 		.name	= "renesas_intc_irqpin",
+		.of_match_table = intc_irqpin_dt_ids,
+		.owner  = THIS_MODULE,
 	}
 };
 
