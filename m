From: Valentin Schneider <valentin.schneider@arm.com>
Date: Mon, 23 Sep 2019 14:36:12 +0000
Subject: [PATCH v2 1/9] sched/core: Fix preempt_schedule() interrupt return comment
Message-Id: <20190923143620.29334-2-valentin.schneider@arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20190923143620.29334-1-valentin.schneider@arm.com>
In-Reply-To: <20190923143620.29334-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: uclinux-h8-devel@lists.sourceforge.jp, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-m68k@lists.linux-m68k.org, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-riscv@lists.infradead.org

preempt_schedule_irq() is the one that should be called on return from
interrupt, clean up the comment to avoid any ambiguity.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f9a1346a5fa9..3f40ea9f1372 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4223,9 +4223,8 @@ static void __sched notrace preempt_schedule_common(void)
 
 #ifdef CONFIG_PREEMPTION
 /*
- * this is the entry point to schedule() from in-kernel preemption
- * off of preempt_enable. Kernel preemptions off return from interrupt
- * occur there and call schedule directly.
+ * This is the entry point to schedule() from in-kernel preemption
+ * off of preempt_enable.
  */
 asmlinkage __visible void __sched notrace preempt_schedule(void)
 {
@@ -4296,7 +4295,7 @@ EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
 #endif /* CONFIG_PREEMPTION */
 
 /*
- * this is the entry point to schedule() from kernel preemption
+ * This is the entry point to schedule() from kernel preemption
  * off of irq context.
  * Note, that this is called and return with irqs disabled. This will
  * protect us against recursive calling from irq.
--
2.22.0
