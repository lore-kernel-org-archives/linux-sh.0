From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 04 Dec 2013 12:05:46 +0000
Subject: [PATCH 01/02] irqchip: renesas-irqc: Use lazy disable
Message-Id: <20131204120546.29642.15772.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20131204120537.29642.942.sendpatchset@w520>
In-Reply-To: <20131204120537.29642.942.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

From: Magnus Damm <damm@opensource.se>

Set the ->irq_enable() and ->irq_disable() methods to NULL
to enable lazy disable of interrupts. This by itself provides
some level of optimization, but is mainly enabled as ground
work for future Suspend-to-RAM wake up support.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/irqchip/irq-renesas-irqc.c |    2 --
 1 file changed, 2 deletions(-)

--- 0001/drivers/irqchip/irq-renesas-irqc.c
+++ work/drivers/irqchip/irq-renesas-irqc.c	2013-12-04 18:12:45.000000000 +0900
@@ -212,8 +212,6 @@ static int irqc_probe(struct platform_de
 	irq_chip->name = name;
 	irq_chip->irq_mask = irqc_irq_disable;
 	irq_chip->irq_unmask = irqc_irq_enable;
-	irq_chip->irq_enable = irqc_irq_enable;
-	irq_chip->irq_disable = irqc_irq_disable;
 	irq_chip->irq_set_type = irqc_irq_set_type;
 	irq_chip->flags	= IRQCHIP_SKIP_SET_WAKE;
 
