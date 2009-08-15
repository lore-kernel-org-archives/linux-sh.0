From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 15 Aug 2009 02:53:42 +0000
Subject: [PATCH 04/04] sh: sh7724 ddr self-refresh changes
Message-Id: <20090815025342.8125.7783.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch updates the SuperH Mobile sleep assembly code with
support for DBSC memory controller found in the sh7724 processor.

Without this fix the memory hooked up to the sh7724 processor
will never enter self-refresh mode before suspending to ram. The
effect of this is that the memory contents most likeley will be
lost upon resume which may or may not be what you want.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/shmobile/sleep.S |   70 ++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 2 deletions(-)

--- 0001/arch/sh/kernel/cpu/shmobile/sleep.S
+++ work/arch/sh/kernel/cpu/shmobile/sleep.S	2009-08-14 12:36:40.000000000 +0900
@@ -26,8 +26,30 @@ ENTRY(sh_mobile_standby)
 
 	tst	#SUSP_SH_SF, r0
 	bt	skip_set_sf
+#ifdef CONFIG_CPU_SUBTYPE_SH7724
+	/* DBSC: put memory in self-refresh mode */
 
-	/* SDRAM: disable power down and put in self-refresh mode */
+	mov.l	dben_reg, r4
+	mov.l	dben_data0, r1
+	mov.l	r1, @r4
+
+	mov.l	dbrfpdn0_reg, r4
+	mov.l	dbrfpdn0_data0, r1
+	mov.l	r1, @r4
+
+	mov.l	dbcmdcnt_reg, r4
+	mov.l	dbcmdcnt_data0, r1
+	mov.l	r1, @r4
+
+	mov.l	dbcmdcnt_reg, r4
+	mov.l	dbcmdcnt_data1, r1
+	mov.l	r1, @r4
+
+	mov.l	dbrfpdn0_reg, r4
+	mov.l	dbrfpdn0_data1, r1
+	mov.l	r1, @r4
+#else
+	/* SBSC: disable power down and put in self-refresh mode */
 	mov.l	1f, r4
 	mov.l	2f, r1
 	mov.l	@r4, r2
@@ -35,6 +57,7 @@ ENTRY(sh_mobile_standby)
 	mov.l   3f, r3
 	and	r3, r2
 	mov.l	r2, @r4
+#endif
 
 skip_set_sf:
 	tst	#SUSP_SH_SLEEP, r0
@@ -84,7 +107,36 @@ done_sleep:
 	tst	#SUSP_SH_SF, r0
 	bt	skip_restore_sf
 
-	/* SDRAM: set auto-refresh mode */
+#ifdef CONFIG_CPU_SUBTYPE_SH7724
+	/* DBSC: put memory in auto-refresh mode */
+
+	mov.l	dbrfpdn0_reg, r4
+	mov.l	dbrfpdn0_data0, r1
+	mov.l	r1, @r4
+
+	/* sleep 140 ns */
+	nop
+	nop
+	nop
+	nop
+
+	mov.l	dbcmdcnt_reg, r4
+	mov.l	dbcmdcnt_data0, r1
+	mov.l	r1, @r4
+
+	mov.l	dbcmdcnt_reg, r4
+	mov.l	dbcmdcnt_data1, r1
+	mov.l	r1, @r4
+
+	mov.l	dben_reg, r4
+	mov.l	dben_data1, r1
+	mov.l	r1, @r4
+
+	mov.l	dbrfpdn0_reg, r4
+	mov.l	dbrfpdn0_data2, r1
+	mov.l	r1, @r4
+#else
+	/* SBSC: set auto-refresh mode */
 	mov.l	1f, r4
 	mov.l	@r4, r2
 	mov.l   4f, r3
@@ -98,15 +150,29 @@ done_sleep:
 	add	r4, r3
 	or	r2, r3
 	mov.l	r3, @r1
+#endif
 skip_restore_sf:
 	rts
 	 nop
 
 	.balign 4
+#ifdef CONFIG_CPU_SUBTYPE_SH7724
+dben_reg:	.long	0xfd000010 /* DBEN */
+dben_data0:	.long	0
+dben_data1:	.long	1
+dbrfpdn0_reg:	.long	0xfd000040 /* DBRFPDN0 */
+dbrfpdn0_data0:	.long	0
+dbrfpdn0_data1:	.long	1
+dbrfpdn0_data2:	.long	0x00010000
+dbcmdcnt_reg:	.long	0xfd000014 /* DBCMDCNT */
+dbcmdcnt_data0:	.long	2
+dbcmdcnt_data1:	.long	4
+#else
 1:	.long	0xfe400008 /* SDCR0 */
 2:	.long	0x00000400
 3:	.long	0xffff7fff
 4:	.long	0xfffffbff
+#endif
 5:	.long	0xa4150020 /* STBCR */
 6:	.long   0xfe40001c /* RTCOR */
 7:	.long   0xfe400018 /* RTCNT */
