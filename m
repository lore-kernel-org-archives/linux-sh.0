From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 14 Oct 2009 10:18:56 +0000
Subject: [PATCH 04/07] sh: Use immediate data for sh7724 DBSC
Message-Id: <20091014101856.21842.73069.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Use immediate data for the DBSC code to save a bit of space.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/shmobile/sleep.S |   28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

--- 0004/arch/sh/kernel/cpu/shmobile/sleep.S
+++ work/arch/sh/kernel/cpu/shmobile/sleep.S	2009-10-13 15:01:24.000000000 +0900
@@ -117,23 +117,23 @@ skip_mmu_save_disable:
 #ifdef CONFIG_CPU_SUBTYPE_SH7724
 	/* DBSC: put memory in self-refresh mode */
 	mov.l	dben_reg, r4
-	mov.l	dben_data0, r1
+	mov	#0, r1
 	mov.l	r1, @r4
 
 	mov.l	dbrfpdn0_reg, r4
-	mov.l	dbrfpdn0_data0, r1
+	mov	#0, r1
 	mov.l	r1, @r4
 
 	mov.l	dbcmdcnt_reg, r4
-	mov.l	dbcmdcnt_data0, r1
+	mov	#2, r1
 	mov.l	r1, @r4
 
 	mov.l	dbcmdcnt_reg, r4
-	mov.l	dbcmdcnt_data1, r1
+	mov	#4 r1
 	mov.l	r1, @r4
 
 	mov.l	dbrfpdn0_reg, r4
-	mov.l	dbrfpdn0_data1, r1
+	mov	#1, r1
 	mov.l	r1, @r4
 #else
 	/* SBSC: disable power down and put in self-refresh mode */
@@ -253,7 +253,7 @@ skip_mmu_restore:
 #ifdef CONFIG_CPU_SUBTYPE_SH7724
 	/* DBSC: put memory in auto-refresh mode */
 	mov.l	dbrfpdn0_reg, k4
-	mov.l	dbrfpdn0_data0, k1
+	mov	#0, k1
 	mov.l	k1, @k4
 
 	nop /* sleep 140 ns */
@@ -262,19 +262,19 @@ skip_mmu_restore:
 	nop
 
 	mov.l	dbcmdcnt_reg, k4
-	mov.l	dbcmdcnt_data0, k1
+	mov	#2, k1
 	mov.l	k1, @k4
 
 	mov.l	dbcmdcnt_reg, k4
-	mov.l	dbcmdcnt_data1, k1
+	mov	#4, k1
 	mov.l	k1, @k4
 
 	mov.l	dben_reg, k4
-	mov.l	dben_data1, k1
+	mov	#1, k1
 	mov.l	k1, @k4
 
 	mov.l	dbrfpdn0_reg, k4
-	mov.l	dbrfpdn0_data2, k1
+	mov.l	dbrfpdn0_data, k1
 	mov.l	k1, @k4
 #else
 	/* SBSC: set auto-refresh mode */
@@ -308,15 +308,9 @@ saved_vbr:	.long	0
 offset_vbr:	.long	0x600
 #ifdef CONFIG_CPU_SUBTYPE_SH7724
 dben_reg:	.long	0xfd000010 /* DBEN */
-dben_data0:	.long	0
-dben_data1:	.long	1
 dbrfpdn0_reg:	.long	0xfd000040 /* DBRFPDN0 */
-dbrfpdn0_data0:	.long	0
-dbrfpdn0_data1:	.long	1
-dbrfpdn0_data2:	.long	0x00010000
+dbrfpdn0_data:	.long	0x00010000
 dbcmdcnt_reg:	.long	0xfd000014 /* DBCMDCNT */
-dbcmdcnt_data0:	.long	2
-dbcmdcnt_data1:	.long	4
 #else
 1:	.long	0xfe400008 /* SDCR0 */
 2:	.long	0x00000400
