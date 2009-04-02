From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Date: Thu, 02 Apr 2009 09:41:36 +0000
Subject: [RFC patch V2] Move dsp register and fix access function
Message-Id: <20090402094136.GA13576@gandalf.sssup.it>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch is only a request for comment. I do some change of the code.
Move the dsp registers on task's private data

Signed-not-really-of-by: Michael Trimarchi <michael@evidence.eu.com>

---
diff --git a/arch/sh/include/asm/processor_32.h b/arch/sh/include/asm/processor_32.h
index efdd78a..5386991 100644
--- a/arch/sh/include/asm/processor_32.h
+++ b/arch/sh/include/asm/processor_32.h
@@ -57,6 +57,18 @@ asmlinkage void __init sh_cpu_init(void);
 #define SR_IMASK	0x000000f0
 #define SR_FD		0x00008000

+#ifdef CONFIG_SH_DSP
+/*
+ * DSP structure and data
+ */
+
+struct sh_dsp_struct {
+	unsigned long dsp_regs[14];
+	long status;
+};
+
+#endif
+
 /*
  * FPU structure and data
  */
@@ -96,6 +108,11 @@ struct thread_struct {

 	/* floating point info */
 	union sh_fpu_union fpu;
+
+#ifdef CONFIG_SH_DSP
+	/* Dsp status information */
+	struct sh_dsp_struct dsp_status;
+#endif
 };

 /* Count of active tasks with UBC settings */
diff --git a/arch/sh/include/asm/ptrace.h b/arch/sh/include/asm/ptrace.h
index 81c6568..d3f6caa 100644
--- a/arch/sh/include/asm/ptrace.h
+++ b/arch/sh/include/asm/ptrace.h
@@ -119,16 +119,8 @@ struct task_struct;
 extern void user_enable_single_step(struct task_struct *);
 extern void user_disable_single_step(struct task_struct *);

-#ifdef CONFIG_SH_DSP
-#define task_pt_regs(task) \
-	((struct pt_regs *) (task_stack_page(task) + THREAD_SIZE \
-		 - sizeof(struct pt_dspregs)) - 1)
-#define task_pt_dspregs(task) \
-	((struct pt_dspregs *) (task_stack_page(task) + THREAD_SIZE) - 1)
-#else
 #define task_pt_regs(task) \
 	((struct pt_regs *) (task_stack_page(task) + THREAD_SIZE) - 1)
-#endif

 static inline unsigned long profile_pc(struct pt_regs *regs)
 {
diff --git a/arch/sh/include/asm/system_32.h b/arch/sh/include/asm/system_32.h
index a726d5d..e309e59 100644
--- a/arch/sh/include/asm/system_32.h
+++ b/arch/sh/include/asm/system_32.h
@@ -3,61 +3,138 @@

 #include <linux/types.h>

+#ifdef CONFIG_SH_DSP
+
+#define is_dsp_enabled(tsk)						\
+        (!!(tsk->thread.dsp_status.status & SR_DSP))
+
+#define __restore_dsp(tsk)						\
+do {									\
+	register u32 *__ts2 __asm__ ("r2") =				\
+			(u32 *)&tsk->thread.dsp_status;			\
+	__asm__ __volatile__ (						\
+		".balign 4\n\t"						\
+		"movs.l	@r2+, a1\n\t"					\
+		"movs.l	@r2+, a0g\n\t"					\
+		"movs.l	@r2+, a1g\n\t"					\
+		"movs.l	@r2+, m0\n\t"					\
+		"movs.l	@r2+, m1\n\t"					\
+		"movs.l	@r2+, a0\n\t"					\
+		"movs.l	@r2+, x0\n\t"					\
+		"movs.l	@r2+, x1\n\t"					\
+		"movs.l	@r2+, y0\n\t"					\
+		"movs.l	@r2+, y1\n\t"					\
+		"lds.l	@r2+, dsr\n\t"					\
+		"ldc.l	@r2+, rs\n\t"					\
+		"ldc.l	@r2+, re\n\t"					\
+		"ldc.l	@r2+, mod\n\t"					\
+		: : "r" (__ts2));					\
+} while (0)
+
+
+#define __save_dsp(tsk)							\
+do {									\
+	register u32 *__ts2 __asm__ ("r2") =				\
+			(u32 *)&tsk->thread.dsp_status + 14;		\
+									\
+	__asm__ __volatile__ (						\
+		".balign 4\n\t"						\
+		"stc.l	mod, @-r2\n\t"				\
+		"stc.l	re, @-r2\n\t"					\
+		"stc.l	rs, @-r2\n\t"					\
+		"sts.l	dsr, @-r2\n\t"				\
+		"sts.l	y1, @-r2\n\t"					\
+		"sts.l	y0, @-r2\n\t"					\
+		"sts.l	x1, @-r2\n\t"					\
+		"sts.l	x0, @-r2\n\t"					\
+		"sts.l	a0, @-r2\n\t"					\
+		".word	0xf653		! movs.l	a1, @-r2\n\t"	\
+		".word	0xf6f3		! movs.l	a0g, @-r2\n\t"	\
+		".word	0xf6d3		! movs.l	a1g, @-r2\n\t"	\
+		".word	0xf6c3		! movs.l        m0, @-r2\n\t"	\
+		".word	0xf6e3		! movs.l        m1, @-r2\n\t"	\
+		: : "r" (__ts2));					\
+} while (0)
+
+#else
+
+#define is_dsp_enabled(tsk)	(0)
+
+#endif
+
 struct task_struct *__switch_to(struct task_struct *prev,
 				struct task_struct *next);

 /*
  *	switch_to() should switch tasks to task nr n, first
  */
-#define switch_to(prev, next, last)					\
-do {									\
-	register u32 *__ts1 __asm__ ("r1") = (u32 *)&prev->thread.sp;	\
-	register u32 *__ts2 __asm__ ("r2") = (u32 *)&prev->thread.pc;	\
-	register u32 *__ts4 __asm__ ("r4") = (u32 *)prev;		\
-	register u32 *__ts5 __asm__ ("r5") = (u32 *)next;		\
-	register u32 *__ts6 __asm__ ("r6") = (u32 *)&next->thread.sp;	\
-	register u32 __ts7 __asm__ ("r7") = next->thread.pc;		\
-	struct task_struct *__last;					\
-									\
-	__asm__ __volatile__ (						\
-		".balign 4\n\t"						\
-		"stc.l	gbr, @-r15\n\t"					\
-		"sts.l	pr, @-r15\n\t"					\
-		"mov.l	r8, @-r15\n\t"					\
-		"mov.l	r9, @-r15\n\t"					\
-		"mov.l	r10, @-r15\n\t"					\
-		"mov.l	r11, @-r15\n\t"					\
-		"mov.l	r12, @-r15\n\t"					\
-		"mov.l	r13, @-r15\n\t"					\
-		"mov.l	r14, @-r15\n\t"					\
-		"mov.l	r15, @r1\t! save SP\n\t"			\
-		"mov.l	@r6, r15\t! change to new stack\n\t"		\
-		"mova	1f, %0\n\t"					\
-		"mov.l	%0, @r2\t! save PC\n\t"				\
-		"mov.l	2f, %0\n\t"					\
-		"jmp	@%0\t! call __switch_to\n\t"			\
-		" lds	r7, pr\t!  with return to new PC\n\t"		\
-		".balign	4\n"					\
-		"2:\n\t"						\
-		".long	__switch_to\n"					\
-		"1:\n\t"						\
-		"mov.l	@r15+, r14\n\t"					\
-		"mov.l	@r15+, r13\n\t"					\
-		"mov.l	@r15+, r12\n\t"					\
-		"mov.l	@r15+, r11\n\t"					\
-		"mov.l	@r15+, r10\n\t"					\
-		"mov.l	@r15+, r9\n\t"					\
-		"mov.l	@r15+, r8\n\t"					\
-		"lds.l	@r15+, pr\n\t"					\
-		"ldc.l	@r15+, gbr\n\t"					\
-		: "=z" (__last)						\
-		: "r" (__ts1), "r" (__ts2), "r" (__ts4),		\
-		  "r" (__ts5), "r" (__ts6), "r" (__ts7)			\
-		: "r3", "t");						\
-									\
-	last = __last;							\
+#define switch_to(prev, next, last)				\
+do {								\
+	register u32 *__ts1 __asm__ ("r1");			\
+	register u32 *__ts2 __asm__ ("r2");			\
+	register u32 *__ts4 __asm__ ("r4");			\
+	register u32 *__ts5 __asm__ ("r5");			\
+	register u32 *__ts6 __asm__ ("r6");			\
+	register u32 __ts7 __asm__ ("r7");			\
+	struct task_struct *__last;				\
+								\
+	if (is_dsp_enabled(prev))				\
+		__save_dsp(prev);				\
+								\
+	__ts1 = (u32 *)&prev->thread.sp;			\
+	__ts2 = (u32 *)&prev->thread.pc;			\
+	__ts4 = (u32 *)prev;					\
+	__ts5 = (u32 *)next;					\
+	__ts6 = (u32 *)&next->thread.sp;			\
+	__ts7 = next->thread.pc;				\
+								\
+	__asm__ __volatile__ (					\
+		".balign 4\n\t"					\
+		"stc.l	gbr, @-r15\n\t"				\
+		"sts.l	pr, @-r15\n\t"				\
+		"mov.l	r8, @-r15\n\t"				\
+		"mov.l	r9, @-r15\n\t"				\
+		"mov.l	r10, @-r15\n\t"				\
+		"mov.l	r11, @-r15\n\t"				\
+		"mov.l	r12, @-r15\n\t"				\
+		"mov.l	r13, @-r15\n\t"				\
+		"mov.l	r14, @-r15\n\t"				\
+		"mov.l	r15, @r1\t! save SP\n\t"		\
+		"mov.l	@r6, r15\t! change to new stack\n\t"	\
+		"mova	1f, %0\n\t"				\
+		"mov.l	%0, @r2\t! save PC\n\t"			\
+		"mov.l	2f, %0\n\t"				\
+		"jmp	@%0\t! call __switch_to\n\t"		\
+		" lds	r7, pr\t!  with return to new PC\n\t"	\
+		".balign	4\n"				\
+		"2:\n\t"					\
+		".long	__switch_to\n"				\
+		"1:\n\t"					\
+		"mov.l	@r15+, r14\n\t"				\
+		"mov.l	@r15+, r13\n\t"				\
+		"mov.l	@r15+, r12\n\t"				\
+		"mov.l	@r15+, r11\n\t"				\
+		"mov.l	@r15+, r10\n\t"				\
+		"mov.l	@r15+, r9\n\t"				\
+		"mov.l	@r15+, r8\n\t"				\
+		"lds.l	@r15+, pr\n\t"				\
+		"ldc.l	@r15+, gbr\n\t"				\
+		: "=z" (__last)					\
+		: "r" (__ts1), "r" (__ts2), "r" (__ts4),	\
+		  "r" (__ts5), "r" (__ts6), "r" (__ts7)		\
+		: "r3", "t");					\
+								\
+	last = __last;						\
 } while (0)

+#ifdef CONFIG_SH_DSP
+#define finish_arch_switch(prev)				\
+do {								\
+	if (is_dsp_enabled(prev))				\
+		__restore_dsp(prev);				\
+} while (0)
+#endif
+
 #define __uses_jump_to_uncached \
 	noinline __attribute__ ((__section__ (".uncached.text")))

diff --git a/arch/sh/kernel/cpu/sh3/entry.S b/arch/sh/kernel/cpu/sh3/entry.S
index 55da0ff..eaaa719 100644
--- a/arch/sh/kernel/cpu/sh3/entry.S
+++ b/arch/sh/kernel/cpu/sh3/entry.S
@@ -254,40 +254,6 @@ restore_all:

 	lds	k2, pr			! restore pr
 	!
-#ifdef CONFIG_SH_DSP
-	mov.l	@r15+, k0		! DSP mode marker
-	mov.l	5f, k1
-	cmp/eq	k0, k1			! Do we have a DSP stack frame?
-	bf	skip_restore
-
-	stc	sr, k0			! Enable CPU DSP mode
-	or	k1, k0			! (within kernel it may be disabled)
-	ldc	k0, sr
-	mov	r2, k0			! Backup r2
-
-	! Restore DSP registers from stack
-	mov	r15, r2
-	movs.l	@r2+, a1
-	movs.l	@r2+, a0g
-	movs.l	@r2+, a1g
-	movs.l	@r2+, m0
-	movs.l	@r2+, m1
-	mov	r2, r15
-
-	lds.l	@r15+, a0
-	lds.l	@r15+, x0
-	lds.l	@r15+, x1
-	lds.l	@r15+, y0
-	lds.l	@r15+, y1
-	lds.l	@r15+, dsr
-	ldc.l	@r15+, rs
-	ldc.l	@r15+, re
-	ldc.l	@r15+, mod
-
-	mov	k0, r2			! Restore r2
-skip_restore:
-#endif
-	!
 	! Calculate new SR value
 	mov	k3, k2			! original SR value
 	mov	#0xf0, k1
@@ -358,7 +324,7 @@ general_exception:
 	add	k0, k4
 0:
 	! Setup stack and save DSP context (k0 contains original r15 on return)
-	bsr	prepare_stack_save_dsp
+	bsr	prepare_stack
 	 nop

 	! Save registers / Switch to bank 0
@@ -374,15 +340,14 @@ general_exception:
 1:	.long	EXPEVT
 #endif

-! prepare_stack_save_dsp()
+! prepare_stack()
 ! - roll back gRB
 ! - switch to kernel stack
-! - save DSP
 ! k0 returns original sp (after roll back)
 ! k1 trashed
 ! k2 trashed

-prepare_stack_save_dsp:
+prepare_stack:
 #ifdef CONFIG_GUSA
 	! Check for roll back gRB (User and Kernel)
 	mov	r15, k0
@@ -416,47 +381,9 @@ prepare_stack_save_dsp:
 	mov	k1, r15		! change to kernel stack
 	!
 1:
-#ifdef CONFIG_SH_DSP
-	! Save DSP context if needed
-	stc	sr, k1
-	mov	#0x10, k2
-	shll8   k2			! DSP=1 (0x00001000)
-	tst	k2, k1			! Check if in DSP mode (passed in k2)
-	bt/s	skip_save
-	 mov	#0, k1			! Set marker for no stack frame
-
-	mov	k2, k1			! Save has-frame marker
-
-	! Save DSP registers on stack
-	stc.l	mod, @-r15
-	stc.l	re, @-r15
-	stc.l	rs, @-r15
-	sts.l	dsr, @-r15
-	sts.l	y1, @-r15
-	sts.l	y0, @-r15
-	sts.l	x1, @-r15
-	sts.l	x0, @-r15
-	sts.l	a0, @-r15
-
-	! GAS is broken, does not generate correct "movs.l Ds,@-As" instr.
-
-	! FIXME: Make sure that this is still the case with newer toolchains,
-	! as we're not at all interested in supporting ancient toolchains at
-	! this point. -- PFM.
-
-	mov	r15, k2
-	.word	0xf653			! movs.l	a1, @-r2
-	.word	0xf6f3			! movs.l	a0g, @-r2
-	.word	0xf6d3			! movs.l	a1g, @-r2
-	.word	0xf6c3			! movs.l	m0, @-r2
-	.word	0xf6e3			! movs.l	m1, @-r2
-	mov	k2, r15
-
-skip_save:
-	mov.l	k1, @-r15		! Push DSP mode marker onto stack
-#endif
 	rts
-	 nop
+	nop
+
 !
 ! 0x400: Instruction and Data TLB miss exception vector
 !
@@ -468,7 +395,7 @@ handle_exception:
 	mova	exception_data, k0

 	! Setup stack and save DSP context (k0 contains original r15 on return)
-	bsr	prepare_stack_save_dsp
+	bsr	prepare_stack
 	 PREF(k0)

 	! Save registers / Switch to bank 0
@@ -572,7 +499,7 @@ ENTRY(handle_interrupt)
 	mova	exception_data, k0

 	! Setup stack and save DSP context (k0 contains original r15 on return)
-	bsr	prepare_stack_save_dsp
+	bsr	prepare_stack
 	 PREF(k0)

 	! Save registers / Switch to bank 0
diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index ddafbbb..7de460a 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -184,6 +184,11 @@ int copy_thread(int nr, unsigned long clone_flags, unsigned long usp,
 	copy_to_stopped_child_used_math(p);
 #endif

+#if defined(CONFIG_SH_DSP)
+	if (is_dsp_enabled(p))
+                __save_dsp(p);
+#endif
+
 	childregs = task_pt_regs(p);
 	*childregs = *regs;

diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
index 29ca09d..e9eaf21 100644
--- a/arch/sh/kernel/ptrace_32.c
+++ b/arch/sh/kernel/ptrace_32.c
@@ -195,12 +195,14 @@ static int fpregs_active(struct task_struct *target,
 #endif

 #ifdef CONFIG_SH_DSP
+
 static int dspregs_get(struct task_struct *target,
 		       const struct user_regset *regset,
 		       unsigned int pos, unsigned int count,
 		       void *kbuf, void __user *ubuf)
 {
-	const struct pt_dspregs *regs = task_pt_dspregs(target);
+	const struct pt_dspregs *regs +		(struct pt_dspregs *)&target->thread.dsp_status.dsp_regs;
 	int ret;

 	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, regs,
@@ -217,7 +219,8 @@ static int dspregs_set(struct task_struct *target,
 		       unsigned int pos, unsigned int count,
 		       const void *kbuf, const void __user *ubuf)
 {
-	struct pt_dspregs *regs = task_pt_dspregs(target);
+	struct pt_dspregs *regs +		(struct pt_dspregs *)&target->thread.dsp_status.dsp_regs;
 	int ret;

 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, regs,
@@ -236,6 +239,7 @@ static int dspregs_active(struct task_struct *target,

 	return regs->sr & SR_DSP ? regset->n : 0;
 }
+
 #endif

 /*
diff --git a/arch/sh/kernel/traps_32.c b/arch/sh/kernel/traps_32.c
index 60dcf87..30ca9c5 100644
--- a/arch/sh/kernel/traps_32.c
+++ b/arch/sh/kernel/traps_32.c
@@ -664,6 +664,8 @@ asmlinkage void do_reserved_inst(unsigned long r4, unsigned long r5,
 	if (is_dsp_inst(regs)) {
 		/* Enable DSP mode, and restart instruction. */
 		regs->sr |= SR_DSP;
+		/* Save DSP mode */
+		tsk->thread.dsp_status.status |= SR_DSP;
 		return;
 	}
 #endif
