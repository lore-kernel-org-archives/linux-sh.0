From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 13 Nov 2020 14:02:10 +0000
Subject: [patch 03/19] irqstat: Get rid of nmi_count() and __IRQ_STAT()
Message-Id: <20201113141733.005212732@linutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20201113140207.499353218@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Rich Felker <dalias@libc.org>, Catalin Marinas <catalin.marinas@arm.com>, Paul McKenney <paulmck@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Frederic Weisbecker <frederic@kernel.org>, Valentin Schneider <valentin.schneider@arm.com>, Jeff Dike <jdike@addtoit.com>, Russell King <linux@armlinux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>, linux-um@lists.infradead.org, Will Deacon <will@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>

Nothing uses this anymore.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irq_cpustat.h |    4 ----
 1 file changed, 4 deletions(-)

--- a/include/linux/irq_cpustat.h
+++ b/include/linux/irq_cpustat.h
@@ -19,10 +19,6 @@
 
 #ifndef __ARCH_IRQ_STAT
 DECLARE_PER_CPU_ALIGNED(irq_cpustat_t, irq_stat);	/* defined in asm/hardirq.h */
-#define __IRQ_STAT(cpu, member)	(per_cpu(irq_stat.member, cpu))
 #endif
 
-/* arch dependent irq_stat fields */
-#define nmi_count(cpu)		__IRQ_STAT((cpu), __nmi_count)	/* i386 */
-
 #endif	/* __irq_cpustat_h */
