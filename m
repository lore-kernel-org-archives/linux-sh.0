From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 20 Jul 2015 10:06:35 +0000
Subject: [PATCH 03/03] irqchip: renesas-irqc: Make use of irq_find_mapping()
Message-Id: <20150720100635.2552.20906.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150720100602.2552.85507.sendpatchset@little-apple>
In-Reply-To: <20150720100602.2552.85507.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: jason@lakedaemon.net, geert+renesas@glider.be, linux-kernel@vger.kernel.org, horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

From: Magnus Damm <damm+renesas@opensource.se>

Instead of locally caching the virq as domain_irq
simply rely on the IRQ domain code and irq_find_mapping().
This reduces the delta between the IRQC driver and
the generic chip implementation.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/irqchip/irq-renesas-irqc.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

--- 0003/drivers/irqchip/irq-renesas-irqc.c
+++ work/drivers/irqchip/irq-renesas-irqc.c	2015-07-20 17:59:13.000000000 +0900
@@ -53,7 +53,6 @@
 struct irqc_irq {
 	int hw_irq;
 	int requested_irq;
-	int domain_irq;
 	struct irqc_priv *p;
 };
 
@@ -70,8 +69,8 @@ struct irqc_priv {
 
 static void irqc_dbg(struct irqc_irq *i, char *str)
 {
-	dev_dbg(&i->p->pdev->dev, "%s (%d:%d:%d)\n",
-		str, i->requested_irq, i->hw_irq, i->domain_irq);
+	dev_dbg(&i->p->pdev->dev, "%s (%d:%d)\n",
+		str, i->requested_irq, i->hw_irq);
 }
 
 static void irqc_irq_enable(struct irq_data *d)
@@ -145,7 +144,7 @@ static irqreturn_t irqc_irq_handler(int
 	if (ioread32(p->iomem + DETECT_STATUS) & bit) {
 		iowrite32(bit, p->iomem + DETECT_STATUS);
 		irqc_dbg(i, "demux2");
-		generic_handle_irq(i->domain_irq);
+		generic_handle_irq(irq_find_mapping(p->irq_domain, i->hw_irq));
 		return IRQ_HANDLED;
 	}
 	return IRQ_NONE;
@@ -156,9 +155,6 @@ static int irqc_irq_domain_map(struct ir
 {
 	struct irqc_priv *p = h->host_data;
 
-	p->irq[hw].domain_irq = virq;
-	p->irq[hw].hw_irq = hw;
-
 	irqc_dbg(&p->irq[hw], "map");
 	irq_set_chip_data(virq, h->host_data);
 	irq_set_chip_and_handler(virq, &p->irq_chip, handle_level_irq);
@@ -214,6 +210,7 @@ static int irqc_probe(struct platform_de
 			break;
 
 		p->irq[k].p = p;
+		p->irq[k].hw_irq = k;
 		p->irq[k].requested_irq = irq->start;
 	}
 
