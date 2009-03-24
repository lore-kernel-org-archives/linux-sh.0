From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Date: Tue, 24 Mar 2009 11:28:28 +0000
Subject: [RFC patch] Fix stack dsp offset
Message-Id: <20090324112828.GA17344@gandalf.sssup.it>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Compute correcly the offset of the registers on the stack when the
CONFIG_SH_DSP is enabled. It add a thread depend information
in the thread_struct. It was tested in the migor sh4a using
a gdbserver application for a non dsp application.

Signed-off-by: Michael Trimarchi <michael@evidence.eu.com>
---
diff --git a/arch/sh/include/asm/processor_32.h b/arch/sh/include/asm/processor_32.h
index efdd78a..46e73b2 100644
--- a/arch/sh/include/asm/processor_32.h
+++ b/arch/sh/include/asm/processor_32.h
@@ -96,6 +96,9 @@ struct thread_struct {
 
 	/* floating point info */
 	union sh_fpu_union fpu;
+
+	/* Dsp status information */
+	long dsp_status;
 };
 
 /* Count of active tasks with UBC settings */
diff --git a/arch/sh/include/asm/ptrace.h b/arch/sh/include/asm/ptrace.h
index 81c6568..3504f2d 100644
--- a/arch/sh/include/asm/ptrace.h
+++ b/arch/sh/include/asm/ptrace.h
@@ -120,11 +120,19 @@ extern void user_enable_single_step(struct task_struct *);
 extern void user_disable_single_step(struct task_struct *);
 
 #ifdef CONFIG_SH_DSP
-#define task_pt_regs(task) \
-	((struct pt_regs *) (task_stack_page(task) + THREAD_SIZE \
-		 - sizeof(struct pt_dspregs)) - 1)
+extern int is_dsp_enabled(struct task_struct *);
+
 #define task_pt_dspregs(task) \
-	((struct pt_dspregs *) (task_stack_page(task) + THREAD_SIZE) - 1)
+	((struct pt_dspregs *) (task_stack_page(task) + THREAD_SIZE \
+		 - sizeof(unsigned long)) - 1)
+
+#define task_pt_regs(task) \
+        (is_dsp_enabled(task) ? \
+		((struct pt_regs *) (task_stack_page(task) + \
+			THREAD_SIZE - sizeof(struct pt_dspregs) - \
+			sizeof(unsigned long)) - 1): \
+		((struct pt_regs *) (task_stack_page(task) + \
+			THREAD_SIZE - sizeof(unsigned long)) - 1))
 #else
 #define task_pt_regs(task) \
 	((struct pt_regs *) (task_stack_page(task) + THREAD_SIZE) - 1)
diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
index 29ca09d..4560637 100644
--- a/arch/sh/kernel/ptrace_32.c
+++ b/arch/sh/kernel/ptrace_32.c
@@ -195,6 +195,12 @@ static int fpregs_active(struct task_struct *target,
 #endif
 
 #ifdef CONFIG_SH_DSP
+
+int is_dsp_enabled(struct task_struct *task)
+{
+	return !!(task->thread.dsp_status & SR_DSP);
+}
+
 static int dspregs_get(struct task_struct *target,
 		       const struct user_regset *regset,
 		       unsigned int pos, unsigned int count,
diff --git a/arch/sh/kernel/traps_32.c b/arch/sh/kernel/traps_32.c
index 60dcf87..d97886d 100644
--- a/arch/sh/kernel/traps_32.c
+++ b/arch/sh/kernel/traps_32.c
@@ -664,6 +664,8 @@ asmlinkage void do_reserved_inst(unsigned long r4, unsigned long r5,
 	if (is_dsp_inst(regs)) {
 		/* Enable DSP mode, and restart instruction. */
 		regs->sr |= SR_DSP;
+		/* Save DSP mode */
+		tsk->thread.dsp_status |= SR_DSP;
 		return;
 	}
 #endif
