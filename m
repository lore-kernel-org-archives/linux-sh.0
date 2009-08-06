From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 06 Aug 2009 15:16:29 +0000
Subject: [PATCH] sh: clean up Migo-R header file
Message-Id: <20090806151629.5142.26006.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch moves the Migo-R specific header file from
mach-common/ into mach-migor/ and removes unused cruft.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/include/mach-common/mach/migor.h |   64 ------------------------------
 arch/sh/include/mach-migor/mach/migor.h  |   14 ++++++
 2 files changed, 14 insertions(+), 64 deletions(-)

--- 0001/arch/sh/include/mach-common/mach/migor.h
+++ /dev/null	2009-08-04 09:21:32.824030158 +0900
@@ -1,64 +0,0 @@
-#ifndef __ASM_SH_MIGOR_H
-#define __ASM_SH_MIGOR_H
-
-/*
- * linux/include/asm-sh/migor.h
- *
- * Copyright (C) 2008 Renesas Solutions
- *
- * Portions Copyright (C) 2007 Nobuhiro Iwamatsu
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- */
-#include <asm/addrspace.h>
-
-/* GPIO */
-#define PORT_PACR 0xa4050100
-#define PORT_PDCR 0xa4050106
-#define PORT_PECR 0xa4050108
-#define PORT_PHCR 0xa405010e
-#define PORT_PJCR 0xa4050110
-#define PORT_PKCR 0xa4050112
-#define PORT_PLCR 0xa4050114
-#define PORT_PMCR 0xa4050116
-#define PORT_PRCR 0xa405011c
-#define PORT_PTCR 0xa4050140
-#define PORT_PUCR 0xa4050142
-#define PORT_PVCR 0xa4050144
-#define PORT_PWCR 0xa4050146
-#define PORT_PXCR 0xa4050148
-#define PORT_PYCR 0xa405014a
-#define PORT_PZCR 0xa405014c
-#define PORT_PADR 0xa4050120
-#define PORT_PHDR 0xa405012e
-#define PORT_PTDR 0xa4050160
-#define PORT_PWDR 0xa4050166
-
-#define PORT_HIZCRA 0xa4050158
-#define PORT_HIZCRC 0xa405015c
-
-#define PORT_MSELCRB 0xa4050182
-
-#define PORT_PSELA 0xa405014e
-#define PORT_PSELB 0xa4050150
-#define PORT_PSELC 0xa4050152
-#define PORT_PSELD 0xa4050154
-#define PORT_PSELE 0xa4050156
-
-#define PORT_HIZCRA 0xa4050158
-#define PORT_HIZCRB 0xa405015a
-#define PORT_HIZCRC 0xa405015c
-
-#define BSC_CS4BCR 0xfec10010
-#define BSC_CS6ABCR 0xfec1001c
-#define BSC_CS4WCR 0xfec10030
-
-#include <video/sh_mobile_lcdc.h>
-
-int migor_lcd_qvga_setup(void *board_data, void *sys_ops_handle,
-			 struct sh_mobile_lcdc_sys_bus_ops *sys_ops);
-
-#endif /* __ASM_SH_MIGOR_H */
--- /dev/null
+++ work/arch/sh/include/mach-migor/mach/migor.h	2009-08-06 21:56:02.000000000 +0900
@@ -0,0 +1,14 @@
+#ifndef __ASM_SH_MIGOR_H
+#define __ASM_SH_MIGOR_H
+
+#define PORT_MSELCRB 0xa4050182
+#define BSC_CS4BCR 0xfec10010
+#define BSC_CS6ABCR 0xfec1001c
+#define BSC_CS4WCR 0xfec10030
+
+#include <video/sh_mobile_lcdc.h>
+
+int migor_lcd_qvga_setup(void *board_data, void *sys_ops_handle,
+			 struct sh_mobile_lcdc_sys_bus_ops *sys_ops);
+
+#endif /* __ASM_SH_MIGOR_H */
