From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 10 Mar 2010 11:17:49 +0000
Subject: [PATCH] ARM: Add support for 10 hardirq bits
Message-Id: <20100310111749.18521.9002.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

This patch adds support for 10 hardirq bits to
the ARM architecture. Needed by the SH-Mobile
ARM processor sh7372 that has more than 512 IRQs.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/include/asm/hardirq.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- 0001/arch/arm/include/asm/hardirq.h
+++ work/arch/arm/include/asm/hardirq.h	2010-03-09 21:08:10.000000000 +0900
@@ -12,7 +12,9 @@ typedef struct {
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
-#if NR_IRQS > 256
+#if NR_IRQS > 512
+#define HARDIRQ_BITS	10
+#elif NR_IRQS > 256
 #define HARDIRQ_BITS	9
 #else
 #define HARDIRQ_BITS	8
