From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 13 Nov 2020 14:02:09 +0000
Subject: [patch 02/19] sh: Get rid of nmi_count()
Message-Id: <20201113141732.844232404@linutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20201113140207.499353218@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Rich Felker <dalias@libc.org>, Catalin Marinas <catalin.marinas@arm.com>, Paul McKenney <paulmck@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Frederic Weisbecker <frederic@kernel.org>, Valentin Schneider <valentin.schneider@arm.com>, Jeff Dike <jdike@addtoit.com>, Russell King <linux@armlinux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>, linux-um@lists.infradead.org, Will Deacon <will@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>

nmi_count() is a historical leftover and SH is the only user. Replace it
with regular per cpu accessors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/kernel/irq.c   |    2 +-
 arch/sh/kernel/traps.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/sh/kernel/irq.c
+++ b/arch/sh/kernel/irq.c
@@ -44,7 +44,7 @@ int arch_show_interrupts(struct seq_file
 
 	seq_printf(p, "%*s: ", prec, "NMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", nmi_count(j));
+		seq_printf(p, "%10u ", per_cpu(irq_stat.__nmi_count, j);
 	seq_printf(p, "  Non-maskable interrupts\n");
 
 	seq_printf(p, "%*s: %10u\n", prec, "ERR", atomic_read(&irq_err_count));
--- a/arch/sh/kernel/traps.c
+++ b/arch/sh/kernel/traps.c
@@ -186,7 +186,7 @@ BUILD_TRAP_HANDLER(nmi)
 	arch_ftrace_nmi_enter();
 
 	nmi_enter();
-	nmi_count(cpu)++;
+	this_cpu_inc(irq_stat.__nmi_count);
 
 	switch (notify_die(DIE_NMI, "NMI", regs, 0, vec & 0xff, SIGINT)) {
 	case NOTIFY_OK:
