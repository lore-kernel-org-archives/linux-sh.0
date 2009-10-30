From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 30 Oct 2009 04:23:59 +0000
Subject: [PATCH 03/09] sh: Add Ecovec24 specific memory pre/post sleep code
Message-Id: <20091030042359.11783.23483.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add self-refresh handling code for the Ecovec24 board.  

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/mach-ecovec24/Makefile |    1 
 arch/sh/boards/mach-ecovec24/sdram.S  |   52 +++++++++++++++++++++++++++++++++
 arch/sh/boards/mach-ecovec24/setup.c  |   14 ++++++++
 3 files changed, 66 insertions(+), 1 deletion(-)

--- 0001/arch/sh/boards/mach-ecovec24/Makefile
+++ work/arch/sh/boards/mach-ecovec24/Makefile	2009-10-30 12:51:03.000000000 +0900
@@ -6,4 +6,4 @@
 # for more details.
 #
 
-obj-y	 := setup.o
\ No newline at end of file
+obj-y	 := setup.o sdram.o
\ No newline at end of file
--- /dev/null
+++ work/arch/sh/boards/mach-ecovec24/sdram.S	2009-10-30 12:49:39.000000000 +0900
@@ -0,0 +1,52 @@
+/*
+ * Ecovec24 sdram self/auto-refresh setup code
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
+#include <asm/romimage-macros.h>
+
+/* code to enter and leave self-refresh. must be self-contained.
+ * this code will be copied to on-chip memory and executed from there.
+ */
+	.balign 4
+ENTRY(ecovec24_sdram_enter_start)
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
+ENTRY(ecovec24_sdram_enter_end)
+
+	.balign 4
+ENTRY(ecovec24_sdram_leave_start)
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
+ENTRY(ecovec24_sdram_leave_end)
--- 0001/arch/sh/boards/mach-ecovec24/setup.c
+++ work/arch/sh/boards/mach-ecovec24/setup.c	2009-10-30 12:50:48.000000000 +0900
@@ -26,6 +26,7 @@
 #include <asm/sh_eth.h>
 #include <asm/sh_keysc.h>
 #include <asm/clock.h>
+#include <asm/suspend.h>
 #include <cpu/sh7724.h>
 
 /*
@@ -526,8 +527,21 @@ static void __init sh_eth_init(struct sh
 
 #define PORT_HIZA 0xA4050158
 #define IODRIVEA  0xA405018A
+
+extern char ecovec24_sdram_enter_start;
+extern char ecovec24_sdram_enter_end;
+extern char ecovec24_sdram_leave_start;
+extern char ecovec24_sdram_leave_end;
+
 static int __init arch_setup(void)
 {
+	/* register board specific self-refresh code */
+	sh_mobile_register_self_refresh(SUSP_SH_STANDBY | SUSP_SH_SF,
+					&ecovec24_sdram_enter_start,
+					&ecovec24_sdram_enter_end,
+					&ecovec24_sdram_leave_start,
+					&ecovec24_sdram_leave_end);
+
 	/* enable STATUS0, STATUS2 and PDSTATUS */
 	gpio_request(GPIO_FN_STATUS0, NULL);
 	gpio_request(GPIO_FN_STATUS2, NULL);
