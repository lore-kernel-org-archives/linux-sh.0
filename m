From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 25 Mar 2011 13:56:04 +0000
Subject: [patch 1/2] sh: Retrieve the wakeup flag from irq_data
Message-Id: <20110325135542.970002118@linutronix.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/sh/intc/core.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-2.6-tip/drivers/sh/intc/core.c
=================================--- linux-2.6-tip.orig/drivers/sh/intc/core.c
+++ linux-2.6-tip/drivers/sh/intc/core.c
@@ -427,13 +427,12 @@ static int intc_suspend(struct sys_devic
 	case PM_EVENT_SUSPEND:
 		/* enable wakeup irqs belonging to this intc controller */
 		for_each_active_irq(irq) {
-			desc = irq_to_desc(irq);
 			data = irq_get_irq_data(irq);
 			chip = irq_data_get_irq_chip(data);
 
 			if (chip != &d->chip)
 				continue;
-			if ((desc->status & IRQ_WAKEUP))
+			if (irqd_is_wakeup_set(data))
 				chip->irq_enable(data);
 		}
 		break;


