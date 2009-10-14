From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 14 Oct 2009 10:19:12 +0000
Subject: [PATCH 06/07] sh: Add R-Standby support
Message-Id: <20091014101912.21842.25895.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add experimental R-standby support for sh7724. Right now only
the kfr2r09 board is enabled. This should obviously not be
board dependent in the future.

Not-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/shmobile/pm.c    |   11 +++--
 arch/sh/kernel/cpu/shmobile/sleep.S |   69 ++++++++++++++++++++++++++++++-----
 2 files changed, 68 insertions(+), 12 deletions(-)

--- 0004/arch/sh/kernel/cpu/shmobile/pm.c
+++ work/arch/sh/kernel/cpu/shmobile/pm.c	2009-10-14 18:07:02.000000000 +0900
@@ -23,16 +23,15 @@
  * Sleep mode is just plain "sleep" instruction
  * Sleep Self-Refresh mode is above plus RAM put in Self-Refresh
  * Standby Self-Refresh mode is above plus stopped clocks
+ * R-standby turns off the main power domain
  */
 #define SUSP_MODE_SLEEP		(SUSP_SH_SLEEP)
 #define SUSP_MODE_SLEEP_SF	(SUSP_SH_SLEEP | SUSP_SH_SF)
 #define SUSP_MODE_STANDBY_SF	(SUSP_SH_STANDBY | SUSP_SH_SF)
+#define SUSP_MODE_RSTANDBY	(SUSP_SH_RSTANDBY | SUSP_SH_MMU | SUSP_SH_BSC | SUSP_SH_SF)
 
 /*
- * The following modes are not there yet:
- *
- * R-standby mode is unsupported, but will be added in the future
- * U-standby mode is low priority since it needs bootloader hacks
+ * U-standby mode is unsupported since it needs bootloader hacks
  */
 
 #ifdef CONFIG_CPU_SUBTYPE_SH7724
@@ -61,7 +60,11 @@ static int sh_pm_enter(suspend_state_t s
 {
 	local_irq_disable();
 	set_bl_bit();
+#ifdef CONFIG_SH_KFR2R09
+	sh_mobile_call_standby(SUSP_MODE_RSTANDBY);
+#else
 	sh_mobile_call_standby(SUSP_MODE_STANDBY_SF);
+#endif
 	local_irq_disable();
 	clear_bl_bit();
 	return 0;
--- 0006/arch/sh/kernel/cpu/shmobile/sleep.S
+++ work/arch/sh/kernel/cpu/shmobile/sleep.S	2009-10-14 18:07:02.000000000 +0900
@@ -246,6 +246,22 @@ test_rstandby:
 	tst	#SUSP_SH_RSTANDBY, r0
 	bt	test_ustandby
 
+	/* save sp */
+	mova    saved_sp, r0
+	mov.l   r15, @r0
+
+	/* setup resume address in BAR register */
+	stc     vbr, r1
+	mov.l   offset_resume, r4
+	add     r4, r1
+	mov.l   bar_reg, r4
+	mov.l   r1, @r4
+
+	/* make sure the SRSTF bit is cleared in RWTCSR */
+	mov.l   rwtcsr_reg, r0
+	mov.l   rwtcsr_data, r1
+	mov.w   r1, @r0
+
 	/* set mode to "r-standby mode" */
 	bra	do_sleep
 	 mov	#0x20, r1
@@ -272,19 +288,49 @@ again:
 	bra	again
 	 nop
 
+restore_jump_rstandby:
+	/* disable RWDT reset */
+	mov.l   rwtcsr_reg, k0
+	mov.l   rwtcsr_data, k1
+	mov.w   k1, @k0
+
+	/* restore sp */
+	mov.l   saved_sp, r15
+
+	/* restore sr */
+	mov.l	saved_sr, r0
+	ldc	r0, sr
+
+	/* set return_addr to old PR value */
+	mov.l	saved_spc, k4
+	mova	return_addr, k0
+	mov.l	k4, @k0
+
+	bra	restore_jump_common
+	 nop
+	
 restore_jump_vbr:
+
+	/* set return_addr to vbr vector */
+	mov.l	saved_vbr, k0
+	mov.l	offset_vbr, k4
+	add	k0, k4
+	mova	return_addr, k0
+	mov.l	k4, @k0
+
 	/* setup spc with return address to c code */
 	mov.l	saved_spc, k0
 	ldc	k0, spc
 
-	/* restore vbr */
-	mov.l	saved_vbr, k0
-	ldc	k0, vbr
-
 	/* setup ssr with saved sr */
 	mov.l	saved_sr, k0
 	ldc	k0, ssr
 
+restore_jump_common:
+	/* restore vbr */
+	mov.l	saved_vbr, k0
+	ldc	k0, vbr
+
 	/* get mode flags */
 	mov.l	saved_mode, k0
 
@@ -499,19 +545,22 @@ skip_bsc_restore:
 	mov.l	k0, @k1
 #endif
 skip_restore_sf:
-	/* jump to vbr vector */
-	mov.l	saved_vbr, k0
-	mov.l	offset_vbr, k4
-	add	k4, k0
+
+	/* jump to address in return_addr */
+	mov.l	return_addr, k0
 	jmp	@k0
 	 nop
 
 	.balign 4
 saved_mode:	.long	0
 saved_spc:	.long	0
+saved_sp:	.long	0
 saved_sr:	.long	0
 saved_vbr:	.long	0
 offset_vbr:	.long	0x600
+return_addr:	.long	0
+bar_reg:       .long   0xa4150040 /* BAR */
+offset_resume: .long   restore_jump_rstandby - sh_mobile_standby
 #ifdef CONFIG_CPU_SUBTYPE_SH7724
 dben_reg:	.long	0xfd000010 /* DBEN */
 dbcmdcnt_reg:	.long	0xfd000014 /* DBCMDCNT */
@@ -585,6 +634,10 @@ dbpdcnt0_reg:  .long   0xfd000108 /* DBP
 dbpdcnt0_data: .long   0
 #endif
 
+/* RWDT */
+rwtcsr_reg:    .long   0xa4520004
+rwtcsr_data:   .long   0xa500
+
 /* interrupt vector @ 0x600 */
 	.balign 	0x400,0,0x400
 	.long	0xdeadbeef
