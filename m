From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 30 Oct 2009 04:24:48 +0000
Subject: [PATCH 09/09] sh: Add KFR2R09 specific memory pre/post R-standby code
Message-Id: <20091030042448.11783.78397.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add R-standby support to the KFR2R09 sdram code.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/mach-kfr2r09/sdram.S |   28 ++++++++++++++++++++++++++++
 arch/sh/boards/mach-kfr2r09/setup.c |    3 ++-
 2 files changed, 30 insertions(+), 1 deletion(-)

--- 0006/arch/sh/boards/mach-kfr2r09/sdram.S
+++ work/arch/sh/boards/mach-kfr2r09/sdram.S	2009-10-29 17:16:31.000000000 +0900
@@ -39,6 +39,10 @@ ENTRY(kfr2r09_sdram_leave_start)
 
 	/* DBSC: put memory in auto-refresh mode */
 
+	mov.l	@(SH_SLEEP_MODE, r5), r0
+	tst	#SUSP_SH_RSTANDBY, r0
+	bf	resume_rstandby
+
 	ED 0xFD000040, 0x00000000 /* DBRFPDN0 */
 	WAIT 1
 	ED 0xFD000014, 0x00000002 /* DBCMDCNT (PALL) */
@@ -49,4 +53,28 @@ ENTRY(kfr2r09_sdram_leave_start)
 	rts
 	 nop
 
+resume_rstandby:
+
+	/* DBSC: re-initialize and put in auto-refresh */
+
+	ED 0xFD000108, 0x40000301 /* DBPDCNT0 */
+	ED 0xFD000020, 0x011B0002 /* DBCONF */
+	ED 0xFD000030, 0x03060E02 /* DBTR0 */
+	ED 0xFD000034, 0x01020102 /* DBTR1 */
+	ED 0xFD000038, 0x01090406 /* DBTR2 */
+	ED 0xFD000008, 0x00000004 /* DBKIND */
+	ED 0xFD000040, 0x00000001 /* DBRFPDN0 */
+	ED 0xFD000040, 0x00000000 /* DBRFPDN0 */
+	ED 0xFD000018, 0x00000001 /* DBCKECNT */
+	WAIT 1
+	ED 0xFD000010, 0x00000001 /* DBEN */
+	ED 0xFD000044, 0x000004AF /* DBRFPDN1 */
+	ED 0xFD000048, 0x20CF0037 /* DBRFPDN2 */
+	ED 0xFD000014, 0x00000004 /* DBCMDCNT (REF) */
+	ED 0xFD000108, 0x40000300 /* DBPDCNT0 */
+	ED 0xFD000040, 0x00010000 /* DBRFPDN0 */
+
+	rts
+	 nop
+
 ENTRY(kfr2r09_sdram_leave_end)
--- 0006/arch/sh/boards/mach-kfr2r09/setup.c
+++ work/arch/sh/boards/mach-kfr2r09/setup.c	2009-10-29 17:11:14.000000000 +0900
@@ -453,7 +453,8 @@ extern char kfr2r09_sdram_leave_end;
 static int __init kfr2r09_devices_setup(void)
 {
 	/* register board specific self-refresh code */
-	sh_mobile_register_self_refresh(SUSP_SH_STANDBY | SUSP_SH_SF,
+	sh_mobile_register_self_refresh(SUSP_SH_STANDBY | SUSP_SH_SF |
+					SUSP_SH_RSTANDBY,
 					&kfr2r09_sdram_enter_start,
 					&kfr2r09_sdram_enter_end,
 					&kfr2r09_sdram_leave_start,
