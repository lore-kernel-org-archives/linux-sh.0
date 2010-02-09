From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 09 Feb 2010 04:29:22 +0000
Subject: [PATCH] sh: extend INTC with force_enable
Message-Id: <20100209042922.30795.63988.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Extend the shared INTC code with force_enable support to
allow keeping mask bits statically enabled. Needed by
upcoming INTC SDHI patches that mux together a bunch of
vectors to a single linux interrupt which is masked by
a priority register, but needs individual mask bits
constantly enabled.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on the intc_hw_desc patch.

 drivers/sh/intc.c       |  151 +++++++++++++++++++++++++++++++++++++++++------
 include/linux/sh_intc.h |    1 
 2 files changed, 133 insertions(+), 19 deletions(-)

--- 0002/drivers/sh/intc.c
+++ work/drivers/sh/intc.c	2010-02-09 12:46:18.000000000 +0900
@@ -259,6 +259,43 @@ static void intc_disable(unsigned int ir
 	}
 }
 
+static void (*intc_enable_noprio_fns[])(unsigned long addr,
+					unsigned long handle,
+					void (*fn)(unsigned long,
+						   unsigned long,
+						   unsigned long),
+					unsigned int irq) = {
+	[MODE_ENABLE_REG] = intc_mode_field,
+	[MODE_MASK_REG] = intc_mode_zero,
+	[MODE_DUAL_REG] = intc_mode_field,
+	[MODE_PRIO_REG] = intc_mode_field,
+	[MODE_PCLR_REG] = intc_mode_field,
+};
+
+static void intc_enable_disable(struct intc_desc_int *d,
+				unsigned long handle, int do_enable)
+{
+	unsigned long addr;
+	unsigned int cpu;
+	void (*fn)(unsigned long, unsigned long,
+		   void (*)(unsigned long, unsigned long, unsigned long),
+		   unsigned int);
+
+	if (do_enable) {
+		for (cpu = 0; cpu < SMP_NR(d, _INTC_ADDR_E(handle)); cpu++) {
+			addr = INTC_REG(d, _INTC_ADDR_E(handle), cpu);
+			fn = intc_enable_noprio_fns[_INTC_MODE(handle)];
+			fn(addr, handle, intc_reg_fns[_INTC_FN(handle)], 0);
+		}
+	} else {
+		for (cpu = 0; cpu < SMP_NR(d, _INTC_ADDR_D(handle)); cpu++) {
+			addr = INTC_REG(d, _INTC_ADDR_D(handle), cpu);
+			fn = intc_disable_fns[_INTC_MODE(handle)];
+			fn(addr, handle, intc_reg_fns[_INTC_FN(handle)], 0);
+		}
+	}
+}
+
 static int intc_set_wake(unsigned int irq, unsigned int on)
 {
 	return 0; /* allow wakeup, but setup hardware in intc_suspend() */
@@ -417,19 +454,21 @@ static intc_enum __init intc_grp_id(stru
 	return 0;
 }
 
-static unsigned int __init intc_mask_data(struct intc_desc *desc,
-					  struct intc_desc_int *d,
-					  intc_enum enum_id, int do_grps)
+static unsigned int __init _intc_mask_data(struct intc_desc *desc,
+					   struct intc_desc_int *d,
+					   intc_enum enum_id,
+					   unsigned int *reg_idx,
+					   unsigned int *fld_idx)
 {
 	struct intc_mask_reg *mr = desc->hw.mask_regs;
-	unsigned int i, j, fn, mode;
+	unsigned int fn, mode;
 	unsigned long reg_e, reg_d;
 
-	for (i = 0; mr && enum_id && i < desc->hw.nr_mask_regs; i++) {
-		mr = desc->hw.mask_regs + i;
+	while (mr && enum_id && *reg_idx < desc->hw.nr_mask_regs) {
+		mr = desc->hw.mask_regs + *reg_idx;
 
-		for (j = 0; j < ARRAY_SIZE(mr->enum_ids); j++) {
-			if (mr->enum_ids[j] != enum_id)
+		for (; *fld_idx < ARRAY_SIZE(mr->enum_ids); (*fld_idx)++) {
+			if (mr->enum_ids[*fld_idx] != enum_id)
 				continue;
 
 			if (mr->set_reg && mr->clr_reg) {
@@ -455,29 +494,49 @@ static unsigned int __init intc_mask_dat
 					intc_get_reg(d, reg_e),
 					intc_get_reg(d, reg_d),
 					1,
-					(mr->reg_width - 1) - j);
+					(mr->reg_width - 1) - *fld_idx);
 		}
+
+		*fld_idx = 0;
+		(*reg_idx)++;
 	}
 
+	return 0;
+}
+
+static unsigned int __init intc_mask_data(struct intc_desc *desc,
+					  struct intc_desc_int *d,
+					  intc_enum enum_id, int do_grps)
+{
+	unsigned int i = 0;
+	unsigned int j = 0;
+	unsigned int ret;
+
+	ret = _intc_mask_data(desc, d, enum_id, &i, &j);
+	if (ret)
+		return ret;
+
 	if (do_grps)
 		return intc_mask_data(desc, d, intc_grp_id(desc, enum_id), 0);
 
 	return 0;
 }
 
-static unsigned int __init intc_prio_data(struct intc_desc *desc,
-					  struct intc_desc_int *d,
-					  intc_enum enum_id, int do_grps)
+static unsigned int __init _intc_prio_data(struct intc_desc *desc,
+					   struct intc_desc_int *d,
+					   intc_enum enum_id,
+					   unsigned int *reg_idx,
+					   unsigned int *fld_idx)
 {
 	struct intc_prio_reg *pr = desc->hw.prio_regs;
-	unsigned int i, j, fn, mode, bit;
+	unsigned int fn, n, mode, bit;
 	unsigned long reg_e, reg_d;
 
-	for (i = 0; pr && enum_id && i < desc->hw.nr_prio_regs; i++) {
-		pr = desc->hw.prio_regs + i;
+	while (pr && enum_id && *reg_idx < desc->hw.nr_prio_regs) {
+		pr = desc->hw.prio_regs + *reg_idx;
 
-		for (j = 0; j < ARRAY_SIZE(pr->enum_ids); j++) {
-			if (pr->enum_ids[j] != enum_id)
+		for (; *fld_idx < ARRAY_SIZE(pr->enum_ids); (*fld_idx)++) {
+			if (pr->enum_ids[*fld_idx] != enum_id)
 				continue;
 
 			if (pr->set_reg && pr->clr_reg) {
@@ -495,24 +554,69 @@ static unsigned int __init intc_prio_dat
 			}
 
 			fn += (pr->reg_width >> 3) - 1;
+			n = *fld_idx + 1;
 
-			BUG_ON((j + 1) * pr->field_width > pr->reg_width);
+			BUG_ON(n * pr->field_width > pr->reg_width);
 
-			bit = pr->reg_width - ((j + 1) * pr->field_width);
+			bit = pr->reg_width - (n * pr->field_width);
 
 			return _INTC_MK(fn, mode,
 					intc_get_reg(d, reg_e),
 					intc_get_reg(d, reg_d),
 					pr->field_width, bit);
 		}
+
+		*fld_idx = 0;
+		(*reg_idx)++;
 	}
 
+	return 0;
+}
+
+static unsigned int __init intc_prio_data(struct intc_desc *desc,
+					  struct intc_desc_int *d,
+					  intc_enum enum_id, int do_grps)
+{
+	unsigned int i = 0;
+	unsigned int j = 0;
+	unsigned int ret;
+
+	ret = _intc_prio_data(desc, d, enum_id, &i, &j);
+	if (ret)
+		return ret;
+
 	if (do_grps)
 		return intc_prio_data(desc, d, intc_grp_id(desc, enum_id), 0);
 
 	return 0;
 }
 
+static void __init intc_enable_disable_enum(struct intc_desc *desc,
+					    struct intc_desc_int *d,
+					    intc_enum enum_id, int enable)
+{
+	unsigned int i, j, data;
+
+	/* go through and enable/disable all mask bits */
+	i = j = 0;
+	do {
+		data = _intc_mask_data(desc, d, enum_id, &i, &j);
+		if (data)
+			intc_enable_disable(d, data, enable);
+		j++;
+	} while (data);
+
+	/* go through and enable/disable all priority fields */
+	i = j = 0;
+	do {
+		data = _intc_prio_data(desc, d, enum_id, &i, &j);
+		if (data)
+			intc_enable_disable(d, data, enable);
+
+		j++;
+	} while (data);
+}
+
 static unsigned int __init intc_ack_data(struct intc_desc *desc,
 					  struct intc_desc_int *d,
 					  intc_enum enum_id)
@@ -747,6 +851,11 @@ void __init register_intc_controller(str
 		d->chip.mask_ack = intc_mask_ack;
 	}
 
+
+	/* disable bits matching force_enable before registering irqs */
+	if (desc->force_enable)
+		intc_enable_disable_enum(desc, d, desc->force_enable, 0);
+
 	BUG_ON(k > 256); /* _INTC_ADDR_E() and _INTC_ADDR_D() are 8 bits */
 
 	/* register the vectors one by one */
@@ -792,6 +901,10 @@ void __init register_intc_controller(str
 			set_irq_data(irq2, (void *)irq);
 		}
 	}
+
+	/* enable bits matching force_enable after registering irqs */
+	if (desc->force_enable)
+		intc_enable_disable_enum(desc, d, desc->force_enable, 1);
 }
 
 static int intc_suspend(struct sys_device *dev, pm_message_t state)
--- 0002/include/linux/sh_intc.h
+++ work/include/linux/sh_intc.h	2010-02-09 12:45:35.000000000 +0900
@@ -71,6 +71,7 @@ struct intc_hw_desc {
 
 struct intc_desc {
 	char *name;
+	intc_enum force_enable;
 	struct intc_hw_desc hw;
 };
 
