From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 14 Oct 2009 10:18:47 +0000
Subject: [PATCH 03/07] sh: Add save/restore sleep code for MMU/cache
Message-Id: <20091014101847.21842.39050.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add experimental restore/save code for MMU and Cache registers.
In the future it is most likely better to handle this somewhere
else than from the on-chip memory.

Not-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/suspend.h       |    1 
 arch/sh/kernel/cpu/shmobile/pm.c    |    5 +
 arch/sh/kernel/cpu/shmobile/sleep.S |  147 ++++++++++++++++++++++++++++++++++-
 3 files changed, 152 insertions(+), 1 deletion(-)

--- 0001/arch/sh/include/asm/suspend.h
+++ work/arch/sh/include/asm/suspend.h	2009-10-13 14:49:52.000000000 +0900
@@ -27,5 +27,6 @@ static inline void sh_mobile_setup_cpuid
 #define SUSP_SH_RSTANDBY	(1 << 2) /* SH-Mobile R-standby mode */
 #define SUSP_SH_USTANDBY	(1 << 3) /* SH-Mobile U-standby mode */
 #define SUSP_SH_SF		(1 << 4) /* Enable self-refresh */
+#define SUSP_SH_MMU		(1 << 5) /* Save/Restore MMU */
 
 #endif /* _ASM_SH_SUSPEND_H */
--- 0003/arch/sh/kernel/cpu/shmobile/pm.c
+++ work/arch/sh/kernel/cpu/shmobile/pm.c	2009-10-13 17:35:23.000000000 +0900
@@ -14,6 +14,7 @@
 #include <linux/io.h>
 #include <linux/suspend.h>
 #include <asm/suspend.h>
+#include <asm/cacheflush.h>
 #include <asm/uaccess.h>
 
 /*
@@ -48,6 +49,10 @@ void sh_mobile_call_standby(unsigned lon
 	void *onchip_mem = (void *)RAM_BASE;
 	void (*standby_onchip_mem)(unsigned long, unsigned long) = onchip_mem;
 
+	/* flush the caches if MMU flag is set */
+	if (mode & SUSP_SH_MMU)
+		flush_cache_all();
+
 	/* Let assembly snippet in on-chip memory handle the rest */
 	standby_onchip_mem(mode, RAM_BASE);
 }
--- 0001/arch/sh/kernel/cpu/shmobile/sleep.S
+++ work/arch/sh/kernel/cpu/shmobile/sleep.S	2009-10-13 17:36:18.000000000 +0900
@@ -58,6 +58,76 @@ ENTRY(sh_mobile_standby)
 	/* put mode flags in r0 */
 	mov	r4, r0
 
+	/* save MMU state */
+	tst	#SUSP_SH_MMU, r0
+	bt	skip_mmu_save_disable
+
+	mov.l   pteh_reg, r0
+	mov.l   @r0, r1
+	mova    pteh_data, r0
+	mov.l   r1, @r0
+
+	mov.l   ptel_reg, r0
+	mov.l   @r0, r1
+	mova    ptel_data, r0
+	mov.l   r1, @r0
+
+	mov.l   ttb_reg, r0
+	mov.l   @r0, r1
+	mova    ttb_data, r0
+	mov.l   r1, @r0
+	
+	mov.l   tea_reg, r0
+	mov.l   @r0, r1
+	mova    tea_data, r0
+	mov.l   r1, @r0
+
+	mov.l   mmucr_reg, r0
+	mov.l   @r0, r1
+	mova    mmucr_data, r0
+	mov.l   r1, @r0
+
+	mov.l   ptea_reg, r0
+	mov.l   @r0, r1
+	mova    ptea_data, r0
+	mov.l   r1, @r0
+
+	mov.l   pascr_reg, r0
+	mov.l   @r0, r1
+	mova    pascr_data, r0
+	mov.l   r1, @r0
+	
+	mov.l   irmcr_reg, r0
+	mov.l   @r0, r1
+	mova    irmcr_data, r0
+	mov.l   r1, @r0
+       
+	/* invalidate TLBs and disable the MMU */
+	mov     #4, r1
+	mov.l   mmucr_reg, r0
+	mov.l   r1, @r0
+	icbi    @r0
+
+	/* save cache registers and disable caches */
+	mov.l   ccr_reg, r0
+	mov.l   @r0, r1
+	mova    ccr_data, r0
+	mov.l   r1, @r0
+
+	mov.l   ramcr_reg, r0
+	mov.l   @r0, r1
+	mova    ramcr_data, r0
+	mov.l   r1, @r0
+
+	mov.l   ccr_reg, r0
+	mov     #0, r1
+	mov.l   r1, @r0
+	icbi    @r0
+
+skip_mmu_save_disable:
+	/* put mode flags in r0 */
+	mov	r4, r0
+
 	tst	#SUSP_SH_SF, r0
 	bt	skip_set_sf
 #ifdef CONFIG_CPU_SUBTYPE_SH7724
@@ -146,12 +216,64 @@ restore_jump_vbr:
 	/* get mode flags */
 	mov.l	saved_mode, k0
 
-done_sleep:
+	/* restore MMU configuration */
+	tst	#SUSP_SH_MMU, k0
+	bt	skip_mmu_restore
+
+	mov.l   pteh_reg, k4
+	mov.l   pteh_data, k1
+	mov.l   k1, @k4
+
+	mov.l   ptel_reg, k4
+	mov.l   ptel_data, k1
+	mov.l   k1, @k4
+
+	mov.l   ttb_reg, k4
+	mov.l   ttb_data, k1
+	mov.l   k1, @k4
+
+	mov.l   tea_reg, k4
+	mov.l   tea_data, k1
+	mov.l   k1, @k4
+
+	mov.l   ptea_reg, k4
+	mov.l   ptea_data, k1
+	mov.l   k1, @k4
+	
+	mov.l   pascr_reg, k4
+	mov.l   pascr_data, k1
+	mov.l   k1, @k4
+
+	mov.l   irmcr_reg, k4
+	mov.l   irmcr_data, k1
+	mov.l   k1, @k4
+
+	mov.l   mmucr_reg, k4
+	mov.l   mmucr_data, k1
+	mov.l   k1, @k4
+	icbi    @k4
+
+	/* restore cache settings */
+	mov.l   ramcr_reg, k4
+	mov.l   ramcr_data, k1
+	mov.l   k1, @k4
+	icbi    @k4
+
+	mov.l   ccr_reg, k4
+	mov.l   ccr_data, k1
+	mov.l   k1, @k4
+	icbi    @k4
+	
+skip_mmu_restore:
+	
 	/* reset standby mode to sleep mode */
 	mov.l	5f, k4
 	mov	#0x00, k1
 	mov.l	k1, @k4
 
+	/* get mode flags */
+	mov.l	saved_mode, k0
+
 	tst	#SUSP_SH_SF, k0
 	bt	skip_restore_sf
 
@@ -233,6 +355,29 @@ dbcmdcnt_data1:	.long	4
 7:	.long   0xfe400018 /* RTCNT */
 8:	.long   0xa55a0000
 
+/* MMU */
+pteh_reg:      .long   0xff000000 /* PTEH */
+pteh_data:     .long   0
+ptel_reg:      .long   0xff000004 /* PTEL */
+ptel_data:     .long   0
+ttb_reg:       .long   0xff000008 /* TTB */
+ttb_data:      .long   0
+tea_reg:       .long   0xff00000c /* TEA */
+tea_data:      .long   0
+mmucr_reg:     .long   0xff000010 /* MMUCR */
+mmucr_data:    .long   0
+ptea_reg:      .long   0xff000034 /* PTEA */
+ptea_data:     .long   0
+pascr_reg:     .long   0xff000070 /* PASCR */
+pascr_data:    .long   0
+irmcr_reg:     .long   0xff000078 /* IRMCR */
+irmcr_data:    .long   0
+
+/* Cache */
+ccr_reg:       .long   0xff00001c /* CCR */
+ccr_data:      .long   0
+ramcr_reg:     .long   0xff000074 /* RAMCR */
+ramcr_data:    .long   0
 
 /* interrupt vector @ 0x600 */
 	.balign 	0x400,0,0x400
