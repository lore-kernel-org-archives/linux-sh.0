From: Alex Dowad <alexinbeijing@gmail.com>
Date: Fri, 13 Mar 2015 18:14:49 +0000
Subject: [PATCH 26/32] sh: copy_thread(): rename 'arg' argument to 'kthread_arg'
Message-Id: <1426270496-26362-16-git-send-email-alexinbeijing@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1426270496-26362-1-git-send-email-alexinbeijing@gmail.com>
In-Reply-To: <1426270496-26362-1-git-send-email-alexinbeijing@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: "open list:SUPERH" <linux-sh@vger.kernel.org>

The 'arg' argument to copy_thread() is only ever used when forking a new
kernel thread. Hence, rename it to 'kthread_arg' for clarity (and consistency
with do_fork() and other arch-specific implementations of copy_thread()).

Signed-off-by: Alex Dowad <alexinbeijing@gmail.com>
---
 arch/sh/kernel/process_32.c | 10 ++++++++--
 arch/sh/kernel/process_64.c | 12 +++++++++---
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index 2885fc9..fded1b4 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -123,8 +123,11 @@ EXPORT_SYMBOL(dump_fpu);
 asmlinkage void ret_from_fork(void);
 asmlinkage void ret_from_kernel_thread(void);
 
+/*
+ * Copy architecture-specific thread state
+ */
 int copy_thread(unsigned long clone_flags, unsigned long usp,
-		unsigned long arg, struct task_struct *p)
+		unsigned long kthread_arg, struct task_struct *p)
 {
 	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs;
@@ -146,9 +149,10 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	childregs = task_pt_regs(p);
 	p->thread.sp = (unsigned long) childregs;
 	if (unlikely(p->flags & PF_KTHREAD)) {
+		/* kernel thread */
 		memset(childregs, 0, sizeof(struct pt_regs));
 		p->thread.pc = (unsigned long) ret_from_kernel_thread;
-		childregs->regs[4] = arg;
+		childregs->regs[4] = kthread_arg;
 		childregs->regs[5] = usp;
 		childregs->sr = SR_MD;
 #if defined(CONFIG_SH_FPU)
@@ -159,6 +163,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 		p->thread.fpu_counter = 0;
 		return 0;
 	}
+
+	/* user thread */
 	*childregs = *current_pt_regs();
 
 	if (usp)
diff --git a/arch/sh/kernel/process_64.c b/arch/sh/kernel/process_64.c
index e2062e6..693105d 100644
--- a/arch/sh/kernel/process_64.c
+++ b/arch/sh/kernel/process_64.c
@@ -371,8 +371,11 @@ EXPORT_SYMBOL(dump_fpu);
 asmlinkage void ret_from_fork(void);
 asmlinkage void ret_from_kernel_thread(void);
 
+/*
+ * Copy architecture-specific thread state
+ */
 int copy_thread(unsigned long clone_flags, unsigned long usp,
-		unsigned long arg, struct task_struct *p)
+		unsigned long kthread_arg, struct task_struct *p)
 {
 	struct pt_regs *childregs;
 
@@ -391,14 +394,17 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	p->thread.sp = (unsigned long) childregs;
 
 	if (unlikely(p->flags & PF_KTHREAD)) {
+		/* kernel thread */
 		memset(childregs, 0, sizeof(struct pt_regs));
-		childregs->regs[2] = (unsigned long)arg;
-		childregs->regs[3] = (unsigned long)usp;
+		childregs->regs[2] = kthread_arg;
+		childregs->regs[3] = usp;
 		childregs->sr = (1 << 30); /* not user_mode */
 		childregs->sr |= SR_FD; /* Invalidate FPU flag */
 		p->thread.pc = (unsigned long) ret_from_kernel_thread;
 		return 0;
 	}
+
+	/* user thread */
 	*childregs = *current_pt_regs();
 
 	/*
-- 
2.0.0.GIT

