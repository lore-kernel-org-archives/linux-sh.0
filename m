From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 30 Oct 2009 04:24:40 +0000
Subject: [PATCH 08/09] sh: Add R-standby sleep mode support
Message-Id: <20091030042440.11783.30987.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add R-standby specific bits to the SuperH Mobile sleep code.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/suspend.h       |    5 +++++
 arch/sh/kernel/asm-offsets.c        |    3 +++
 arch/sh/kernel/cpu/shmobile/pm.c    |   13 ++++++-------
 arch/sh/kernel/cpu/shmobile/sleep.S |   12 ++++++++++++
 4 files changed, 26 insertions(+), 7 deletions(-)

--- 0009/arch/sh/include/asm/suspend.h
+++ work/arch/sh/include/asm/suspend.h	2009-10-29 17:28:12.000000000 +0900
@@ -38,6 +38,7 @@ void sh_mobile_register_self_refresh(uns
 /* register structure for address/data information */
 struct sh_sleep_regs {
 	unsigned long stbcr;
+	unsigned long bar;
 
 	/* MMU */
 	unsigned long pteh;
@@ -63,10 +64,14 @@ struct sh_sleep_data {
 	unsigned long sf_pre;
 	unsigned long sf_post;
 
+	/* address of resume code */
+	unsigned long resume;
+
 	/* register state saved and restored by the assembly code */
 	unsigned long vbr;
 	unsigned long spc;
 	unsigned long sr;
+	unsigned long sp;
 
 	/* structure for keeping register addresses */
 	struct sh_sleep_regs addr;
--- 0009/arch/sh/kernel/asm-offsets.c
+++ work/arch/sh/kernel/asm-offsets.c	2009-10-29 17:28:31.000000000 +0900
@@ -38,12 +38,15 @@ int main(void)
 	DEFINE(SH_SLEEP_MODE, offsetof(struct sh_sleep_data, mode));
 	DEFINE(SH_SLEEP_SF_PRE, offsetof(struct sh_sleep_data, sf_pre));
 	DEFINE(SH_SLEEP_SF_POST, offsetof(struct sh_sleep_data, sf_post));
+	DEFINE(SH_SLEEP_RESUME, offsetof(struct sh_sleep_data, resume));
 	DEFINE(SH_SLEEP_VBR, offsetof(struct sh_sleep_data, vbr));
 	DEFINE(SH_SLEEP_SPC, offsetof(struct sh_sleep_data, spc));
 	DEFINE(SH_SLEEP_SR, offsetof(struct sh_sleep_data, sr));
+	DEFINE(SH_SLEEP_SP, offsetof(struct sh_sleep_data, sp));
 	DEFINE(SH_SLEEP_BASE_ADDR, offsetof(struct sh_sleep_data, addr));
 	DEFINE(SH_SLEEP_BASE_DATA, offsetof(struct sh_sleep_data, data));
 	DEFINE(SH_SLEEP_REG_STBCR, offsetof(struct sh_sleep_regs, stbcr));
+	DEFINE(SH_SLEEP_REG_BAR, offsetof(struct sh_sleep_regs, bar));
 	DEFINE(SH_SLEEP_REG_PTEH, offsetof(struct sh_sleep_regs, pteh));
 	DEFINE(SH_SLEEP_REG_PTEL, offsetof(struct sh_sleep_regs, ptel));
 	DEFINE(SH_SLEEP_REG_TTB, offsetof(struct sh_sleep_regs, ttb));
--- 0010/arch/sh/kernel/cpu/shmobile/pm.c
+++ work/arch/sh/kernel/cpu/shmobile/pm.c	2009-10-29 17:27:27.000000000 +0900
@@ -33,13 +33,10 @@ ATOMIC_NOTIFIER_HEAD(sh_mobile_post_slee
 #define SUSP_MODE_SLEEP		(SUSP_SH_SLEEP)
 #define SUSP_MODE_SLEEP_SF	(SUSP_SH_SLEEP | SUSP_SH_SF)
 #define SUSP_MODE_STANDBY_SF	(SUSP_SH_STANDBY | SUSP_SH_SF)
-
-/*
- * The following modes are not there yet:
- *
- * R-standby mode is unsupported, but will be added in the future
- * U-standby mode is low priority since it needs bootloader hacks
- */
+#define SUSP_MODE_RSTANDBY	(SUSP_SH_RSTANDBY | SUSP_SH_MMU | SUSP_SH_SF)
+ /*
+  * U-standby mode is unsupported since it needs bootloader hacks
+  */
 
 #ifdef CONFIG_CPU_SUBTYPE_SH7724
 #define RAM_BASE 0xfd800000 /* RSMEM */
@@ -90,6 +87,7 @@ void sh_mobile_register_self_refresh(uns
 	/* part 0: data area */
 	sdp = onchip_mem;
 	sdp->addr.stbcr = 0xa4150020; /* STBCR */
+	sdp->addr.bar = 0xa4150040; /* BAR */
 	sdp->addr.pteh = 0xff000000; /* PTEH */
 	sdp->addr.ptel = 0xff000004; /* PTEL */
 	sdp->addr.ttb = 0xff000008; /* TTB */
@@ -124,6 +122,7 @@ void sh_mobile_register_self_refresh(uns
 	vp = onchip_mem + 0x600; /* located at interrupt vector */
 	n = &sh_mobile_sleep_resume_end - &sh_mobile_sleep_resume_start;
 	memcpy(vp, &sh_mobile_sleep_resume_start, n);
+	sdp->resume = (unsigned long)vp;
 
 	sh_mobile_sleep_supported |= flags;
 }
--- 0009/arch/sh/kernel/cpu/shmobile/sleep.S
+++ work/arch/sh/kernel/cpu/shmobile/sleep.S	2009-10-29 17:29:14.000000000 +0900
@@ -48,6 +48,9 @@ ENTRY(sh_mobile_sleep_enter_start)
 	stc	sr, r0
 	mov.l	r0, @(SH_SLEEP_SR, r5)
 
+	/* save sp */
+	mov.l	r15, @(SH_SLEEP_SP, r5)
+
 	/* save stbcr */
 	bsr     save_register
 	 mov    #SH_SLEEP_REG_STBCR, r0
@@ -125,6 +128,12 @@ test_rstandby:
 	tst	#SUSP_SH_RSTANDBY, r0
 	bt	test_ustandby
 
+	/* setup BAR register */
+	bsr	get_register
+	 mov	#SH_SLEEP_REG_BAR, r0
+	mov.l	@(SH_SLEEP_RESUME, r5), r1
+	mov.l	r1, @r0
+
 	/* set mode to "r-standby mode" */
 	bra	do_sleep
 	 mov	#0x20, r1
@@ -203,6 +212,9 @@ ENTRY(sh_mobile_sleep_resume_start)
 	mov.l	@(SH_SLEEP_SR, r5), r0
 	ldc	r0, ssr
 
+	/* restore sp */
+	mov.l   @(SH_SLEEP_SP, r5), r15
+
 	/* restore sleep mode register */
 	bsr     restore_register
 	 mov    #SH_SLEEP_REG_STBCR, r0
