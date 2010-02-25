From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 25 Feb 2010 11:03:24 +0000
Subject: [PATCH] sh: SH-Mobile R-standby register save/restore
Message-Id: <20100225110324.6849.13911.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add code to save/restore registers during
R-standby sleep on SH-Mobile processors.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Tested on the sh7724 processor using ms7724se and Ecovec.

 arch/sh/include/asm/suspend.h       |    1 
 arch/sh/kernel/cpu/shmobile/pm.c    |    3 
 arch/sh/kernel/cpu/shmobile/sleep.S |  121 ++++++++++++++++++++++++++++++++++-
 3 files changed, 122 insertions(+), 3 deletions(-)

--- 0001/arch/sh/include/asm/suspend.h
+++ work/arch/sh/include/asm/suspend.h	2010-02-25 19:22:59.000000000 +0900
@@ -92,5 +92,6 @@ extern unsigned long sh_mobile_sleep_sup
 #define SUSP_SH_USTANDBY	(1 << 3) /* SH-Mobile U-standby mode */
 #define SUSP_SH_SF		(1 << 4) /* Enable self-refresh */
 #define SUSP_SH_MMU		(1 << 5) /* Save/restore MMU and cache */
+#define SUSP_SH_REGS		(1 << 6) /* Save/restore registers */
 
 #endif /* _ASM_SH_SUSPEND_H */
--- 0001/arch/sh/kernel/cpu/shmobile/pm.c
+++ work/arch/sh/kernel/cpu/shmobile/pm.c	2010-02-25 19:22:59.000000000 +0900
@@ -33,7 +33,8 @@ ATOMIC_NOTIFIER_HEAD(sh_mobile_post_slee
 #define SUSP_MODE_SLEEP		(SUSP_SH_SLEEP)
 #define SUSP_MODE_SLEEP_SF	(SUSP_SH_SLEEP | SUSP_SH_SF)
 #define SUSP_MODE_STANDBY_SF	(SUSP_SH_STANDBY | SUSP_SH_SF)
-#define SUSP_MODE_RSTANDBY	(SUSP_SH_RSTANDBY | SUSP_SH_MMU | SUSP_SH_SF)
+#define SUSP_MODE_RSTANDBY_SF \
+	(SUSP_SH_RSTANDBY | SUSP_SH_MMU | SUSP_SH_REGS | SUSP_SH_SF)
  /*
   * U-standby mode is unsupported since it needs bootloader hacks
   */
--- 0001/arch/sh/kernel/cpu/shmobile/sleep.S
+++ work/arch/sh/kernel/cpu/shmobile/sleep.S	2010-02-25 19:22:59.000000000 +0900
@@ -48,8 +48,48 @@ ENTRY(sh_mobile_sleep_enter_start)
 	stc	sr, r0
 	mov.l	r0, @(SH_SLEEP_SR, r5)
 
-	/* save sp */
+	/* save general purpose registers to stack if needed */
+	mov.l	@(SH_SLEEP_MODE, r5), r0
+	tst	#SUSP_SH_REGS, r0
+	bt	skip_regs_save
+
+	sts.l	pr, @-r15
+	mov.l	r14, @-r15
+	mov.l	r13, @-r15
+	mov.l	r12, @-r15
+	mov.l	r11, @-r15
+	mov.l	r10, @-r15
+	mov.l	r9, @-r15
+	mov.l	r8, @-r15
+
+	/* make sure bank0 is selected, save low registers */
+	mov.l	rb_bit, r9
+	not	r9, r9
+	bsr	set_sr
+	 mov	#0, r10
+
+	bsr	save_low_regs
+	 nop
+
+	/* switch to bank 1, save low registers */
+	mov.l	rb_bit, r10
+	bsr	set_sr
+	 mov	#-1, r9
+
+	bsr	save_low_regs
+	 nop
+
+	/* switch back to bank 0 */
+	mov.l	rb_bit, r9
+	not	r9, r9
+	bsr	set_sr
+	 mov	#0, r10
+
+skip_regs_save:
+
+	/* save sp, also set to internal ram */
 	mov.l	r15, @(SH_SLEEP_SP, r5)
+	mov	r5, r15
 
 	/* save stbcr */
 	bsr     save_register
@@ -60,7 +100,7 @@ ENTRY(sh_mobile_sleep_enter_start)
 	tst	#SUSP_SH_MMU, r0
 	bt	skip_mmu_save_disable
 
-       /* save mmu state */
+	/* save mmu state */
 	bsr	save_register
 	 mov	#SH_SLEEP_REG_PTEH, r0
 
@@ -177,6 +217,29 @@ get_register:
 	mov.l	@(r0, r5), r0
 	rts
 	 nop
+
+set_sr:
+	stc	sr, r8
+	and	r9, r8
+	or	r10, r8
+	ldc	r8, sr
+	rts
+	 nop
+
+save_low_regs:
+	mov.l	r7, @-r15
+	mov.l	r6, @-r15
+	mov.l	r5, @-r15
+	mov.l	r4, @-r15
+	mov.l	r3, @-r15
+	mov.l	r2, @-r15
+	mov.l	r1, @-r15
+	rts
+	 mov.l	r0, @-r15
+
+	.balign 4
+rb_bit:	.long	0x20000000 ! RB=1
+
 ENTRY(sh_mobile_sleep_enter_end)
 
 	.balign 4
@@ -270,6 +333,40 @@ skip_restore_sf:
 	icbi	@r0
 
 skip_restore_mmu:
+
+	/* restore general purpose registers if needed */
+	mov.l	@(SH_SLEEP_MODE, r5), r0
+	tst	#SUSP_SH_REGS, r0
+	bt	skip_restore_regs
+
+	/* switch to bank 1, restore low registers */
+	mov.l	_rb_bit, r10
+	bsr	_set_sr
+	 mov	#-1, r9
+
+	bsr	restore_low_regs
+	 nop
+
+	/* switch to bank0, restore low registers */
+	mov.l	_rb_bit, r9
+	not	r9, r9
+	bsr	_set_sr
+	 mov	#0, r10
+
+	bsr	restore_low_regs
+	 nop
+
+	/* restore the rest of the registers */
+	mov.l	@r15+, r8
+	mov.l	@r15+, r9
+	mov.l	@r15+, r10
+	mov.l	@r15+, r11
+	mov.l	@r15+, r12
+	mov.l	@r15+, r13
+	mov.l	@r15+, r14
+	lds.l	@r15+, pr
+
+skip_restore_regs:
 	rte
 	 nop
 
@@ -283,6 +380,26 @@ restore_register:
 	rts
 	 nop
 
+_set_sr:
+	stc	sr, r8
+	and	r9, r8
+	or	r10, r8
+	ldc	r8, sr
+	rts
+	 nop
+
+restore_low_regs:
+	mov.l	@r15+, r0
+	mov.l	@r15+, r1
+	mov.l	@r15+, r2
+	mov.l	@r15+, r3
+	mov.l	@r15+, r4
+	mov.l	@r15+, r5
+	mov.l	@r15+, r6
+	rts
+	 mov.l	@r15+, r7
+
 	.balign 4
+_rb_bit:	.long	0x20000000 ! RB=1
 1:	.long	~0x7ff
 ENTRY(sh_mobile_sleep_resume_end)
