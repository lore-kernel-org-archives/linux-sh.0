From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 06 Mar 2009 06:41:56 +0000
Subject: [PATCH] sh: hibernation support
Message-Id: <20090306064156.27281.35572.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add Suspend-to-disk / swsusp / CONFIG_HIBERNATION support
to the SuperH architecture.

To suspend, use "swapon /dev/sda2; echo disk > /sys/power/state"
To resume, pass "resume=/dev/sda2" on the kernel command line.

The patch "pm: rework includes, remove arch ifdefs V2" is
needed to allow the generic swsusp code to build properly.

Hibernation is not enabled with this patch though, a patch
setting ARCH_HIBERNATION_POSSIBLE will be submitted later.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Tested on a sh7785lcr board.

 arch/sh/include/asm/suspend.h  |   14 +++
 arch/sh/kernel/Makefile_32     |    1 
 arch/sh/kernel/asm-offsets.c   |    8 ++
 arch/sh/kernel/cpu/sh3/entry.S |  144 +++++++++++++++++++++++++++++++++++++++-
 arch/sh/kernel/pm.c            |   39 ++++++++++
 5 files changed, 203 insertions(+), 3 deletions(-)

--- /dev/null
+++ work/arch/sh/include/asm/suspend.h	2009-03-02 15:23:59.000000000 +0900
@@ -0,0 +1,14 @@
+#ifndef _ASM_SH_SUSPEND_H
+#define _ASM_SH_SUSPEND_H
+
+static inline int arch_prepare_suspend(void) { return 0; }
+extern const void __nosave_begin, __nosave_end;
+
+#include <asm/ptrace.h>
+
+struct swsusp_arch_regs {
+	struct pt_regs user_regs;
+	unsigned long bank1_regs[8];
+};
+
+#endif /* _ASM_SH_SUSPEND_H */
--- 0001/arch/sh/kernel/Makefile_32
+++ work/arch/sh/kernel/Makefile_32	2009-03-02 15:23:59.000000000 +0900
@@ -30,5 +30,6 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_GENERIC_GPIO)	+= gpio.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
 obj-$(CONFIG_DUMP_CODE)		+= disassemble.o
+obj-$(CONFIG_PM)		+= pm.o
 
 EXTRA_CFLAGS += -Werror
--- 0001/arch/sh/kernel/asm-offsets.c
+++ work/arch/sh/kernel/asm-offsets.c	2009-03-02 15:23:59.000000000 +0900
@@ -12,8 +12,10 @@
 #include <linux/types.h>
 #include <linux/mm.h>
 #include <linux/kbuild.h>
+#include <linux/suspend.h>
 
 #include <asm/thread_info.h>
+#include <asm/suspend.h>
 
 int main(void)
 {
@@ -25,5 +27,11 @@ int main(void)
 	DEFINE(TI_PRE_COUNT,	offsetof(struct thread_info, preempt_count));
 	DEFINE(TI_RESTART_BLOCK,offsetof(struct thread_info, restart_block));
 
+#ifdef CONFIG_HIBERNATION
+	DEFINE(pbe_address, offsetof(struct pbe, address));
+	DEFINE(pbe_orig_address, offsetof(struct pbe, orig_address));
+	DEFINE(pbe_next, offsetof(struct pbe, next));
+	DEFINE(SWSUSP_ARCH_REGS_SIZE, sizeof(struct swsusp_arch_regs));
+#endif
 	return 0;
 }
--- 0001/arch/sh/kernel/cpu/sh3/entry.S
+++ work/arch/sh/kernel/cpu/sh3/entry.S	2009-03-02 15:26:57.000000000 +0900
@@ -323,6 +323,76 @@ skip_restore:
 #endif
 7:	.long	0x30000000
 
+#ifdef CONFIG_HIBERNATION
+! swsusp_arch_resume()
+! - copy restore_pblist pages
+! - restore registers from swsusp_arch_regs_cpu0
+
+ENTRY(swsusp_arch_resume)
+	mov.l	4f, r15
+	mov.l	1f, r4
+	mov.l	@r4, r4
+
+copy_loop:
+	mov	r4, r0
+	cmp/eq	#0, r0
+	bt	do_restore_regs
+
+	mov.l	@(pbe_address, r4), r2
+	mov.l	@(pbe_orig_address, r4), r5
+
+	mov.l	2f, r3
+	shlr2	r3
+	shlr2	r3
+copy_page:
+	dt	r3
+	mov.l	@r2+,r1   /*  16n+0 */
+	mov.l	r1,@r5
+	add	#4,r5
+	mov.l	@r2+,r1	  /*  16n+4 */
+	mov.l	r1,@r5
+	add	#4,r5
+	mov.l	@r2+,r1   /*  16n+8 */
+	mov.l	r1,@r5
+	add	#4,r5
+	mov.l	@r2+,r1   /*  16n+12 */
+	mov.l	r1,@r5
+	bf/s	copy_page
+	 add	#4,r5
+
+	bra	copy_loop
+	 mov.l	@(pbe_next, r4), r4
+
+do_restore_regs:
+	! BL=0: R7->R0 is bank0
+	mov.l	3f, r8
+	bsr	restore_regs
+	 nop
+
+	! BL=1: R7->R0 is bank1
+	lds	k2, pr
+	ldc	k3, ssr
+
+	mov.l	@r15+, r0
+	mov.l	@r15+, r1
+	mov.l	@r15+, r2
+	mov.l	@r15+, r3
+	mov.l	@r15+, r4
+	mov.l	@r15+, r5
+	mov.l	@r15+, r6
+	mov.l	@r15+, r7
+
+	rte
+	 nop
+	! BL=0: R7->R0 is bank0
+
+	.align	2
+1:	.long	restore_pblist
+2:	.long	PAGE_SIZE
+3:	.long	0x20000000 ! RB=1
+4:	.long	swsusp_arch_regs_cpu0
+#endif /* CONFIG_HIBERNATION */
+
 ! common exception handler
 #include "../../entry-common.S"
 	
@@ -362,8 +432,10 @@ general_exception:
 	 nop
 
 	! Save registers / Switch to bank 0
+	mov.l	k4, k2		! keep vector in k2
+	mov.l	1f, k4		! SR bits to clear in k4
 	bsr	save_regs	! needs original pr value in k3
-	 mov	k4, k2		! keep vector in k2
+	 nop
 
 	bra	handle_exception_special
 	 nop
@@ -471,6 +543,7 @@ handle_exception:
 
 	! Save registers / Switch to bank 0
 	mov.l	5f, k2		! vector register address
+	mov.l	1f, k4		! SR bits to clear in k4
 	bsr	save_regs	! needs original pr value in k3
 	 mov.l	@k2, k2		! read out vector and keep in k2
 
@@ -495,7 +568,7 @@ handle_exception_special:
 ! k0 contains original stack pointer*
 ! k1 trashed
 ! k3 passes original pr*
-! k4 trashed
+! k4 passes SR bitmask
 ! BL=1 on entry, on exit BL=0.
 
 save_regs:
@@ -518,8 +591,16 @@ save_regs:
 	mov.l	r8, @-r15
 
 	mov.l	0f, k3		! SR bits to set in k3
-	mov.l	1f, k4		! SR bits to clear in k4
 
+	! fall-through
+
+! save_low_regs()
+! - modify SR for bank switch
+! - save r7, r6, r5, r4, r3, r2, r1, r0 on the stack
+! k3 passes bits to set in SR
+! k4 passes bits to clear in SR
+
+save_low_regs:
 	stc	sr, r8
 	or	k3, r8
 	and	k4, r8
@@ -565,6 +646,7 @@ ENTRY(handle_interrupt)
 	 PREF(k0)
 
 	! Save registers / Switch to bank 0
+	mov.l	1f, k4		! SR bits to clear in k4
 	bsr	save_regs	! needs original pr value in k3
 	 mov	#-1, k2		! default vector kept in k2
 
@@ -591,3 +673,59 @@ exception_data:
 5:	.long	EXPEVT
 6:	.long	exception_handling_table
 7:	.long	ret_from_exception
+
+#ifdef CONFIG_HIBERNATION
+! swsusp_arch_suspend()
+! - prepare pc for resume, return from function without swsusp_save on resume
+! - save registers in swsusp_arch_regs_cpu0
+! - call swsusp_save write suspend image
+
+ENTRY(swsusp_arch_suspend)
+	sts	pr, r0		! save pr in r0
+	mov	r15, r2		! save sp in r2
+	mov	r8, r5		! save r8 in r5
+	stc	sr, r1
+	ldc	r1, ssr		! save sr in ssr
+	mov.l	1f, r1
+	ldc	r1, spc		! setup pc value for resuming
+	mov.l	5f, r15		! use swsusp_arch_regs_cpu0 as stack
+	mov.l	6f, r3
+	add	r3, r15		! save from top of structure
+
+	! BL=0: R7->R0 is bank0
+	mov.l	2f, r3		! get new SR value for bank1
+	mov	#0, r4
+	bsr	save_low_regs	! switch to bank1 and save bank1 r7->r0
+	 not	r4, r4
+
+	! BL=1: R7->R0 is bank1
+	stc	r2_bank, k0	! fetch old sp from r2_bank0
+	mov.l	3f, k4		! SR bits to clear in k4
+	bsr	save_regs	! switch to bank0 and save all regs
+	 stc	r0_bank, k3	! fetch old pr from r0_bank0
+
+	! BL=0: R7->R0 is bank0
+	mov	r2, r15		! restore old sp
+	mov	r5, r8		! restore old r8
+	stc	ssr, r1
+	ldc	r1, sr		! restore old sr
+	lds	r0, pr		! restore old pr
+	mov.l	4f, r0
+	jmp	@r0
+	 nop
+
+do_swsusp_save:
+	mov	r2, r15		! restore old sp
+	mov	r5, r8		! restore old r8
+	lds	r0, pr		! restore old pr
+	rts
+	 mov	#0, r0
+
+	.align	2
+1:	.long	do_swsusp_save
+2:	.long	0x20000000 ! RB=1
+3:	.long	0xdfffffff ! RB=0
+4:	.long	swsusp_save
+5:	.long	swsusp_arch_regs_cpu0
+6:	.long	SWSUSP_ARCH_REGS_SIZE
+#endif /* CONFIG_HIBERNATION */
--- /dev/null
+++ work/arch/sh/kernel/pm.c	2009-03-02 15:23:59.000000000 +0900
@@ -0,0 +1,39 @@
+/*
+ * pm.c - SuperH power management code
+ *
+ * Copyright (C) 2009 Magnus Damm
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/suspend.h>
+#include <asm/suspend.h>
+#include <asm/tlbflush.h>
+#include <asm/page.h>
+#include <asm/fpu.h>
+
+#ifdef CONFIG_HIBERNATION
+struct swsusp_arch_regs swsusp_arch_regs_cpu0;
+
+int pfn_is_nosave(unsigned long pfn)
+{
+	unsigned long begin_pfn = __pa(&__nosave_begin) >> PAGE_SHIFT;
+	unsigned long end_pfn = PAGE_ALIGN(__pa(&__nosave_end)) >> PAGE_SHIFT;
+
+	return (pfn >= begin_pfn) && (pfn < end_pfn);
+}
+
+void save_processor_state(void)
+{
+	init_fpu(current);
+}
+
+void restore_processor_state(void)
+{
+	local_flush_tlb_all();
+}
+#endif
