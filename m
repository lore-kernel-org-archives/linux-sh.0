From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 29 Oct 2009 10:52:15 +0000
Subject: [PATCH 05/07] sh: Add kfr2r09 specific memory pre/post sleep code
Message-Id: <20091029105215.29078.73642.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add self-refresh handling code for the KFR2R09 board.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/mach-kfr2r09/Makefile |    2 -
 arch/sh/boards/mach-kfr2r09/sdram.S  |   52 ++++++++++++++++++++++++++++++++++
 arch/sh/boards/mach-kfr2r09/setup.c  |   13 ++++++++
 3 files changed, 66 insertions(+), 1 deletion(-)

--- 0001/arch/sh/boards/mach-kfr2r09/Makefile
+++ work/arch/sh/boards/mach-kfr2r09/Makefile	2009-10-29 16:53:19.000000000 +0900
@@ -1,2 +1,2 @@
-obj-y	 := setup.o
+obj-y	 := setup.o sdram.o
 obj-$(CONFIG_FB_SH_MOBILE_LCDC)	+=  lcd_wqvga.o
--- /dev/null
+++ work/arch/sh/boards/mach-kfr2r09/sdram.S	2009-10-29 16:54:57.000000000 +0900
@@ -0,0 +1,52 @@
+/*
+ * KFR2R09 sdram self/auto-refresh setup code
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
+ENTRY(kfr2r09_sdram_enter_start)
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
+ENTRY(kfr2r09_sdram_enter_end)
+
+	.balign 4
+ENTRY(kfr2r09_sdram_leave_start)
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
+ENTRY(kfr2r09_sdram_leave_end)
--- 0001/arch/sh/boards/mach-kfr2r09/setup.c
+++ work/arch/sh/boards/mach-kfr2r09/setup.c	2009-10-29 16:53:19.000000000 +0900
@@ -21,6 +21,7 @@
 #include <media/soc_camera.h>
 #include <media/sh_mobile_ceu.h>
 #include <video/sh_mobile_lcdc.h>
+#include <asm/suspend.h>
 #include <asm/clock.h>
 #include <asm/machvec.h>
 #include <asm/io.h>
@@ -444,8 +445,20 @@ static int kfr2r09_usb0_gadget_setup(voi
 	return 0;
 }
 
+extern char kfr2r09_sdram_enter_start;
+extern char kfr2r09_sdram_enter_end;
+extern char kfr2r09_sdram_leave_start;
+extern char kfr2r09_sdram_leave_end;
+
 static int __init kfr2r09_devices_setup(void)
 {
+	/* register board specific self-refresh code */
+	sh_mobile_register_self_refresh(SUSP_SH_STANDBY | SUSP_SH_SF,
+					&kfr2r09_sdram_enter_start,
+					&kfr2r09_sdram_enter_end,
+					&kfr2r09_sdram_leave_start,
+					&kfr2r09_sdram_leave_end);
+
 	/* enable SCIF1 serial port for YC401 console support */
 	gpio_request(GPIO_FN_SCIF1_RXD, NULL);
 	gpio_request(GPIO_FN_SCIF1_TXD, NULL);
