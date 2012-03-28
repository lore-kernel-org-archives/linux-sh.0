From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 28 Mar 2012 10:22:38 +0000
Subject: [PATCH 02/06] ARM: mach-shmobile: Use NR_IRQS_LEGACY as IRQ offset
Message-Id: <20120328102238.18870.85134.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20120328064034.28557.13697.sendpatchset@w520>
In-Reply-To: <20120328064034.28557.13697.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Use NR_IRQS_LEGACY as INTC IRQ offset on mach-shmobile.

This moves up the INTC vector 0x0200 from Linux interrupt 0
to NR_IRQS_LEGACY which is set to 16 for the ARM architecture.

Without this change it is impossible to allocate vector 0x0200
together with upcoming IRQ domain support.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/entry-intc.S        |    2 ++
 arch/arm/mach-shmobile/include/mach/irqs.h |    6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

--- 0001/arch/arm/mach-shmobile/entry-intc.S
+++ work/arch/arm/mach-shmobile/entry-intc.S	2012-03-27 17:03:51.000000000 +0900
@@ -9,6 +9,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <asm/irq.h>
 #include <asm/entry-macro-multi.S>
 
 #define INTCA_BASE	0xe6980000
@@ -44,6 +45,7 @@
 	/* Convert vector to irq number, same as the evt2irq() macro */
 	lsr	\irqnr, \irqnr, #0x5
 	subs	\irqnr, \irqnr, #16
+	adds	\irqnr, \irqnr, #NR_IRQS_LEGACY
 
 1000:
 	.endm
--- 0001/arch/arm/mach-shmobile/include/mach/irqs.h
+++ work/arch/arm/mach-shmobile/include/mach/irqs.h	2012-03-27 17:03:41.000000000 +0900
@@ -1,14 +1,16 @@
 #ifndef __ASM_MACH_IRQS_H
 #define __ASM_MACH_IRQS_H
 
+#include <asm/irq.h>
+
 #define NR_IRQS         1024
 
 /* GIC */
 #define gic_spi(nr)		((nr) + 32)
 
 /* INTCA */
-#define evt2irq(evt)		(((evt) >> 5) - 16)
-#define irq2evt(irq)		(((irq) + 16) << 5)
+#define evt2irq(evt)		(NR_IRQS_LEGACY + ((evt) >> 5) - 16)
+#define irq2evt(irq)		(((irq) + 16 - NR_IRQS_LEGACY) << 5)
 
 /* INTCS */
 #define INTCS_VECT_BASE		0x2200
