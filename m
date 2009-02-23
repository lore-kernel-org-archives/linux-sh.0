From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 23 Feb 2009 07:16:34 +0000
Subject: [PATCH 03/04] sh: remove EXPEVT vector from stack on sh3/sh4/sh4a
Message-Id: <20090223071634.12295.18307.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Remove EXPEVT vector from the stack, lookup_exception_vector()
for sh3/sh4/sh4a is already using k2 to get the vector.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/include/asm/ptrace.h   |    8 +++-----
 arch/sh/kernel/cpu/sh3/entry.S |    5 +----
 2 files changed, 4 insertions(+), 9 deletions(-)

--- 0001/arch/sh/include/asm/ptrace.h
+++ work/arch/sh/include/asm/ptrace.h	2009-02-23 13:50:20.000000000 +0900
@@ -122,14 +122,12 @@ extern void user_disable_single_step(str
 #ifdef CONFIG_SH_DSP
 #define task_pt_regs(task) \
 	((struct pt_regs *) (task_stack_page(task) + THREAD_SIZE \
-		 - sizeof(struct pt_dspregs) - sizeof(unsigned long)) - 1)
+		 - sizeof(struct pt_dspregs)) - 1)
 #define task_pt_dspregs(task) \
-	((struct pt_dspregs *) (task_stack_page(task) + THREAD_SIZE \
-		 - sizeof(unsigned long)) - 1)
+	((struct pt_dspregs *) (task_stack_page(task) + THREAD_SIZE) - 1)
 #else
 #define task_pt_regs(task) \
-	((struct pt_regs *) (task_stack_page(task) + THREAD_SIZE \
-		 - sizeof(unsigned long)) - 1)
+	((struct pt_regs *) (task_stack_page(task) + THREAD_SIZE) - 1)
 #endif
 
 static inline unsigned long profile_pc(struct pt_regs *regs)
--- 0006/arch/sh/kernel/cpu/sh3/entry.S
+++ work/arch/sh/kernel/cpu/sh3/entry.S	2009-02-23 13:50:58.000000000 +0900
@@ -312,7 +312,6 @@ skip_restore:
 	mov	#0, k1
 	mov.b	k1, @k0
 #endif
-	mov.l	@r15+, k2		! restore EXPEVT
 	mov	k4, r15
 	rte
 	 nop
@@ -487,20 +486,18 @@ handle_exception_special:
 	.align	L1_CACHE_SHIFT
 
 ! save_regs()
-! - save vector, default tra, macl, mach, gbr, ssr, pr* and spc on the stack
+! - save default tra, macl, mach, gbr, ssr, pr* and spc on the stack
 ! - save r15*, r14, r13, r12, r11, r10, r9, r8 on the stack
 ! - switch bank
 ! - save r7, r6, r5, r4, r3, r2, r1, r0 on the stack
 ! k0 contains original stack pointer*
 ! k1 trashed
-! k2 passes vector (EXPEVT)
 ! k3 passes original pr*
 ! k4 trashed
 ! BL=1 on entry, on exit BL=0.
 
 save_regs:
 	mov	#-1, r1
-	mov.l	k2, @-r15	! vector in k2
 	mov.l	k1, @-r15	! set TRA (default: -1)
 	sts.l	macl, @-r15
 	sts.l	mach, @-r15
