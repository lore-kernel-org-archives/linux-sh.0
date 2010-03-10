From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 10 Mar 2010 09:38:55 +0000
Subject: [PATCH] sh: INTC ioremap support V2
Message-Id: <20100310093855.5431.96000.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Extend the INTC code with ioremap() support V2.

Support INTC controllers that are not accessible through
a 1:1 virt:phys window. Needed by SH-Mobile ARM INTCS.

The INTC code behaves as usual if the io window resource
is omitted. The slow phys->virt lookup only happens during
setup. The fast path code operates on virtual addresses.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 INTC topic branch material

 Applies on top of the INTC memory error handling patch

 Changes since V1:
 - support multiple memory windows
 - use phys_addr_t and void __iomem *
 - error handling

 drivers/sh/intc.c       |   80 ++++++++++++++++++++++++++++++++++++++++++-----
 include/linux/sh_intc.h |    4 ++
 2 files changed, 76 insertions(+), 8 deletions(-)

--- 0014/drivers/sh/intc.c
+++ work/drivers/sh/intc.c	2010-03-10 17:38:40.000000000 +0900
@@ -43,6 +43,12 @@ struct intc_handle_int {
 	unsigned long handle;
 };
 
+struct intc_win {
+	phys_addr_t phys;
+	void __iomem *virt;
+	unsigned long size;
+};
+
 struct intc_desc_int {
 	struct list_head list;
 	struct sys_device sysdev;
@@ -56,6 +62,8 @@ struct intc_desc_int {
 	unsigned int nr_prio;
 	struct intc_handle_int *sense;
 	unsigned int nr_sense;
+	struct intc_win *win;
+	unsigned int nr_win;
 	struct irq_chip chip;
 };
 
@@ -420,11 +428,39 @@ static int intc_set_sense(unsigned int i
 	return 0;
 }
 
+static unsigned long intc_phys_to_virt(struct intc_desc_int *d,
+				       unsigned long address)
+{
+	struct intc_win *win;
+	int k;
+
+	/* scan through physical windows and convert address */
+	for (k = 0; k < d->nr_win; k++) {
+		win = d->win + k;
+
+		if (address < win->phys)
+			continue;
+
+		if (address >= (win->phys + win->size))
+			continue;
+
+		address -= win->phys;
+		address += (unsigned long)win->virt;
+
+		return address;
+	}
+
+	/* no windows defined, register must be 1:1 mapped virt:phys */
+	return address;
+}
+
 static unsigned int __init intc_get_reg(struct intc_desc_int *d,
-				 unsigned long address)
+					unsigned long address)
 {
 	unsigned int k;
 
+	address = intc_phys_to_virt(d, address);
+
 	for (k = 0; k < d->nr_reg; k++) {
 		if (d->reg[k] = address)
 			return k;
@@ -774,6 +810,8 @@ static unsigned int __init save_reg(stru
 				    unsigned int smp)
 {
 	if (value) {
+		value = intc_phys_to_virt(d, value);
+
 		d->reg[cnt] = value;
 #ifdef CONFIG_SMP
 		d->smp[cnt] = smp;
@@ -794,6 +832,7 @@ int __init register_intc_controller(stru
 	unsigned int i, k, smp;
 	struct intc_hw_desc *hw = &desc->hw;
 	struct intc_desc_int *d;
+	struct resource *res;
 
 	d = kzalloc(sizeof(*d), GFP_NOWAIT);
 	if (!d)
@@ -802,6 +841,25 @@ int __init register_intc_controller(stru
 	INIT_LIST_HEAD(&d->list);
 	list_add(&d->list, &intc_list);
 
+	if (desc->num_resources) {
+		d->nr_win = desc->num_resources;
+		d->win = kzalloc(d->nr_win * sizeof(*d->win), GFP_NOWAIT);
+		if (!d->win)
+			goto err1;
+
+		for (k = 0; k < d->nr_win; k++) {
+			res = desc->resource + k;
+			WARN_ON(resource_type(res) != IORESOURCE_MEM);
+			d->win[k].phys = res->start;
+			d->win[k].size = resource_size(res);
+			d->win[k].virt = ioremap_nocache(res->start,
+							 resource_size(res));
+
+			if (!d->win[k].virt)
+				goto err2;
+		}
+	}
+
 	d->nr_reg = hw->mask_regs ? hw->nr_mask_regs * 2 : 0;
 	d->nr_reg += hw->prio_regs ? hw->nr_prio_regs * 2 : 0;
 	d->nr_reg += hw->sense_regs ? hw->nr_sense_regs : 0;
@@ -809,12 +867,12 @@ int __init register_intc_controller(stru
 
 	d->reg = kzalloc(d->nr_reg * sizeof(*d->reg), GFP_NOWAIT);
 	if (!d->reg)
-		goto err1;
+		goto err2;
 
 #ifdef CONFIG_SMP
 	d->smp = kzalloc(d->nr_reg * sizeof(*d->smp), GFP_NOWAIT);
 	if (!d->smp)
-		goto err2;
+		goto err3;
 #endif
 	k = 0;
 
@@ -830,7 +888,7 @@ int __init register_intc_controller(stru
 		d->prio = kzalloc(hw->nr_vectors * sizeof(*d->prio),
 				  GFP_NOWAIT);
 		if (!d->prio)
-			goto err3;
+			goto err4;
 
 		for (i = 0; i < hw->nr_prio_regs; i++) {
 			smp = IS_SMP(hw->prio_regs[i]);
@@ -843,7 +901,7 @@ int __init register_intc_controller(stru
 		d->sense = kzalloc(hw->nr_vectors * sizeof(*d->sense),
 				   GFP_NOWAIT);
 		if (!d->sense)
-			goto err4;
+			goto err5;
 
 		for (i = 0; i < hw->nr_sense_regs; i++)
 			k += save_reg(d, k, hw->sense_regs[i].reg, 0);
@@ -925,14 +983,20 @@ int __init register_intc_controller(stru
 		intc_enable_disable_enum(desc, d, desc->force_enable, 1);
 
 	return 0;
- err4:
+ err5:
 	kfree(d->prio);
- err3:
+ err4:
 #ifdef CONFIG_SMP
 	kfree(d->smp);
- err2:
+ err3:
 #endif
 	kfree(d->reg);
+ err2:
+	if (d->win)
+		for (k = 0; k < d->nr_win; k++)
+			iounmap(d->win[k].virt);
+
+	kfree(d->win);
  err1:
 	kfree(d);
  err0:
--- 0014/include/linux/sh_intc.h
+++ work/include/linux/sh_intc.h	2010-03-10 17:38:16.000000000 +0900
@@ -1,6 +1,8 @@
 #ifndef __SH_INTC_H
 #define __SH_INTC_H
 
+#include <linux/ioport.h>
+
 typedef unsigned char intc_enum;
 
 struct intc_vect {
@@ -71,6 +73,8 @@ struct intc_hw_desc {
 
 struct intc_desc {
 	char *name;
+	struct resource *resource;
+	unsigned int num_resources;
 	intc_enum force_enable;
 	intc_enum force_disable;
 	struct intc_hw_desc hw;
