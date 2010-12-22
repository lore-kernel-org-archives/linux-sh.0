From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 22 Dec 2010 12:17:09 +0000
Subject: [PATCH] ARM: mach-shmobile: Use shared GIC entry macros
Message-Id: <20101222121709.9942.76569.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Use the GIC demux code in asm/hardware/entry-macro-gic.S
on the R-Mobile / SH-Mobile processors.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends the following ARM patch:
 "[PATCH 01/07] ARM: Introduce asm/hardware/entry-macro-gic.S"
 http://www.arm.linux.org.uk/developer/patches/viewpatch.php?idd75/1

 arch/arm/mach-shmobile/include/mach/entry-macro-gic.S |   62 -----------------
 1 file changed, 1 insertion(+), 61 deletions(-)

--- 0001/arch/arm/mach-shmobile/include/mach/entry-macro-gic.S
+++ work/arch/arm/mach-shmobile/include/mach/entry-macro-gic.S	2010-12-22 21:09:21.000000000 +0900
@@ -16,6 +16,7 @@
  */
 #include <mach/hardware.h>
 #include <asm/hardware/gic.h>
+#include <asm/hardware/entry-macro-gic.S>
 
 	.macro  disable_fiq
 	.endm
@@ -26,64 +27,3 @@
 
 	.macro  arch_ret_to_user, tmp1, tmp2
 	.endm
-
-	/*
-	 * The interrupt numbering scheme is defined in the
-	 * interrupt controller spec.  To wit:
-	 *
-	 * Interrupts 0-15 are IPI
-	 * 16-28 are reserved
-	 * 29-31 are local.  We allow 30 to be used for the watchdog.
-	 * 32-1020 are global
-	 * 1021-1022 are reserved
-	 * 1023 is "spurious" (no interrupt)
-	 *
-	 * For now, we ignore all local interrupts so only return an
-	 * interrupt if it's between 30 and 1020.  The test_for_ipi
-	 * routine below will pick up on IPIs.
-	 *
-	 * A simple read from the controller will tell us the number of
-	 * the highest priority enabled interrupt.  We then just need to
-	 * check whether it is in the valid range for an IRQ (30-1020
-	 * inclusive).
-	 */
-
-	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-
-	ldr	\irqstat, [\base, #GIC_CPU_INTACK]
-	/* bits 12-10 = src CPU, 9-0 = int # */
-
-	ldr	\tmp, 21
-	bic	\irqnr, \irqstat, #0x1c00
-	cmp	\irqnr, #29
-	cmpcc	\irqnr, \irqnr
-	cmpne	\irqnr, \tmp
-	cmpcs	\irqnr, \irqnr
-
-	.endm
-
-	/*
-	 * We assume that irqstat (the raw value of the IRQ acknowledge
-	 * register) is preserved from the macro above.
-	 * If there is an IPI, we immediately signal end of interrupt on the
-	 * controller, since this requires the original irqstat value which
-	 * we won't easily be able to recreate later.
-	 */
-
-	.macro test_for_ipi, irqnr, irqstat, base, tmp
-	bic	\irqnr, \irqstat, #0x1c00
-	cmp	\irqnr, #16
-	strcc	\irqstat, [\base, #GIC_CPU_EOI]
-	cmpcs	\irqnr, \irqnr
-	.endm
-
-	/* As above, this assumes that irqstat and base are preserved.. */
-
-	.macro test_for_ltirq, irqnr, irqstat, base, tmp
-	bic	\irqnr, \irqstat, #0x1c00
-	mov 	\tmp, #0
-	cmp	\irqnr, #29
-	moveq	\tmp, #1
-	streq	\irqstat, [\base, #GIC_CPU_EOI]
-	cmp	\tmp, #0
-	.endm
