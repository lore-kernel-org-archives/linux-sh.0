From: Roel Kluin <roel.kluin@gmail.com>
Date: Thu, 23 Apr 2009 19:47:11 +0000
Subject: [PATCH] SH-5: struct pt_regs:syscall_nr is unsigned.
Message-Id: <49F0C5BF.4090207@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

vi arch/sh/include/asm/ptrace.h +9
And note that struct pt_regs:syscall_nr is unsigned.

So I think something like the patch below is required, isn't it? As an
alternative to the patch below, syscall_nr could become signed. what is
preferred?
--------------------------->8-------------8<------------------------------
In restore_sigcontext() syscall_nr is set to -1, but it is unsigned for
SH-5.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/arch/sh/include/asm/syscall_64.h b/arch/sh/include/asm/syscall_64.h
index c3561ca..291fc86 100644
--- a/arch/sh/include/asm/syscall_64.h
+++ b/arch/sh/include/asm/syscall_64.h
@@ -9,7 +9,7 @@
 static inline long syscall_get_nr(struct task_struct *task,
 				  struct pt_regs *regs)
 {
-	return (regs->syscall_nr >= 0) ? regs->regs[9] : -1L;
+	return (regs->syscall_nr != -1) ? regs->regs[9] : -1L;
 }
 
 static inline void syscall_rollback(struct task_struct *task,
diff --git a/arch/sh/kernel/signal_64.c b/arch/sh/kernel/signal_64.c
index 0663a0e..b851141 100644
--- a/arch/sh/kernel/signal_64.c
+++ b/arch/sh/kernel/signal_64.c
@@ -51,7 +51,7 @@ static inline void
 handle_syscall_restart(struct pt_regs *regs, struct sigaction *sa)
 {
 	/* If we're not from a syscall, bail out */
-	if (regs->syscall_nr < 0)
+	if (regs->syscall_nr = -1)
 		return;
 
 	/* check for system call restart.. */
@@ -127,7 +127,7 @@ static int do_signal(struct pt_regs *regs, sigset_t *oldset)
 
 no_signal:
 	/* Did we come from a system call? */
-	if (regs->syscall_nr >= 0) {
+	if (regs->syscall_nr != -1) {
 		/* Restart the system call - no handlers present */
 		switch (regs->regs[REG_RET]) {
 		case -ERESTARTNOHAND:
