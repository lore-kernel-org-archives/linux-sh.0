From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 09 Feb 2010 04:24:46 +0000
Subject: [PATCH] sh: extend INTC with struct intc_hw_desc
Message-Id: <20100209042446.30785.32661.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch updates the INTC code by moving all vectors,
groups and registers from struct intc_desc to struct
intc_hw_desc.

The idea is that INTC tables should go from using the
macro(s) DECLARE_INTC_DESC..() only to using struct
intc_desc with name and hw initialized using the macro
INTC_HW_DESC(). This move makes it easy to initialize
an extended struct intc_desc in the future.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/sh/intc.c       |   88 ++++++++++++++++++++++++-----------------------
 include/linux/sh_intc.h |   31 ++++++++++------
 2 files changed, 65 insertions(+), 54 deletions(-)

--- 0001/drivers/sh/intc.c
+++ work/drivers/sh/intc.c	2010-02-09 12:42:30.000000000 +0900
@@ -400,11 +400,11 @@ static unsigned int __init intc_get_reg(
 static intc_enum __init intc_grp_id(struct intc_desc *desc,
 				    intc_enum enum_id)
 {
-	struct intc_group *g = desc->groups;
+	struct intc_group *g = desc->hw.groups;
 	unsigned int i, j;
 
-	for (i = 0; g && enum_id && i < desc->nr_groups; i++) {
-		g = desc->groups + i;
+	for (i = 0; g && enum_id && i < desc->hw.nr_groups; i++) {
+		g = desc->hw.groups + i;
 
 		for (j = 0; g->enum_ids[j]; j++) {
 			if (g->enum_ids[j] != enum_id)
@@ -421,12 +421,12 @@ static unsigned int __init intc_mask_dat
 					  struct intc_desc_int *d,
 					  intc_enum enum_id, int do_grps)
 {
-	struct intc_mask_reg *mr = desc->mask_regs;
+	struct intc_mask_reg *mr = desc->hw.mask_regs;
 	unsigned int i, j, fn, mode;
 	unsigned long reg_e, reg_d;
 
-	for (i = 0; mr && enum_id && i < desc->nr_mask_regs; i++) {
-		mr = desc->mask_regs + i;
+	for (i = 0; mr && enum_id && i < desc->hw.nr_mask_regs; i++) {
+		mr = desc->hw.mask_regs + i;
 
 		for (j = 0; j < ARRAY_SIZE(mr->enum_ids); j++) {
 			if (mr->enum_ids[j] != enum_id)
@@ -469,12 +469,12 @@ static unsigned int __init intc_prio_dat
 					  struct intc_desc_int *d,
 					  intc_enum enum_id, int do_grps)
 {
-	struct intc_prio_reg *pr = desc->prio_regs;
+	struct intc_prio_reg *pr = desc->hw.prio_regs;
 	unsigned int i, j, fn, mode, bit;
 	unsigned long reg_e, reg_d;
 
-	for (i = 0; pr && enum_id && i < desc->nr_prio_regs; i++) {
-		pr = desc->prio_regs + i;
+	for (i = 0; pr && enum_id && i < desc->hw.nr_prio_regs; i++) {
+		pr = desc->hw.prio_regs + i;
 
 		for (j = 0; j < ARRAY_SIZE(pr->enum_ids); j++) {
 			if (pr->enum_ids[j] != enum_id)
@@ -517,12 +517,12 @@ static unsigned int __init intc_ack_data
 					  struct intc_desc_int *d,
 					  intc_enum enum_id)
 {
-	struct intc_mask_reg *mr = desc->ack_regs;
+	struct intc_mask_reg *mr = desc->hw.ack_regs;
 	unsigned int i, j, fn, mode;
 	unsigned long reg_e, reg_d;
 
-	for (i = 0; mr && enum_id && i < desc->nr_ack_regs; i++) {
-		mr = desc->ack_regs + i;
+	for (i = 0; mr && enum_id && i < desc->hw.nr_ack_regs; i++) {
+		mr = desc->hw.ack_regs + i;
 
 		for (j = 0; j < ARRAY_SIZE(mr->enum_ids); j++) {
 			if (mr->enum_ids[j] != enum_id)
@@ -549,11 +549,11 @@ static unsigned int __init intc_sense_da
 					   struct intc_desc_int *d,
 					   intc_enum enum_id)
 {
-	struct intc_sense_reg *sr = desc->sense_regs;
+	struct intc_sense_reg *sr = desc->hw.sense_regs;
 	unsigned int i, j, fn, bit;
 
-	for (i = 0; sr && enum_id && i < desc->nr_sense_regs; i++) {
-		sr = desc->sense_regs + i;
+	for (i = 0; sr && enum_id && i < desc->hw.nr_sense_regs; i++) {
+		sr = desc->hw.sense_regs + i;
 
 		for (j = 0; j < ARRAY_SIZE(sr->enum_ids); j++) {
 			if (sr->enum_ids[j] != enum_id)
@@ -656,7 +656,7 @@ static void __init intc_register_irq(str
 	/* irq should be disabled by default */
 	d->chip.mask(irq);
 
-	if (desc->ack_regs)
+	if (desc->hw.ack_regs)
 		ack_handle[irq] = intc_ack_data(desc, d, enum_id);
 }
 
@@ -684,6 +684,7 @@ static void intc_redirect_irq(unsigned i
 void __init register_intc_controller(struct intc_desc *desc)
 {
 	unsigned int i, k, smp;
+	struct intc_hw_desc *hw = &desc->hw;
 	struct intc_desc_int *d;
 
 	d = kzalloc(sizeof(*d), GFP_NOWAIT);
@@ -691,10 +692,10 @@ void __init register_intc_controller(str
 	INIT_LIST_HEAD(&d->list);
 	list_add(&d->list, &intc_list);
 
-	d->nr_reg = desc->mask_regs ? desc->nr_mask_regs * 2 : 0;
-	d->nr_reg += desc->prio_regs ? desc->nr_prio_regs * 2 : 0;
-	d->nr_reg += desc->sense_regs ? desc->nr_sense_regs : 0;
-	d->nr_reg += desc->ack_regs ? desc->nr_ack_regs : 0;
+	d->nr_reg = hw->mask_regs ? hw->nr_mask_regs * 2 : 0;
+	d->nr_reg += hw->prio_regs ? hw->nr_prio_regs * 2 : 0;
+	d->nr_reg += hw->sense_regs ? hw->nr_sense_regs : 0;
+	d->nr_reg += hw->ack_regs ? hw->nr_ack_regs : 0;
 
 	d->reg = kzalloc(d->nr_reg * sizeof(*d->reg), GFP_NOWAIT);
 #ifdef CONFIG_SMP
@@ -702,30 +703,31 @@ void __init register_intc_controller(str
 #endif
 	k = 0;
 
-	if (desc->mask_regs) {
-		for (i = 0; i < desc->nr_mask_regs; i++) {
-			smp = IS_SMP(desc->mask_regs[i]);
-			k += save_reg(d, k, desc->mask_regs[i].set_reg, smp);
-			k += save_reg(d, k, desc->mask_regs[i].clr_reg, smp);
+	if (hw->mask_regs) {
+		for (i = 0; i < hw->nr_mask_regs; i++) {
+			smp = IS_SMP(hw->mask_regs[i]);
+			k += save_reg(d, k, hw->mask_regs[i].set_reg, smp);
+			k += save_reg(d, k, hw->mask_regs[i].clr_reg, smp);
 		}
 	}
 
-	if (desc->prio_regs) {
-		d->prio = kzalloc(desc->nr_vectors * sizeof(*d->prio), GFP_NOWAIT);
+	if (hw->prio_regs) {
+		d->prio = kzalloc(hw->nr_vectors * sizeof(*d->prio),
+				  GFP_NOWAIT);
 
-		for (i = 0; i < desc->nr_prio_regs; i++) {
-			smp = IS_SMP(desc->prio_regs[i]);
-			k += save_reg(d, k, desc->prio_regs[i].set_reg, smp);
-			k += save_reg(d, k, desc->prio_regs[i].clr_reg, smp);
+		for (i = 0; i < hw->nr_prio_regs; i++) {
+			smp = IS_SMP(hw->prio_regs[i]);
+			k += save_reg(d, k, hw->prio_regs[i].set_reg, smp);
+			k += save_reg(d, k, hw->prio_regs[i].clr_reg, smp);
 		}
 	}
 
-	if (desc->sense_regs) {
-		d->sense = kzalloc(desc->nr_vectors * sizeof(*d->sense), GFP_NOWAIT);
+	if (hw->sense_regs) {
+		d->sense = kzalloc(hw->nr_vectors * sizeof(*d->sense),
+				   GFP_NOWAIT);
 
-		for (i = 0; i < desc->nr_sense_regs; i++) {
-			k += save_reg(d, k, desc->sense_regs[i].reg, 0);
-		}
+		for (i = 0; i < hw->nr_sense_regs; i++)
+			k += save_reg(d, k, hw->sense_regs[i].reg, 0);
 	}
 
 	d->chip.name = desc->name;
@@ -738,9 +740,9 @@ void __init register_intc_controller(str
 	d->chip.set_type = intc_set_sense;
 	d->chip.set_wake = intc_set_wake;
 
-	if (desc->ack_regs) {
-		for (i = 0; i < desc->nr_ack_regs; i++)
-			k += save_reg(d, k, desc->ack_regs[i].set_reg, 0);
+	if (hw->ack_regs) {
+		for (i = 0; i < hw->nr_ack_regs; i++)
+			k += save_reg(d, k, hw->ack_regs[i].set_reg, 0);
 
 		d->chip.mask_ack = intc_mask_ack;
 	}
@@ -748,8 +750,8 @@ void __init register_intc_controller(str
 	BUG_ON(k > 256); /* _INTC_ADDR_E() and _INTC_ADDR_D() are 8 bits */
 
 	/* register the vectors one by one */
-	for (i = 0; i < desc->nr_vectors; i++) {
-		struct intc_vect *vect = desc->vectors + i;
+	for (i = 0; i < hw->nr_vectors; i++) {
+		struct intc_vect *vect = hw->vectors + i;
 		unsigned int irq = evt2irq(vect->vect);
 		struct irq_desc *irq_desc;
 
@@ -764,8 +766,8 @@ void __init register_intc_controller(str
 
 		intc_register_irq(desc, d, vect->enum_id, irq);
 
-		for (k = i + 1; k < desc->nr_vectors; k++) {
-			struct intc_vect *vect2 = desc->vectors + k;
+		for (k = i + 1; k < hw->nr_vectors; k++) {
+			struct intc_vect *vect2 = hw->vectors + k;
 			unsigned int irq2 = evt2irq(vect2->vect);
 
 			if (vect->enum_id != vect2->enum_id)
--- 0001/include/linux/sh_intc.h
+++ work/include/linux/sh_intc.h	2010-02-09 12:41:39.000000000 +0900
@@ -45,7 +45,7 @@ struct intc_sense_reg {
 #define INTC_SMP(stride, nr)
 #endif
 
-struct intc_desc {
+struct intc_hw_desc {
 	struct intc_vect *vectors;
 	unsigned int nr_vectors;
 	struct intc_group *groups;
@@ -56,29 +56,38 @@ struct intc_desc {
 	unsigned int nr_prio_regs;
 	struct intc_sense_reg *sense_regs;
 	unsigned int nr_sense_regs;
-	char *name;
 	struct intc_mask_reg *ack_regs;
 	unsigned int nr_ack_regs;
 };
 
 #define _INTC_ARRAY(a) a, sizeof(a)/sizeof(*a)
+#define INTC_HW_DESC(vectors, groups, mask_regs,	\
+		     prio_regs,	sense_regs, ack_regs)	\
+{							\
+	_INTC_ARRAY(vectors), _INTC_ARRAY(groups),	\
+	_INTC_ARRAY(mask_regs), _INTC_ARRAY(prio_regs),	\
+	_INTC_ARRAY(sense_regs), _INTC_ARRAY(ack_regs),	\
+}
+
+struct intc_desc {
+	char *name;
+	struct intc_hw_desc hw;
+};
+
 #define DECLARE_INTC_DESC(symbol, chipname, vectors, groups,		\
 	mask_regs, prio_regs, sense_regs)				\
 struct intc_desc symbol __initdata = {					\
-	_INTC_ARRAY(vectors), _INTC_ARRAY(groups),			\
-	_INTC_ARRAY(mask_regs), _INTC_ARRAY(prio_regs),			\
-	_INTC_ARRAY(sense_regs),					\
-	chipname,							\
+	.name = chipname,						\
+	.hw = INTC_HW_DESC(vectors, groups, mask_regs,			\
+			   prio_regs, sense_regs, NULL),		\
 }
 
 #define DECLARE_INTC_DESC_ACK(symbol, chipname, vectors, groups,	\
 	mask_regs, prio_regs, sense_regs, ack_regs)			\
 struct intc_desc symbol __initdata = {					\
-	_INTC_ARRAY(vectors), _INTC_ARRAY(groups),			\
-	_INTC_ARRAY(mask_regs), _INTC_ARRAY(prio_regs),			\
-	_INTC_ARRAY(sense_regs),					\
-	chipname,							\
-	_INTC_ARRAY(ack_regs),						\
+	.name = chipname,						\
+	.hw = INTC_HW_DESC(vectors, groups, mask_regs,			\
+			   prio_regs, sense_regs, ack_regs),		\
 }
 
 void __init register_intc_controller(struct intc_desc *desc);
