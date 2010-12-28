From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 28 Dec 2010 08:27:19 +0000
Subject: [PATCH 04/04] ARM: mach-shmobile: Rely on run-time IRQ handlers
Message-Id: <20101228082719.11806.65240.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Remove now unused IRQ demux code. All R-Mobile and
SH-Mobile processors should register IRQ demux
handlers during run-time.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/entry-macro-gic.S  |   29 -------
 arch/arm/mach-shmobile/include/mach/entry-macro-intc.S |   61 ----------------
 arch/arm/mach-shmobile/include/mach/entry-macro.S      |   23 ++++--
 arch/arm/mach-shmobile/include/mach/hardware.h         |    3 
 4 files changed, 18 insertions(+), 98 deletions(-)

--- 0005/arch/arm/mach-shmobile/include/mach/entry-macro-gic.S
+++ /dev/null	2010-12-20 11:05:22.086254221 +0900
@@ -1,29 +0,0 @@
-/*
- * Copyright (C) 2010 Renesas Solutions Corp.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-#include <mach/hardware.h>
-#include <asm/hardware/gic.h>
-#include <asm/hardware/entry-macro-gic.S>
-
-	.macro  disable_fiq
-	.endm
-
-	.macro	get_irqnr_preamble, base, tmp
-	ldr	\base, =(0xf0000100)
-	.endm
-
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
--- 0001/arch/arm/mach-shmobile/include/mach/entry-macro-intc.S
+++ /dev/null	2010-12-20 11:05:22.086254221 +0900
@@ -1,61 +0,0 @@
-/*
- * Copyright (C) 2010 Magnus Damm
- * Copyright (C) 2008 Renesas Solutions Corp.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-#include <mach/irqs.h>
-
-#define INTCA_BASE	0xe6980000
-#define INTFLGA_OFFS	0x00000018 /* accept pending interrupt */
-#define INTEVTA_OFFS	0x00000020 /* vector number of accepted interrupt */
-#define INTLVLA_OFFS	0x00000030 /* priority level of accepted interrupt */
-#define INTLVLB_OFFS	0x00000034 /* previous priority level */
-
-	.macro  disable_fiq
-	.endm
-
-	.macro  get_irqnr_preamble, base, tmp
-	ldr     \base, =INTCA_BASE
-	.endm
-
-	.macro  arch_ret_to_user, tmp1, tmp2
-	.endm
-
-	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
-	/* The single INTFLGA read access below results in the following:
-	 *
-	 * 1. INTLVLB is updated with old priority value from INTLVLA
-	 * 2. Highest priority interrupt is accepted
-	 * 3. INTLVLA is updated to contain priority of accepted interrupt
-	 * 4. Accepted interrupt vector is stored in INTFLGA and INTEVTA
-	 */
-	ldr     \irqnr, [\base, #INTFLGA_OFFS]
-
-	/* Restore INTLVLA with the value saved in INTLVLB.
-	 * This is required to support interrupt priorities properly.
-	 */
-	ldrb	\tmp, [\base, #INTLVLB_OFFS]
-	strb    \tmp, [\base, #INTLVLA_OFFS]
-
-	/* Handle invalid vector number case */
-	cmp	\irqnr, #0
-	beq	1000f
-
-	/* Convert vector to irq number, same as the evt2irq() macro */
-	lsr	\irqnr, \irqnr, #0x5
-	subs	\irqnr, \irqnr, #16
-
-1000:
-	.endm
--- 0001/arch/arm/mach-shmobile/include/mach/entry-macro.S
+++ work/arch/arm/mach-shmobile/include/mach/entry-macro.S	2010-12-28 14:57:19.000000000 +0900
@@ -14,8 +14,21 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
-#if defined(CONFIG_ARM_GIC)
-#include <mach/entry-macro-gic.S>
-#else
-#include <mach/entry-macro-intc.S>
-#endif
+
+	.macro  disable_fiq
+	.endm
+
+	.macro  get_irqnr_preamble, base, tmp
+	.endm
+
+	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
+	.endm
+
+	.macro  test_for_ipi, irqnr, irqstat, base, tmp
+	.endm
+
+	.macro  test_for_ltirq, irqnr, irqstat, base, tmp
+	.endm
+
+	.macro  arch_ret_to_user, tmp1, tmp2
+	.endm
--- 0001/arch/arm/mach-shmobile/include/mach/hardware.h
+++ work/arch/arm/mach-shmobile/include/mach/hardware.h	2010-12-28 14:57:35.000000000 +0900
@@ -1,7 +1,4 @@
 #ifndef __ASM_MACH_HARDWARE_H
 #define __ASM_MACH_HARDWARE_H
 
-/* INTFLGA register - used by low level interrupt code in entry-macro.S */
-#define INTFLGA			0xe6980018
-
 #endif /* __ASM_MACH_HARDWARE_H */
