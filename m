From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 14 Oct 2009 10:18:30 +0000
Subject: [PATCH 01/07] sh: Restore all INTC registers on resume
Message-Id: <20091014101830.21842.25661.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Extend the INTC code to re-init secondary masking and priority
registers at resume time. A better solution is to have per-CPU
save-and-restore support for each sleep mode.

Not-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/sh/intc.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

--- 0001/drivers/sh/intc.c
+++ work/drivers/sh/intc.c	2009-10-08 12:13:22.000000000 +0900
@@ -54,6 +54,8 @@ struct intc_desc_int {
 	unsigned int nr_prio;
 	struct intc_handle_int *sense;
 	unsigned int nr_sense;
+	struct intc_handle_int *secondary;
+	unsigned int nr_secondary;
 	struct irq_chip chip;
 };
 
@@ -612,6 +614,14 @@ static void __init intc_register_irq(str
 	if (data[!primary])
 		_intc_enable(irq, data[!primary]);
 
+	/* add to d->secondary list if secondary masking method is present */
+	if (data[!primary]) {
+		hp = d->secondary + d->nr_secondary;
+		hp->irq = irq;
+		hp->handle = data[!primary];
+		d->nr_secondary++;
+	}
+
 	/* add irq to d->prio list if priority is available */
 	if (data[1]) {
 		hp = d->prio + d->nr_prio;
@@ -717,6 +727,9 @@ void __init register_intc_controller(str
 		}
 	}
 
+	d->secondary = kzalloc(desc->nr_vectors * sizeof(*d->secondary),
+			       GFP_NOWAIT);
+
 	d->chip.name = desc->name;
 	d->chip.mask = intc_disable;
 	d->chip.unmask = intc_enable;
@@ -787,6 +800,7 @@ static int intc_suspend(struct sys_devic
 {
 	struct intc_desc_int *d;
 	struct irq_desc *desc;
+	struct intc_handle_int *ihp;
 	int irq;
 
 	/* get intc controller associated with this sysdev */
@@ -794,11 +808,22 @@ static int intc_suspend(struct sys_devic
 
 	switch (state.event) {
 	case PM_EVENT_ON:
+#if 0
 		if (d->state.event != PM_EVENT_FREEZE)
 			break;
+#endif
 		for_each_irq_desc(irq, desc) {
 			if (desc->chip != &d->chip)
 				continue;
+
+			/* setup secondary masking register if available */
+			ihp = intc_find_irq(d->secondary, d->nr_secondary, irq);
+			if (ihp)
+				_intc_enable(irq, ihp->handle);
+
+			/* set priority as well */
+			intc_set_priority(irq, intc_prio_level[irq]);
+
 			if (desc->status & IRQ_DISABLED)
 				intc_disable(irq);
 			else
