From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 01 Apr 2009 14:30:59 +0000
Subject: [PATCH] sh_intc: set_irq_wake() support
Message-Id: <20090401143059.32645.74804.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add set_irq_wake() support to intc using sysdev and suspend.

The intc controllers are put on a list at registration time
and registered as sysdev devices later on during the boot.

The sysdev class suspend callback is used to find irqs with
wakeup enabled belonging to our intc controller. Such irqs
are simply enabled so wakeup interrupts may reach the cpu.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/sh/intc.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

--- 0002/drivers/sh/intc.c
+++ work/drivers/sh/intc.c	2009-04-01 22:54:58.000000000 +0900
@@ -22,6 +22,8 @@
 #include <linux/interrupt.h>
 #include <linux/bootmem.h>
 #include <linux/sh_intc.h>
+#include <linux/sysdev.h>
+#include <linux/list.h>
 
 #define _INTC_MK(fn, mode, addr_e, addr_d, width, shift) \
 	((shift) | ((width) << 5) | ((fn) << 9) | ((mode) << 13) | \
@@ -40,6 +42,8 @@ struct intc_handle_int {
 };
 
 struct intc_desc_int {
+	struct list_head list;
+	struct sys_device sysdev;
 	unsigned long *reg;
 #ifdef CONFIG_SMP
 	unsigned long *smp;
@@ -52,6 +56,8 @@ struct intc_desc_int {
 	struct irq_chip chip;
 };
 
+static LIST_HEAD(intc_list);
+
 #ifdef CONFIG_SMP
 #define IS_SMP(x) x.smp
 #define INTC_REG(d, x, c) (d->reg[(x)] + ((d->smp[(x)] & 0xff) * c))
@@ -232,6 +238,11 @@ static void intc_disable(unsigned int ir
 	}
 }
 
+static int intc_set_wake(unsigned int irq, unsigned int on)
+{
+	return 0; /* allow wakeup, but setup hardware in intc_suspend() */
+}
+
 #if defined(CONFIG_CPU_SH3) || defined(CONFIG_CPU_SH4A)
 static void intc_mask_ack(unsigned int irq)
 {
@@ -664,6 +675,9 @@ void __init register_intc_controller(str
 
 	d = alloc_bootmem(sizeof(*d));
 
+	INIT_LIST_HEAD(&d->list);
+	list_add(&d->list, &intc_list);
+
 	d->nr_reg = desc->mask_regs ? desc->nr_mask_regs * 2 : 0;
 	d->nr_reg += desc->prio_regs ? desc->nr_prio_regs * 2 : 0;
 	d->nr_reg += desc->sense_regs ? desc->nr_sense_regs : 0;
@@ -711,6 +725,7 @@ void __init register_intc_controller(str
 	d->chip.disable = intc_disable;
 	d->chip.shutdown = intc_disable;
 	d->chip.set_type = intc_set_sense;
+	d->chip.set_wake = intc_set_wake;
 
 #if defined(CONFIG_CPU_SH3) || defined(CONFIG_CPU_SH4A)
 	if (desc->ack_regs) {
@@ -761,3 +776,53 @@ void __init register_intc_controller(str
 		intc_register_irq(desc, d, vect->enum_id, evt2irq(vect->vect));
 	}
 }
+
+static int intc_suspend(struct sys_device *dev, pm_message_t state)
+{
+	struct intc_desc_int *d;
+	struct irq_desc *desc;
+	int irq;
+
+	/* get intc controller associated with this sysdev */
+	d = container_of(dev, struct intc_desc_int, sysdev);
+
+	/* enable wakeup irqs belonging to this intc controller */
+	for_each_irq_desc(irq, desc) {
+		if ((desc->status & IRQ_WAKEUP) && (desc->chip = &d->chip))
+			intc_enable(irq);
+	}
+
+	return 0;
+}
+
+static struct sysdev_class intc_sysdev_class = {
+	.name = "intc",
+	.suspend = intc_suspend,
+};
+
+/* register this intc as sysdev to allow suspend/resume */
+static int __init register_intc_sysdevs(void)
+{
+	struct intc_desc_int *d;
+	int error;
+	int id = 0;
+
+	error = sysdev_class_register(&intc_sysdev_class);
+	if (!error) {
+		list_for_each_entry(d, &intc_list, list) {
+			d->sysdev.id = id;
+			d->sysdev.cls = &intc_sysdev_class;
+			error = sysdev_register(&d->sysdev);
+			if (error)
+				break;
+			id++;
+		}
+	}
+
+	if (error)
+		pr_warning("intc: sysdev registration error\n");
+
+	return error;
+}
+
+device_initcall(register_intc_sysdevs);
