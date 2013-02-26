From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 26 Feb 2013 02:55:20 +0000
Subject: [PATCH 01/03] ARM: shmobile: irq_pin() for static IRQ pin assignment
Message-Id: <20130226030059.9682.28722.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add the macro irq_pin() to let board-specific code using
platform devices tie in external IRQn pins in a common way.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/irqs.h |    4 ++++
 1 file changed, 4 insertions(+)

--- 0001/arch/arm/mach-shmobile/include/mach/irqs.h
+++ work/arch/arm/mach-shmobile/include/mach/irqs.h	2013-02-15 23:19:52.000000000 +0900
@@ -11,4 +11,8 @@
 #define INTCS_VECT(n, vect)	INTC_VECT((n), INTCS_VECT_BASE + (vect))
 #define intcs_evt2irq(evt)	evt2irq(INTCS_VECT_BASE + (evt))
 
+/* External IRQ pins */
+#define IRQPIN_BASE		2000
+#define irq_pin(nr)		((nr) + IRQPIN_BASE)
+
 #endif /* __ASM_MACH_IRQS_H */
