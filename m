From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 25 Feb 2010 11:07:52 +0000
Subject: [PATCH] sh: ecovec r-standby support
Message-Id: <20100225110752.6872.31582.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch adds board specific r-standby resume code
for ecovec.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/mach-ecovec24/sdram.S |   59 ++++++++++++++++++++++++++++++++++
 arch/sh/boards/mach-ecovec24/setup.c |    3 +
 2 files changed, 61 insertions(+), 1 deletion(-)

--- 0001/arch/sh/boards/mach-ecovec24/sdram.S
+++ work/arch/sh/boards/mach-ecovec24/sdram.S	2010-02-25 19:14:57.000000000 +0900
@@ -37,6 +37,10 @@ ENTRY(ecovec24_sdram_enter_end)
 	.balign 4
 ENTRY(ecovec24_sdram_leave_start)
 
+	mov.l	@(SH_SLEEP_MODE, r5), r0
+	tst	#SUSP_SH_RSTANDBY, r0
+	bf	resume_rstandby
+
 	/* DBSC: put memory in auto-refresh mode */
 
 	ED 0xFD000040, 0x00000000 /* DBRFPDN0 */
@@ -49,4 +53,59 @@ ENTRY(ecovec24_sdram_leave_start)
 	rts
 	 nop
 
+resume_rstandby:
+
+	/* DBSC: re-initialize and put in auto-refresh */
+
+	ED 0xFD000108, 0x00000181 /* DBPDCNT0 */
+	ED 0xFD000020, 0x015B0002 /* DBCONF */
+	ED 0xFD000030, 0x03071502 /* DBTR0 */
+	ED 0xFD000034, 0x02020102 /* DBTR1 */
+	ED 0xFD000038, 0x01090405 /* DBTR2 */
+	ED 0xFD00003C, 0x00000002 /* DBTR3 */
+	ED 0xFD000008, 0x00000005 /* DBKIND */
+	ED 0xFD000040, 0x00000001 /* DBRFPDN0 */
+	ED 0xFD000040, 0x00000000 /* DBRFPDN0 */
+	ED 0xFD000018, 0x00000001 /* DBCKECNT */
+
+	mov	#100,r0
+WAIT_400NS:
+	dt	r0
+	bf	WAIT_400NS
+
+	ED 0xFD000014, 0x00000002 /* DBCMDCNT (PALL) */
+	ED 0xFD000060, 0x00020000 /* DBMRCNT (EMR2) */
+	ED 0xFD000060, 0x00030000 /* DBMRCNT (EMR3) */
+	ED 0xFD000060, 0x00010004 /* DBMRCNT (EMR) */
+	ED 0xFD000060, 0x00000532 /* DBMRCNT (MRS) */
+	ED 0xFD000014, 0x00000002 /* DBCMDCNT (PALL) */
+	ED 0xFD000014, 0x00000004 /* DBCMDCNT (REF) */
+	ED 0xFD000014, 0x00000004 /* DBCMDCNT (REF) */
+	ED 0xFD000060, 0x00000432 /* DBMRCNT (MRS) */
+	ED 0xFD000060, 0x000103c0 /* DBMRCNT (EMR) */
+	ED 0xFD000060, 0x00010040 /* DBMRCNT (EMR) */
+
+	mov	#100,r0
+WAIT_400NS_2:
+	dt	r0
+	bf	WAIT_400NS_2
+
+	ED 0xFD000010, 0x00000001 /* DBEN */
+	ED 0xFD000044, 0x0000050f /* DBRFPDN1 */
+	ED 0xFD000048, 0x236800e6 /* DBRFPDN2 */
+
+	mov.l	DUMMY,r0
+	mov.l	@r0, r1 /* force single dummy read */
+
+	ED 0xFD000014, 0x00000002 /* DBCMDCNT (PALL) */
+	ED 0xFD000014, 0x00000004 /* DBCMDCNT (REF) */
+	ED 0xFD000108, 0x00000080 /* DBPDCNT0 */
+	ED 0xFD000040, 0x00010000 /* DBRFPDN0 */
+
+	rts
+	 nop
+
+	.balign 4
+DUMMY:	.long	0xac400000
+
 ENTRY(ecovec24_sdram_leave_end)
--- 0001/arch/sh/boards/mach-ecovec24/setup.c
+++ work/arch/sh/boards/mach-ecovec24/setup.c	2010-02-25 19:21:46.000000000 +0900
@@ -829,7 +829,8 @@ static int __init arch_setup(void)
 	struct clk *clk;
 
 	/* register board specific self-refresh code */
-	sh_mobile_register_self_refresh(SUSP_SH_STANDBY | SUSP_SH_SF,
+	sh_mobile_register_self_refresh(SUSP_SH_STANDBY | SUSP_SH_SF |
+					SUSP_SH_RSTANDBY,
 					&ecovec24_sdram_enter_start,
 					&ecovec24_sdram_enter_end,
 					&ecovec24_sdram_leave_start,
