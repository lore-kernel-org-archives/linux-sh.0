From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Fri, 04 Jul 2008 03:37:12 +0000
Subject: [PATCH] sh: add interrupt ack code to sh4a
Message-Id: <486D9AE8.7000301@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080424123634.19643.57391.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080424123634.19643.57391.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch is based on interrupt acknowledge code for external
interrupt sources on sh3 processors and adds on sh4a processors.

Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---
 arch/sh/kernel/cpu/irq/intc.c          |   31 +++++++++++++++++++++++--------
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   10 ++++++++--
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   10 ++++++++--
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   10 ++++++++--
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c |   11 ++++++++---
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c |   11 ++++++++---
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c |   17 +++++++++++------
 include/asm-sh/hw_irq.h                |    4 ++--
 8 files changed, 76 insertions(+), 28 deletions(-)

diff --git a/arch/sh/kernel/cpu/irq/intc.c b/arch/sh/kernel/cpu/irq/intc.c
index da5dae7..8c70e20 100644
--- a/arch/sh/kernel/cpu/irq/intc.c
+++ b/arch/sh/kernel/cpu/irq/intc.c
@@ -62,7 +62,7 @@ struct intc_desc_int {
 #endif

 static unsigned int intc_prio_level[NR_IRQS]; /* for now */
-#ifdef CONFIG_CPU_SH3
+#if defined(CONFIG_CPU_SH3) || defined(CONFIG_CPU_SH4A)
 static unsigned long ack_handle[NR_IRQS];
 #endif

@@ -231,7 +231,7 @@ static void intc_disable(unsigned int irq)
 	}
 }

-#ifdef CONFIG_CPU_SH3
+#if defined(CONFIG_CPU_SH3) || defined(CONFIG_CPU_SH4A)
 static void intc_mask_ack(unsigned int irq)
 {
 	struct intc_desc_int *d = get_intc_desc(irq);
@@ -244,8 +244,23 @@ static void intc_mask_ack(unsigned int irq)

 	if (handle) {
 		addr = INTC_REG(d, _INTC_ADDR_D(handle), 0);
-		ctrl_inb(addr);
-		ctrl_outb(0x3f ^ set_field(0, 1, handle), addr);
+		switch (_INTC_FN(handle)) {
+		case REG_FN_MODIFY_BASE + 0:	/* 8bit */
+			ctrl_inb(addr);
+			ctrl_outb(0xff ^ set_field(0, 1, handle), addr);
+			break;
+		case REG_FN_MODIFY_BASE + 1:	/* 16bit */
+			ctrl_inw(addr);
+			ctrl_outw(0xffff ^ set_field(0, 1, handle), addr);
+			break;
+		case REG_FN_MODIFY_BASE + 3:	/* 32bit */
+			ctrl_inl(addr);
+			ctrl_outl(0xffffffff ^ set_field(0, 1, handle), addr);
+			break;
+		default:
+			BUG();
+			break;
+		}
 	}
 }
 #endif
@@ -466,7 +481,7 @@ static unsigned int __init intc_prio_data(struct intc_desc *desc,
 	return 0;
 }

-#ifdef CONFIG_CPU_SH3
+#if defined(CONFIG_CPU_SH3) || defined(CONFIG_CPU_SH4A)
 static unsigned int __init intc_ack_data(struct intc_desc *desc,
 					  struct intc_desc_int *d,
 					  intc_enum enum_id)
@@ -601,7 +616,7 @@ static void __init intc_register_irq(struct intc_desc *desc,
 	/* irq should be disabled by default */
 	d->chip.mask(irq);

-#ifdef CONFIG_CPU_SH3
+#if defined(CONFIG_CPU_SH3) || defined(CONFIG_CPU_SH4A)
 	if (desc->ack_regs)
 		ack_handle[irq] = intc_ack_data(desc, d, enum_id);
 #endif
@@ -635,7 +650,7 @@ void __init register_intc_controller(struct intc_desc *desc)
 	d->nr_reg += desc->prio_regs ? desc->nr_prio_regs * 2 : 0;
 	d->nr_reg += desc->sense_regs ? desc->nr_sense_regs : 0;

-#ifdef CONFIG_CPU_SH3
+#if defined(CONFIG_CPU_SH3) || defined(CONFIG_CPU_SH4A)
 	d->nr_reg += desc->ack_regs ? desc->nr_ack_regs : 0;
 #endif
 	d->reg = alloc_bootmem(d->nr_reg * sizeof(*d->reg));
@@ -676,7 +691,7 @@ void __init register_intc_controller(struct intc_desc *desc)
 	d->chip.mask_ack = intc_disable;
 	d->chip.set_type = intc_set_sense;

-#ifdef CONFIG_CPU_SH3
+#if defined(CONFIG_CPU_SH3) || defined(CONFIG_CPU_SH4A)
 	if (desc->ack_regs) {
 		for (i = 0; i < desc->nr_ack_regs; i++)
 			k += save_reg(d, k, desc->ack_regs[i].set_reg, 0);
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7366.c b/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
index f26b5cd..f97ea8e 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
@@ -163,8 +163,14 @@ static struct intc_sense_reg sense_registers[] __initdata = {
 	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
 };

-static DECLARE_INTC_DESC(intc_desc, "sh7366", vectors, groups,
-			 mask_registers, prio_registers, sense_registers);
+static struct intc_mask_reg ack_registers[] __initdata = {
+	{ 0xa4140024, 0, 8, /* INTREQ00 */
+	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
+};
+
+static DECLARE_INTC_DESC_ACK(intc_desc, "sh7366", vectors, groups,
+			     mask_registers, prio_registers, sense_registers,
+			     ack_registers);

 void __init plat_irq_setup(void)
 {
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index 62ebccf..d8617b6 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -229,8 +229,14 @@ static struct intc_sense_reg sense_registers[] __initdata = {
 	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
 };

-static DECLARE_INTC_DESC(intc_desc, "sh7722", vectors, groups,
-			 mask_registers, prio_registers, sense_registers);
+static struct intc_mask_reg ack_registers[] __initdata = {
+	{ 0xa4140024, 0, 8, /* INTREQ00 */
+	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
+};
+
+static DECLARE_INTC_DESC_ACK(intc_desc, "sh7722", vectors, groups,
+			     mask_registers, prio_registers, sense_registers,
+			     ack_registers);

 void __init plat_irq_setup(void)
 {
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
index a0470f2..abd1ca0 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
@@ -326,8 +326,14 @@ static struct intc_sense_reg sense_registers[] __initdata = {
 	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
 };

-static DECLARE_INTC_DESC(intc_desc, "sh7723", vectors, groups,
-			 mask_registers, prio_registers, sense_registers);
+static struct intc_mask_reg ack_registers[] __initdata = {
+	{ 0xa4140024, 0, 8, /* INTREQ00 */
+	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
+};
+
+static DECLARE_INTC_DESC_ACK(intc_desc, "sh7723", vectors, groups,
+			     mask_registers, prio_registers, sense_registers,
+			     ack_registers);

 void __init plat_irq_setup(void)
 {
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7763.c b/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
index 3b278df..3c5b629 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
@@ -296,9 +296,14 @@ static struct intc_sense_reg irq_sense_registers[] __initdata = {
 					    IRQ4, IRQ5, IRQ6, IRQ7 } },
 };

-static DECLARE_INTC_DESC(intc_irq_desc, "sh7763-irq", irq_vectors,
-			NULL, irq_mask_registers, irq_prio_registers,
-			irq_sense_registers);
+static struct intc_mask_reg irq_ack_registers[] __initdata = {
+	{ 0xffd00024, 0, 32, /* INTREQ */
+	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
+};
+
+static DECLARE_INTC_DESC_ACK(intc_irq_desc, "sh7763-irq", irq_vectors,
+			     NULL, irq_mask_registers, irq_prio_registers,
+			     irq_sense_registers, irq_ack_registers);


 /* External interrupt pins in IRL mode */
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
index 18dbbe2..fb8200c 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
@@ -217,9 +217,14 @@ static struct intc_sense_reg irq_sense_registers[] __initdata = {
 					    IRQ4, IRQ5, IRQ6, IRQ7 } },
 };

-static DECLARE_INTC_DESC(intc_irq_desc, "sh7780-irq", irq_vectors,
-			 NULL, irq_mask_registers, irq_prio_registers,
-			 irq_sense_registers);
+static struct intc_mask_reg irq_ack_registers[] __initdata = {
+	{ 0xffd00024, 0, 32, /* INTREQ */
+	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
+};
+
+static DECLARE_INTC_DESC_ACK(intc_irq_desc, "sh7780-irq", irq_vectors,
+			     NULL, irq_mask_registers, irq_prio_registers,
+			     irq_sense_registers, irq_ack_registers);

 /* External interrupt pins in IRL mode */

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
index 621e732..30baa63 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
@@ -238,13 +238,18 @@ static struct intc_sense_reg sense_registers[] __initdata = {
 					    IRQ4, IRQ5, IRQ6, IRQ7 } },
 };

-static DECLARE_INTC_DESC(intc_desc_irq0123, "sh7785-irq0123", vectors_irq0123,
-			 NULL, mask_registers, prio_registers,
-			 sense_registers);
+static struct intc_mask_reg ack_registers[] __initdata = {
+	{ 0xffd00024, 0, 32, /* INTREQ */
+	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
+};
+
+static DECLARE_INTC_DESC_ACK(intc_desc_irq0123, "sh7785-irq0123",
+			     vectors_irq0123, NULL, mask_registers,
+			     prio_registers, sense_registers, ack_registers);

-static DECLARE_INTC_DESC(intc_desc_irq4567, "sh7785-irq4567", vectors_irq4567,
-			 NULL, mask_registers, prio_registers,
-			 sense_registers);
+static DECLARE_INTC_DESC_ACK(intc_desc_irq4567, "sh7785-irq4567",
+			     vectors_irq4567, NULL, mask_registers,
+			     prio_registers, sense_registers, ack_registers);

 /* External interrupt pins in IRL mode */

diff --git a/include/asm-sh/hw_irq.h b/include/asm-sh/hw_irq.h
index 7438d1e..d557b00 100644
--- a/include/asm-sh/hw_irq.h
+++ b/include/asm-sh/hw_irq.h
@@ -79,7 +79,7 @@ struct intc_desc {
 	struct intc_sense_reg *sense_regs;
 	unsigned int nr_sense_regs;
 	char *name;
-#ifdef CONFIG_CPU_SH3
+#if defined(CONFIG_CPU_SH3) || defined(CONFIG_CPU_SH4A)
 	struct intc_mask_reg *ack_regs;
 	unsigned int nr_ack_regs;
 #endif
@@ -95,7 +95,7 @@ struct intc_desc symbol __initdata = {					\
 	chipname,							\
 }

-#ifdef CONFIG_CPU_SH3
+#if defined(CONFIG_CPU_SH3) || defined(CONFIG_CPU_SH4A)
 #define DECLARE_INTC_DESC_ACK(symbol, chipname, vectors, groups,	\
 	mask_regs, prio_regs, sense_regs, ack_regs)			\
 struct intc_desc symbol __initdata = {					\

