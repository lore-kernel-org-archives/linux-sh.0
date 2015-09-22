From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 22 Sep 2015 07:08:14 +0000
Subject: [PATCH v2 2/2] ARM: shmobile: Remove legacy mach/irqs.h
Message-Id: <1442905694-2317-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The header isn't needed anymore now that all SoCs use multiplatform
kernels. Remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/include/mach/irqs.h | 10 ----------
 arch/arm/mach-shmobile/irqs.h              | 15 ---------------
 arch/arm/mach-shmobile/setup-r8a7778.c     |  1 -
 3 files changed, 26 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-shmobile/irqs.h

diff --git a/arch/arm/mach-shmobile/include/mach/irqs.h b/arch/arm/mach-shmobile/include/mach/irqs.h
deleted file mode 100644
index 5aee83f079e2..000000000000
--- a/arch/arm/mach-shmobile/include/mach/irqs.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef __ASM_MACH_IRQS_H
-#define __ASM_MACH_IRQS_H
-
-/* Stuck here until drivers/pinctl/sh-pfc gets rid of legacy code */
-
-/* External IRQ pins */
-#define IRQPIN_BASE		2000
-#define irq_pin(nr)		((nr) + IRQPIN_BASE)
-
-#endif /* __ASM_MACH_IRQS_H */
diff --git a/arch/arm/mach-shmobile/irqs.h b/arch/arm/mach-shmobile/irqs.h
deleted file mode 100644
index 3070f6d887eb..000000000000
--- a/arch/arm/mach-shmobile/irqs.h
+++ /dev/null
@@ -1,15 +0,0 @@
-#ifndef __SHMOBILE_IRQS_H
-#define __SHMOBILE_IRQS_H
-
-#include "include/mach/irqs.h"
-
-/* GIC */
-#define gic_spi(nr)		((nr) + 32)
-#define gic_iid(nr)		(nr) /* ICCIAR / interrupt ID */
-
-/* GPIO IRQ */
-#define _GPIO_IRQ_BASE		2500
-#define GPIO_IRQ_BASE(x)	(_GPIO_IRQ_BASE + (32 * x))
-#define GPIO_IRQ(x, y)		(_GPIO_IRQ_BASE + (32 * x) + y)
-
-#endif /* __SHMOBILE_IRQS_H */
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index b0c9986d022d..008ea680fb8a 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -22,7 +22,6 @@
 #include <asm/mach/arch.h>
 
 #include "common.h"
-#include "irqs.h"
 
 #define MODEMR 0xffcc0020
 
-- 
2.4.6

