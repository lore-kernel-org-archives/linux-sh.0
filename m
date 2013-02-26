From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 26 Feb 2013 11:58:44 +0000
Subject: [PATCH 01/05] irqchip: intc-irqpin: Whitespace fixes
Message-Id: <20130226115844.5630.68157.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20130226115834.5630.45471.sendpatchset@w520>
In-Reply-To: <20130226115834.5630.45471.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: kuninori.morimoto.gx@renesas.com, linux-sh@vger.kernel.org, benh@kernel.crashing.org, grant.likely@secretlab.ca, horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

From: Magnus Damm <damm@opensource.se>

Remove whitespace damage and add newline
between variables and code.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Thanks to Simon Horman and Thomas Gleixner for feedback.

 drivers/irqchip/irq-renesas-intc-irqpin.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- 0002/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ work/drivers/irqchip/irq-renesas-intc-irqpin.c	2013-02-26 19:01:12.000000000 +0900
@@ -57,13 +57,13 @@ struct intc_irqpin_iomem {
 	unsigned long (*read)(void __iomem *iomem);
 	void (*write)(void __iomem *iomem, unsigned long data);
 	int width;
-};  
+};
 
 struct intc_irqpin_irq {
 	int hw_irq;
 	int irq;
 	struct intc_irqpin_priv *p;
-};  
+};
 
 struct intc_irqpin_priv {
 	struct intc_irqpin_iomem iomem[INTC_IRQPIN_REG_NR];
@@ -99,6 +99,7 @@ static inline unsigned long intc_irqpin_
 					     int reg)
 {
 	struct intc_irqpin_iomem *i = &p->iomem[reg];
+
 	return i->read(i->iomem);
 }
 
@@ -106,6 +107,7 @@ static inline void intc_irqpin_write(str
 				     int reg, unsigned long data)
 {
 	struct intc_irqpin_iomem *i = &p->iomem[reg];
+
 	i->write(i->iomem, data);
 }
 
@@ -405,7 +407,7 @@ static int intc_irqpin_probe(struct plat
 			dev_warn(&pdev->dev, "irq base mismatch (%d/%d)\n",
 				 p->config.irq_base, k);
 	}
-	
+
 	return 0;
 
 err3:
