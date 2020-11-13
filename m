From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 13 Nov 2020 14:02:15 +0000
Subject: [patch 08/19] sh: irqstat: Use the generic irq_cpustat_t
Message-Id: <20201113141733.625146223@linutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20201113140207.499353218@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Rich Felker <dalias@libc.org>, Catalin Marinas <catalin.marinas@arm.com>, Paul McKenney <paulmck@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Frederic Weisbecker <frederic@kernel.org>, Valentin Schneider <valentin.schneider@arm.com>, Jeff Dike <jdike@addtoit.com>, Russell King <linux@armlinux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>, linux-um@lists.infradead.org, Will Deacon <will@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>

SH can now use the generic irq_cpustat_t. Define ack_bad_irq so the generic
header does not emit the generic version of it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/include/asm/hardirq.h |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

--- a/arch/sh/include/asm/hardirq.h
+++ b/arch/sh/include/asm/hardirq.h
@@ -2,16 +2,10 @@
 #ifndef __ASM_SH_HARDIRQ_H
 #define __ASM_SH_HARDIRQ_H
 
-#include <linux/threads.h>
-#include <linux/irq.h>
-
-typedef struct {
-	unsigned int __softirq_pending;
-	unsigned int __nmi_count;		/* arch dependent */
-} ____cacheline_aligned irq_cpustat_t;
-
-#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
-
 extern void ack_bad_irq(unsigned int irq);
+#define ack_bad_irq ack_bad_irq
+#define ARCH_WANTS_NMI_IRQSTAT
+
+#include <asm-generic/hardirq.h>
 
 #endif /* __ASM_SH_HARDIRQ_H */
