From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 21 Mar 2008 09:43:19 +0000
Subject: [PATCH 01/06] sh: Add MigoR header file
Message-Id: <20080321094319.10532.87404.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds a MigoR specific header file. We may want to use a cpu
specific header file instead, but this will do for now.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/renesas/migor/setup.c |    9 -----
 include/asm-sh/migor.h               |   58 ++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 8 deletions(-)

--- 0001/arch/sh/boards/renesas/migor/setup.c
+++ work/arch/sh/boards/renesas/migor/setup.c	2008-03-20 22:20:13.000000000 +0900
@@ -14,6 +14,7 @@
 #include <asm/machvec.h>
 #include <asm/io.h>
 #include <asm/sh_keysc.h>
+#include <asm/migor.h>
 
 /* Address     IRQ  Size  Bus  Description
  * 0x00000000       64MB  16   NOR Flash (SP29PL256N)
@@ -87,14 +88,6 @@ static int __init migor_devices_setup(vo
 }
 __initcall(migor_devices_setup);
 
-#define PORT_PJCR       0xA4050110UL
-#define PORT_PSELA      0xA405014EUL
-#define PORT_PYCR       0xA405014AUL
-#define PORT_PZCR       0xA405014CUL
-#define PORT_HIZCRA     0xA4050158UL
-#define PORT_HIZCRC     0xA405015CUL
-#define MSTPCR2         0xA4150038UL
-
 static void __init migor_setup(char **cmdline_p)
 {
 	/* SMC91C111 - Enable IRQ0 */
--- /dev/null
+++ work/include/asm-sh/migor.h	2008-03-20 23:27:39.000000000 +0900
@@ -0,0 +1,58 @@
+#ifndef __ASM_SH_MIGOR_H
+#define __ASM_SH_MIGOR_H
+
+/*
+ * linux/include/asm-sh/migor.h
+ *
+ * Copyright (C) 2008 Renesas Solutions
+ *
+ * Portions Copyright (C) 2007 Nobuhiro Iwamatsu
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ */
+#include <asm/addrspace.h>
+
+/* GPIO */
+#define MSTPCR0 0xa4150030
+#define MSTPCR1 0xa4150034
+#define MSTPCR2 0xa4150038
+
+#define PORT_PACR 0xa4050100
+#define PORT_PDCR 0xa4050106
+#define PORT_PECR 0xa4050108
+#define PORT_PHCR 0xa405010e
+#define PORT_PJCR 0xa4050110
+#define PORT_PKCR 0xa4050112
+#define PORT_PLCR 0xa4050114
+#define PORT_PMCR 0xa4050116
+#define PORT_PRCR 0xa405011c
+#define PORT_PWCR 0xa4050146
+#define PORT_PXCR 0xa4050148
+#define PORT_PYCR 0xa405014a
+#define PORT_PZCR 0xa405014c
+#define PORT_PADR 0xa4050120
+#define PORT_PWDR 0xa4050166
+
+#define PORT_HIZCRA 0xa4050158
+#define PORT_HIZCRC 0xa405015c
+
+#define PORT_MSELCRB 0xa4050182
+
+#define MSTPCR1 0xa4150034
+#define MSTPCR2 0xa4150038
+
+#define PORT_PSELA 0xa405014e
+#define PORT_PSELB 0xa4050150
+#define PORT_PSELC 0xa4050152
+#define PORT_PSELD 0xa4050154
+
+#define PORT_HIZCRA 0xa4050158
+#define PORT_HIZCRB 0xa405015a
+#define PORT_HIZCRC 0xa405015c
+
+#define BSC_CS6ABCR 0xfec1001c
+
+#endif /* __ASM_SH_MIGOR_H */
