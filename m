From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Date: Tue, 04 Mar 2014 16:43:21 +0000
Subject: [tip:irq/core] sh: Use irq_set_affinity instead of homebrewn code
Message-Id: <tip-6decf1a33c386d4addc2ed9d269c3868f08c70bb@git.kernel.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20140223212736.774961401@linutronix.de>
In-Reply-To: <20140223212736.774961401@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-tip-commits@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, hpa@zytor.com, mingo@kernel.org, peterz@infradead.org, lethal@linux-sh.org, tglx@linutronix.de

Commit-ID:  6decf1a33c386d4addc2ed9d269c3868f08c70bb
Gitweb:     http://git.kernel.org/tip/6decf1a33c386d4addc2ed9d269c3868f08c70bb
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 23 Feb 2014 21:40:10 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 4 Mar 2014 17:37:55 +0100

sh: Use irq_set_affinity instead of homebrewn code

There is no point in having an incomplete copy of irq_set_affinity()
for the hotplug irq migration code.

Use the core function instead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: sh <linux-sh@vger.kernel.org>
Link: http://lkml.kernel.org/r/20140223212736.774961401@linutronix.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/sh/kernel/irq.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
index 0833736..65a1ecd 100644
--- a/arch/sh/kernel/irq.c
+++ b/arch/sh/kernel/irq.c
@@ -217,19 +217,6 @@ void __init init_IRQ(void)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-static void route_irq(struct irq_data *data, unsigned int irq, unsigned int cpu)
-{
-	struct irq_desc *desc = irq_to_desc(irq);
-	struct irq_chip *chip = irq_data_get_irq_chip(data);
-
-	printk(KERN_INFO "IRQ%u: moving from cpu%u to cpu%u\n",
-	       irq, data->node, cpu);
-
-	raw_spin_lock_irq(&desc->lock);
-	chip->irq_set_affinity(data, cpumask_of(cpu), false);
-	raw_spin_unlock_irq(&desc->lock);
-}
-
 /*
  * The CPU has been marked offline.  Migrate IRQs off this CPU.  If
  * the affinity settings do not allow other CPUs, force them onto any
@@ -250,11 +237,8 @@ void migrate_irqs(void)
 						    irq, cpu);
 
 				cpumask_setall(data->affinity);
-				newcpu = cpumask_any_and(data->affinity,
-							 cpu_online_mask);
 			}
-
-			route_irq(data, irq, newcpu);
+			irq_set_affinity(irq, data->affinity);
 		}
 	}
 }
