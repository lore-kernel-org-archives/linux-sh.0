From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 10 Mar 2010 09:31:01 +0000
Subject: [PATCH] sh: add INTC out of memory error handling
Message-Id: <20100310093101.5422.38371.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Extend the INTC code to warn and return an error code
in the case of memory allocation failure.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 INTC topic branch material

 drivers/sh/intc.c       |   29 ++++++++++++++++++++++++++++-
 include/linux/sh_intc.h |    2 +-
 2 files changed, 29 insertions(+), 2 deletions(-)

--- 0005/drivers/sh/intc.c
+++ work/drivers/sh/intc.c	2010-03-10 16:31:22.000000000 +0900
@@ -789,13 +789,15 @@ static void intc_redirect_irq(unsigned i
 	generic_handle_irq((unsigned int)get_irq_data(irq));
 }
 
-void __init register_intc_controller(struct intc_desc *desc)
+int __init register_intc_controller(struct intc_desc *desc)
 {
 	unsigned int i, k, smp;
 	struct intc_hw_desc *hw = &desc->hw;
 	struct intc_desc_int *d;
 
 	d = kzalloc(sizeof(*d), GFP_NOWAIT);
+	if (!d)
+		goto err0;
 
 	INIT_LIST_HEAD(&d->list);
 	list_add(&d->list, &intc_list);
@@ -806,8 +808,13 @@ void __init register_intc_controller(str
 	d->nr_reg += hw->ack_regs ? hw->nr_ack_regs : 0;
 
 	d->reg = kzalloc(d->nr_reg * sizeof(*d->reg), GFP_NOWAIT);
+	if (!d->reg)
+		goto err1;
+
 #ifdef CONFIG_SMP
 	d->smp = kzalloc(d->nr_reg * sizeof(*d->smp), GFP_NOWAIT);
+	if (!d->smp)
+		goto err2;
 #endif
 	k = 0;
 
@@ -822,6 +829,8 @@ void __init register_intc_controller(str
 	if (hw->prio_regs) {
 		d->prio = kzalloc(hw->nr_vectors * sizeof(*d->prio),
 				  GFP_NOWAIT);
+		if (!d->prio)
+			goto err3;
 
 		for (i = 0; i < hw->nr_prio_regs; i++) {
 			smp = IS_SMP(hw->prio_regs[i]);
@@ -833,6 +842,8 @@ void __init register_intc_controller(str
 	if (hw->sense_regs) {
 		d->sense = kzalloc(hw->nr_vectors * sizeof(*d->sense),
 				   GFP_NOWAIT);
+		if (!d->sense)
+			goto err4;
 
 		for (i = 0; i < hw->nr_sense_regs; i++)
 			k += save_reg(d, k, hw->sense_regs[i].reg, 0);
@@ -912,6 +923,22 @@ void __init register_intc_controller(str
 	/* enable bits matching force_enable after registering irqs */
 	if (desc->force_enable)
 		intc_enable_disable_enum(desc, d, desc->force_enable, 1);
+
+	return 0;
+ err4:
+	kfree(d->prio);
+ err3:
+#ifdef CONFIG_SMP
+	kfree(d->smp);
+ err2:
+#endif
+	kfree(d->reg);
+ err1:
+	kfree(d);
+ err0:
+	pr_err("unable to allocate INTC memory\n");
+
+	return -ENOMEM;
 }
 
 static int intc_suspend(struct sys_device *dev, pm_message_t state)
--- 0005/include/linux/sh_intc.h
+++ work/include/linux/sh_intc.h	2010-03-10 16:18:59.000000000 +0900
@@ -92,7 +92,7 @@ struct intc_desc symbol __initdata = {		
 			   prio_regs, sense_regs, ack_regs),		\
 }
 
-void __init register_intc_controller(struct intc_desc *desc);
+int __init register_intc_controller(struct intc_desc *desc);
 int intc_set_priority(unsigned int irq, unsigned int prio);
 
 int reserve_irq_vector(unsigned int irq);
