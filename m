From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 13 Nov 2020 14:02:16 +0000
Subject: [patch 09/19] irqstat: Move declaration into asm-generic/hardirq.h
Message-Id: <20201113141733.737377332@linutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20201113140207.499353218@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Rich Felker <dalias@libc.org>, Catalin Marinas <catalin.marinas@arm.com>, Paul McKenney <paulmck@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Frederic Weisbecker <frederic@kernel.org>, Valentin Schneider <valentin.schneider@arm.com>, Jeff Dike <jdike@addtoit.com>, Russell King <linux@armlinux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>, linux-um@lists.infradead.org, Will Deacon <will@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>

Move the declaration of the irq_cpustat per cpu variable to
asm-generic/hardirq.h and remove the now empty linux/irq_cpustat.h header.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/asm-generic/hardirq.h |    3 ++-
 include/linux/irq_cpustat.h   |   24 ------------------------
 2 files changed, 2 insertions(+), 25 deletions(-)

--- a/include/asm-generic/hardirq.h
+++ b/include/asm-generic/hardirq.h
@@ -12,7 +12,8 @@ typedef struct {
 #endif
 } ____cacheline_aligned irq_cpustat_t;
 
-#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
+DECLARE_PER_CPU_ALIGNED(irq_cpustat_t, irq_stat);
+
 #include <linux/irq.h>
 
 #ifndef ack_bad_irq
--- a/include/linux/irq_cpustat.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __irq_cpustat_h
-#define __irq_cpustat_h
-
-/*
- * Contains default mappings for irq_cpustat_t, used by almost every
- * architecture.  Some arch (like s390) have per cpu hardware pages and
- * they define their own mappings for irq_stat.
- *
- * Keith Owens <kaos@ocs.com.au> July 2000.
- */
-
-
-/*
- * Simple wrappers reducing source bloat.  Define all irq_stat fields
- * here, even ones that are arch dependent.  That way we get common
- * definitions instead of differing sets for each arch.
- */
-
-#ifndef __ARCH_IRQ_STAT
-DECLARE_PER_CPU_ALIGNED(irq_cpustat_t, irq_stat);	/* defined in asm/hardirq.h */
-#endif
-
-#endif	/* __irq_cpustat_h */
