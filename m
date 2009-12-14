From: Matt Fleming <matt@console-pimps.org>
Date: Mon, 14 Dec 2009 20:12:04 +0000
Subject: [PATCH] sh: Fix up FPU build for SH5
Message-Id: <1260821524-32579-1-git-send-email-matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

After the recent FPU optimisation commit the signature of save_fpu()
changed. "regs" wasn't used in the implementation of save_fpu() anyway.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/kernel/cpu/sh5/fpu.c |    4 ++--
 arch/sh/kernel/process_64.c  |    4 ++--
 arch/sh/kernel/ptrace_64.c   |    4 ++--
 arch/sh/kernel/signal_64.c   |    2 +-
 arch/sh/kernel/traps_64.c    |    4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh5/fpu.c b/arch/sh/kernel/cpu/sh5/fpu.c
index dd4f51f..4648cce 100644
--- a/arch/sh/kernel/cpu/sh5/fpu.c
+++ b/arch/sh/kernel/cpu/sh5/fpu.c
@@ -34,7 +34,7 @@ static union sh_fpu_union init_fpuregs = {
 	}
 };
 
-void save_fpu(struct task_struct *tsk, struct pt_regs *regs)
+void save_fpu(struct task_struct *tsk)
 {
 	asm volatile("fst.p     %0, (0*8), fp0\n\t"
 		     "fst.p     %0, (1*8), fp2\n\t"
@@ -153,7 +153,7 @@ do_fpu_state_restore(unsigned long ex, struct pt_regs *regs)
 	enable_fpu();
 	if (last_task_used_math != NULL)
 		/* Other processes fpu state, save away */
-		save_fpu(last_task_used_math, regs);
+		save_fpu(last_task_used_math);
 
         last_task_used_math = current;
         if (used_math()) {
diff --git a/arch/sh/kernel/process_64.c b/arch/sh/kernel/process_64.c
index 359b8a2..31f80c6 100644
--- a/arch/sh/kernel/process_64.c
+++ b/arch/sh/kernel/process_64.c
@@ -404,7 +404,7 @@ int dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpu)
 	if (fpvalid) {
 		if (current = last_task_used_math) {
 			enable_fpu();
-			save_fpu(tsk, regs);
+			save_fpu(tsk);
 			disable_fpu();
 			last_task_used_math = 0;
 			regs->sr |= SR_FD;
@@ -431,7 +431,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 #ifdef CONFIG_SH_FPU
 	if(last_task_used_math = current) {
 		enable_fpu();
-		save_fpu(current, regs);
+		save_fpu(current);
 		disable_fpu();
 		last_task_used_math = NULL;
 		regs->sr |= SR_FD;
diff --git a/arch/sh/kernel/ptrace_64.c b/arch/sh/kernel/ptrace_64.c
index 952da83..873ebdc 100644
--- a/arch/sh/kernel/ptrace_64.c
+++ b/arch/sh/kernel/ptrace_64.c
@@ -82,7 +82,7 @@ get_fpu_long(struct task_struct *task, unsigned long addr)
 
 	if (last_task_used_math = task) {
 		enable_fpu();
-		save_fpu(task, regs);
+		save_fpu(task);
 		disable_fpu();
 		last_task_used_math = 0;
 		regs->sr |= SR_FD;
@@ -118,7 +118,7 @@ put_fpu_long(struct task_struct *task, unsigned long addr, unsigned long data)
 		set_stopped_child_used_math(task);
 	} else if (last_task_used_math = task) {
 		enable_fpu();
-		save_fpu(task, regs);
+		save_fpu(task);
 		disable_fpu();
 		last_task_used_math = 0;
 		regs->sr |= SR_FD;
diff --git a/arch/sh/kernel/signal_64.c b/arch/sh/kernel/signal_64.c
index feb3ddd..ce76dbd 100644
--- a/arch/sh/kernel/signal_64.c
+++ b/arch/sh/kernel/signal_64.c
@@ -314,7 +314,7 @@ setup_sigcontext_fpu(struct pt_regs *regs, struct sigcontext __user *sc)
 
 	if (current = last_task_used_math) {
 		enable_fpu();
-		save_fpu(current, regs);
+		save_fpu(current);
 		disable_fpu();
 		last_task_used_math = NULL;
 		regs->sr |= SR_FD;
diff --git a/arch/sh/kernel/traps_64.c b/arch/sh/kernel/traps_64.c
index 75c0cbe..d86f531 100644
--- a/arch/sh/kernel/traps_64.c
+++ b/arch/sh/kernel/traps_64.c
@@ -600,7 +600,7 @@ static int misaligned_fpu_load(struct pt_regs *regs,
 		   indexed by register number. */
 		if (last_task_used_math = current) {
 			enable_fpu();
-			save_fpu(current, regs);
+			save_fpu(current);
 			disable_fpu();
 			last_task_used_math = NULL;
 			regs->sr |= SR_FD;
@@ -673,7 +673,7 @@ static int misaligned_fpu_store(struct pt_regs *regs,
 		   indexed by register number. */
 		if (last_task_used_math = current) {
 			enable_fpu();
-			save_fpu(current, regs);
+			save_fpu(current);
 			disable_fpu();
 			last_task_used_math = NULL;
 			regs->sr |= SR_FD;
-- 
1.6.2.5

