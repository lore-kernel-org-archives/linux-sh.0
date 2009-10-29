From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 29 Oct 2009 10:52:31 +0000
Subject: [PATCH 07/07] sh: Add migor specific memory pre/post sleep code
Message-Id: <20091029105231.29078.66383.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add self-refresh handling code for the Migo-R board.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/mach-migor/Makefile |    2 -
 arch/sh/boards/mach-migor/sdram.S  |   69 ++++++++++++++++++++++++++++++++++++
 arch/sh/boards/mach-migor/setup.c  |   13 ++++++
 3 files changed, 82 insertions(+), 2 deletions(-)

--- 0001/arch/sh/boards/mach-migor/Makefile
+++ work/arch/sh/boards/mach-migor/Makefile	2009-10-29 19:09:03.000000000 +0900
@@ -1,2 +1,2 @@
-obj-y	 := setup.o
+obj-y	 := setup.o sdram.o
 obj-$(CONFIG_SH_MIGOR_QVGA)	+=  lcd_qvga.o
--- /dev/null
+++ work/arch/sh/boards/mach-migor/sdram.S	2009-10-29 19:14:42.000000000 +0900
@@ -0,0 +1,69 @@
+/*
+ * Migo-R sdram self/auto-refresh setup code
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
+ENTRY(migor_sdram_enter_start)
+
+	/* SBSC: disable power down and put in self-refresh mode */
+	mov.l	1f, r4
+	mov.l	2f, r1
+	mov.l	@r4, r2
+	or	r1, r2
+	mov.l   3f, r3
+	and	r3, r2
+	mov.l	r2, @r4
+
+	rts
+	 nop
+
+	.balign 4
+1:	.long	0xfe400008 /* SDCR0 */
+2:	.long	0x00000400
+3:	.long	0xffff7fff
+ENTRY(migor_sdram_enter_end)
+
+	.balign 4
+ENTRY(migor_sdram_leave_start)
+
+	/* SBSC: set auto-refresh mode */
+	mov.l	1f, r4
+	mov.l	@r4, r0
+	mov.l   4f, r1
+	and	r1, r0
+	mov.l	r0, @r4
+	mov.l	6f, r4
+	mov.l	8f, r0
+	mov.l	@r4, r1
+	mov	#-1, r4
+	add	r4, r1
+	or	r1, r0
+	mov.l	7f, r1
+	mov.l	r0, @r1
+
+	rts
+	 nop
+
+	.balign 4
+1:	.long	0xfe400008 /* SDCR0 */
+4:	.long	0xfffffbff
+6:	.long   0xfe40001c /* RTCOR */
+7:	.long   0xfe400018 /* RTCNT */
+8:	.long   0xa55a0000
+ENTRY(migor_sdram_leave_end)
--- 0001/arch/sh/boards/mach-migor/setup.c
+++ work/arch/sh/boards/mach-migor/setup.c	2009-10-29 19:13:53.000000000 +0900
@@ -26,6 +26,7 @@
 #include <asm/machvec.h>
 #include <asm/io.h>
 #include <asm/sh_keysc.h>
+#include <asm/suspend.h>
 #include <mach/migor.h>
 #include <cpu/sh7722.h>
 
@@ -478,9 +479,19 @@ static struct platform_device *migor_dev
 	&migor_camera[1],
 };
 
+extern char migor_sdram_enter_start;
+extern char migor_sdram_enter_end;
+extern char migor_sdram_leave_start;
+extern char migor_sdram_leave_end;
+
 static int __init migor_devices_setup(void)
 {
-
+	/* register board specific self-refresh code */
+	sh_mobile_register_self_refresh(SUSP_SH_STANDBY | SUSP_SH_SF,
+					&migor_sdram_enter_start,
+					&migor_sdram_enter_end,
+					&migor_sdram_leave_start,
+					&migor_sdram_leave_end);
 #ifdef CONFIG_PM
 	/* Let D11 LED show STATUS0 */
 	gpio_request(GPIO_FN_STATUS0, NULL);
