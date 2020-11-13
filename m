From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 13 Nov 2020 14:02:22 +0000
Subject: [patch 15/19] tick/sched: Prevent false positive softirq pending warnings on RT
Message-Id: <20201113141734.442990268@linutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20201113140207.499353218@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Rich Felker <dalias@libc.org>, Catalin Marinas <catalin.marinas@arm.com>, Paul McKenney <paulmck@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Frederic Weisbecker <frederic@kernel.org>, Valentin Schneider <valentin.schneider@arm.com>, Jeff Dike <jdike@addtoit.com>, Russell King <linux@armlinux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>, linux-um@lists.infradead.org, Will Deacon <will@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On RT a task which has soft interrupts disabled can block on a lock and
schedule out to idle while soft interrupts are pending. This triggers the
warning in the NOHZ idle code which complains about going idle with pending
soft interrupts. But as the task is blocked soft interrupt processing is
temporarily blocked as well which means that such a warning is a false
positive.

To prevent that check the per CPU state which indicates that a scheduled
out task has soft interrupts disabled.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/bottom_half.h |    6 ++++++
 kernel/softirq.c            |   15 +++++++++++++++
 kernel/time/tick-sched.c    |    2 +-
 3 files changed, 22 insertions(+), 1 deletion(-)

--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -32,4 +32,10 @@ static inline void local_bh_enable(void)
 	__local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
 }
 
+#ifdef CONFIG_PREEMPT_RT
+extern bool local_bh_blocked(void);
+#else
+static inline bool local_bh_blocked(void) { return false; }
+#endif
+
 #endif /* _LINUX_BH_H */
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -138,6 +138,21 @@ static DEFINE_PER_CPU(struct softirq_ctr
 	.lock	= INIT_LOCAL_LOCK(softirq_ctrl.lock),
 };
 
+/**
+ * local_bh_blocked() - Check for idle whether BH processing is blocked
+ *
+ * Returns false if the per CPU softirq::cnt is 0 otherwise true.
+ *
+ * This is invoked from the idle task to guard against false positive
+ * softirq pending warnings, which would happen when the task which holds
+ * softirq_ctrl::lock was the only running task on the CPU and blocks on
+ * some other lock.
+ */
+bool local_bh_blocked(void)
+{
+	return this_cpu_read(softirq_ctrl.cnt) != 0;
+}
+
 void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 {
 	unsigned long flags;
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -925,7 +925,7 @@ static bool can_stop_idle_tick(int cpu,
 	if (unlikely(local_softirq_pending())) {
 		static int ratelimit;
 
-		if (ratelimit < 10 &&
+		if (ratelimit < 10 && !local_bh_blocked() &&
 		    (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
 			pr_warn("NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #%02x!!!\n",
 				(unsigned int) local_softirq_pending());
