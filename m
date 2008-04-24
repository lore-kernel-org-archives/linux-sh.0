From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 24 Apr 2008 12:36:34 +0000
Subject: [PATCH] sh: add interrupt ack code to sh3
Message-Id: <20080424123634.19643.57391.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds interrupt acknowledge code for external interrupt
sources on sh3 processors. Only really required for edge triggered
interrupts, but we ack regardless of sense configuration.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/irq/intc.c      |   79 ++++++++++++++++++++++++++++++++++--
 arch/sh/kernel/cpu/sh3/setup-sh3.c |   17 +++++--
 include/asm-sh/hw_irq.h            |   16 +++++++
 3 files changed, 104 insertions(+), 8 deletions(-)

--- 0001/arch/sh/kernel/cpu/irq/intc.c
+++ work/arch/sh/kernel/cpu/irq/intc.c	2008-04-24 20:47:42.000000000 +0900
@@ -1,7 +1,7 @@
 /*
  * Shared interrupt handling code for IPR and INTC2 types of IRQs.
  *
- * Copyright (C) 2007 Magnus Damm
+ * Copyright (C) 2007, 2008 Magnus Damm
  *
  * Based on intc2.c and ipr.c
  *
@@ -62,6 +62,9 @@ struct intc_desc_int {
 #endif
 
 static unsigned int intc_prio_level[NR_IRQS]; /* for now */
+#ifdef CONFIG_CPU_SH3
+static unsigned long ack_handle[NR_IRQS];
+#endif
 
 static inline struct intc_desc_int *get_intc_desc(unsigned int irq)
 {
@@ -219,6 +222,25 @@ static void intc_disable(unsigned int ir
 	}
 }
 
+#ifdef CONFIG_CPU_SH3
+static void intc_mask_ack(unsigned int irq)
+{
+	struct intc_desc_int *d = get_intc_desc(irq);
+	unsigned long handle = ack_handle[irq];
+	unsigned long addr;
+
+	intc_disable(irq);
+
+	/* read register and write zero only to the assocaited bit */
+
+	if (handle) {
+		addr = INTC_REG(d, _INTC_ADDR_D(handle), 0);
+		ctrl_inb(addr);
+		ctrl_outb(0x3f ^ set_field(0, 1, handle), addr);
+	}
+}
+#endif
+
 static struct intc_handle_int *intc_find_irq(struct intc_handle_int *hp,
 					     unsigned int nr_hp,
 					     unsigned int irq)
@@ -430,6 +452,40 @@ static unsigned int __init intc_prio_dat
 	return 0;
 }
 
+#ifdef CONFIG_CPU_SH3
+static unsigned int __init intc_ack_data(struct intc_desc *desc,
+					  struct intc_desc_int *d,
+					  intc_enum enum_id)
+{
+	struct intc_mask_reg *mr = desc->ack_regs;
+	unsigned int i, j, fn, mode;
+	unsigned long reg_e, reg_d;
+
+	for (i = 0; mr && enum_id && i < desc->nr_ack_regs; i++) {
+		mr = desc->ack_regs + i;
+
+		for (j = 0; j < ARRAY_SIZE(mr->enum_ids); j++) {
+			if (mr->enum_ids[j] != enum_id)
+				continue;
+
+			fn = REG_FN_MODIFY_BASE;
+			mode = MODE_ENABLE_REG;
+			reg_e = mr->set_reg;
+			reg_d = mr->set_reg;
+
+			fn += (mr->reg_width >> 3) - 1;
+			return _INTC_MK(fn, mode,
+					intc_get_reg(d, reg_e),
+					intc_get_reg(d, reg_d),
+					1,
+					(mr->reg_width - 1) - j);
+		}
+	}
+
+	return 0;
+}
+#endif
+
 static unsigned int __init intc_sense_data(struct intc_desc *desc,
 					   struct intc_desc_int *d,
 					   intc_enum enum_id)
@@ -530,6 +586,11 @@ static void __init intc_register_irq(str
 
 	/* irq should be disabled by default */
 	d->chip.mask(irq);
+
+#ifdef CONFIG_CPU_SH3
+	if (desc->ack_regs)
+		ack_handle[irq] = intc_ack_data(desc, d, enum_id);
+#endif
 }
 
 static unsigned int __init save_reg(struct intc_desc_int *d,
@@ -560,6 +621,9 @@ void __init register_intc_controller(str
 	d->nr_reg += desc->prio_regs ? desc->nr_prio_regs * 2 : 0;
 	d->nr_reg += desc->sense_regs ? desc->nr_sense_regs : 0;
 
+#ifdef CONFIG_CPU_SH3
+	d->nr_reg += desc->ack_regs ? desc->nr_ack_regs : 0;
+#endif
 	d->reg = alloc_bootmem(d->nr_reg * sizeof(*d->reg));
 #ifdef CONFIG_SMP
 	d->smp = alloc_bootmem(d->nr_reg * sizeof(*d->smp));
@@ -592,14 +656,23 @@ void __init register_intc_controller(str
 		}
 	}
 
-	BUG_ON(k > 256); /* _INTC_ADDR_E() and _INTC_ADDR_D() are 8 bits */
-
 	d->chip.name = desc->name;
 	d->chip.mask = intc_disable;
 	d->chip.unmask = intc_enable;
 	d->chip.mask_ack = intc_disable;
 	d->chip.set_type = intc_set_sense;
 
+#ifdef CONFIG_CPU_SH3
+	if (desc->ack_regs) {
+		for (i = 0; i < desc->nr_ack_regs; i++)
+			k += save_reg(d, k, desc->ack_regs[i].set_reg, 0);
+
+		d->chip.mask_ack = intc_mask_ack;
+	}
+#endif
+
+	BUG_ON(k > 256); /* _INTC_ADDR_E() and _INTC_ADDR_D() are 8 bits */
+
 	for (i = 0; i < desc->nr_vectors; i++) {
 		struct intc_vect *vect = desc->vectors + i;
 
--- 0010/arch/sh/kernel/cpu/sh3/setup-sh3.c
+++ work/arch/sh/kernel/cpu/sh3/setup-sh3.c	2008-04-24 20:25:24.000000000 +0900
@@ -35,15 +35,22 @@ static struct intc_prio_reg prio_registe
 	{ 0xa4000018, 0, 16, 4, /* IPRD */ { 0, 0, IRQ5, IRQ4 } },
 };
 
+static struct intc_mask_reg ack_registers[] __initdata = {
+	{ 0xa4000004, 0, 8, /* IRR0 */
+	  { 0, 0, IRQ5, IRQ4, IRQ3, IRQ2, IRQ1, IRQ0 } },
+};
+
 static struct intc_sense_reg sense_registers[] __initdata = {
 	{ 0xa4000010, 16, 2, { 0, 0, IRQ5, IRQ4, IRQ3, IRQ2, IRQ1, IRQ0 } },
 };
 
-static DECLARE_INTC_DESC(intc_desc_irq0123, "sh3-irq0123", vectors_irq0123,
-			 NULL, NULL, prio_registers, sense_registers);
-
-static DECLARE_INTC_DESC(intc_desc_irq45, "sh3-irq45", vectors_irq45,
-			 NULL, NULL, prio_registers, sense_registers);
+static DECLARE_INTC_DESC_ACK(intc_desc_irq0123, "sh3-irq0123",
+			     vectors_irq0123, NULL, NULL,
+			     prio_registers, sense_registers, ack_registers);
+
+static DECLARE_INTC_DESC_ACK(intc_desc_irq45, "sh3-irq45",
+			     vectors_irq45, NULL, NULL,
+			     prio_registers, sense_registers, ack_registers);
 
 #define INTC_ICR1		0xa4000010UL
 #define INTC_ICR1_IRQLVL	(1<<14)
--- 0010/include/asm-sh/hw_irq.h
+++ work/include/asm-sh/hw_irq.h	2008-04-24 20:25:24.000000000 +0900
@@ -79,6 +79,10 @@ struct intc_desc {
 	struct intc_sense_reg *sense_regs;
 	unsigned int nr_sense_regs;
 	char *name;
+#ifdef CONFIG_CPU_SH3
+	struct intc_mask_reg *ack_regs;
+	unsigned int nr_ack_regs;
+#endif
 };
 
 #define _INTC_ARRAY(a) a, sizeof(a)/sizeof(*a)
@@ -91,6 +95,18 @@ struct intc_desc symbol __initdata = {		
 	chipname,							\
 }
 
+#ifdef CONFIG_CPU_SH3
+#define DECLARE_INTC_DESC_ACK(symbol, chipname, vectors, groups,	\
+	mask_regs, prio_regs, sense_regs, ack_regs)			\
+struct intc_desc symbol __initdata = {					\
+	_INTC_ARRAY(vectors), _INTC_ARRAY(groups),			\
+	_INTC_ARRAY(mask_regs), _INTC_ARRAY(prio_regs),			\
+	_INTC_ARRAY(sense_regs),					\
+	chipname,							\
+	_INTC_ARRAY(ack_regs),						\
+}
+#endif
+
 void __init register_intc_controller(struct intc_desc *desc);
 int intc_set_priority(unsigned int irq, unsigned int prio);
 
