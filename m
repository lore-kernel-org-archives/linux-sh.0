From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 30 Oct 2009 04:23:51 +0000
Subject: [PATCH 02/09] sh: Add ap325rxa specific memory pre/post sleep code
Message-Id: <20091030042351.11783.58274.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add self-refresh handling code for the AP325RXA board.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/mach-ap325rxa/Makefile |    2 
 arch/sh/boards/mach-ap325rxa/sdram.S  |   69 +++++++++++++++++++++++++++++++++
 arch/sh/boards/mach-ap325rxa/setup.c  |   13 ++++++
 3 files changed, 83 insertions(+), 1 deletion(-)

--- 0002/arch/sh/boards/mach-ap325rxa/Makefile
+++ work/arch/sh/boards/mach-ap325rxa/Makefile	2009-10-30 12:17:18.000000000 +0900
@@ -1,2 +1,2 @@
-obj-y	 := setup.o
+obj-y	 := setup.o sdram.o
 
--- /dev/null
+++ work/arch/sh/boards/mach-ap325rxa/sdram.S	2009-10-30 12:13:19.000000000 +0900
@@ -0,0 +1,69 @@
+/*
+ * AP325RXA sdram self/auto-refresh setup code
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
+ENTRY(ap325rxa_sdram_enter_start)
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
+ENTRY(ap325rxa_sdram_enter_end)
+
+	.balign 4
+ENTRY(ap325rxa_sdram_leave_start)
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
+ENTRY(ap325rxa_sdram_leave_end)
--- 0002/arch/sh/boards/mach-ap325rxa/setup.c
+++ work/arch/sh/boards/mach-ap325rxa/setup.c	2009-10-30 12:14:50.000000000 +0900
@@ -27,6 +27,7 @@
 #include <video/sh_mobile_lcdc.h>
 #include <asm/io.h>
 #include <asm/clock.h>
+#include <asm/suspend.h>
 #include <cpu/sh7723.h>
 
 static struct smsc911x_platform_config smsc911x_config = {
@@ -481,8 +482,20 @@ static struct platform_device *ap325rxa_
 	&ap325rxa_camera[1],
 };
 
+extern char ap325rxa_sdram_enter_start;
+extern char ap325rxa_sdram_enter_end;
+extern char ap325rxa_sdram_leave_start;
+extern char ap325rxa_sdram_leave_end;
+
 static int __init ap325rxa_devices_setup(void)
 {
+	/* register board specific self-refresh code */
+	sh_mobile_register_self_refresh(SUSP_SH_STANDBY | SUSP_SH_SF,
+					&ap325rxa_sdram_enter_start,
+					&ap325rxa_sdram_enter_end,
+					&ap325rxa_sdram_leave_start,
+					&ap325rxa_sdram_leave_end);
+
 	/* LD3 and LD4 LEDs */
 	gpio_request(GPIO_PTX5, NULL); /* RUN */
 	gpio_direction_output(GPIO_PTX5, 1);
