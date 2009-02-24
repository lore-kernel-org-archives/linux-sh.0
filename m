From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 24 Feb 2009 13:58:57 +0000
Subject: [PATCH 01/04] sh: multiple vectors per irq - base
Message-Id: <20090224135857.12058.3261.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Instead of keeping the single vector -> single linux irq mapping
we extend the intc code to support merging of vectors to a single
linux irq. This helps processors such as sh7750, sh7780 and sh7785
which have more vectors than masking ability. With this patch in
place we can modify the intc tables to use one irq per maskable
irq source. Please note the following:

 - If multiple vectors share the same enum then only the
   first vector will be available as a linux irq.

 - Drivers may need to be rewritten to get pending irq 
   source from the hardware block instead of irq number.

This patch together with the sh7785 specific intc tables solves
DMA controller irq issues related to buggy interrupt masking.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
Reported-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---

 arch/sh/kernel/irq.c    |    2 +-
 drivers/sh/intc.c       |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/sh_intc.h |    1 +
 3 files changed, 49 insertions(+), 1 deletion(-)

--- 0001/arch/sh/kernel/irq.c
+++ work/arch/sh/kernel/irq.c	2009-02-24 14:52:49.000000000 +0900
@@ -106,7 +106,7 @@ asmlinkage int do_IRQ(unsigned int irq, 
 	}
 #endif
 
-	irq = irq_demux(evt2irq(irq));
+	irq = irq_demux(intc_evt2irq(irq));
 
 #ifdef CONFIG_IRQSTACKS
 	curctx = (union irq_ctx *)current_thread_info();
--- 0001/drivers/sh/intc.c
+++ work/drivers/sh/intc.c	2009-02-24 14:52:49.000000000 +0900
@@ -568,6 +568,10 @@ static void __init intc_register_irq(str
 	if (!data[0] && data[1])
 		primary = 1;
 
+	if (!data[0] && !data[1])
+		pr_warning("intc: missing unique irq mask for 0x%04x\n",
+			   irq2evt(irq));
+
 	data[0] = data[0] ? data[0] : intc_mask_data(desc, d, enum_id, 1);
 	data[1] = data[1] ? data[1] : intc_prio_data(desc, d, enum_id, 1);
 
@@ -641,6 +645,17 @@ static unsigned int __init save_reg(stru
 	return 0;
 }
 
+static unsigned char *intc_evt2irq_table;
+
+unsigned int intc_evt2irq(unsigned int vector)
+{
+	unsigned int irq = evt2irq(vector);
+
+	if (intc_evt2irq_table && intc_evt2irq_table[irq])
+		irq = intc_evt2irq_table[irq];
+
+	return irq;
+}
 
 void __init register_intc_controller(struct intc_desc *desc)
 {
@@ -705,8 +720,40 @@ void __init register_intc_controller(str
 
 	BUG_ON(k > 256); /* _INTC_ADDR_E() and _INTC_ADDR_D() are 8 bits */
 
+	/* keep the first vector only if same enum is used multiple times */
 	for (i = 0; i < desc->nr_vectors; i++) {
 		struct intc_vect *vect = desc->vectors + i;
+		int first_irq = evt2irq(vect->vect);
+
+		if (!vect->enum_id)
+			continue;
+
+		for (k = i + 1; k < desc->nr_vectors; k++) {
+			struct intc_vect *vect2 = desc->vectors + k;
+
+			if (vect->enum_id != vect2->enum_id)
+				continue;
+
+			vect2->enum_id = 0;
+
+			if (!intc_evt2irq_table)
+				intc_evt2irq_table = alloc_bootmem(NR_IRQS);
+
+			if (!intc_evt2irq_table) {
+				pr_warning("intc: cannot allocate evt2irq!\n");
+				continue;
+			}
+
+			intc_evt2irq_table[evt2irq(vect2->vect)] = first_irq;
+		}
+	}
+
+	/* register the vectors one by one */
+	for (i = 0; i < desc->nr_vectors; i++) {
+		struct intc_vect *vect = desc->vectors + i;
+
+		if (!vect->enum_id)
+			continue;
 
 		intc_register_irq(desc, d, vect->enum_id, evt2irq(vect->vect));
 	}
--- 0001/include/linux/sh_intc.h
+++ work/include/linux/sh_intc.h	2009-02-24 14:52:49.000000000 +0900
@@ -85,6 +85,7 @@ struct intc_desc symbol __initdata = {		
 }
 #endif
 
+unsigned int intc_evt2irq(unsigned int vector);
 void __init register_intc_controller(struct intc_desc *desc);
 int intc_set_priority(unsigned int irq, unsigned int prio);
 
