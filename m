From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 13 Nov 2020 14:02:17 +0000
Subject: [patch 10/19] preempt: Cleanup the macro maze a bit
Message-Id: <20201113141733.864469886@linutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20201113140207.499353218@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Rich Felker <dalias@libc.org>, Catalin Marinas <catalin.marinas@arm.com>, Paul McKenney <paulmck@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Frederic Weisbecker <frederic@kernel.org>, Valentin Schneider <valentin.schneider@arm.com>, Jeff Dike <jdike@addtoit.com>, Russell King <linux@armlinux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>, linux-um@lists.infradead.org, Will Deacon <will@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>

Make the macro maze consistent and prepare it for adding the RT variant for
BH accounting.

 - Use nmi_count() for the NMI portion of preempt count
 - Introduce in_hardirq() to make the naming consistent and non-ambiguos
 - Use the macros to create combined checks (e.g. in_task()) so the
   softirq representation for RT just falls into place.
 - Update comments and move the deprecated macros aside

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/preempt.h |   30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -77,31 +77,33 @@
 /* preempt_count() and related functions, depends on PREEMPT_NEED_RESCHED */
 #include <asm/preempt.h>
 
+#define nmi_count()	(preempt_count() & NMI_MASK)
 #define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
 #define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
-#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK \
-				 | NMI_MASK))
+#define irq_count()	(nmi_count() | hardirq_count() | softirq_count())
 
 /*
- * Are we doing bottom half or hardware interrupt processing?
+ * Macros to retrieve the current execution context:
  *
- * in_irq()       - We're in (hard) IRQ context
+ * in_nmi()		- We're in NMI context
+ * in_hardirq()		- We're in hard IRQ context
+ * in_serving_softirq()	- We're in softirq context
+ * in_task()		- We're in task context
+ */
+#define in_nmi()		(nmi_count())
+#define in_hardirq()		(hardirq_count())
+#define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)
+#define in_task()		(!(in_nmi() | in_hardirq() | in_serving_softirq()))
+
+/*
+ * The following macros are deprecated and should not be used in new code:
+ * in_irq()       - Obsolete version of in_hardirq()
  * in_softirq()   - We have BH disabled, or are processing softirqs
  * in_interrupt() - We're in NMI,IRQ,SoftIRQ context or have BH disabled
- * in_serving_softirq() - We're in softirq context
- * in_nmi()       - We're in NMI context
- * in_task()	  - We're in task context
- *
- * Note: due to the BH disabled confusion: in_softirq(),in_interrupt() really
- *       should not be used in new code.
  */
 #define in_irq()		(hardirq_count())
 #define in_softirq()		(softirq_count())
 #define in_interrupt()		(irq_count())
-#define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)
-#define in_nmi()		(preempt_count() & NMI_MASK)
-#define in_task()		(!(preempt_count() & \
-				   (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
 
 /*
  * The preempt_count offset after preempt_disable();
