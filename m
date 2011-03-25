From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 25 Mar 2011 13:56:05 +0000
Subject: [patch 2/2] sh: Convert to new function names
Message-Id: <20110325135543.066370574@linutronix.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Scripted with coccinelle.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/sh/boards/board-magicpanelr2.c  |   12 ++++++------
 arch/sh/boards/mach-cayman/irq.c     |    4 ++--
 arch/sh/boards/mach-dreamcast/irq.c  |    3 +--
 arch/sh/boards/mach-ecovec24/setup.c |    2 +-
 arch/sh/boards/mach-microdev/irq.c   |    2 +-
 arch/sh/boards/mach-se/7206/irq.c    |    2 +-
 arch/sh/boards/mach-se/7343/irq.c    |   23 ++++++++++++-----------
 arch/sh/boards/mach-se/7722/irq.c    |   15 ++++++++-------
 arch/sh/boards/mach-se/7724/irq.c    |   15 +++++++--------
 arch/sh/boards/mach-x3proto/gpio.c   |    8 ++++----
 arch/sh/cchips/hd6446x/hd64461.c     |    6 +++---
 arch/sh/kernel/cpu/irq/imask.c       |    4 ++--
 arch/sh/kernel/cpu/irq/intc-sh5.c    |    2 +-
 arch/sh/kernel/cpu/irq/ipr.c         |    6 +++---
 drivers/sh/intc/core.c               |   14 +++++++-------
 drivers/sh/intc/virq.c               |   12 ++++++------
 16 files changed, 65 insertions(+), 65 deletions(-)

Index: linux-2.6-tip/arch/sh/boards/board-magicpanelr2.c
=================================--- linux-2.6-tip.orig/arch/sh/boards/board-magicpanelr2.c
+++ linux-2.6-tip/arch/sh/boards/board-magicpanelr2.c
@@ -388,12 +388,12 @@ static void __init init_mpr2_IRQ(void)
 {
 	plat_irq_setup_pins(IRQ_MODE_IRQ); /* install handlers for IRQ0-5 */
 
-	set_irq_type(32, IRQ_TYPE_LEVEL_LOW);    /* IRQ0 CAN1 */
-	set_irq_type(33, IRQ_TYPE_LEVEL_LOW);    /* IRQ1 CAN2 */
-	set_irq_type(34, IRQ_TYPE_LEVEL_LOW);    /* IRQ2 CAN3 */
-	set_irq_type(35, IRQ_TYPE_LEVEL_LOW);    /* IRQ3 SMSC9115 */
-	set_irq_type(36, IRQ_TYPE_EDGE_RISING);  /* IRQ4 touchscreen */
-	set_irq_type(37, IRQ_TYPE_EDGE_FALLING); /* IRQ5 touchscreen */
+	irq_set_irq_type(32, IRQ_TYPE_LEVEL_LOW);    /* IRQ0 CAN1 */
+	irq_set_irq_type(33, IRQ_TYPE_LEVEL_LOW);    /* IRQ1 CAN2 */
+	irq_set_irq_type(34, IRQ_TYPE_LEVEL_LOW);    /* IRQ2 CAN3 */
+	irq_set_irq_type(35, IRQ_TYPE_LEVEL_LOW);    /* IRQ3 SMSC9115 */
+	irq_set_irq_type(36, IRQ_TYPE_EDGE_RISING);  /* IRQ4 touchscreen */
+	irq_set_irq_type(37, IRQ_TYPE_EDGE_FALLING); /* IRQ5 touchscreen */
 
 	intc_set_priority(32, 13);		/* IRQ0 CAN1 */
 	intc_set_priority(33, 13);		/* IRQ0 CAN2 */
Index: linux-2.6-tip/arch/sh/boards/mach-cayman/irq.c
=================================--- linux-2.6-tip.orig/arch/sh/boards/mach-cayman/irq.c
+++ linux-2.6-tip/arch/sh/boards/mach-cayman/irq.c
@@ -149,8 +149,8 @@ void init_cayman_irq(void)
 	}
 
 	for (i = 0; i < NR_EXT_IRQS; i++) {
-		set_irq_chip_and_handler(START_EXT_IRQS + i, &cayman_irq_type,
-					 handle_level_irq);
+		irq_set_chip_and_handler(START_EXT_IRQS + i,
+					 &cayman_irq_type, handle_level_irq);
 	}
 
 	/* Setup the SMSC interrupt */
Index: linux-2.6-tip/arch/sh/boards/mach-dreamcast/irq.c
=================================--- linux-2.6-tip.orig/arch/sh/boards/mach-dreamcast/irq.c
+++ linux-2.6-tip/arch/sh/boards/mach-dreamcast/irq.c
@@ -161,7 +161,6 @@ void systemasic_irq_init(void)
 			return;
 		}
 
-		set_irq_chip_and_handler(i, &systemasic_int,
-					 handle_level_irq);
+		irq_set_chip_and_handler(i, &systemasic_int, handle_level_irq);
 	}
 }
Index: linux-2.6-tip/arch/sh/boards/mach-ecovec24/setup.c
=================================--- linux-2.6-tip.orig/arch/sh/boards/mach-ecovec24/setup.c
+++ linux-2.6-tip/arch/sh/boards/mach-ecovec24/setup.c
@@ -1102,7 +1102,7 @@ static int __init arch_setup(void)
 
 		/* enable TouchScreen */
 		i2c_register_board_info(0, &ts_i2c_clients, 1);
-		set_irq_type(IRQ0, IRQ_TYPE_LEVEL_LOW);
+		irq_set_irq_type(IRQ0, IRQ_TYPE_LEVEL_LOW);
 	}
 
 	/* enable CEU0 */
Index: linux-2.6-tip/arch/sh/boards/mach-microdev/irq.c
=================================--- linux-2.6-tip.orig/arch/sh/boards/mach-microdev/irq.c
+++ linux-2.6-tip/arch/sh/boards/mach-microdev/irq.c
@@ -117,7 +117,7 @@ static struct irq_chip microdev_irq_type
 static void __init make_microdev_irq(unsigned int irq)
 {
 	disable_irq_nosync(irq);
-	set_irq_chip_and_handler(irq, &microdev_irq_type, handle_level_irq);
+	irq_set_chip_and_handler(irq, &microdev_irq_type, handle_level_irq);
 	disable_microdev_irq(irq_get_irq_data(irq));
 }
 
Index: linux-2.6-tip/arch/sh/boards/mach-se/7206/irq.c
=================================--- linux-2.6-tip.orig/arch/sh/boards/mach-se/7206/irq.c
+++ linux-2.6-tip/arch/sh/boards/mach-se/7206/irq.c
@@ -126,7 +126,7 @@ static struct irq_chip se7206_irq_chip _
 static void make_se7206_irq(unsigned int irq)
 {
 	disable_irq_nosync(irq);
-	set_irq_chip_and_handler_name(irq, &se7206_irq_chip,
+	irq_set_chip_and_handler_name(irq, &se7206_irq_chip,
 				      handle_level_irq, "level");
 	disable_se7206_irq(irq_get_irq_data(irq));
 }
Index: linux-2.6-tip/arch/sh/boards/mach-se/7343/irq.c
=================================--- linux-2.6-tip.orig/arch/sh/boards/mach-se/7343/irq.c
+++ linux-2.6-tip/arch/sh/boards/mach-se/7343/irq.c
@@ -67,19 +67,20 @@ void __init init_7343se_IRQ(void)
 			return;
 		se7343_fpga_irq[i] = irq;
 
-		set_irq_chip_and_handler_name(se7343_fpga_irq[i],
+		irq_set_chip_and_handler_name(se7343_fpga_irq[i],
 					      &se7343_irq_chip,
-					      handle_level_irq, "level");
+					      handle_level_irq,
+					      "level");
 
-		set_irq_chip_data(se7343_fpga_irq[i], (void *)i);
+		irq_set_chip_data(se7343_fpga_irq[i], (void *)i);
 	}
 
-	set_irq_chained_handler(IRQ0_IRQ, se7343_irq_demux);
-	set_irq_type(IRQ0_IRQ, IRQ_TYPE_LEVEL_LOW);
-	set_irq_chained_handler(IRQ1_IRQ, se7343_irq_demux);
-	set_irq_type(IRQ1_IRQ, IRQ_TYPE_LEVEL_LOW);
-	set_irq_chained_handler(IRQ4_IRQ, se7343_irq_demux);
-	set_irq_type(IRQ4_IRQ, IRQ_TYPE_LEVEL_LOW);
-	set_irq_chained_handler(IRQ5_IRQ, se7343_irq_demux);
-	set_irq_type(IRQ5_IRQ, IRQ_TYPE_LEVEL_LOW);
+	irq_set_chained_handler(IRQ0_IRQ, se7343_irq_demux);
+	irq_set_irq_type(IRQ0_IRQ, IRQ_TYPE_LEVEL_LOW);
+	irq_set_chained_handler(IRQ1_IRQ, se7343_irq_demux);
+	irq_set_irq_type(IRQ1_IRQ, IRQ_TYPE_LEVEL_LOW);
+	irq_set_chained_handler(IRQ4_IRQ, se7343_irq_demux);
+	irq_set_irq_type(IRQ4_IRQ, IRQ_TYPE_LEVEL_LOW);
+	irq_set_chained_handler(IRQ5_IRQ, se7343_irq_demux);
+	irq_set_irq_type(IRQ5_IRQ, IRQ_TYPE_LEVEL_LOW);
 }
Index: linux-2.6-tip/arch/sh/boards/mach-se/7722/irq.c
=================================--- linux-2.6-tip.orig/arch/sh/boards/mach-se/7722/irq.c
+++ linux-2.6-tip/arch/sh/boards/mach-se/7722/irq.c
@@ -67,16 +67,17 @@ void __init init_se7722_IRQ(void)
 			return;
 		se7722_fpga_irq[i] = irq;
 
-		set_irq_chip_and_handler_name(se7722_fpga_irq[i],
+		irq_set_chip_and_handler_name(se7722_fpga_irq[i],
 					      &se7722_irq_chip,
-					      handle_level_irq, "level");
+					      handle_level_irq,
+					      "level");
 
-		set_irq_chip_data(se7722_fpga_irq[i], (void *)i);
+		irq_set_chip_data(se7722_fpga_irq[i], (void *)i);
 	}
 
-	set_irq_chained_handler(IRQ0_IRQ, se7722_irq_demux);
-	set_irq_type(IRQ0_IRQ, IRQ_TYPE_LEVEL_LOW);
+	irq_set_chained_handler(IRQ0_IRQ, se7722_irq_demux);
+	irq_set_irq_type(IRQ0_IRQ, IRQ_TYPE_LEVEL_LOW);
 
-	set_irq_chained_handler(IRQ1_IRQ, se7722_irq_demux);
-	set_irq_type(IRQ1_IRQ, IRQ_TYPE_LEVEL_LOW);
+	irq_set_chained_handler(IRQ1_IRQ, se7722_irq_demux);
+	irq_set_irq_type(IRQ1_IRQ, IRQ_TYPE_LEVEL_LOW);
 }
Index: linux-2.6-tip/arch/sh/boards/mach-se/7724/irq.c
=================================--- linux-2.6-tip.orig/arch/sh/boards/mach-se/7724/irq.c
+++ linux-2.6-tip/arch/sh/boards/mach-se/7724/irq.c
@@ -140,17 +140,16 @@ void __init init_se7724_IRQ(void)
 			return;
 		}
 
-		set_irq_chip_and_handler_name(irq,
-					      &se7724_irq_chip,
+		irq_set_chip_and_handler_name(irq, &se7724_irq_chip,
 					      handle_level_irq, "level");
 	}
 
-	set_irq_chained_handler(IRQ0_IRQ, se7724_irq_demux);
-	set_irq_type(IRQ0_IRQ, IRQ_TYPE_LEVEL_LOW);
+	irq_set_chained_handler(IRQ0_IRQ, se7724_irq_demux);
+	irq_set_irq_type(IRQ0_IRQ, IRQ_TYPE_LEVEL_LOW);
 
-	set_irq_chained_handler(IRQ1_IRQ, se7724_irq_demux);
-	set_irq_type(IRQ1_IRQ, IRQ_TYPE_LEVEL_LOW);
+	irq_set_chained_handler(IRQ1_IRQ, se7724_irq_demux);
+	irq_set_irq_type(IRQ1_IRQ, IRQ_TYPE_LEVEL_LOW);
 
-	set_irq_chained_handler(IRQ2_IRQ, se7724_irq_demux);
-	set_irq_type(IRQ2_IRQ, IRQ_TYPE_LEVEL_LOW);
+	irq_set_chained_handler(IRQ2_IRQ, se7724_irq_demux);
+	irq_set_irq_type(IRQ2_IRQ, IRQ_TYPE_LEVEL_LOW);
 }
Index: linux-2.6-tip/arch/sh/boards/mach-x3proto/gpio.c
=================================--- linux-2.6-tip.orig/arch/sh/boards/mach-x3proto/gpio.c
+++ linux-2.6-tip/arch/sh/boards/mach-x3proto/gpio.c
@@ -102,8 +102,8 @@ int __init x3proto_gpio_setup(void)
 
 		spin_lock_irqsave(&x3proto_gpio_lock, flags);
 		x3proto_gpio_irq_map[i] = irq;
-		set_irq_chip_and_handler_name(irq, &dummy_irq_chip,
-					handle_simple_irq, "gpio");
+		irq_set_chip_and_handler_name(irq, &dummy_irq_chip,
+					      handle_simple_irq, "gpio");
 		spin_unlock_irqrestore(&x3proto_gpio_lock, flags);
 	}
 
@@ -113,8 +113,8 @@ int __init x3proto_gpio_setup(void)
 		x3proto_gpio_chip.base + x3proto_gpio_chip.ngpio,
 		ilsel);
 
-	set_irq_chained_handler(ilsel, x3proto_gpio_irq_handler);
-	set_irq_wake(ilsel, 1);
+	irq_set_chained_handler(ilsel, x3proto_gpio_irq_handler);
+	irq_set_irq_wake(ilsel, 1);
 
 	return 0;
 
Index: linux-2.6-tip/arch/sh/cchips/hd6446x/hd64461.c
=================================--- linux-2.6-tip.orig/arch/sh/cchips/hd6446x/hd64461.c
+++ linux-2.6-tip/arch/sh/cchips/hd6446x/hd64461.c
@@ -107,12 +107,12 @@ int __init setup_hd64461(void)
 			return -EINVAL;
 		}
 
-		set_irq_chip_and_handler(i, &hd64461_irq_chip,
+		irq_set_chip_and_handler(i, &hd64461_irq_chip,
 					 handle_level_irq);
 	}
 
-	set_irq_chained_handler(CONFIG_HD64461_IRQ, hd64461_irq_demux);
-	set_irq_type(CONFIG_HD64461_IRQ, IRQ_TYPE_LEVEL_LOW);
+	irq_set_chained_handler(CONFIG_HD64461_IRQ, hd64461_irq_demux);
+	irq_set_irq_type(CONFIG_HD64461_IRQ, IRQ_TYPE_LEVEL_LOW);
 
 #ifdef CONFIG_HD64461_ENABLER
 	printk(KERN_INFO "HD64461: enabling PCMCIA devices\n");
Index: linux-2.6-tip/arch/sh/kernel/cpu/irq/imask.c
=================================--- linux-2.6-tip.orig/arch/sh/kernel/cpu/irq/imask.c
+++ linux-2.6-tip/arch/sh/kernel/cpu/irq/imask.c
@@ -80,6 +80,6 @@ static struct irq_chip imask_irq_chip = 
 
 void make_imask_irq(unsigned int irq)
 {
-	set_irq_chip_and_handler_name(irq, &imask_irq_chip,
-				      handle_level_irq, "level");
+	irq_set_chip_and_handler_name(irq, &imask_irq_chip, handle_level_irq,
+				      "level");
 }
Index: linux-2.6-tip/arch/sh/kernel/cpu/irq/intc-sh5.c
=================================--- linux-2.6-tip.orig/arch/sh/kernel/cpu/irq/intc-sh5.c
+++ linux-2.6-tip/arch/sh/kernel/cpu/irq/intc-sh5.c
@@ -135,7 +135,7 @@ void __init plat_irq_setup(void)
 
 	/* Set default: per-line enable/disable, priority driven ack/eoi */
 	for (i = 0; i < NR_INTC_IRQS; i++)
-		set_irq_chip_and_handler(i, &intc_irq_type, handle_level_irq);
+		irq_set_chip_and_handler(i, &intc_irq_type, handle_level_irq);
 
 
 	/* Disable all interrupts and set all priorities to 0 to avoid trouble */
Index: linux-2.6-tip/arch/sh/kernel/cpu/irq/ipr.c
=================================--- linux-2.6-tip.orig/arch/sh/kernel/cpu/irq/ipr.c
+++ linux-2.6-tip/arch/sh/kernel/cpu/irq/ipr.c
@@ -74,9 +74,9 @@ void register_ipr_controller(struct ipr_
 		}
 
 		disable_irq_nosync(p->irq);
-		set_irq_chip_and_handler_name(p->irq, &desc->chip,
-				      handle_level_irq, "level");
-		set_irq_chip_data(p->irq, p);
+		irq_set_chip_and_handler_name(p->irq, &desc->chip,
+					      handle_level_irq, "level");
+		irq_set_chip_data(p->irq, p);
 		disable_ipr_irq(irq_get_irq_data(p->irq));
 	}
 }
Index: linux-2.6-tip/drivers/sh/intc/core.c
=================================--- linux-2.6-tip.orig/drivers/sh/intc/core.c
+++ linux-2.6-tip/drivers/sh/intc/core.c
@@ -62,7 +62,7 @@ void intc_set_prio_level(unsigned int ir
 
 static void intc_redirect_irq(unsigned int irq, struct irq_desc *desc)
 {
-	generic_handle_irq((unsigned int)get_irq_data(irq));
+	generic_handle_irq((unsigned int)irq_get_handler_data(irq));
 }
 
 static void __init intc_register_irq(struct intc_desc *desc,
@@ -115,9 +115,9 @@ static void __init intc_register_irq(str
 	irq_data = irq_get_irq_data(irq);
 
 	disable_irq_nosync(irq);
-	set_irq_chip_and_handler_name(irq, &d->chip,
-				      handle_level_irq, "level");
-	set_irq_chip_data(irq, (void *)data[primary]);
+	irq_set_chip_and_handler_name(irq, &d->chip, handle_level_irq,
+				      "level");
+	irq_set_chip_data(irq, (void *)data[primary]);
 
 	/*
 	 * set priority level
@@ -339,9 +339,9 @@ int __init register_intc_controller(stru
 			vect2->enum_id = 0;
 
 			/* redirect this interrupts to the first one */
-			set_irq_chip(irq2, &dummy_irq_chip);
-			set_irq_chained_handler(irq2, intc_redirect_irq);
-			set_irq_data(irq2, (void *)irq);
+			irq_set_chip(irq2, &dummy_irq_chip);
+			irq_set_chained_handler(irq2, intc_redirect_irq);
+			irq_set_handler_data(irq2, (void *)irq);
 		}
 	}
 
Index: linux-2.6-tip/drivers/sh/intc/virq.c
=================================--- linux-2.6-tip.orig/drivers/sh/intc/virq.c
+++ linux-2.6-tip/drivers/sh/intc/virq.c
@@ -110,7 +110,7 @@ static void intc_virq_handler(unsigned i
 {
 	struct irq_data *data = irq_get_irq_data(irq);
 	struct irq_chip *chip = irq_data_get_irq_chip(data);
-	struct intc_virq_list *entry, *vlist = irq_data_get_irq_data(data);
+	struct intc_virq_list *entry, *vlist = irq_data_get_irq_handler_data(data);
 	struct intc_desc_int *d = get_intc_desc(irq);
 
 	chip->irq_mask_ack(data);
@@ -118,7 +118,7 @@ static void intc_virq_handler(unsigned i
 	for_each_virq(entry, vlist) {
 		unsigned long addr, handle;
 
-		handle = (unsigned long)get_irq_data(entry->irq);
+		handle = (unsigned long)irq_get_handler_data(entry->irq);
 		addr = INTC_REG(d, _INTC_ADDR_E(handle), 0);
 
 		if (intc_reg_fns[_INTC_FN(handle)](addr, handle, 0))
@@ -229,13 +229,13 @@ restart:
 
 		intc_irq_xlate_set(irq, entry->enum_id, d);
 
-		set_irq_chip_and_handler_name(irq, get_irq_chip(entry->pirq),
+		irq_set_chip_and_handler_name(irq, irq_get_chip(entry->pirq),
 					      handle_simple_irq, "virq");
-		set_irq_chip_data(irq, get_irq_chip_data(entry->pirq));
+		irq_set_chip_data(irq, irq_get_chip_data(entry->pirq));
 
-		set_irq_data(irq, (void *)entry->handle);
+		irq_set_handler_data(irq, (void *)entry->handle);
 
-		set_irq_chained_handler(entry->pirq, intc_virq_handler);
+		irq_set_chained_handler(entry->pirq, intc_virq_handler);
 		add_virq_to_pirq(entry->pirq, irq);
 
 		radix_tree_tag_clear(&d->tree, entry->enum_id,


