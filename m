From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 23 Feb 2009 07:15:07 +0000
Subject: [PATCH 02/04] sh: rework register restore code for sh3/sh4/sh4a
Message-Id: <20090223071507.12292.25023.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch reworks the sh3/sh4/sh4a register restore code in
the following ways:
 - break out restore_regs() from restore_all()
 - the register saving order is unchanged
 - use restore_regs() in sh_bios_handler and restore_all
 - document the function

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh3/entry.S |   68 +++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 35 deletions(-)

--- 0005/arch/sh/kernel/cpu/sh3/entry.S
+++ work/arch/sh/kernel/cpu/sh3/entry.S	2009-02-23 14:16:13.000000000 +0900
@@ -188,44 +188,35 @@ call_dae:
 #if defined(CONFIG_SH_STANDARD_BIOS)
 	/* Unwind the stack and jmp to the debug entry */
 ENTRY(sh_bios_handler)
-	mov.l	@r15+, r0
-	mov.l	@r15+, r1
-	mov.l	@r15+, r2
-	mov.l	@r15+, r3
-	mov.l	@r15+, r4
-	mov.l	@r15+, r5
-	mov.l	@r15+, r6
-	mov.l	@r15+, r7
-	stc	sr, r8
-	mov.l	1f, r9			! BL =1, RB=1, IMASK=0x0F
-	or	r9, r8
-	ldc	r8, sr			! here, change the register bank
-	mov.l	@r15+, r8
-	mov.l	@r15+, r9
-	mov.l	@r15+, r10
-	mov.l	@r15+, r11
-	mov.l	@r15+, r12
-	mov.l	@r15+, r13
-	mov.l	@r15+, r14
-	mov.l	@r15+, k0
-	ldc.l	@r15+, spc
-	lds.l	@r15+, pr
-	mov.l	@r15+, k1
-	ldc.l	@r15+, gbr
-	lds.l	@r15+, mach
-	lds.l	@r15+, macl
-	mov	k0, r15
+	mov.l	1f, r8
+	bsr	restore_regs
+	 nop
+
+	lds	k2, pr			! restore pr
+	mov	k4, r15
 	!
 	mov.l	2f, k0
 	mov.l	@k0, k0
 	jmp	@k0
-	 ldc	k1, ssr
+	 ldc	k3, ssr
 	.align	2
 1:	.long	0x300000f0
 2:	.long	gdb_vbr_vector
 #endif /* CONFIG_SH_STANDARD_BIOS */
 
-restore_all:
+! restore_regs()
+! - restore r0, r1, r2, r3, r4, r5, r6, r7 from the stack
+! - switch bank
+! - restore r8, r9, r10, r11, r12, r13, r14, r15 from the stack
+! - restore spc, pr*, ssr, gbr, mach, macl, skip default tra
+! k2 returns original pr
+! k3 returns original sr
+! k4 returns original stack pointer
+! r8 passes SR bitmask, overwritten with restored data on return
+! r9 trashed
+! BL=0 on entry, on exit BL=1 (depending on r8).
+
+restore_regs:
 	mov.l	@r15+, r0
 	mov.l	@r15+, r1
 	mov.l	@r15+, r2
@@ -235,10 +226,9 @@ restore_all:
 	mov.l	@r15+, r6
 	mov.l	@r15+, r7
 	!
-	stc	sr, r8
-	mov.l	7f, r9
-	or	r9, r8			! BL =1, RB=1
-	ldc	r8, sr			! here, change the register bank
+	stc	sr, r9
+	or	r8, r9
+	ldc	r9, sr
 	!
 	mov.l	@r15+, r8
 	mov.l	@r15+, r9
@@ -249,12 +239,20 @@ restore_all:
 	mov.l	@r15+, r14
 	mov.l	@r15+, k4		! original stack pointer
 	ldc.l	@r15+, spc
-	lds.l	@r15+, pr
+	mov.l	@r15+, k2		! original PR
 	mov.l	@r15+, k3		! original SR
 	ldc.l	@r15+, gbr
 	lds.l	@r15+, mach
 	lds.l	@r15+, macl
-	add	#4, r15			! Skip syscall number
+	rts
+	 add	#4, r15			! Skip syscall number
+
+restore_all:
+	mov.l	7f, r8
+	bsr	restore_regs
+	 nop
+
+	lds	k2, pr			! restore pr
 	!
 #ifdef CONFIG_SH_DSP
 	mov.l	@r15+, k0		! DSP mode marker
