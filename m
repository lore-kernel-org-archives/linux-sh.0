From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 13 Nov 2020 14:02:11 +0000
Subject: [patch 04/19] um/irqstat: Get rid of the duplicated declarations
Message-Id: <20201113141733.156361337@linutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20201113140207.499353218@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Rich Felker <dalias@libc.org>, Marc Zyngier <maz@kernel.org>, Paul McKenney <paulmck@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Frederic Weisbecker <frederic@kernel.org>, Valentin Schneider <valentin.schneider@arm.com>, Jeff Dike <jdike@addtoit.com>, Russell King <linux@armlinux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-um@lists.infradead.org, Will Deacon <will@kernel.org>, linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>, Catalin Marinas <catalin.marinas@arm.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>

irq_cpustat_t and ack_bad_irq() are exactly the same as the asm-generic
ones.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
---
 arch/um/include/asm/hardirq.h |   17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

--- a/arch/um/include/asm/hardirq.h
+++ b/arch/um/include/asm/hardirq.h
@@ -2,22 +2,7 @@
 #ifndef __ASM_UM_HARDIRQ_H
 #define __ASM_UM_HARDIRQ_H
 
-#include <linux/cache.h>
-#include <linux/threads.h>
-
-typedef struct {
-	unsigned int __softirq_pending;
-} ____cacheline_aligned irq_cpustat_t;
-
-#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
-#include <linux/irq.h>
-
-#ifndef ack_bad_irq
-static inline void ack_bad_irq(unsigned int irq)
-{
-	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
-}
-#endif
+#include <asm-generic/hardirq.h>
 
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED 1
 
