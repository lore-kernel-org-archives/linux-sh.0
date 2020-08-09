From: Al Viro <viro@zeniv.linux.org.uk>
Date: Sun, 09 Aug 2020 16:14:38 +0000
Subject: Re: "sh: convert to ->regset_get()" breaks linux-sh build
Message-Id: <20200809161438.GZ1236603@ZenIV.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <9c2d391c-6463-398e-95a1-8f238d739340@physik.fu-berlin.de>
In-Reply-To: <9c2d391c-6463-398e-95a1-8f238d739340@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

On Sun, Aug 09, 2020 at 03:39:50PM +0200, John Paul Adrian Glaubitz wrote:
> Hi Al!
> 
> I just tried building Linux next for SH to test it on my SH7785LCR board
> but the build is currently broken due to a regression introduced by your
> change to convert SH to ->regset_get():
> 
> make[1]: 'include/generated/machtypes.h' is up to date.
>   CALL    scripts/checksyscalls.sh
> <stdin>:1511:2: warning: #warning syscall clone3 not implemented [-Wcpp]
>   CALL    scripts/atomic/check-atomics.sh
>   CHK     include/generated/compile.h
>   CC      arch/sh/kernel/ptrace_32.o
> arch/sh/kernel/ptrace_32.c:168:5: error: conflicting types for ‘fpregs_get’
>   168 | int fpregs_get(struct task_struct *target,
>       |     ^~~~~~~~~~
> In file included from arch/sh/kernel/ptrace_32.c:31:
> ./arch/sh/include/asm/fpu.h:40:12: note: previous declaration of ‘fpregs_get’ was here
>    40 | extern int fpregs_get(struct task_struct *target,
>       |            ^~~~~~~~~~
> make[1]: *** [scripts/Makefile.build:283: arch/sh/kernel/ptrace_32.o] Error 1
> make: *** [Makefile:1789: arch/sh/kernel] Error 2

What the... oh, I see.

Commit in the regset followup series has fixed that, with bisect hazard unnoticed.
And since only the followups have not gone in, bisect hazard has turned into
a mainline breakage ;/

Sorry about that.  FWIW, the commit in question is this; all per-architecture
parts in it are mutually independent, but I'll probably just send this one
to Linus - no point splitting it up.

commit bb1a773d5b6bf018bf84fdb3fbba01d3ef54e2c9
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Fri May 22 20:02:02 2020 -0400

    kill unused dump_fpu() instances
    
    dump_fpu() is used only on the architectures that support elf
    and have neither CORE_DUMP_USE_REGSET nor ELF_CORE_COPY_FPREGS
    defined.
    
    Currently that's csky, m68k, microblaze, nds32 and unicore32.  The rest
    of the instances are dead code.
    
    NB: THIS MUST GO AFTER ELF_FDPIC CONVERSION
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index 8c8e5172fecd..4bfe721513ab 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -295,11 +295,6 @@ void flush_thread(void)
 {
 }
 
-int dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpu)
-{
-	return 0;
-}
-
 int elf_check_arch(const struct elf32_hdr *x)
 {
 	unsigned int eflags;
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 58eaa1f60e16..844099e934bd 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -282,21 +282,6 @@ int dump_task_regs(struct task_struct *t, elf_gregset_t *elfregs)
 	return 1;
 }
 
-/*
- * fill in the fpe structure for a core dump...
- */
-int dump_fpu (struct pt_regs *regs, struct user_fp *fp)
-{
-	struct thread_info *thread = current_thread_info();
-	int used_math = thread->used_cp[1] | thread->used_cp[2];
-
-	if (used_math)
-		memcpy(fp, &thread->fpstate.soft, sizeof (*fp));
-
-	return used_math != 0;
-}
-EXPORT_SYMBOL(dump_fpu);
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	struct stackframe frame;
diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index ac07f5f4b76b..05a8fe59d528 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -153,15 +153,6 @@ unsigned long get_wchan(struct task_struct *p)
 	return 0;
 }
 
-/*
- * Required placeholder.
- */
-int dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpu)
-{
-	return 0;
-}
-
-
 /*
  * Called on the exit path of event entry; see vm_entry.S
  *
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index 96dfb9e4b16f..e681a6d82260 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -514,52 +514,18 @@ do_copy_task_regs (struct task_struct *task, struct unw_frame_info *info, void *
 	unw_get_ar(info, UNW_AR_SSD, &dst[56]);
 }
 
-void
-do_dump_task_fpu (struct task_struct *task, struct unw_frame_info *info, void *arg)
-{
-	elf_fpreg_t *dst = arg;
-	int i;
-
-	memset(dst, 0, sizeof(elf_fpregset_t));	/* don't leak any "random" bits */
-
-	if (unw_unwind_to_user(info) < 0)
-		return;
-
-	/* f0 is 0.0, f1 is 1.0 */
-
-	for (i = 2; i < 32; ++i)
-		unw_get_fr(info, i, dst + i);
-
-	ia64_flush_fph(task);
-	if ((task->thread.flags & IA64_THREAD_FPH_VALID) != 0)
-		memcpy(dst + 32, task->thread.fph, 96*16);
-}
-
 void
 do_copy_regs (struct unw_frame_info *info, void *arg)
 {
 	do_copy_task_regs(current, info, arg);
 }
 
-void
-do_dump_fpu (struct unw_frame_info *info, void *arg)
-{
-	do_dump_task_fpu(current, info, arg);
-}
-
 void
 ia64_elf_core_copy_regs (struct pt_regs *pt, elf_gregset_t dst)
 {
 	unw_init_running(do_copy_regs, dst);
 }
 
-int
-dump_fpu (struct pt_regs *pt, elf_fpregset_t dst)
-{
-	unw_init_running(do_dump_fpu, dst);
-	return 1;	/* f0-f31 are always valid so we always return 1 */
-}
-
 /*
  * Flush thread state.  This is called when a thread does an execve().
  */
diff --git a/arch/nios2/kernel/process.c b/arch/nios2/kernel/process.c
index 509e7855e8dc..9392d55c7471 100644
--- a/arch/nios2/kernel/process.c
+++ b/arch/nios2/kernel/process.c
@@ -251,11 +251,3 @@ void start_thread(struct pt_regs *regs, unsigned long pc, unsigned long sp)
 	regs->ea = pc;
 	regs->sp = sp;
 }
-
-#include <linux/elfcore.h>
-
-/* Fill in the FPU structure for a core dump. */
-int dump_fpu(struct pt_regs *regs, elf_fpregset_t *r)
-{
-	return 0; /* Nios2 has no FPU and thus no FPU registers */
-}
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index d7010e72450c..3895d06a06af 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -214,13 +214,6 @@ void start_thread(struct pt_regs *regs, unsigned long pc, unsigned long sp)
 	regs->sp = sp;
 }
 
-/* Fill in the fpu structure for a core dump.  */
-int dump_fpu(struct pt_regs *regs, elf_fpregset_t * fpu)
-{
-	/* TODO */
-	return 0;
-}
-
 extern struct thread_info *_switch(struct thread_info *old_ti,
 				   struct thread_info *new_ti);
 extern int lwa_flag;
diff --git a/arch/parisc/include/asm/elf.h b/arch/parisc/include/asm/elf.h
index d00973aab7f1..651eacdb549b 100644
--- a/arch/parisc/include/asm/elf.h
+++ b/arch/parisc/include/asm/elf.h
@@ -305,9 +305,6 @@ typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
 
 struct task_struct;
 
-extern int dump_task_fpu (struct task_struct *, elf_fpregset_t *);
-#define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs) dump_task_fpu(tsk, elf_fpregs)
-
 struct pt_regs;	/* forward declaration... */
 
 
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index 230a6422b99f..680147969d4f 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -152,25 +152,6 @@ void release_thread(struct task_struct *dead_task)
 {
 }
 
-/*
- * Fill in the FPU structure for a core dump.
- */
-
-int dump_fpu (struct pt_regs * regs, elf_fpregset_t *r)
-{
-	if (regs = NULL)
-		return 0;
-
-	memcpy(r, regs->fr, sizeof *r);
-	return 1;
-}
-
-int dump_task_fpu (struct task_struct *tsk, elf_fpregset_t *r)
-{
-	memcpy(r, tsk->thread.regs.fr, sizeof(*r));
-	return 1;
-}
-
 /*
  * Idle thread support
  *
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index eb6e23ad15a2..21b573cfe8d9 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -160,24 +160,6 @@ asmlinkage void execve_tail(void)
 	asm volatile("sfpc %0" : : "d" (0));
 }
 
-/*
- * fill in the FPU structure for a core dump.
- */
-int dump_fpu (struct pt_regs * regs, s390_fp_regs *fpregs)
-{
-	save_fpu_regs();
-	fpregs->fpc = current->thread.fpu.fpc;
-	fpregs->pad = 0;
-	if (MACHINE_HAS_VX)
-		convert_vx_to_fp((freg_t *)&fpregs->fprs,
-				 current->thread.fpu.vxrs);
-	else
-		memcpy(&fpregs->fprs, current->thread.fpu.fprs,
-		       sizeof(fpregs->fprs));
-	return 1;
-}
-EXPORT_SYMBOL(dump_fpu);
-
 unsigned long get_wchan(struct task_struct *p)
 {
 	struct unwind_state state;
diff --git a/arch/sh/include/asm/fpu.h b/arch/sh/include/asm/fpu.h
index 43cfaf929aa7..04584be8986c 100644
--- a/arch/sh/include/asm/fpu.h
+++ b/arch/sh/include/asm/fpu.h
@@ -37,11 +37,6 @@ struct user_regset;
 extern int do_fpu_inst(unsigned short, struct pt_regs *);
 extern int init_fpu(struct task_struct *);
 
-extern int fpregs_get(struct task_struct *target,
-		      const struct user_regset *regset,
-		      unsigned int pos, unsigned int count,
-		      void *kbuf, void __user *ubuf);
-
 static inline void __unlazy_fpu(struct task_struct *tsk, struct pt_regs *regs)
 {
 	if (task_thread_info(tsk)->status & TS_USEDFPU) {
diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index 6ab397bc47ed..7a59a63560c5 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -93,24 +93,6 @@ void release_thread(struct task_struct *dead_task)
 	/* do nothing */
 }
 
-/* Fill in the fpu structure for a core dump.. */
-int dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpu)
-{
-	int fpvalid = 0;
-
-#if defined(CONFIG_SH_FPU)
-	struct task_struct *tsk = current;
-
-	fpvalid = !!tsk_used_math(tsk);
-	if (fpvalid)
-		fpvalid = !fpregs_get(tsk, NULL,
-				      (struct membuf){fpu, sizeof(*fpu)});
-#endif
-
-	return fpvalid;
-}
-EXPORT_SYMBOL(dump_fpu);
-
 asmlinkage void ret_from_fork(void);
 asmlinkage void ret_from_kernel_thread(void);
 
diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
index 5c93bdb6c41a..609b7c917e6e 100644
--- a/arch/sh/kernel/ptrace_32.c
+++ b/arch/sh/kernel/ptrace_32.c
@@ -165,7 +165,7 @@ static int genregs_set(struct task_struct *target,
 }
 
 #ifdef CONFIG_SH_FPU
-int fpregs_get(struct task_struct *target,
+static int fpregs_get(struct task_struct *target,
 	       const struct user_regset *regset,
 	       struct membuf to)
 {
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 13cb5638fab8..32b41693e648 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -408,55 +408,6 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 	return 0;
 }
 
-/*
- * fill in the fpu structure for a core dump.
- */
-int dump_fpu (struct pt_regs * regs, elf_fpregset_t * fpregs)
-{
-	if (used_math()) {
-		memset(fpregs, 0, sizeof(*fpregs));
-		fpregs->pr_q_entrysize = 8;
-		return 1;
-	}
-#ifdef CONFIG_SMP
-	if (test_thread_flag(TIF_USEDFPU)) {
-		put_psr(get_psr() | PSR_EF);
-		fpsave(&current->thread.float_regs[0], &current->thread.fsr,
-		       &current->thread.fpqueue[0], &current->thread.fpqdepth);
-		if (regs != NULL) {
-			regs->psr &= ~(PSR_EF);
-			clear_thread_flag(TIF_USEDFPU);
-		}
-	}
-#else
-	if (current = last_task_used_math) {
-		put_psr(get_psr() | PSR_EF);
-		fpsave(&current->thread.float_regs[0], &current->thread.fsr,
-		       &current->thread.fpqueue[0], &current->thread.fpqdepth);
-		if (regs != NULL) {
-			regs->psr &= ~(PSR_EF);
-			last_task_used_math = NULL;
-		}
-	}
-#endif
-	memcpy(&fpregs->pr_fr.pr_regs[0],
-	       &current->thread.float_regs[0],
-	       (sizeof(unsigned long) * 32));
-	fpregs->pr_fsr = current->thread.fsr;
-	fpregs->pr_qcnt = current->thread.fpqdepth;
-	fpregs->pr_q_entrysize = 8;
-	fpregs->pr_en = 1;
-	if(fpregs->pr_qcnt != 0) {
-		memcpy(&fpregs->pr_q[0],
-		       &current->thread.fpqueue[0],
-		       sizeof(struct fpq) * fpregs->pr_qcnt);
-	}
-	/* Zero out the rest. */
-	memset(&fpregs->pr_q[fpregs->pr_qcnt], 0,
-	       sizeof(struct fpq) * (32 - fpregs->pr_qcnt));
-	return 1;
-}
-
 unsigned long get_wchan(struct task_struct *task)
 {
 	unsigned long pc, fp, bias = 0;
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index 54945eacd3b5..c31b2ac70e3c 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -700,72 +700,6 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	return 0;
 }
 
-typedef struct {
-	union {
-		unsigned int	pr_regs[32];
-		unsigned long	pr_dregs[16];
-	} pr_fr;
-	unsigned int __unused;
-	unsigned int	pr_fsr;
-	unsigned char	pr_qcnt;
-	unsigned char	pr_q_entrysize;
-	unsigned char	pr_en;
-	unsigned int	pr_q[64];
-} elf_fpregset_t32;
-
-/*
- * fill in the fpu structure for a core dump.
- */
-int dump_fpu (struct pt_regs * regs, elf_fpregset_t * fpregs)
-{
-	unsigned long *kfpregs = current_thread_info()->fpregs;
-	unsigned long fprs = current_thread_info()->fpsaved[0];
-
-	if (test_thread_flag(TIF_32BIT)) {
-		elf_fpregset_t32 *fpregs32 = (elf_fpregset_t32 *)fpregs;
-
-		if (fprs & FPRS_DL)
-			memcpy(&fpregs32->pr_fr.pr_regs[0], kfpregs,
-			       sizeof(unsigned int) * 32);
-		else
-			memset(&fpregs32->pr_fr.pr_regs[0], 0,
-			       sizeof(unsigned int) * 32);
-		fpregs32->pr_qcnt = 0;
-		fpregs32->pr_q_entrysize = 8;
-		memset(&fpregs32->pr_q[0], 0,
-		       (sizeof(unsigned int) * 64));
-		if (fprs & FPRS_FEF) {
-			fpregs32->pr_fsr = (unsigned int) current_thread_info()->xfsr[0];
-			fpregs32->pr_en = 1;
-		} else {
-			fpregs32->pr_fsr = 0;
-			fpregs32->pr_en = 0;
-		}
-	} else {
-		if(fprs & FPRS_DL)
-			memcpy(&fpregs->pr_regs[0], kfpregs,
-			       sizeof(unsigned int) * 32);
-		else
-			memset(&fpregs->pr_regs[0], 0,
-			       sizeof(unsigned int) * 32);
-		if(fprs & FPRS_DU)
-			memcpy(&fpregs->pr_regs[16], kfpregs+16,
-			       sizeof(unsigned int) * 32);
-		else
-			memset(&fpregs->pr_regs[16], 0,
-			       sizeof(unsigned int) * 32);
-		if(fprs & FPRS_FEF) {
-			fpregs->pr_fsr = current_thread_info()->xfsr[0];
-			fpregs->pr_gsr = current_thread_info()->gsr[0];
-		} else {
-			fpregs->pr_fsr = fpregs->pr_gsr = 0;
-		}
-		fpregs->pr_fprs = fprs;
-	}
-	return 1;
-}
-EXPORT_SYMBOL(dump_fpu);
-
 unsigned long get_wchan(struct task_struct *task)
 {
 	unsigned long pc, fp, bias = 0;
