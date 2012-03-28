From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 28 Mar 2012 06:57:56 +0000
Subject: [PATCH] sh: INTC IRQ domain and DT support prototype
Message-Id: <20120328065756.17270.2804.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This prototype patch hacks up IRQ Domain support for INTC.

Tested with DT on sh7372. Another incremental DT patch
for sh7372 is needed to make use of this feature.

Probably needs to be reworked into something better looking.

Not-yet-signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/sh/intc/chip.c      |    6 -
 drivers/sh/intc/core.c      |  149 ++++++++++++++++++++++++++++++++++++-------
 drivers/sh/intc/internals.h |    4 +
 include/linux/sh_intc.h     |    6 +
 4 files changed, 139 insertions(+), 26 deletions(-)

--- 0001/drivers/sh/intc/chip.c
+++ work/drivers/sh/intc/chip.c	2012-03-27 19:30:06.000000000 +0900
@@ -86,7 +86,7 @@ static void intc_mask_ack(struct irq_dat
 {
 	unsigned int irq = data->irq;
 	struct intc_desc_int *d = get_intc_desc(irq);
-	unsigned long handle = intc_get_ack_handle(irq);
+	unsigned long handle = intc_get_ack_handle(data->hwirq);
 	unsigned long addr;
 
 	intc_disable(data);
@@ -152,7 +152,7 @@ int intc_set_priority(unsigned int irq,
 	struct irq_data *data = irq_get_irq_data(irq);
 	struct intc_handle_int *ihp;
 
-	if (!intc_get_prio_level(irq) || prio <= 1)
+	if (!intc_get_prio_level(data->hwirq) || prio <= 1)
 		return -EINVAL;
 
 	ihp = intc_find_irq(d->prio, d->nr_prio, irq);
@@ -160,7 +160,7 @@ int intc_set_priority(unsigned int irq,
 		if (prio >= (1 << _INTC_WIDTH(ihp->handle)))
 			return -EINVAL;
 
-		intc_set_prio_level(irq, prio);
+		intc_set_prio_level(data->hwirq, prio);
 
 		/*
 		 * only set secondary masking method directly
--- 0001/drivers/sh/intc/core.c
+++ work/drivers/sh/intc/core.c	2012-03-27 19:30:58.000000000 +0900
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/interrupt.h>
@@ -31,6 +32,8 @@
 #include <linux/spinlock.h>
 #include <linux/radix-tree.h>
 #include <linux/export.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
 #include "internals.h"
 
 LIST_HEAD(intc_list);
@@ -49,9 +52,9 @@ unsigned int intc_get_dfl_prio_level(voi
 	return default_prio_level;
 }
 
-unsigned int intc_get_prio_level(unsigned int irq)
+unsigned int intc_get_prio_level(unsigned int hwirq)
 {
-	return intc_prio_level[irq];
+	return intc_prio_level[hwirq];
 }
 
 void intc_set_prio_level(unsigned int irq, unsigned int level)
@@ -71,6 +74,7 @@ static void intc_redirect_irq(unsigned i
 static void __init intc_register_irq(struct intc_desc *desc,
 				     struct intc_desc_int *d,
 				     intc_enum enum_id,
+				     unsigned int hwirq,
 				     unsigned int irq)
 {
 	struct intc_handle_int *hp;
@@ -125,7 +129,7 @@ static void __init intc_register_irq(str
 	/*
 	 * set priority level
 	 */
-	intc_set_prio_level(irq, intc_get_dfl_prio_level());
+	intc_set_prio_level(hwirq, intc_get_dfl_prio_level());
 
 	/* enable secondary masking method if present */
 	if (data[!primary])
@@ -159,8 +163,8 @@ static void __init intc_register_irq(str
 	/* irq should be disabled by default */
 	d->chip.irq_mask(irq_data);
 
-	intc_set_ack_handle(irq, desc, d, enum_id);
-	intc_set_dist_handle(irq, desc, d, enum_id);
+	intc_set_ack_handle(hwirq, desc, d, enum_id);
+	intc_set_dist_handle(hwirq, desc, d, enum_id);
 
 	activate_irq(irq);
 }
@@ -183,9 +187,36 @@ static unsigned int __init save_reg(stru
 	return 0;
 }
 
-int __init register_intc_controller(struct intc_desc *desc)
+#ifdef CONFIG_IRQ_DOMAIN
+static int intc_default_dt_translate(struct irq_domain *d,
+				     struct device_node *controller,
+				     const u32 *intspec, unsigned int intsize,
+				     unsigned long *out_hwirq,
+				     unsigned int *out_type)
+{
+	if (d->of_node != controller)
+		return -EINVAL;
+
+	if (intsize < 1)
+		return -EINVAL;
+
+	*out_hwirq = evt2irq(intspec[0]);
+	*out_type = 0;
+	return 0;
+}
+
+const struct irq_domain_ops intc_irq_domain_ops = {
+	.dt_translate = intc_default_dt_translate,
+};
+
+#endif /* CONFIG_IRQ_DOMAIN */
+
+static int __init __register_intc_controller(struct intc_desc *desc,
+					     struct device_node *node,
+					     struct device_node *parent,
+					     const struct irq_domain_ops *ops)
 {
-	unsigned int i, k, smp;
+	unsigned int i, k, n, smp;
 	struct intc_hw_desc *hw = &desc->hw;
 	struct intc_desc_int *d;
 	struct resource *res;
@@ -203,6 +234,58 @@ int __init register_intc_controller(stru
 	raw_spin_lock_init(&d->lock);
 	INIT_RADIX_TREE(&d->tree, GFP_ATOMIC);
 
+#ifdef CONFIG_IRQ_DOMAIN
+	d->domain.hwirq_base = ~0;
+	d->domain.nr_irq = 0;
+
+	/* determine actual range of IRQS for this controller */
+	for (i = 0; i < hw->nr_vectors; i++) {
+		struct intc_vect *vect = hw->vectors + i;
+		unsigned int irq = evt2irq(vect->vect);
+		
+		if (irq > d->domain.nr_irq)
+			d->domain.nr_irq = irq;
+
+		if (irq < d->domain.hwirq_base)
+			d->domain.hwirq_base = irq;
+	}
+
+	d->domain.nr_irq = (d->domain.nr_irq - d->domain.hwirq_base) + 1;
+
+	/* allocate non-root interrupt controllers dynamically.
+	 * the root interrupt controller remains static which allows
+	 * us to keep on supporting regular platform devices easily.
+	 */
+	if (parent) {
+		d->domain.nr_irq += d->domain.hwirq_base;
+		d->domain.hwirq_base = 0;
+
+		d->domain.irq_base = irq_alloc_descs(-1, d->domain.hwirq_base,
+						     d->domain.nr_irq,
+						     numa_node_id());
+	} else {
+		d->domain.irq_base = irq_alloc_descs(d->domain.hwirq_base,
+						     d->domain.hwirq_base,
+						     d->domain.nr_irq,
+						     numa_node_id());
+	}
+
+	pr_debug("intc: hw base = %d, nr = %d, sw base = %d\n",
+		 d->domain.hwirq_base, d->domain.nr_irq, d->domain.irq_base);
+
+	if (IS_ERR_VALUE(d->domain.irq_base)) {
+		pr_err("can't get irq_desc for %d\n", d->domain.hwirq_base);
+		goto err1;
+	}
+
+	if (node)
+		d->domain.of_node = of_node_get(node);
+
+	d->domain.priv = d;
+	d->domain.ops = ops ? ops : &intc_irq_domain_ops;
+	irq_domain_add(&d->domain);
+#endif
+
 	d->index = nr_intc_controllers;
 
 	if (desc->num_resources) {
@@ -212,14 +295,14 @@ int __init register_intc_controller(stru
 		if (!d->window)
 			goto err1;
 
-		for (k = 0; k < d->nr_windows; k++) {
-			res = desc->resource + k;
+		for (n = 0; n < d->nr_windows; n++) {
+			res = desc->resource + n;
 			WARN_ON(resource_type(res) != IORESOURCE_MEM);
-			d->window[k].phys = res->start;
-			d->window[k].size = resource_size(res);
-			d->window[k].virt = ioremap_nocache(res->start,
+			d->window[n].phys = res->start;
+			d->window[n].size = resource_size(res);
+			d->window[n].virt = ioremap_nocache(res->start,
 							 resource_size(res));
-			if (!d->window[k].virt)
+			if (!d->window[n].virt)
 				goto err2;
 		}
 	}
@@ -306,20 +389,23 @@ int __init register_intc_controller(stru
 	/* register the vectors one by one */
 	for (i = 0; i < hw->nr_vectors; i++) {
 		struct intc_vect *vect = hw->vectors + i;
-		unsigned int irq = evt2irq(vect->vect);
-		int res;
+		unsigned int hwirq = evt2irq(vect->vect);
+		unsigned int irq = hwirq;
 
 		if (!vect->enum_id)
 			continue;
 
-		res = irq_alloc_desc_at(irq, numa_node_id());
-		if (res != irq && res != -EEXIST) {
+#ifdef CONFIG_IRQ_DOMAIN
+		irq = irq_domain_to_irq(&d->domain, hwirq);
+#else
+		n = irq_alloc_desc_at(irq, numa_node_id());
+		if (n != irq && n != -EEXIST) {
 			pr_err("can't get irq_desc for %d\n", irq);
 			continue;
 		}
-
-		intc_irq_xlate_set(irq, vect->enum_id, d);
-		intc_register_irq(desc, d, vect->enum_id, irq);
+#endif
+		intc_irq_xlate_set(hwirq, vect->enum_id, d);
+		intc_register_irq(desc, d, vect->enum_id, hwirq, irq);
 
 		for (k = i + 1; k < hw->nr_vectors; k++) {
 			struct intc_vect *vect2 = hw->vectors + k;
@@ -333,12 +419,15 @@ int __init register_intc_controller(stru
 			 * IRQ support, each vector still needs to have
 			 * its own backing irq_desc.
 			 */
-			res = irq_alloc_desc_at(irq2, numa_node_id());
-			if (res != irq2 && res != -EEXIST) {
+#ifdef CONFIG_IRQ_DOMAIN
+			irq2 = irq_domain_to_irq(&d->domain, irq2);
+#else
+			n = irq_alloc_desc_at(irq2, numa_node_id());
+			if (n != irq2 && n != -EEXIST) {
 				pr_err("can't get irq_desc for %d\n", irq2);
 				continue;
 			}
-
+#endif
 			vect2->enum_id = 0;
 
 			/* redirect this interrupts to the first one */
@@ -381,6 +470,20 @@ err0:
 	return -ENOMEM;
 }
 
+int __init register_intc_controller(struct intc_desc *desc)
+{
+	return __register_intc_controller(desc, NULL, NULL, NULL);
+}
+
+int __init register_intc_controller_dt(struct intc_desc *desc,
+				       struct device_node *node,
+				       struct device_node *parent,
+				       const struct irq_domain_ops *ops)
+{
+	return __register_intc_controller(desc, node, parent, ops);
+}
+
+
 static int intc_suspend(void)
 {
 	struct intc_desc_int *d;
--- 0001/drivers/sh/intc/internals.h
+++ work/drivers/sh/intc/internals.h	2012-03-27 19:30:06.000000000 +0900
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <linux/radix-tree.h>
 #include <linux/device.h>
+#include <linux/irqdomain.h>
 
 #define _INTC_MK(fn, mode, addr_e, addr_d, width, shift) \
 	((shift) | ((width) << 5) | ((fn) << 9) | ((mode) << 13) | \
@@ -67,6 +68,9 @@ struct intc_desc_int {
 	struct intc_window *window;
 	unsigned int nr_windows;
 	struct irq_chip chip;
+#ifdef CONFIG_IRQ_DOMAIN
+	struct irq_domain domain;
+#endif
 	bool skip_suspend;
 };
 
--- 0001/include/linux/sh_intc.h
+++ work/include/linux/sh_intc.h	2012-03-27 19:30:06.000000000 +0900
@@ -116,6 +116,12 @@ struct intc_desc symbol __initdata = {
 }
 
 int register_intc_controller(struct intc_desc *desc);
+struct device_node;
+struct irq_domain_ops;
+int register_intc_controller_dt(struct intc_desc *desc,
+				struct device_node *node,
+				struct device_node *parent,
+				const struct irq_domain_ops *ops);
 void reserve_intc_vectors(struct intc_vect *vectors, unsigned int nr_vecs);
 int intc_set_priority(unsigned int irq, unsigned int prio);
 int intc_irq_lookup(const char *chipname, intc_enum enum_id);
