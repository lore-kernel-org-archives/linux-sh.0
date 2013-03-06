From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 06 Mar 2013 06:23:39 +0000
Subject: [PATCH] irqchip: irqc: Add DT support
Message-Id: <20130306062339.5262.30625.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, benh@kernel.crashing.org, grant.likely@secretlab.ca, horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

From: Magnus Damm <damm@opensource.se>

Add DT support to the IRQC External IRQ Pin driver.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/irqchip/irq-renesas-irqc.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- 0001/drivers/irqchip/irq-renesas-irqc.c
+++ work/drivers/irqchip/irq-renesas-irqc.c	2013-03-06 15:01:42.000000000 +0900
@@ -145,6 +145,7 @@ static int irqc_irq_domain_map(struct ir
 
 static struct irq_domain_ops irqc_irq_domain_ops = {
 	.map	= irqc_irq_domain_map,
+	.xlate  = irq_domain_xlate_twocell,
 };
 
 static int irqc_probe(struct platform_device *pdev)
@@ -273,11 +274,19 @@ static int irqc_remove(struct platform_d
 	return 0;
 }
 
+static const struct of_device_id irqc_dt_ids[] = {
+	{ .compatible = "renesas,irqc", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, irqc_dt_ids);
+
 static struct platform_driver irqc_device_driver = {
 	.probe		= irqc_probe,
 	.remove		= irqc_remove,
 	.driver		= {
 		.name	= "renesas_irqc",
+		.of_match_table	= irqc_dt_ids,
+		.owner	= THIS_MODULE,
 	}
 };
 
