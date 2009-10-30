From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 30 Oct 2009 04:24:07 +0000
Subject: [PATCH 04/09] sh: Rework SuperH Mobile sleep mode code
Message-Id: <20091030042407.11783.78032.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Rework the SuperH Mobile sleep code from including
board specific code to allowing each board to provide
pre/post code snippets. These snippets should contain
sdram management code to enter and leave self-refresh.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/suspend.h       |   27 +++
 arch/sh/kernel/asm-offsets.c        |   10 +
 arch/sh/kernel/cpu/shmobile/pm.c    |   54 ++++++-
 arch/sh/kernel/cpu/shmobile/sleep.S |  244 +++++++++++++----------------------
 4 files changed, 171 insertions(+), 164 deletions(-)

--- 0005/arch/sh/include/asm/suspend.h
+++ work/arch/sh/include/asm/suspend.h	2009-10-29 17:24:52.000000000 +0900
@@ -34,6 +34,33 @@ extern struct atomic_notifier_head sh_mo
 void sh_mobile_register_self_refresh(unsigned long flags,
 				     void *pre_start, void *pre_end,
 				     void *post_start, void *post_end);
+
+/* register structure for address/data information */
+struct sh_sleep_regs {
+	unsigned long stbcr;
+};
+
+/* data area for low-level sleep code */
+struct sh_sleep_data {
+	/* current sleep mode (SUSP_SH_...) */
+	unsigned long mode;
+
+	/* addresses of board specific self-refresh snippets */
+	unsigned long sf_pre;
+	unsigned long sf_post;
+
+	/* register state saved and restored by the assembly code */
+	unsigned long vbr;
+	unsigned long spc;
+	unsigned long sr;
+
+	/* structure for keeping register addresses */
+	struct sh_sleep_regs addr;
+
+	/* structure for saving/restoring register state */
+	struct sh_sleep_regs data;
+};
+
 #endif
 
 /* flags passed to assembly suspend code */
--- 0001/arch/sh/kernel/asm-offsets.c
+++ work/arch/sh/kernel/asm-offsets.c	2009-10-29 17:23:21.000000000 +0900
@@ -34,5 +34,15 @@ int main(void)
 	DEFINE(PBE_NEXT, offsetof(struct pbe, next));
 	DEFINE(SWSUSP_ARCH_REGS_SIZE, sizeof(struct swsusp_arch_regs));
 #endif
+
+	DEFINE(SH_SLEEP_MODE, offsetof(struct sh_sleep_data, mode));
+	DEFINE(SH_SLEEP_SF_PRE, offsetof(struct sh_sleep_data, sf_pre));
+	DEFINE(SH_SLEEP_SF_POST, offsetof(struct sh_sleep_data, sf_post));
+	DEFINE(SH_SLEEP_VBR, offsetof(struct sh_sleep_data, vbr));
+	DEFINE(SH_SLEEP_SPC, offsetof(struct sh_sleep_data, spc));
+	DEFINE(SH_SLEEP_SR, offsetof(struct sh_sleep_data, sr));
+	DEFINE(SH_SLEEP_BASE_ADDR, offsetof(struct sh_sleep_data, addr));
+	DEFINE(SH_SLEEP_BASE_DATA, offsetof(struct sh_sleep_data, data));
+	DEFINE(SH_SLEEP_REG_STBCR, offsetof(struct sh_sleep_regs, stbcr));
 	return 0;
 }
--- 0005/arch/sh/kernel/cpu/shmobile/pm.c
+++ work/arch/sh/kernel/cpu/shmobile/pm.c	2009-10-29 17:23:21.000000000 +0900
@@ -42,13 +42,14 @@ ATOMIC_NOTIFIER_HEAD(sh_mobile_post_slee
 
 #define ILRAM_BASE 0xe5200000
 
-extern const unsigned char sh_mobile_standby[];
-extern const unsigned int sh_mobile_standby_size;
-
 void sh_mobile_call_standby(unsigned long mode)
 {
 	void *onchip_mem = (void *)ILRAM_BASE;
-	void (*standby_onchip_mem)(unsigned long, unsigned long) = onchip_mem;
+	struct sh_sleep_data *sdp = onchip_mem;
+	void (*standby_onchip_mem)(unsigned long, unsigned long);
+
+	/* code located directly after data structure */
+	standby_onchip_mem = (void *)(sdp + 1);
 
 	atomic_notifier_call_chain(&sh_mobile_pre_sleep_notifier_list,
 				   mode, NULL);
@@ -60,10 +61,48 @@ void sh_mobile_call_standby(unsigned lon
 				   mode, NULL);
 }
 
+extern char sh_mobile_sleep_enter_start;
+extern char sh_mobile_sleep_enter_end;
+
+extern char sh_mobile_sleep_resume_start;
+extern char sh_mobile_sleep_resume_end;
+
 void sh_mobile_register_self_refresh(unsigned long flags,
 				     void *pre_start, void *pre_end,
 				     void *post_start, void *post_end)
 {
+	void *onchip_mem = (void *)ILRAM_BASE;
+	void *vp;
+	struct sh_sleep_data *sdp;
+	int n;
+
+	/* part 0: data area */
+	sdp = onchip_mem;
+	sdp->addr.stbcr = 0xa4150020; /* STBCR */
+	vp = sdp + 1;
+
+	/* part 1: common code to enter sleep mode */
+	n = &sh_mobile_sleep_enter_end - &sh_mobile_sleep_enter_start;
+	memcpy(vp, &sh_mobile_sleep_enter_start, n);
+	vp += roundup(n, 4);
+
+	/* part 2: board specific code to enter self-refresh mode */
+	n = pre_end - pre_start;
+	memcpy(vp, pre_start, n);
+	sdp->sf_pre = (unsigned long)vp;
+	vp += roundup(n, 4);
+
+	/* part 3: board specific code to resume from self-refresh mode */
+	n = post_end - post_start;
+	memcpy(vp, post_start, n);
+	sdp->sf_post = (unsigned long)vp;
+	vp += roundup(n, 4);
+
+	/* part 4: common code to resume from sleep mode */
+	WARN_ON(vp > (onchip_mem + 0x600));
+	vp = onchip_mem + 0x600; /* located at interrupt vector */
+	n = &sh_mobile_sleep_resume_end - &sh_mobile_sleep_resume_start;
+	memcpy(vp, &sh_mobile_sleep_resume_start, n);
 }
 
 static int sh_pm_enter(suspend_state_t state)
@@ -83,13 +122,6 @@ static struct platform_suspend_ops sh_pm
 
 static int __init sh_pm_init(void)
 {
-	void *onchip_mem = (void *)ILRAM_BASE;
-
-	/* Copy the assembly snippet to the otherwise ununsed ILRAM */
-	memcpy(onchip_mem, sh_mobile_standby, sh_mobile_standby_size);
-	wmb();
-	ctrl_barrier();
-
 	suspend_set_ops(&sh_pm_ops);
 	sh_mobile_setup_cpuidle();
 	return 0;
--- 0001/arch/sh/kernel/cpu/shmobile/sleep.S
+++ work/arch/sh/kernel/cpu/shmobile/sleep.S	2009-10-29 17:24:36.000000000 +0900
@@ -20,79 +20,49 @@
  * Kernel mode register usage, see entry.S:
  *	k0	scratch
  *	k1	scratch
- *	k4	scratch
  */
 #define k0	r0
 #define k1	r1
-#define k4	r4
 
-/* manage self-refresh and enter standby mode.
+/* manage self-refresh and enter standby mode. must be self-contained.
  * this code will be copied to on-chip memory and executed from there.
  */
+	.balign 4
+ENTRY(sh_mobile_sleep_enter_start)
 
-	.balign 	4096,0,4096
-ENTRY(sh_mobile_standby)
+	/* save mode flags */
+	mov.l	r4, @(SH_SLEEP_MODE, r5)
 
 	/* save original vbr */
-	stc	vbr, r1
-	mova	saved_vbr, r0
-	mov.l	r1, @r0
+	stc	vbr, r0
+	mov.l	r0, @(SH_SLEEP_VBR, r5)
 
 	/* point vbr to our on-chip memory page */
 	ldc	r5, vbr
 
 	/* save return address */
-	mova	saved_spc, r0
-	sts	pr, r5
-	mov.l	r5, @r0
+	sts	pr, r0
+	mov.l	r0, @(SH_SLEEP_SPC, r5)
 
 	/* save sr */
-	mova	saved_sr, r0
-	stc	sr, r5
-	mov.l	r5, @r0
+	stc	sr, r0
+	mov.l	r0, @(SH_SLEEP_SR, r5)
 
-	/* save mode flags */
-	mova	saved_mode, r0
-	mov.l	r4, @r0
-
-	/* put mode flags in r0 */
-	mov	r4, r0
+	/* save stbcr */
+	bsr     save_register
+	 mov    #SH_SLEEP_REG_STBCR, r0
 
+	/* call self-refresh entering code if needed */
+	mov.l	@(SH_SLEEP_MODE, r5), r0
 	tst	#SUSP_SH_SF, r0
 	bt	skip_set_sf
-#ifdef CONFIG_CPU_SUBTYPE_SH7724
-	/* DBSC: put memory in self-refresh mode */
-	mov.l	dben_reg, r4
-	mov.l	dben_data0, r1
-	mov.l	r1, @r4
-
-	mov.l	dbrfpdn0_reg, r4
-	mov.l	dbrfpdn0_data0, r1
-	mov.l	r1, @r4
-
-	mov.l	dbcmdcnt_reg, r4
-	mov.l	dbcmdcnt_data0, r1
-	mov.l	r1, @r4
-
-	mov.l	dbcmdcnt_reg, r4
-	mov.l	dbcmdcnt_data1, r1
-	mov.l	r1, @r4
-
-	mov.l	dbrfpdn0_reg, r4
-	mov.l	dbrfpdn0_data1, r1
-	mov.l	r1, @r4
-#else
-	/* SBSC: disable power down and put in self-refresh mode */
-	mov.l	1f, r4
-	mov.l	2f, r1
-	mov.l	@r4, r2
-	or	r1, r2
-	mov.l   3f, r3
-	and	r3, r2
-	mov.l	r2, @r4
-#endif
+
+	mov.l	@(SH_SLEEP_SF_PRE, r5), r0
+	jsr	@r0
+	 nop
 
 skip_set_sf:
+	mov.l	@(SH_SLEEP_MODE, r5), r0
 	tst	#SUSP_SH_STANDBY, r0
 	bt	test_rstandby
 
@@ -123,124 +93,92 @@ force_sleep:
 
 do_sleep:
 	/* setup and enter selected standby mode */
-	mov.l	5f, r4
-	mov.l	r1, @r4
+	bsr     get_register
+	 mov    #SH_SLEEP_REG_STBCR, r0
+	mov.l	r1, @r0
 again:
 	sleep
 	bra	again
 	 nop
 
-restore_jump_vbr:
+save_register:
+	add	#SH_SLEEP_BASE_ADDR, r0
+	mov.l	@(r0, r5), r1
+	add	#-SH_SLEEP_BASE_ADDR, r0
+	mov.l	@r1, r1
+	add	#SH_SLEEP_BASE_DATA, r0
+	mov.l	r1, @(r0, r5)
+	add	#-SH_SLEEP_BASE_DATA, r0
+	rts
+	 nop
+
+get_register:
+	add	#SH_SLEEP_BASE_ADDR, r0
+	mov.l	@(r0, r5), r0
+	rts
+	 nop
+ENTRY(sh_mobile_sleep_enter_end)
+
+	.balign 4
+ENTRY(sh_mobile_sleep_resume_start)
+
+	/* figure out start address */
+	bsr	0f
+	 nop
+0:
+	sts	pr, k1
+	mov.l	1f, k0
+	and	k0, k1
+
+	/* store pointer to data area in VBR */
+	ldc	k1, vbr
+
+	/* setup sr with saved sr */
+	mov.l	@(SH_SLEEP_SR, k1), k0
+	ldc	k0, sr
+
+	/* now: user register set! */
+	stc	vbr, r5
+
 	/* setup spc with return address to c code */
-	mov.l	saved_spc, k0
-	ldc	k0, spc
+	mov.l	@(SH_SLEEP_SPC, r5), r0
+	ldc	r0, spc
 
 	/* restore vbr */
-	mov.l	saved_vbr, k0
-	ldc	k0, vbr
+	mov.l	@(SH_SLEEP_VBR, r5), r0
+	ldc	r0, vbr
 
 	/* setup ssr with saved sr */
-	mov.l	saved_sr, k0
-	ldc	k0, ssr
-
-	/* get mode flags */
-	mov.l	saved_mode, k0
+	mov.l	@(SH_SLEEP_SR, r5), r0
+	ldc	r0, ssr
 
-done_sleep:
-	/* reset standby mode to sleep mode */
-	mov.l	5f, k4
-	mov	#0x00, k1
-	mov.l	k1, @k4
+	/* restore sleep mode register */
+	bsr     restore_register
+	 mov    #SH_SLEEP_REG_STBCR, r0
 
-	tst	#SUSP_SH_SF, k0
+	/* call self-refresh resume code if needed */
+	mov.l	@(SH_SLEEP_MODE, r5), r0
+	tst	#SUSP_SH_SF, r0
 	bt	skip_restore_sf
 
-#ifdef CONFIG_CPU_SUBTYPE_SH7724
-	/* DBSC: put memory in auto-refresh mode */
-	mov.l	dbrfpdn0_reg, k4
-	mov.l	dbrfpdn0_data0, k1
-	mov.l	k1, @k4
-
-	nop /* sleep 140 ns */
-	nop
-	nop
-	nop
-
-	mov.l	dbcmdcnt_reg, k4
-	mov.l	dbcmdcnt_data0, k1
-	mov.l	k1, @k4
-
-	mov.l	dbcmdcnt_reg, k4
-	mov.l	dbcmdcnt_data1, k1
-	mov.l	k1, @k4
-
-	mov.l	dben_reg, k4
-	mov.l	dben_data1, k1
-	mov.l	k1, @k4
-
-	mov.l	dbrfpdn0_reg, k4
-	mov.l	dbrfpdn0_data2, k1
-	mov.l	k1, @k4
-#else
-	/* SBSC: set auto-refresh mode */
-	mov.l	1f, k4
-	mov.l	@k4, k0
-	mov.l   4f, k1
-	and	k1, k0
-	mov.l	k0, @k4
-	mov.l	6f, k4
-	mov.l	8f, k0
-	mov.l	@k4, k1
-	mov	#-1, k4
-	add	k4, k1
-	or	k1, k0
-	mov.l	7f, k1
-	mov.l	k0, @k1
-#endif
+	mov.l	@(SH_SLEEP_SF_POST, r5), r0
+	jsr	@r0
+	 nop
+
 skip_restore_sf:
-	/* jump to vbr vector */
-	mov.l	saved_vbr, k0
-	mov.l	offset_vbr, k4
-	add	k4, k0
-	jmp	@k0
+	rte
 	 nop
 
-	.balign 4
-saved_mode:	.long	0
-saved_spc:	.long	0
-saved_sr:	.long	0
-saved_vbr:	.long	0
-offset_vbr:	.long	0x600
-#ifdef CONFIG_CPU_SUBTYPE_SH7724
-dben_reg:	.long	0xfd000010 /* DBEN */
-dben_data0:	.long	0
-dben_data1:	.long	1
-dbrfpdn0_reg:	.long	0xfd000040 /* DBRFPDN0 */
-dbrfpdn0_data0:	.long	0
-dbrfpdn0_data1:	.long	1
-dbrfpdn0_data2:	.long	0x00010000
-dbcmdcnt_reg:	.long	0xfd000014 /* DBCMDCNT */
-dbcmdcnt_data0:	.long	2
-dbcmdcnt_data1:	.long	4
-#else
-1:	.long	0xfe400008 /* SDCR0 */
-2:	.long	0x00000400
-3:	.long	0xffff7fff
-4:	.long	0xfffffbff
-#endif
-5:	.long	0xa4150020 /* STBCR */
-6:	.long   0xfe40001c /* RTCOR */
-7:	.long   0xfe400018 /* RTCNT */
-8:	.long   0xa55a0000
-
-
-/* interrupt vector @ 0x600 */
-	.balign 	0x400,0,0x400
-	.long	0xdeadbeef
-	.balign 	0x200,0,0x200
-	bra	restore_jump_vbr
+restore_register:
+	add	#SH_SLEEP_BASE_DATA, r0
+	mov.l	@(r0, r5), r1
+	add	#-SH_SLEEP_BASE_DATA, r0
+	add	#SH_SLEEP_BASE_ADDR, r0
+	mov.l	@(r0, r5), r0
+	mov.l	r1, @r0
+	rts
 	 nop
-sh_mobile_standby_end:
 
-ENTRY(sh_mobile_standby_size)
-	.long sh_mobile_standby_end - sh_mobile_standby
+	.balign 4
+1:	.long	~0x7ff
+ENTRY(sh_mobile_sleep_resume_end)
