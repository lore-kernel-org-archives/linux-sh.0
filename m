From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 29 Sep 2008 10:46:26 +0000
Subject: [PATCH] sh: Rework sh7720 GPIO header usage
Message-Id: <20080929104626.5354.80315.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch reworks the sh7720 gpio includes. Makes space for the
generic GPIO code.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Compile tested with the magicpanelr2_defconfig.

 arch/sh/include/asm/gpio.h         |    8 --------
 arch/sh/include/asm/magicpanelr2.h |    2 +-
 drivers/serial/sh-sci.h            |    4 +++-
 3 files changed, 4 insertions(+), 10 deletions(-)

--- 0001/arch/sh/include/asm/gpio.h
+++ work/arch/sh/include/asm/gpio.h	2008-09-29 15:31:10.000000000 +0900
@@ -1,10 +1,6 @@
 /*
  *  include/asm-sh/gpio.h
  *
- *  Copyright (C) 2007 Markus Brunner, Mark Jonas
- *
- *  Addresses for the Pin Function Controller
- *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
@@ -12,8 +8,4 @@
 #ifndef __ASM_SH_GPIO_H
 #define __ASM_SH_GPIO_H
 
-#if defined(CONFIG_CPU_SH3)
-#include <cpu/gpio.h>
-#endif
-
 #endif /* __ASM_SH_GPIO_H */
--- 0001/arch/sh/include/asm/magicpanelr2.h
+++ work/arch/sh/include/asm/magicpanelr2.h	2008-09-29 15:31:10.000000000 +0900
@@ -13,7 +13,7 @@
 #ifndef __ASM_SH_MAGICPANELR2_H
 #define __ASM_SH_MAGICPANELR2_H
 
-#include <asm/gpio.h>
+#include <cpu-sh3/cpu/gpio.h>
 
 #define __IO_PREFIX mpr2
 #include <asm/io_generic.h>
--- 0001/drivers/serial/sh-sci.h
+++ work/drivers/serial/sh-sci.h	2008-09-29 15:31:10.000000000 +0900
@@ -1,7 +1,9 @@
 #include <linux/serial_core.h>
 #include <asm/io.h>
-#include <asm/gpio.h>
 
+#ifdef CONFIG_CPU_SH3
+#include <cpu-sh3/cpu/gpio.h>
+#endif
 #if defined(CONFIG_H83007) || defined(CONFIG_H83068)
 #include <asm/regs306x.h>
 #endif
