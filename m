From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 11 Mar 2010 05:30:30 +0000
Subject: [PATCH] ARM: mach-shmobile: add INTCS macros
Message-Id: <20100311053030.26699.955.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add SH-Mobile ARM INTCS macros for the INTCS controller.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 No special dependencies.

 arch/arm/mach-shmobile/include/mach/irqs.h |    6 ++++++
 1 file changed, 6 insertions(+)

--- 0001/arch/arm/mach-shmobile/include/mach/irqs.h
+++ work/arch/arm/mach-shmobile/include/mach/irqs.h	2010-03-09 21:13:19.000000000 +0900
@@ -4,7 +4,13 @@
 #define NR_IRQS         512
 #define NR_IRQS_LEGACY  8
 
+/* INTCA */
 #define evt2irq(evt)		(((evt) >> 5) - 16)
 #define irq2evt(irq)		(((irq) + 16) << 5)
 
+/* INTCS */
+#define INTCS_VECT_BASE		0x3400
+#define INTCS_VECT(n, vect)	INTC_VECT((n), INTCS_VECT_BASE + (vect))
+#define intcs_evt2irq(evt)	evt2irq(INTCS_VECT_BASE + (evt))
+
 #endif /* __ASM_MACH_IRQS_H */
