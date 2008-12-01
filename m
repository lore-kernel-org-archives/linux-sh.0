From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 01 Dec 2008 10:33:09 +0000
Subject: [PATCH 05/10] irq: allow free_irq() after setup_irq()
Message-Id: <20081201103309.26620.11140.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds support for using free_irq() on interrupts
allocated with setup_irq(). Without this patch the kernel
will try to kfree() the struct irqaction passed as argument
to setup_irq().

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 include/linux/interrupt.h |    2 ++
 kernel/irq/manage.c       |    4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

--- 0001/include/linux/interrupt.h
+++ work/include/linux/interrupt.h	2008-11-25 19:43:40.000000000 +0900
@@ -48,6 +48,7 @@
  * IRQF_IRQPOLL - Interrupt is used for polling (only the interrupt that is
  *                registered first in an shared interrupt is considered for
  *                performance reasons)
+ * IRQF_STATIC - Interrupt requested with setup_irq(), do not kfree().
  */
 #define IRQF_DISABLED		0x00000020
 #define IRQF_SAMPLE_RANDOM	0x00000040
@@ -57,6 +58,7 @@
 #define IRQF_PERCPU		0x00000400
 #define IRQF_NOBALANCING	0x00000800
 #define IRQF_IRQPOLL		0x00001000
+#define IRQF_STATIC		0x00002000
 
 typedef irqreturn_t (*irq_handler_t)(int, void *);
 
--- 0001/kernel/irq/manage.c
+++ work/kernel/irq/manage.c	2008-11-25 19:44:14.000000000 +0900
@@ -509,6 +509,7 @@ int setup_irq(unsigned int irq, struct i
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 
+	act->flags |= IRQF_STATIC;
 	return __setup_irq(irq, desc, act);
 }
 
@@ -585,7 +586,8 @@ void free_irq(unsigned int irq, void *de
 				local_irq_restore(flags);
 			}
 #endif
-			kfree(action);
+			if (!(action->flags & IRQF_STATIC))
+				kfree(action);
 			return;
 		}
 		printk(KERN_ERR "Trying to free already-free IRQ %d\n", irq);
