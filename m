From: Roel Kluin <roel.kluin@gmail.com>
Date: Thu, 22 Jan 2009 15:16:14 +0000
Subject: Re: [PATCH] SH: fix start_thread and user_stack_pointer macros
Message-Id: <49788DBE.5010802@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Fix macros start_thread and user_stack_pointer.
When these macros aren't called with a variable named regs as second
argument, this will result in a build failure.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Overlooked the start_thread macros in my first patch

diff --git a/arch/sh/include/asm/kprobes.h b/arch/sh/include/asm/kprobes.h
index 6078d8e..613644a 100644
--- a/arch/sh/include/asm/kprobes.h
+++ b/arch/sh/include/asm/kprobes.h
@@ -16,7 +16,7 @@ typedef u16 kprobe_opcode_t;
 	? (MAX_STACK_SIZE) \
 	: (((unsigned long)current_thread_info()) + THREAD_SIZE - (ADDR)))
 
-#define regs_return_value(regs)		((regs)->regs[0])
+#define regs_return_value(_regs)		((_regs)->regs[0])
 #define flush_insn_slot(p)		do { } while (0)
 #define kretprobe_blacklist_size	0
 
diff --git a/arch/sh/include/asm/processor_32.h b/arch/sh/include/asm/processor_32.h
index d79063c..dcaed24 100644
--- a/arch/sh/include/asm/processor_32.h
+++ b/arch/sh/include/asm/processor_32.h
@@ -108,12 +108,12 @@ extern int ubc_usercnt;
 /*
  * Do necessary setup to start up a newly executed thread.
  */
-#define start_thread(regs, new_pc, new_sp)	 \
+#define start_thread(_regs, new_pc, new_sp)	 \
 	set_fs(USER_DS);			 \
-	regs->pr = 0;				 \
-	regs->sr = SR_FD;	/* User mode. */ \
-	regs->pc = new_pc;			 \
-	regs->regs[15] = new_sp
+	_regs->pr = 0;				 \
+	_regs->sr = SR_FD;	/* User mode. */ \
+	_regs->pc = new_pc;			 \
+	_regs->regs[15] = new_sp
 
 /* Forward declaration, a strange C thing */
 struct task_struct;
@@ -189,7 +189,7 @@ extern unsigned long get_wchan(struct task_struct *p);
 #define KSTK_EIP(tsk)  (task_pt_regs(tsk)->pc)
 #define KSTK_ESP(tsk)  (task_pt_regs(tsk)->regs[15])
 
-#define user_stack_pointer(regs)	((regs)->regs[15])
+#define user_stack_pointer(_regs)	((_regs)->regs[15])
 
 #if defined(CONFIG_CPU_SH2A) || defined(CONFIG_CPU_SH3) || \
     defined(CONFIG_CPU_SH4)
diff --git a/arch/sh/include/asm/processor_64.h b/arch/sh/include/asm/processor_64.h
index 803177f..5727d31 100644
--- a/arch/sh/include/asm/processor_64.h
+++ b/arch/sh/include/asm/processor_64.h
@@ -145,13 +145,13 @@ struct thread_struct {
  */
 #define SR_USER (SR_MMU | SR_FD)
 
-#define start_thread(regs, new_pc, new_sp)			\
+#define start_thread(_regs, new_pc, new_sp)			\
 	set_fs(USER_DS);					\
-	regs->sr = SR_USER;	/* User mode. */		\
-	regs->pc = new_pc - 4;	/* Compensate syscall exit */	\
-	regs->pc |= 1;		/* Set SHmedia ! */		\
-	regs->regs[18] = 0;					\
-	regs->regs[15] = new_sp
+	_regs->sr = SR_USER;	/* User mode. */		\
+	_regs->pc = new_pc - 4;	/* Compensate syscall exit */	\
+	_regs->pc |= 1;		/* Set SHmedia ! */		\
+	_regs->regs[18] = 0;					\
+	_regs->regs[15] = new_sp
 
 /* Forward declaration, a strange C thing */
 struct task_struct;
@@ -226,7 +226,7 @@ extern unsigned long get_wchan(struct task_struct *p);
 #define KSTK_EIP(tsk)  ((tsk)->thread.pc)
 #define KSTK_ESP(tsk)  ((tsk)->thread.sp)
 
-#define user_stack_pointer(regs)	((regs)->regs[15])
+#define user_stack_pointer(_regs)	((_regs)->regs[15])
 
 #endif	/* __ASSEMBLY__ */
 #endif /* __ASM_SH_PROCESSOR_64_H */
