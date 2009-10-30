From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 30 Oct 2009 04:24:23 +0000
Subject: [PATCH 06/09] sh: Add MMU and Cache handling sleep mode code
Message-Id: <20091030042423.11783.69243.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add MMU and cache handling functionality to the SuperH Mobile
sleep code. The MMU and cache registers are saved and restored.
The MMU is disabled and the cache is flushed and disabled before
entering sleep modes if the SUSP_SH_MMU flag is set. This flag
should be set in the case of R-standby and most likely for future
U-standby support as well.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/suspend.h       |   15 +++++
 arch/sh/kernel/asm-offsets.c        |   10 +++
 arch/sh/kernel/cpu/shmobile/pm.c    |   15 +++++
 arch/sh/kernel/cpu/shmobile/sleep.S |   92 +++++++++++++++++++++++++++++++++++
 4 files changed, 132 insertions(+)

--- 0007/arch/sh/include/asm/suspend.h
+++ work/arch/sh/include/asm/suspend.h	2009-10-29 16:56:44.000000000 +0900
@@ -38,6 +38,20 @@ void sh_mobile_register_self_refresh(uns
 /* register structure for address/data information */
 struct sh_sleep_regs {
 	unsigned long stbcr;
+
+	/* MMU */
+	unsigned long pteh;
+	unsigned long ptel;
+	unsigned long ttb;
+	unsigned long tea;
+	unsigned long mmucr;
+	unsigned long ptea;
+	unsigned long pascr;
+	unsigned long irmcr;
+
+	/* Cache */
+	unsigned long ccr;
+	unsigned long ramcr;
 };
 
 /* data area for low-level sleep code */
@@ -69,5 +83,6 @@ struct sh_sleep_data {
 #define SUSP_SH_RSTANDBY	(1 << 2) /* SH-Mobile R-standby mode */
 #define SUSP_SH_USTANDBY	(1 << 3) /* SH-Mobile U-standby mode */
 #define SUSP_SH_SF		(1 << 4) /* Enable self-refresh */
+#define SUSP_SH_MMU		(1 << 5) /* Save/restore MMU and cache */
 
 #endif /* _ASM_SH_SUSPEND_H */
--- 0007/arch/sh/kernel/asm-offsets.c
+++ work/arch/sh/kernel/asm-offsets.c	2009-10-29 16:56:44.000000000 +0900
@@ -44,5 +44,15 @@ int main(void)
 	DEFINE(SH_SLEEP_BASE_ADDR, offsetof(struct sh_sleep_data, addr));
 	DEFINE(SH_SLEEP_BASE_DATA, offsetof(struct sh_sleep_data, data));
 	DEFINE(SH_SLEEP_REG_STBCR, offsetof(struct sh_sleep_regs, stbcr));
+	DEFINE(SH_SLEEP_REG_PTEH, offsetof(struct sh_sleep_regs, pteh));
+	DEFINE(SH_SLEEP_REG_PTEL, offsetof(struct sh_sleep_regs, ptel));
+	DEFINE(SH_SLEEP_REG_TTB, offsetof(struct sh_sleep_regs, ttb));
+	DEFINE(SH_SLEEP_REG_TEA, offsetof(struct sh_sleep_regs, tea));
+	DEFINE(SH_SLEEP_REG_MMUCR, offsetof(struct sh_sleep_regs, mmucr));
+	DEFINE(SH_SLEEP_REG_PTEA, offsetof(struct sh_sleep_regs, ptea));
+	DEFINE(SH_SLEEP_REG_PASCR, offsetof(struct sh_sleep_regs, pascr));
+	DEFINE(SH_SLEEP_REG_IRMCR, offsetof(struct sh_sleep_regs, irmcr));
+	DEFINE(SH_SLEEP_REG_CCR, offsetof(struct sh_sleep_regs, ccr));
+	DEFINE(SH_SLEEP_REG_RAMCR, offsetof(struct sh_sleep_regs, ramcr));
 	return 0;
 }
--- 0007/arch/sh/kernel/cpu/shmobile/pm.c
+++ work/arch/sh/kernel/cpu/shmobile/pm.c	2009-10-29 16:59:08.000000000 +0900
@@ -15,6 +15,7 @@
 #include <linux/suspend.h>
 #include <asm/suspend.h>
 #include <asm/uaccess.h>
+#include <asm/cacheflush.h>
 
 /*
  * Notifier lists for pre/post sleep notification
@@ -54,6 +55,10 @@ void sh_mobile_call_standby(unsigned lon
 	atomic_notifier_call_chain(&sh_mobile_pre_sleep_notifier_list,
 				   mode, NULL);
 
+	/* flush the caches if MMU flag is set */
+	if (mode & SUSP_SH_MMU)
+		flush_cache_all();
+
 	/* Let assembly snippet in on-chip memory handle the rest */
 	standby_onchip_mem(mode, ILRAM_BASE);
 
@@ -79,6 +84,16 @@ void sh_mobile_register_self_refresh(uns
 	/* part 0: data area */
 	sdp = onchip_mem;
 	sdp->addr.stbcr = 0xa4150020; /* STBCR */
+	sdp->addr.pteh = 0xff000000; /* PTEH */
+	sdp->addr.ptel = 0xff000004; /* PTEL */
+	sdp->addr.ttb = 0xff000008; /* TTB */
+	sdp->addr.tea = 0xff00000c; /* TEA */
+	sdp->addr.mmucr = 0xff000010; /* MMUCR */
+	sdp->addr.ptea = 0xff000034; /* PTEA */
+	sdp->addr.pascr = 0xff000070; /* PASCR */
+	sdp->addr.irmcr = 0xff000078; /* IRMCR */
+	sdp->addr.ccr = 0xff00001c; /* CCR */
+	sdp->addr.ramcr = 0xff000074; /* RAMCR */
 	vp = sdp + 1;
 
 	/* part 1: common code to enter sleep mode */
--- 0007/arch/sh/kernel/cpu/shmobile/sleep.S
+++ work/arch/sh/kernel/cpu/shmobile/sleep.S	2009-10-29 16:57:25.000000000 +0900
@@ -52,6 +52,57 @@ ENTRY(sh_mobile_sleep_enter_start)
 	bsr     save_register
 	 mov    #SH_SLEEP_REG_STBCR, r0
 
+	/* save mmu and cache context if needed */
+	mov.l	@(SH_SLEEP_MODE, r5), r0
+	tst	#SUSP_SH_MMU, r0
+	bt	skip_mmu_save_disable
+
+       /* save mmu state */
+	bsr	save_register
+	 mov	#SH_SLEEP_REG_PTEH, r0
+
+	bsr	save_register
+	 mov	#SH_SLEEP_REG_PTEL, r0
+
+	bsr	save_register
+	 mov	#SH_SLEEP_REG_TTB, r0
+
+	bsr	save_register
+	 mov	#SH_SLEEP_REG_TEA, r0
+
+	bsr	save_register
+	 mov	#SH_SLEEP_REG_MMUCR, r0
+
+	bsr	save_register
+	 mov	#SH_SLEEP_REG_PTEA, r0
+
+	bsr	save_register
+	 mov	#SH_SLEEP_REG_PASCR, r0
+
+	bsr	save_register
+	 mov	#SH_SLEEP_REG_IRMCR, r0
+
+	/* invalidate TLBs and disable the MMU */
+	bsr	get_register
+	 mov	#SH_SLEEP_REG_MMUCR, r0
+	mov	#4, r1
+	mov.l	r1, @r0
+	icbi	@r0
+
+	/* save cache registers and disable caches */
+	bsr	save_register
+	 mov	#SH_SLEEP_REG_CCR, r0
+
+	bsr	save_register
+	 mov	#SH_SLEEP_REG_RAMCR, r0
+
+	bsr	get_register
+	 mov	#SH_SLEEP_REG_CCR, r0
+	mov	#0, r1
+	mov.l	r1, @r0
+	icbi	@r0
+
+skip_mmu_save_disable:
 	/* call self-refresh entering code if needed */
 	mov.l	@(SH_SLEEP_MODE, r5), r0
 	tst	#SUSP_SH_SF, r0
@@ -166,6 +217,47 @@ restore_jump_vbr:
 	 nop
 
 skip_restore_sf:
+	/* restore mmu and cache state if needed */
+	mov.l	@(SH_SLEEP_MODE, r5), r0
+	tst	#SUSP_SH_MMU, r0
+	bt	skip_restore_mmu
+
+	/* restore mmu state */
+	bsr	restore_register
+	 mov	#SH_SLEEP_REG_PTEH, r0
+
+	bsr	restore_register
+	 mov	#SH_SLEEP_REG_PTEL, r0
+
+	bsr	restore_register
+	 mov	#SH_SLEEP_REG_TTB, r0
+
+	bsr	restore_register
+	 mov	#SH_SLEEP_REG_TEA, r0
+
+	bsr	restore_register
+	 mov	#SH_SLEEP_REG_PTEA, r0
+
+	bsr	restore_register
+	 mov	#SH_SLEEP_REG_PASCR, r0
+
+	bsr	restore_register
+	 mov	#SH_SLEEP_REG_IRMCR, r0
+
+	bsr	restore_register
+	 mov	#SH_SLEEP_REG_MMUCR, r0
+	icbi	@r0
+
+	/* restore cache settings */
+	bsr	restore_register
+	 mov	#SH_SLEEP_REG_RAMCR, r0
+	icbi	@r0
+
+	bsr	restore_register
+	 mov	#SH_SLEEP_REG_CCR, r0
+	icbi	@r0
+
+skip_restore_mmu:
 	rte
 	 nop
 
