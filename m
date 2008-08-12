From: Hideo Saito <saito@densan.co.jp>
Date: Tue, 12 Aug 2008 01:04:34 +0000
Subject: can't single-step on gdb
Message-Id: <20080812.100434.68561126.saito@densan.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

I have a problem as to tracing a program using gdb on my platform(SH7780). I can single-step a program on gdb usually, however, in some conditions, I can not single-step the program because gdb does not change the PC without any failed assertions.

It seems that do_syscall_trace() sets SIGTRAP in exit_code in the task structure before the traced program executes the instruction. I think that do_syscall_trace should ignore single-step because the schedule of the traced process might be delayed.

--- ./arch/sh/kernel/ptrace_32.c.org	2008-04-17 11:49:44.000000000 +0900
+++ ./arch/sh/kernel/ptrace_32.c	2008-08-12 08:53:44.000000000 +0900
@@ -252,18 +252,17 @@ long arch_ptrace(struct task_struct *chi
 asmlinkage void do_syscall_trace(struct pt_regs *regs, int entryexit)
 {
 	struct task_struct *tsk = current;
 
 	if (unlikely(current->audit_context) && entryexit)
 		audit_syscall_exit(AUDITSC_RESULT(regs->regs[0]),
 				   regs->regs[0]);
 
-	if (!test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    !test_thread_flag(TIF_SINGLESTEP))
+	if (!test_thread_flag(TIF_SYSCALL_TRACE))
 		goto out;
 	if (!(tsk->ptrace & PT_PTRACED))
 		goto out;
 
 	/* the 0x80 provides a way for the tracing parent to distinguish
 	   between a syscall stop and SIGTRAP delivery */
 	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD) &&
 				 !test_thread_flag(TIF_SINGLESTEP) ? 0x80 : 0));
