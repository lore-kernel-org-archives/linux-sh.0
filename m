From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 29 Oct 2009 10:52:23 +0000
Subject: [PATCH 06/07] sh: Add ms7724se specific memory pre/post sleep code
Message-Id: <20091029105223.29078.85437.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add self-refresh handling code for the MS7724SE board.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/mach-se/7724/Makefile |    1 
 arch/sh/boards/mach-se/7724/sdram.S  |   52 ++++++++++++++++++++++++++++++++++
 arch/sh/boards/mach-se/7724/setup.c  |   12 +++++++
 3 files changed, 64 insertions(+), 1 deletion(-)

--- 0001/arch/sh/boards/mach-se/7724/Makefile
+++ work/arch/sh/boards/mach-se/7724/Makefile	2009-10-29 18:08:47.000000000 +0900
@@ -7,4 +7,4 @@
 #
 #
 
-obj-y	 := setup.o irq.o
\ No newline at end of file
+obj-y	 := setup.o irq.o sdram.o
--- /dev/null
+++ work/arch/sh/boards/mach-se/7724/sdram.S	2009-10-29 18:12:13.000000000 +0900
@@ -0,0 +1,52 @@
+/*
+ * MS7724SE sdram self/auto-refresh setup code
+ *
+ *  Copyright (C) 2009 Magnus Damm
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/sys.h>
+#include <linux/errno.h>
+#include <linux/linkage.h>
+#include <asm/asm-offsets.h>
+#include <asm/suspend.h>
+#include <asm/partner-jet-macros.h>
+
+/* code to enter and leave self-refresh. must be self-contained.
+ * this code will be copied to on-chip memory and executed from there.
+ */
+	.balign 4
+ENTRY(ms7724se_sdram_enter_start)
+
+	/* DBSC: put memory in self-refresh mode */
+
+	ED 0xFD000010, 0x00000000 /* DBEN */
+	ED 0xFD000040, 0x00000000 /* DBRFPDN0 */
+	ED 0xFD000014, 0x00000002 /* DBCMDCNT (PALL) */
+	ED 0xFD000014, 0x00000004 /* DBCMDCNT (REF) */
+	ED 0xFD000040, 0x00000001 /* DBRFPDN0 */
+
+	rts
+	 nop
+
+ENTRY(ms7724se_sdram_enter_end)
+
+	.balign 4
+ENTRY(ms7724se_sdram_leave_start)
+
+	/* DBSC: put memory in auto-refresh mode */
+
+	ED 0xFD000040, 0x00000000 /* DBRFPDN0 */
+	WAIT 1
+	ED 0xFD000014, 0x00000002 /* DBCMDCNT (PALL) */
+	ED 0xFD000014, 0x00000004 /* DBCMDCNT (REF) */
+	ED 0xFD000010, 0x00000001 /* DBEN */
+	ED 0xFD000040, 0x00010000 /* DBRFPDN0 */
+
+	rts
+	 nop
+
+ENTRY(ms7724se_sdram_leave_end)
--- 0001/arch/sh/boards/mach-se/7724/setup.c
+++ work/arch/sh/boards/mach-se/7724/setup.c	2009-10-29 18:14:18.000000000 +0900
@@ -28,6 +28,7 @@
 #include <asm/sh_eth.h>
 #include <asm/clock.h>
 #include <asm/sh_keysc.h>
+#include <asm/suspend.h>
 #include <cpu/sh7724.h>
 #include <mach-se/mach/se7724.h>
 
@@ -566,11 +567,22 @@ static void __init sh_eth_init(void)
 #define SW41_G    0x4000
 #define SW41_H    0x8000
 
+extern char ms7724se_sdram_enter_start;
+extern char ms7724se_sdram_enter_end;
+extern char ms7724se_sdram_leave_start;
+extern char ms7724se_sdram_leave_end;
+
 static int __init devices_setup(void)
 {
 	u16 sw = ctrl_inw(SW4140); /* select camera, monitor */
 	struct clk *fsia_clk;
 
+	/* register board specific self-refresh code */
+	sh_mobile_register_self_refresh(SUSP_SH_STANDBY | SUSP_SH_SF,
+					&ms7724se_sdram_enter_start,
+					&ms7724se_sdram_enter_end,
+					&ms7724se_sdram_leave_start,
+					&ms7724se_sdram_leave_end);
 	/* Reset Release */
 	ctrl_outw(ctrl_inw(FPGA_OUT) &
 		  ~((1 << 1)  | /* LAN */
