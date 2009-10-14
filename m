From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 14 Oct 2009 10:19:04 +0000
Subject: [PATCH 05/07] sh: Add save/restore sleep code for BSC/DBSC
Message-Id: <20091014101904.21842.85901.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add experimental restore/save code for the BSC and DBSC.
Only CS0 and the DBSC are handled at this point. The DBSC
really needs board specific parameters to work correctly
so we should tie in this as board-specific code somehow.

Not-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/suspend.h       |    1 
 arch/sh/kernel/cpu/shmobile/sleep.S |  216 ++++++++++++++++++++++++++++++++++-
 2 files changed, 215 insertions(+), 2 deletions(-)

--- 0004/arch/sh/include/asm/suspend.h
+++ work/arch/sh/include/asm/suspend.h	2009-10-13 15:04:33.000000000 +0900
@@ -28,5 +28,6 @@ static inline void sh_mobile_setup_cpuid
 #define SUSP_SH_USTANDBY	(1 << 3) /* SH-Mobile U-standby mode */
 #define SUSP_SH_SF		(1 << 4) /* Enable self-refresh */
 #define SUSP_SH_MMU		(1 << 5) /* Save/Restore MMU */
+#define SUSP_SH_BSC		(1 << 6) /* Save/Restore BSC */
 
 #endif /* _ASM_SH_SUSPEND_H */
--- 0005/arch/sh/kernel/cpu/shmobile/sleep.S
+++ work/arch/sh/kernel/cpu/shmobile/sleep.S	2009-10-13 15:32:50.000000000 +0900
@@ -112,6 +112,78 @@ skip_mmu_save_disable:
 	/* put mode flags in r0 */
 	mov	r4, r0
 
+	/* save BSC state */
+	tst	#SUSP_SH_BSC, r0
+	bt	skip_bsc_save
+
+	mov.l   cmncr_reg, r0
+	mov.l   @r0, r1
+	mova    cmncr_data, r0
+	mov.l   r1, @r0
+
+	mov.l   cs0bcr_reg, r0
+	mov.l   @r0, r1
+	mova    cs0bcr_data, r0
+	mov.l   r1, @r0
+       
+	mov.l   cs0wcr_reg, r0
+	mov.l   @r0, r1
+	mova    cs0wcr_data, r0
+	mov.l   r1, @r0
+
+#ifdef CONFIG_CPU_SUBTYPE_SH7724
+	/* save DBSC state */
+	mov.l   dbpdcnt0_reg, r0
+	mov.l   @r0, r1
+	mova    dbpdcnt0_data, r0
+	mov.l   r1, @r0
+
+	mov.l   dbconf_reg, r0
+	mov.l   @r0, r1
+	mova    dbconf_data, r0
+	mov.l   r1, @r0
+
+	mov.l   dbtr0_reg, r0
+	mov.l   @r0, r1
+	mova    dbtr0_data, r0
+	mov.l   r1, @r0
+
+	mov.l   dbtr1_reg, r0
+	mov.l   @r0, r1
+	mova    dbtr1_data, r0
+	mov.l   r1, @r0
+
+	mov.l   dbtr2_reg, r0
+	mov.l   @r0, r1
+	mova    dbtr2_data, r0
+	mov.l   r1, @r0
+
+	mov.l   dbtr3_reg, r0
+	mov.l   @r0, r1
+	mova    dbtr3_data, r0
+	mov.l   r1, @r0
+
+	mov.l   dbkind_reg, r0
+	mov.l   @r0, r1
+	mova    dbkind_data, r0
+	mov.l   r1, @r0
+
+	mov.l   dbrfpdn1_reg, r0
+	mov.l   @r0, r1
+	mova    dbrfpdn1_data, r0
+	mov.l   r1, @r0
+
+	mov.l   dbrfpdn2_reg, r0
+	mov.l   @r0, r1
+	mova    dbrfpdn2_data, r0
+	mov.l   r1, @r0
+#endif
+
+skip_bsc_save:
+
+	/* put mode flags in r0 */
+	mov	r4, r0
+
 	tst	#SUSP_SH_SF, r0
 	bt	skip_set_sf
 #ifdef CONFIG_CPU_SUBTYPE_SH7724
@@ -247,6 +319,113 @@ skip_mmu_restore:
 	/* get mode flags */
 	mov.l	saved_mode, k0
 
+	/* save BSC state */
+	tst	#SUSP_SH_BSC, k0
+	bt	skip_bsc_restore
+
+	/* restore BSC */
+	mov.l   mmselr_reg, k0
+	mov.l   mmselr_data, k1
+	mov.l   k1, @k0
+       
+	mov.l   cmncr_reg, k0
+	mov.l   cmncr_data, k1
+	mov.l   k1, @k0
+       
+	mov.l   cs0bcr_reg, k0
+	mov.l   cs0bcr_data, k1
+	mov.l   k1, @k0
+       
+	mov.l   cs0wcr_reg, k0
+	mov.l   cs0wcr_data, k1
+	mov.l   k1, @k0
+       
+	mov.l   cs0bcr_reg, k0
+	mov.l   cs0bcr_data, k1
+	mov.l   k1, @k0
+	
+#ifdef CONFIG_CPU_SUBTYPE_SH7724
+	/* restore DBSC */
+	mov.l   dbpdcnt0_reg, k0
+	mov.l   dbpdcnt0_data, k1
+	mov     #1, k4
+	or      k4, k1
+	mov.l   k1, @k0
+
+	mov.l   dbconf_reg, k0
+	mov.l   dbconf_data, k1
+	mov.l   k1, @k0
+
+	mov.l   dbtr0_reg, k0
+	mov.l   dbtr0_data, k1
+	mov.l   k1, @k0
+
+	mov.l   dbtr1_reg, k0
+	mov.l   dbtr1_data, k1
+	mov.l   k1, @k0
+
+	mov.l   dbtr2_reg, k0
+	mov.l   dbtr2_data, k1
+	mov.l   k1, @k0
+
+	mov.l   dbtr3_reg, k0
+	mov.l   dbtr3_data, k1
+	mov.l   k1, @k0
+
+	mov.l   dbkind_reg, k0
+	mov.l   dbkind_data, k1
+	mov.l   k1, @k0
+
+	mov.l   dbrfpdn0_reg, k0
+	mov     #1, k1
+	mov.l   k1, @k0
+
+	mov.l   dbrfpdn0_reg, k0
+	mov     #0, k1
+	mov.l   k1, @k0
+
+	mov.l   dbckecnt_reg, k0
+	mov     #1, k1
+	mov.l   k1, @k0
+
+        mov    #66, k4
+wait_again0:
+        nop
+        tst     k4, k4
+        bf/s    wait_again0
+         dt      k4
+
+	mov.l   dben_reg, k0
+	mov     #1, k1
+	mov.l   k1, @k0
+       
+	mov.l   dbrfpdn1_reg, k0
+	mov.l   dbrfpdn1_data, k1
+	mov.l   k1, @k0
+
+	mov.l   dbrfpdn2_reg, k0
+	mov.l   dbrfpdn2_data, k1
+	mov.l   k1, @k0
+
+	mov.l   dbcmdcnt_reg, k0
+	mov     #4, k1
+	mov.l   k1, @k0
+
+	mov.l   dbpdcnt0_reg, k0
+	mov.l   dbpdcnt0_data, k1
+	mov     #-2, k4
+	and     k4, k1
+	mov.l   k1, @k0
+
+	mov.l   dbrfpdn0_reg, k0
+	mov.l   dbrfpdn0_data, k1
+	mov.l   k1, @k0
+#endif
+
+skip_bsc_restore:
+	/* get mode flags */
+	mov.l	saved_mode, k0
+
 	tst	#SUSP_SH_SF, k0
 	bt	skip_restore_sf
 
@@ -308,8 +487,6 @@ saved_vbr:	.long	0
 offset_vbr:	.long	0x600
 #ifdef CONFIG_CPU_SUBTYPE_SH7724
 dben_reg:	.long	0xfd000010 /* DBEN */
-dbrfpdn0_reg:	.long	0xfd000040 /* DBRFPDN0 */
-dbrfpdn0_data:	.long	0x00010000
 dbcmdcnt_reg:	.long	0xfd000014 /* DBCMDCNT */
 #else
 1:	.long	0xfe400008 /* SDCR0 */
@@ -340,6 +517,41 @@ pascr_data:    .long   0
 irmcr_reg:     .long   0xff000078 /* IRMCR */
 irmcr_data:    .long   0
 
+/* BSC */
+cs0bcr_reg:    .long   0xfec10004
+cs0bcr_data:   .long   0
+cs0wcr_reg:    .long   0xfec10024
+cs0wcr_data:   .long   0
+mmselr_reg:    .long   0xff800020
+mmselr_data:   .long   0xa5a50000
+cmncr_reg:     .long   0xfec10000
+cmncr_data:    .long   0
+
+#ifdef CONFIG_CPU_SUBTYPE_SH7724
+/* DBSC */
+dbkind_reg:    .long   0xfd000008 /* DBKIND */
+dbkind_data:   .long   0
+dbckecnt_reg:  .long   0xfd000018 /* DBCKECNT */
+dbconf_reg:    .long   0xfd000020 /* DBCONF */
+dbconf_data:   .long   0
+dbtr0_reg:     .long   0xfd000030 /* DBTR0 */
+dbtr0_data:    .long   0
+dbtr1_reg:     .long   0xfd000034 /* DBTR1 */
+dbtr1_data:    .long   0
+dbtr2_reg:     .long   0xfd000038 /* DBTR2 */
+dbtr2_data:    .long   0
+dbtr3_reg:     .long   0xfd00003c /* DBTR3 */
+dbtr3_data:    .long   0
+dbrfpdn0_reg:  .long   0xfd000040 /* DBRFPDN0 */
+dbrfpdn0_data: .long   0x00010000
+dbrfpdn1_reg:  .long   0xfd000044 /* DBRFPDN1 */
+dbrfpdn1_data: .long   0
+dbrfpdn2_reg:  .long   0xfd000048 /* DBRFPDN2 */
+dbrfpdn2_data: .long   0
+dbpdcnt0_reg:  .long   0xfd000108 /* DBPDCNT0 */
+dbpdcnt0_data: .long   0
+#endif
+
 /* interrupt vector @ 0x600 */
 	.balign 	0x400,0,0x400
 	.long	0xdeadbeef
