From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Mon, 15 Oct 2012 23:15:30 +0000
Subject: [PATCH 2/2] sh: intc: Add support OF of IRQ
Message-Id: <1350342930-25581-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add infomation of device node to struct intc_desc.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 drivers/sh/intc/core.c      |    2 +-
 drivers/sh/intc/internals.h |    3 ++-
 drivers/sh/intc/irqdomain.c |    6 +++---
 include/linux/sh_intc.h     |    1 +
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
index 8f32a13..3963af3 100644
--- a/drivers/sh/intc/core.c
+++ b/drivers/sh/intc/core.c
@@ -311,7 +311,7 @@ int __init register_intc_controller(struct intc_desc *desc)
 
 	BUG_ON(k > 256); /* _INTC_ADDR_E() and _INTC_ADDR_D() are 8 bits */
 
-	intc_irq_domain_init(d, hw);
+	intc_irq_domain_init(d, hw, desc->of_node);
 
 	/* register the vectors one by one */
 	for (i = 0; i < hw->nr_vectors; i++) {
diff --git a/drivers/sh/intc/internals.h b/drivers/sh/intc/internals.h
index 7dff08e..e6f64bf 100644
--- a/drivers/sh/intc/internals.h
+++ b/drivers/sh/intc/internals.h
@@ -190,7 +190,8 @@ void intc_enable_disable_enum(struct intc_desc *desc, struct intc_desc_int *d,
 			      intc_enum enum_id, int enable);
 
 /* irqdomain.c */
-void intc_irq_domain_init(struct intc_desc_int *d, struct intc_hw_desc *hw);
+void intc_irq_domain_init(struct intc_desc_int *d, struct intc_hw_desc *hw,
+				struct device_node *of_node);
 
 /* virq.c */
 void intc_subgroup_init(struct intc_desc *desc, struct intc_desc_int *d);
diff --git a/drivers/sh/intc/irqdomain.c b/drivers/sh/intc/irqdomain.c
index 3968f1c..22ab7af 100644
--- a/drivers/sh/intc/irqdomain.c
+++ b/drivers/sh/intc/irqdomain.c
@@ -42,7 +42,7 @@ static const struct irq_domain_ops intc_evt_ops = {
 };
 
 void __init intc_irq_domain_init(struct intc_desc_int *d,
-				 struct intc_hw_desc *hw)
+				 struct intc_hw_desc *hw, struct device_node *np)
 {
 	unsigned int irq_base, irq_end;
 
@@ -59,10 +59,10 @@ void __init intc_irq_domain_init(struct intc_desc_int *d,
 	 * tree penalty for linear cases with non-zero hwirq bases.
 	 */
 	if (irq_base = 0 && irq_end = (irq_base + hw->nr_vectors - 1))
-		d->domain = irq_domain_add_linear(NULL, hw->nr_vectors,
+		d->domain = irq_domain_add_linear(np, hw->nr_vectors,
 						  &intc_evt_ops, NULL);
 	else
-		d->domain = irq_domain_add_tree(NULL, &intc_evt_ops, NULL);
+		d->domain = irq_domain_add_tree(np, &intc_evt_ops, NULL);
 
 	BUG_ON(!d->domain);
 }
diff --git a/include/linux/sh_intc.h b/include/linux/sh_intc.h
index 455b1cc..75287cc 100644
--- a/include/linux/sh_intc.h
+++ b/include/linux/sh_intc.h
@@ -118,6 +118,7 @@ struct intc_desc {
 	intc_enum force_disable;
 	bool skip_syscore_suspend;
 	struct intc_hw_desc hw;
+	struct device_node *of_node;
 };
 
 #define DECLARE_INTC_DESC(symbol, chipname, vectors, groups,		\
-- 
1.7.10.4

