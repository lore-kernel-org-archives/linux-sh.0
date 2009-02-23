From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 23 Feb 2009 07:14:02 +0000
Subject: [PATCH 01/04] sh: shared register saving code for sh3/sh4/sh4a
Message-Id: <20090223071402.12289.80040.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch reworks the sh3/sh4/sh4a register saving code in
the following ways:
 - break out prepare_stack_save_dsp() from handle_exception()
 - break out save_regs() from handle_exception()
 - the register saving order is unchanged
 - align new functions to fit in cache lines
 - separate exception code from interrupt code
 - keep main code flow in a single cache line per exception vector
 - use bsr/rts for regular functions (save pr first)
 - keep data in one shared cache line (exception_data)
 - document the functions
 - tie in the hp6xx code

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Let me know if you prefer to split this change into smaller pieces.

 arch/sh/boards/mach-hp6xx/pm_wakeup.S |   31 ---
 arch/sh/kernel/cpu/sh3/entry.S        |  273 +++++++++++++++++----------------
 2 files changed, 155 insertions(+), 149 deletions(-)

--- 0001/arch/sh/boards/mach-hp6xx/pm_wakeup.S
+++ work/arch/sh/boards/mach-hp6xx/pm_wakeup.S	2009-02-23 12:26:12.000000000 +0900
@@ -10,47 +10,32 @@
 #include <linux/linkage.h>
 #include <cpu/mmu_context.h>
 
-#define k0	r0
-#define k1	r1
-#define k2	r2
-#define k3	r3
-#define k4	r4
-
 /*
  * Kernel mode register usage:
  *	k0	scratch
  *	k1	scratch
- *	k2	scratch (Exception code)
- *	k3	scratch (Return address)
- *	k4	scratch
- *	k5	reserved
- *	k6	Global Interrupt Mask (0--15 << 4)
- *	k7	CURRENT_THREAD_INFO (pointer to current thread info)
+ * For more details, please have a look at entry.S
  */
 
+#define k0	r0
+#define k1	r1
+
 ENTRY(wakeup_start)
 ! clear STBY bit
-	mov	#-126, k2
+	mov	#-126, k1
    	and	#127, k0
-	mov.b	k0, @k2
+	mov.b	k0, @k1
 ! enable refresh
 	mov.l	5f, k1
 	mov.w	6f, k0
   	mov.w	k0, @k1
 ! jump to handler
-	mov.l	2f, k2
-	mov.l	3f, k3
-	mov.l	@k2, k2
-
 	mov.l	4f, k1
 	jmp	@k1
-	nop
+	 nop
 
 	.align	2
-1:	.long	EXPEVT
-2:	.long	INTEVT
-3:	.long	ret_from_irq
-4:	.long	handle_exception
+4:	.long	handle_interrupt
 5:	.long	0xffffff68
 6:	.word	0x0524
 
--- 0001/arch/sh/kernel/cpu/sh3/entry.S
+++ work/arch/sh/kernel/cpu/sh3/entry.S	2009-02-23 12:33:22.000000000 +0900
@@ -16,6 +16,7 @@
 #include <asm/unistd.h>
 #include <cpu/mmu_context.h>
 #include <asm/page.h>
+#include <asm/cache.h>
 
 ! NOTE:
 ! GNU as (as of 2.9.1) changes bf/s into bt/s and bra, when the address
@@ -294,7 +295,7 @@ skip_restore:
 	mov	#0xf0, k1
 	extu.b	k1, k1
 	not	k1, k1
-	and	k1, k2			! Mask orignal SR value
+	and	k1, k2			! Mask original SR value
 	!
 	mov	k3, k0			! Calculate IMASK-bits
 	shlr2	k0
@@ -336,81 +337,53 @@ skip_restore:
 ENTRY(vbr_base)
 	.long	0
 !
+! 0x100: General exception vector
+!
 	.balign 	256,0,256
 general_exception:
-	mov.l	1f, k2
-	mov.l	2f, k3
-#ifdef CONFIG_CPU_SUBTYPE_SHX3
-	mov.l	@k2, k2
+#ifndef CONFIG_CPU_SUBTYPE_SHX3
+	bra	handle_exception
+	 sts	pr, k3		! save original pr value in k3
+#else
+	mov.l	1f, k4
+	mov.l	@k4, k4
 
 	! Is EXPEVT larger than 0x800?
 	mov	#0x8, k0
 	shll8	k0
-	cmp/hs	k0, k2
+	cmp/hs	k0, k4
 	bf	0f
 
 	! then add 0x580 (k2 is 0xd80 or 0xda0)
 	mov	#0x58, k0
 	shll2	k0
 	shll2	k0
-	add	k0, k2
+	add	k0, k4
 0:
-	bra	handle_exception
+	! Setup stack and save DSP context (k0 contains original r15 on return)
+	bsr	prepare_stack_save_dsp
 	 nop
-#else
-	bra	handle_exception
-	 mov.l	@k2, k2
-#endif
-	.align	2
-1:	.long	EXPEVT
-2:	.long	ret_from_exception
-!
-!
 
-	.balign 	1024,0,1024
-tlb_miss:
-	mov.l	1f, k2
-	mov.l	4f, k3
-	bra	handle_exception
-	 mov.l	@k2, k2
-!
-	.balign 	512,0,512
-interrupt:
-	mov.l	3f, k3
-#if defined(CONFIG_KGDB)
-	mov.l	2f, k2
-	! Debounce (filter nested NMI)
-	mov.l	@k2, k0
-	mov.l	5f, k1
-	cmp/eq	k1, k0
-	bf	0f
-	mov.l	6f, k1
-	tas.b	@k1
-	bt	0f
-	rte
+	! Save registers / Switch to bank 0
+	bsr	save_regs	! needs original pr value in k3
+	 mov.l	k4, k2		! keep vector in k2
+
+	bra	handle_exception_special
 	 nop
-	.align	2
-2:	.long	INTEVT
-5:	.long	NMI_VEC
-6:	.long	in_nmi
-0:
-#endif /* defined(CONFIG_KGDB) */
-	bra	handle_exception
-	 mov	#-1, k2		! interrupt exception marker
 
 	.align	2
 1:	.long	EXPEVT
-3:	.long	ret_from_irq
-4:	.long	ret_from_exception
+#endif
 
-!
-!
-	.align	2
-ENTRY(handle_exception)
-	! Using k0, k1 for scratch registers (r0_bank1, r1_bank),
-	! save all registers onto stack.
-	!
+! prepare_stack_save_dsp()
+! - roll back gRB
+! - switch to kernel stack
+! - save DSP
+! k0 returns original sp (after roll back)
+! k1 trashed
+! k2 trashed
 
+prepare_stack_save_dsp:
 #ifdef CONFIG_GUSA
 	! Check for roll back gRB (User and Kernel)
 	mov	r15, k0
@@ -430,7 +403,7 @@ ENTRY(handle_exception)
 2:	mov	k1, r15		! SP = r1
 1:
 #endif
-
+	! Switch to kernel stack if needed
 	stc	ssr, k0		! Is it from kernel space?
 	shll	k0		! Check MD bit (bit30) by shifting it into...
 	shll	k0		!       ...the T bit
@@ -443,18 +416,17 @@ ENTRY(handle_exception)
 	add	current, k1
 	mov	k1, r15		! change to kernel stack
 	!
-1:	mov.l	2f, k1
-	!
+1:
 #ifdef CONFIG_SH_DSP
-	mov.l	r2, @-r15		! Save r2, we need another reg
-	stc	sr, k4
-	mov.l	1f, r2
-	tst	r2, k4			! Check if in DSP mode
-	mov.l	@r15+, r2		! Restore r2 now
+	! Save DSP context if needed
+	stc	sr, k1
+	mov	#0x10, k2
+	shll8   k2			! DSP=1 (0x00001000)
+	tst	k2, k1			! Check if in DSP mode (passed in k2)
 	bt/s	skip_save
-	 mov	#0, k4			! Set marker for no stack frame
+	 mov	#0, k1			! Set marker for no stack frame
 
-	mov	r2, k4			! Backup r2 (in k4) for later
+	mov	k2, k1			! Save has-frame marker
 
 	! Save DSP registers on stack
 	stc.l	mod, @-r15
@@ -473,35 +445,73 @@ ENTRY(handle_exception)
 	! as we're not at all interested in supporting ancient toolchains at
 	! this point. -- PFM.
 
-	mov	r15, r2
+	mov	r15, k2
 	.word	0xf653			! movs.l	a1, @-r2
 	.word	0xf6f3			! movs.l	a0g, @-r2
 	.word	0xf6d3			! movs.l	a1g, @-r2
 	.word	0xf6c3			! movs.l	m0, @-r2
 	.word	0xf6e3			! movs.l	m1, @-r2
-	mov	r2, r15
+	mov	k2, r15
 
-	mov	k4, r2			! Restore r2
-	mov.l	1f, k4			! Force DSP stack frame
 skip_save:
-	mov.l	k4, @-r15		! Push DSP mode marker onto stack
+	mov.l	k1, @-r15		! Push DSP mode marker onto stack
 #endif
-	! Save the user registers on the stack.
-	mov.l	k2, @-r15	! EXPEVT
+	rts
+	 nop
+!
+! 0x400: Instruction and Data TLB miss exception vector
+!
+	.balign 	1024,0,1024
+tlb_miss:
+	sts	pr, k3		! save original pr value in k3
 
-	mov	#-1, k4
-	mov.l	k4, @-r15	! set TRA (default: -1)
-	!
+handle_exception:
+	! Setup stack and save DSP context (k0 contains original r15 on return)
+	bsr	prepare_stack_save_dsp
+	 nop
+
+	! Save registers / Switch to bank 0
+	mov.l	5f, k2		! vector register address
+	bsr	save_regs	! needs original pr value in k3
+	 mov.l	@k2, k2		! read out vector and keep in k2
+
+handle_exception_special:
+	! Setup return address and jump to exception handler
+	mov.l	7f, r9		! fetch return address
+	stc	r2_bank, r0	! k2 (vector)
+	mov.l	6f, r10
+	shlr2	r0
+	shlr	r0
+	mov.l	@(r0, r10), r10
+	jmp	@r10
+	 lds	r9, pr		! put return address in pr
+
+	.align	L1_CACHE_SHIFT
+
+! save_regs()
+! - save vector, default tra, macl, mach, gbr, ssr, pr* and spc on the stack
+! - save r15*, r14, r13, r12, r11, r10, r9, r8 on the stack
+! - switch bank
+! - save r7, r6, r5, r4, r3, r2, r1, r0 on the stack
+! k0 contains original stack pointer*
+! k1 trashed
+! k2 passes vector (EXPEVT)
+! k3 passes original pr*
+! k4 trashed
+! BL=1 on entry, on exit BL=0.
+
+save_regs:
+	mov	#-1, r1
+	mov.l	k2, @-r15	! vector in k2
+	mov.l	k1, @-r15	! set TRA (default: -1)
 	sts.l	macl, @-r15
 	sts.l	mach, @-r15
 	stc.l	gbr, @-r15
 	stc.l	ssr, @-r15
-	sts.l	pr, @-r15
+	mov.l	k3, @-r15	! original pr in k3
 	stc.l	spc, @-r15
-	!
-	lds	k3, pr		! Set the return address to pr
-	!
-	mov.l	k0, @-r15	! save orignal stack
+
+	mov.l	k0, @-r15	! original stack pointer in k0
 	mov.l	r14, @-r15
 	mov.l	r13, @-r15
 	mov.l	r12, @-r15
@@ -509,13 +519,15 @@ skip_save:
 	mov.l	r10, @-r15
 	mov.l	r9, @-r15
 	mov.l	r8, @-r15
-	!
-	stc	sr, r8		! Back to normal register bank, and
-	or	k1, r8		! Block all interrupts
-	mov.l	3f, k1
-	and	k1, r8		! ...
-	ldc	r8, sr		! ...changed here.
-	!
+
+	mov.l	0f, k3		! SR bits to set in k3
+	mov.l	1f, k4		! SR bits to clear in k4
+
+	stc	sr, r8
+	or	k3, r8
+	and	k4, r8
+	ldc	r8, sr
+
 	mov.l	r7, @-r15
 	mov.l	r6, @-r15
 	mov.l	r5, @-r15
@@ -523,52 +535,61 @@ skip_save:
 	mov.l	r3, @-r15
 	mov.l	r2, @-r15
 	mov.l	r1, @-r15
-	mov.l	r0, @-r15
-
-	/*
-	 * This gets a bit tricky.. in the INTEVT case we don't want to use
-	 * the VBR offset as a destination in the jump call table, since all
-	 * of the destinations are the same. In this case, (interrupt) sets
-	 * a marker in r2 (now r2_bank since SR.RB changed), which we check
-	 * to determine the exception type. For all other exceptions, we
-	 * forcibly read EXPEVT from memory and fix up the jump address, in
-	 * the interrupt exception case we jump to do_IRQ() and defer the
-	 * INTEVT read until there. As a bonus, we can also clean up the SR.RB
-	 * checks that do_IRQ() was doing..
-	 */
-	stc	r2_bank, r8
-	cmp/pz	r8
-	bf	interrupt_exception
-	shlr2	r8
-	shlr	r8
-	mov.l	4f, r9
-	add	r8, r9
-	mov.l	@r9, r9
-	jmp	@r9
-	 nop
 	rts
-	 nop
+	 mov.l	r0, @-r15
 
+!
+! 0x600: Interrupt / NMI vector
+!
+	.balign 	512,0,512
+ENTRY(handle_interrupt)
+#if defined(CONFIG_KGDB)
+	mov.l	2f, k2
+	! Debounce (filter nested NMI)
+	mov.l	@k2, k0
+	mov.l	9f, k1
+	cmp/eq	k1, k0
+	bf	11f
+	mov.l	10f, k1
+	tas.b	@k1
+	bt	11f
+	rte
+	 nop
 	.align	2
-1:	.long	0x00001000	! DSP=1
-2:	.long	0x000080f0	! FD=1, IMASK
-3:	.long	0xcfffffff	! RB=0, BL=0
-4:	.long	exception_handling_table
+9:	.long	NMI_VEC
+10:	.long	in_nmi
+11:
+#endif /* defined(CONFIG_KGDB) */
+	sts	pr, k3		! save original pr value in k3
 
-interrupt_exception:
-	mov.l	1f, r9
-	mov.l	2f, r4
-	mov.l	@r4, r4
-	jmp	@r9
-	 mov	r15, r5
-	rts
+	! Setup stack and save DSP context (k0 contains original r15 on return)
+	bsr	prepare_stack_save_dsp
 	 nop
 
-	.align 2
-1:	.long	do_IRQ
-2:	.long	INTEVT
+	! Save registers / Switch to bank 0
+	bsr	save_regs	! needs original pr value in k3
+	 mov	#-1, k2		! default vector kept in k2
+
+	! Setup return address and jump to do_IRQ
+	mov.l	4f, r9		! fetch return address
+	lds	r9, pr		! put return address in pr
+	mov.l	2f, r4
+	mov.l	3f, r9
+	mov.l	@r4, r4		! pass INTEVT vector as arg0
+	jmp	@r9
+	 mov	r15, r5		! pass saved registers as arg1
 
-	.align	2
 ENTRY(exception_none)
 	rts
 	 nop
+
+	.align	L1_CACHE_SHIFT
+exception_data:
+0:	.long	0x000080f0	! FD=1, IMASK
+1:	.long	0xcfffffff	! RB=0, BL=0
+2:	.long	INTEVT
+3:	.long	do_IRQ
+4:	.long	ret_from_irq
+5:	.long	EXPEVT
+6:	.long	exception_handling_table
+7:	.long	ret_from_exception
