From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 07 Oct 2015 10:51:33 +0000
Subject: [PATCH 1/2] irqchip/renesas-intc-irqpin: Remove obsolete platform data support
Message-Id: <1444215094-27159-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1444215094-27159-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1444215094-27159-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Since commit 4baadb9e05c68962 ("ARM: shmobile: r8a7778: remove obsolete
setup code"), all Renesas SoCs with a renesas-intc-irqpin module are
only supported in generic DT-only ARM multi-platform builds.  The driver
doesn't need to use platform data anymore, hence remove platform data
configuration.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Commit 4baadb9e05c68962 is now in arm-soc/for-next.
---
 drivers/irqchip/irq-renesas-intc-irqpin.c          | 38 +++++++---------------
 .../linux/platform_data/irq-renesas-intc-irqpin.h  | 29 -----------------
 2 files changed, 12 insertions(+), 55 deletions(-)
 delete mode 100644 include/linux/platform_data/irq-renesas-intc-irqpin.h

diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index 9525335723f6..75285ba0edee 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -31,7 +31,6 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
-#include <linux/platform_data/irq-renesas-intc-irqpin.h>
 #include <linux/pm_runtime.h>
 
 #define INTC_IRQPIN_MAX 8 /* maximum 8 interrupts per driver instance */
@@ -75,7 +74,7 @@ struct intc_irqpin_irq {
 struct intc_irqpin_priv {
 	struct intc_irqpin_iomem iomem[INTC_IRQPIN_REG_NR];
 	struct intc_irqpin_irq irq[INTC_IRQPIN_MAX];
-	struct renesas_intc_irqpin_config config;
+	unsigned int sense_bitfield_width;
 	unsigned int number_of_irqs;
 	struct platform_device *pdev;
 	struct irq_chip irq_chip;
@@ -171,7 +170,7 @@ static void intc_irqpin_mask_unmask_prio(struct intc_irqpin_priv *p,
 static int intc_irqpin_set_sense(struct intc_irqpin_priv *p, int irq, int value)
 {
 	/* The SENSE register is assumed to be 32-bit. */
-	int bitfield_width = p->config.sense_bitfield_width;
+	int bitfield_width = p->sense_bitfield_width;
 	int shift = 32 - (irq + 1) * bitfield_width;
 
 	dev_dbg(&p->pdev->dev, "sense irq = %d, mode = %d\n", irq, value);
@@ -376,7 +375,6 @@ MODULE_DEVICE_TABLE(of, intc_irqpin_dt_ids);
 static int intc_irqpin_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct renesas_intc_irqpin_config *pdata = dev->platform_data;
 	const struct of_device_id *of_id;
 	struct intc_irqpin_priv *p;
 	struct intc_irqpin_iomem *i;
@@ -386,6 +384,7 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 	void (*enable_fn)(struct irq_data *d);
 	void (*disable_fn)(struct irq_data *d);
 	const char *name = dev_name(dev);
+	bool control_parent;
 	int ref_irq;
 	int ret;
 	int k;
@@ -397,16 +396,11 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 	}
 
 	/* deal with driver instance configuration */
-	if (pdata) {
-		memcpy(&p->config, pdata, sizeof(*pdata));
-	} else {
-		of_property_read_u32(dev->of_node, "sense-bitfield-width",
-				     &p->config.sense_bitfield_width);
-		p->config.control_parent = of_property_read_bool(dev->of_node,
-								 "control-parent");
-	}
-	if (!p->config.sense_bitfield_width)
-		p->config.sense_bitfield_width = 4; /* default to 4 bits */
+	of_property_read_u32(dev->of_node, "sense-bitfield-width",
+			     &p->sense_bitfield_width);
+	control_parent = of_property_read_bool(dev->of_node, "control-parent");
+	if (!p->sense_bitfield_width)
+		p->sense_bitfield_width = 4; /* default to 4 bits */
 
 	p->pdev = pdev;
 	platform_set_drvdata(pdev, p);
@@ -513,7 +507,7 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 	}
 
 	/* use more severe masking method if requested */
-	if (p->config.control_parent) {
+	if (control_parent) {
 		enable_fn = intc_irqpin_irq_enable_force;
 		disable_fn = intc_irqpin_irq_disable_force;
 	} else if (!p->shared_irqs) {
@@ -532,10 +526,9 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 	irq_chip->irq_set_wake = intc_irqpin_irq_set_wake;
 	irq_chip->flags	= IRQCHIP_MASK_ON_SUSPEND;
 
-	p->irq_domain = irq_domain_add_simple(dev->of_node,
-					      p->number_of_irqs,
-					      p->config.irq_base,
-					      &intc_irqpin_irq_domain_ops, p);
+	p->irq_domain = irq_domain_add_simple(dev->of_node, p->number_of_irqs,
+					      0, &intc_irqpin_irq_domain_ops,
+					      p);
 	if (!p->irq_domain) {
 		ret = -ENXIO;
 		dev_err(dev, "cannot initialize irq domain\n");
@@ -570,13 +563,6 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 
 	dev_info(dev, "driving %d irqs\n", p->number_of_irqs);
 
-	/* warn in case of mismatch if irq base is specified */
-	if (p->config.irq_base) {
-		if (p->config.irq_base != p->irq[0].domain_irq)
-			dev_warn(dev, "irq base mismatch (%d/%d)\n",
-				 p->config.irq_base, p->irq[0].domain_irq);
-	}
-
 	return 0;
 
 err1:
diff --git a/include/linux/platform_data/irq-renesas-intc-irqpin.h b/include/linux/platform_data/irq-renesas-intc-irqpin.h
deleted file mode 100644
index e4cb911066a6..000000000000
--- a/include/linux/platform_data/irq-renesas-intc-irqpin.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * Renesas INTC External IRQ Pin Driver
- *
- *  Copyright (C) 2013 Magnus Damm
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#ifndef __IRQ_RENESAS_INTC_IRQPIN_H__
-#define __IRQ_RENESAS_INTC_IRQPIN_H__
-
-struct renesas_intc_irqpin_config {
-	unsigned int sense_bitfield_width;
-	unsigned int irq_base;
-	bool control_parent;
-};
-
-#endif /* __IRQ_RENESAS_INTC_IRQPIN_H__ */
-- 
1.9.1

