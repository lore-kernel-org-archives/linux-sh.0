From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 13 Nov 2020 14:02:23 +0000
Subject: [patch 16/19] rcu: Prevent false positive softirq warning on RT
Message-Id: <20201113141734.558782917@linutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20201113140207.499353218@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Rich Felker <dalias@libc.org>, Catalin Marinas <catalin.marinas@arm.com>, Paul McKenney <paulmck@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Frederic Weisbecker <frederic@kernel.org>, Valentin Schneider <valentin.schneider@arm.com>, Jeff Dike <jdike@addtoit.com>, Russell King <linux@armlinux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>, linux-um@lists.infradead.org, Will Deacon <will@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>

Soft interrupt disabled sections can legitimately be preempted or schedule
out when blocking on a lock on RT enabled kernels so the RCU preempt check
warning has to be disabled for RT kernels.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rcupdate.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -319,7 +319,8 @@ static inline void rcu_preempt_sleep_che
 #define rcu_sleep_check()						\
 	do {								\
 		rcu_preempt_sleep_check();				\
-		RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map),	\
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))			\
+		    RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map),	\
 				 "Illegal context switch in RCU-bh read-side critical section"); \
 		RCU_LOCKDEP_WARN(lock_is_held(&rcu_sched_lock_map),	\
 				 "Illegal context switch in RCU-sched read-side critical section"); \
