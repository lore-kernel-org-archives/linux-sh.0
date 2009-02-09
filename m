From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Mon, 09 Feb 2009 11:38:08 +0000
Subject: [PATCH] sh: fix INTC group handling
Message-Id: <499015A0.9060105@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

In a grouped interrupt such as DMAC of SH7785, there was the problem that
a certain interrupt masked the other interrupts when it was masked.

Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---
 drivers/sh/intc.c |   71 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/drivers/sh/intc.c b/drivers/sh/intc.c
index 58d24c5..f1826d2 100644
--- a/drivers/sh/intc.c
+++ b/drivers/sh/intc.c
@@ -39,6 +39,12 @@ struct intc_handle_int {
 	unsigned long handle;
 };

+struct intc_groups_int {
+	unsigned long handle;
+	int irq[32];
+	unsigned long enabled_bit;
+};
+
 struct intc_desc_int {
 	unsigned long *reg;
 #ifdef CONFIG_SMP
@@ -49,6 +55,9 @@ struct intc_desc_int {
 	unsigned int nr_prio;
 	struct intc_handle_int *sense;
 	unsigned int nr_sense;
+	struct intc_groups_int *group;
+	int group_index[NR_IRQS];
+	unsigned long group_bit[NR_IRQS];
 	struct irq_chip chip;
 };

@@ -206,6 +215,9 @@ static inline void _intc_enable(unsigned int irq, unsigned long handle)
 	unsigned long addr;
 	unsigned int cpu;

+	if (d->group_bit[irq])
+		d->group[d->group_index[irq]].enabled_bit |= d->group_bit[irq];
+
 	for (cpu = 0; cpu < SMP_NR(d, _INTC_ADDR_E(handle)); cpu++) {
 		addr = INTC_REG(d, _INTC_ADDR_E(handle), cpu);
 		intc_enable_fns[_INTC_MODE(handle)](addr, handle, intc_reg_fns\
@@ -218,13 +230,21 @@ static void intc_enable(unsigned int irq)
 	_intc_enable(irq, (unsigned long)get_irq_chip_data(irq));
 }

-static void intc_disable(unsigned int irq)
+static void _intc_disable(unsigned int irq, int mask_ack)
 {
 	struct intc_desc_int *d = get_intc_desc(irq);
 	unsigned long handle = (unsigned long) get_irq_chip_data(irq);
 	unsigned long addr;
 	unsigned int cpu;

+	if (!mask_ack && d->group_bit[irq]) {
+		struct intc_groups_int *g = &d->group[d->group_index[irq]];
+
+		g->enabled_bit &= ~d->group_bit[irq];
+		if (g->enabled_bit)
+			return;
+	}
+
 	for (cpu = 0; cpu < SMP_NR(d, _INTC_ADDR_D(handle)); cpu++) {
 		addr = INTC_REG(d, _INTC_ADDR_D(handle), cpu);
 		intc_disable_fns[_INTC_MODE(handle)](addr, handle,intc_reg_fns\
@@ -232,6 +252,16 @@ static void intc_disable(unsigned int irq)
 	}
 }

+static void intc_disable(unsigned int irq)
+{
+	_intc_disable(irq, 0);
+}
+
+static void intc_disable_mask_ack(unsigned int irq)
+{
+	_intc_disable(irq, 1);
+}
+
 #if defined(CONFIG_CPU_SH3) || defined(CONFIG_CPU_SH4A)
 static void intc_mask_ack(unsigned int irq)
 {
@@ -546,13 +576,38 @@ static unsigned int __init intc_sense_data(struct intc_desc *desc,
 	return 0;
 }

+static void __init intc_group_data(struct intc_desc *desc,
+				   struct intc_desc_int *d,
+				   int irq,
+				   unsigned long handle)
+{
+	struct intc_group *g = desc->groups;
+	struct intc_groups_int *gi;
+	int i, j;
+
+	for (i = 0; g && i < desc->nr_groups; i++) {
+		gi = &d->group[i];
+		if (!gi->handle || (gi->handle = handle)) {
+			gi->handle = handle;
+			for (j = 0; j < ARRAY_SIZE(gi->irq); j++) {
+				if (!gi->irq[j]) {
+					gi->irq[j] = irq;
+					d->group_index[irq] = i;
+					d->group_bit[irq] = 1 << j;
+					return;
+				}
+			}
+		}
+	}
+}
+
 static void __init intc_register_irq(struct intc_desc *desc,
 				     struct intc_desc_int *d,
 				     intc_enum enum_id,
 				     unsigned int irq)
 {
 	struct intc_handle_int *hp;
-	unsigned int data[2], primary;
+	unsigned int data[2], primary, groups;

 	/* Prefer single interrupt source bitmap over other combinations:
 	 * 1. bitmap, single interrupt source
@@ -568,6 +623,10 @@ static void __init intc_register_irq(struct intc_desc *desc,
 	if (!data[0] && data[1])
 		primary = 1;

+	groups = 0;
+	if (!data[primary])
+		groups = 1;
+
 	data[0] = data[0] ? data[0] : intc_mask_data(desc, d, enum_id, 1);
 	data[1] = data[1] ? data[1] : intc_prio_data(desc, d, enum_id, 1);

@@ -608,6 +667,9 @@ static void __init intc_register_irq(struct intc_desc *desc,
 		d->nr_prio++;
 	}

+	if (groups)
+		intc_group_data(desc, d, irq, data[primary]);
+
 	/* add irq to d->sense list if sense is available */
 	data[0] = intc_sense_data(desc, d, enum_id);
 	if (data[0]) {
@@ -688,10 +750,13 @@ void __init register_intc_controller(struct intc_desc *desc)
 		}
 	}

+	if (desc->nr_groups)
+		d->group = alloc_bootmem(desc->nr_groups * sizeof(*d->group));
+
 	d->chip.name = desc->name;
 	d->chip.mask = intc_disable;
 	d->chip.unmask = intc_enable;
-	d->chip.mask_ack = intc_disable;
+	d->chip.mask_ack = intc_disable_mask_ack;
 	d->chip.set_type = intc_set_sense;

 #if defined(CONFIG_CPU_SH3) || defined(CONFIG_CPU_SH4A)
-- 
1.5.5

