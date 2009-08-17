From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 17 Aug 2009 09:27:29 +0000
Subject: [PATCH] sh: rework SuperH Mobile sleep code exception handling
Message-Id: <20090817092729.9179.33744.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch updates the exception handling in the sleep code
for SuperH Mobile. With the patch applied the sleep code
always rewrites the VBR and resumes from the exception vector,
re-initializes hardware and jumps straight to the original
interrupt vector.

Tested on sh7722 and sh7724 with "Sleep Mode", "Sleep Mode + SF"
and "Software Standby Mode + SF" with CONFIG_SUSPEND.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/shmobile/pm.c    |   16 ---
 arch/sh/kernel/cpu/shmobile/sleep.S |  161 +++++++++++++++++++++++------------
 2 files changed, 110 insertions(+), 67 deletions(-)

--- 0001/arch/sh/kernel/cpu/shmobile/pm.c
+++ work/arch/sh/kernel/cpu/shmobile/pm.c	2009-08-14 13:31:57.000000000 +0900
@@ -41,23 +41,11 @@ extern const unsigned int sh_mobile_stan
 
 void sh_mobile_call_standby(unsigned long mode)
 {
-	extern void *vbr_base;
 	void *onchip_mem = (void *)ILRAM_BASE;
-	void (*standby_onchip_mem)(unsigned long) = onchip_mem;
-
-	/* Note: Wake up from sleep may generate exceptions!
-	 * Setup VBR to point to on-chip ram if self-refresh is
-	 * going to be used.
-	 */
-	if (mode & SUSP_SH_SF)
-		asm volatile("ldc %0, vbr" : : "r" (onchip_mem) : "memory");
+	void (*standby_onchip_mem)(unsigned long, unsigned long) = onchip_mem;
 
 	/* Let assembly snippet in on-chip memory handle the rest */
-	standby_onchip_mem(mode);
-
-	/* Put VBR back in System RAM again */
-	if (mode & SUSP_SH_SF)
-		asm volatile("ldc %0, vbr" : : "r" (&vbr_base) : "memory");
+	standby_onchip_mem(mode, ILRAM_BASE);
 }
 
 static int sh_pm_enter(suspend_state_t state)
--- 0003/arch/sh/kernel/cpu/shmobile/sleep.S
+++ work/arch/sh/kernel/cpu/shmobile/sleep.S	2009-08-14 13:51:34.000000000 +0900
@@ -16,19 +16,52 @@
 #include <asm/asm-offsets.h>
 #include <asm/suspend.h>
 
+/*
+ * Kernel mode register usage, see entry.S:
+ *	k0	scratch
+ *	k1	scratch
+ *	k4	scratch
+ */
+#define k0	r0
+#define k1	r1
+#define k4	r4
+
 /* manage self-refresh and enter standby mode.
  * this code will be copied to on-chip memory and executed from there.
  */
 
 	.balign 	4096,0,4096
 ENTRY(sh_mobile_standby)
+
+	/* save original vbr */
+	stc	vbr, r1
+	mova	saved_vbr, r0
+	mov.l	r1, @r0
+
+	/* point vbr to our on-chip memory page */
+	ldc	r5, vbr
+
+	/* save return address */
+	mova	saved_spc, r0
+	sts	pr, r5
+	mov.l	r5, @r0
+
+	/* save sr */
+	mova	saved_sr, r0
+	stc	sr, r5
+	mov.l	r5, @r0
+
+	/* save mode flags */
+	mova	saved_mode, r0
+	mov.l	r4, @r0
+
+	/* put mode flags in r0 */
 	mov	r4, r0
 
 	tst	#SUSP_SH_SF, r0
 	bt	skip_set_sf
 #ifdef CONFIG_CPU_SUBTYPE_SH7724
 	/* DBSC: put memory in self-refresh mode */
-
 	mov.l	dben_reg, r4
 	mov.l	dben_data0, r1
 	mov.l	r1, @r4
@@ -60,14 +93,6 @@ ENTRY(sh_mobile_standby)
 #endif
 
 skip_set_sf:
-	tst	#SUSP_SH_SLEEP, r0
-	bt	test_standby
-
-	/* set mode to "sleep mode" */
-	bra	do_sleep
-	 mov	#0x00, r1
-
-test_standby:
 	tst	#SUSP_SH_STANDBY, r0
 	bt	test_rstandby
 
@@ -85,77 +110,107 @@ test_rstandby:
 
 test_ustandby:
 	tst	#SUSP_SH_USTANDBY, r0
-	bt	done_sleep
+	bt	force_sleep
 
 	/* set mode to "u-standby mode" */
-	mov	#0x10, r1
+	bra	do_sleep
+	 mov	#0x10, r1
+
+force_sleep:
 
-	/* fall-through */
+	/* set mode to "sleep mode" */
+	mov	#0x00, r1
 
 do_sleep:
 	/* setup and enter selected standby mode */
 	mov.l	5f, r4
 	mov.l	r1, @r4
+again:
 	sleep
+	bra	again
+	 nop
+
+restore_jump_vbr:
+	/* setup spc with return address to c code */
+	mov.l	saved_spc, k0
+	ldc	k0, spc
+
+	/* restore vbr */
+	mov.l	saved_vbr, k0
+	ldc	k0, vbr
+
+	/* setup ssr with saved sr */
+	mov.l	saved_sr, k0
+	ldc	k0, ssr
+
+	/* get mode flags */
+	mov.l	saved_mode, k0
 
 done_sleep:
 	/* reset standby mode to sleep mode */
-	mov.l	5f, r4
-	mov	#0x00, r1
-	mov.l	r1, @r4
+	mov.l	5f, k4
+	mov	#0x00, k1
+	mov.l	k1, @k4
 
-	tst	#SUSP_SH_SF, r0
+	tst	#SUSP_SH_SF, k0
 	bt	skip_restore_sf
 
 #ifdef CONFIG_CPU_SUBTYPE_SH7724
 	/* DBSC: put memory in auto-refresh mode */
+	mov.l	dbrfpdn0_reg, k4
+	mov.l	dbrfpdn0_data0, k1
+	mov.l	k1, @k4
 
-	mov.l	dbrfpdn0_reg, r4
-	mov.l	dbrfpdn0_data0, r1
-	mov.l	r1, @r4
-
-	/* sleep 140 ns */
-	nop
+	nop /* sleep 140 ns */
 	nop
 	nop
 	nop
 
-	mov.l	dbcmdcnt_reg, r4
-	mov.l	dbcmdcnt_data0, r1
-	mov.l	r1, @r4
-
-	mov.l	dbcmdcnt_reg, r4
-	mov.l	dbcmdcnt_data1, r1
-	mov.l	r1, @r4
-
-	mov.l	dben_reg, r4
-	mov.l	dben_data1, r1
-	mov.l	r1, @r4
-
-	mov.l	dbrfpdn0_reg, r4
-	mov.l	dbrfpdn0_data2, r1
-	mov.l	r1, @r4
+	mov.l	dbcmdcnt_reg, k4
+	mov.l	dbcmdcnt_data0, k1
+	mov.l	k1, @k4
+
+	mov.l	dbcmdcnt_reg, k4
+	mov.l	dbcmdcnt_data1, k1
+	mov.l	k1, @k4
+
+	mov.l	dben_reg, k4
+	mov.l	dben_data1, k1
+	mov.l	k1, @k4
+
+	mov.l	dbrfpdn0_reg, k4
+	mov.l	dbrfpdn0_data2, k1
+	mov.l	k1, @k4
 #else
 	/* SBSC: set auto-refresh mode */
-	mov.l	1f, r4
-	mov.l	@r4, r2
-	mov.l   4f, r3
-	and	r3, r2
-	mov.l	r2, @r4
-	mov.l	6f, r4
-	mov.l	7f, r1
-	mov.l	8f, r2
-	mov.l	@r4, r3
-	mov	#-1, r4
-	add	r4, r3
-	or	r2, r3
-	mov.l	r3, @r1
+	mov.l	1f, k4
+	mov.l	@k4, k0
+	mov.l   4f, k1
+	and	k1, k0
+	mov.l	k0, @k4
+	mov.l	6f, k4
+	mov.l	8f, k0
+	mov.l	@k4, k1
+	mov	#-1, k4
+	add	k4, k1
+	or	k1, k0
+	mov.l	7f, k1
+	mov.l	k0, @k1
 #endif
 skip_restore_sf:
-	rts
+	/* jump to vbr vector */
+	mov.l	saved_vbr, k0
+	mov.l	offset_vbr, k4
+	add	k4, k0
+	jmp	@k0
 	 nop
 
 	.balign 4
+saved_mode:	.long	0
+saved_spc:	.long	0
+saved_sr:	.long	0
+saved_vbr:	.long	0
+offset_vbr:	.long	0x600
 #ifdef CONFIG_CPU_SUBTYPE_SH7724
 dben_reg:	.long	0xfd000010 /* DBEN */
 dben_data0:	.long	0
@@ -178,12 +233,12 @@ dbcmdcnt_data1:	.long	4
 7:	.long   0xfe400018 /* RTCNT */
 8:	.long   0xa55a0000
 
+
 /* interrupt vector @ 0x600 */
 	.balign 	0x400,0,0x400
 	.long	0xdeadbeef
 	.balign 	0x200,0,0x200
-	/* sh7722 will end up here in sleep mode */
-	rte
+	bra	restore_jump_vbr
 	 nop
 sh_mobile_standby_end:
 
