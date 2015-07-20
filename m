From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 20 Jul 2015 10:06:25 +0000
Subject: [PATCH 02/03] irqchip: renesas-irqc: Use linear IRQ domain
Message-Id: <20150720100625.2552.63939.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150720100602.2552.85507.sendpatchset@little-apple>
In-Reply-To: <20150720100602.2552.85507.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: jason@lakedaemon.net, geert+renesas@glider.be, linux-kernel@vger.kernel.org, horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

From: Magnus Damm <damm+renesas@opensource.se>

Use linear IRQ domain instead of irq_domain_add_simple()
that also handles non-DT cases. This reduces the delta
between the IRQC code and the generic chip implementation.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/irqchip/irq-renesas-irqc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- 0002/drivers/irqchip/irq-renesas-irqc.c
+++ work/drivers/irqchip/irq-renesas-irqc.c	2015-07-20 18:42:39.762366518 +0900
@@ -242,8 +242,8 @@ static int irqc_probe(struct platform_de
 	irq_chip->irq_set_wake = irqc_irq_set_wake;
 	irq_chip->flags	= IRQCHIP_MASK_ON_SUSPEND;
 
-	p->irq_domain = irq_domain_add_simple(pdev->dev.of_node,
-					      p->number_of_irqs, 0,
+	p->irq_domain = irq_domain_add_linear(pdev->dev.of_node,
+					      p->number_of_irqs,
 					      &irqc_irq_domain_ops, p);
 	if (!p->irq_domain) {
 		ret = -ENXIO;
