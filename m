From: Steve Glendinning <steve.glendinning@smsc.com>
Date: Sun, 23 Nov 2008 14:27:21 +0000
Subject: [PATCH] sh: Add platform-specific constants for SH7709
Message-Id: <1227450442-31915-1-git-send-email-steve.glendinning@smsc.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I'm using these constants in support of an in-house development board,
and thought they may be useful to other users of SH7709.

Signed-off-by: Steve Glendinning <steve.glendinning@smsc.com>
---
 arch/sh/include/cpu-sh3/cpu/gpio.h |   14 ++++++++++++++
 arch/sh/include/mach-se/mach/se.h  |   18 ++++++++++++++++++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/sh/include/cpu-sh3/cpu/gpio.h b/arch/sh/include/cpu-sh3/cpu/gpio.h
index 4e53eb3..9a22b88 100644
--- a/arch/sh/include/cpu-sh3/cpu/gpio.h
+++ b/arch/sh/include/cpu-sh3/cpu/gpio.h
@@ -62,6 +62,20 @@
 #define PORT_PSELC	0xA4050128UL
 #define PORT_PSELD	0xA405012AUL
 
+#elif defined(CONFIG_CPU_SUBTYPE_SH7709)
+
+/* Control registers */
+#define PORT_PACR       0xa4000100UL
+#define PORT_PBCR       0xa4000102UL
+#define PORT_PCCR       0xa4000104UL
+#define PORT_PFCR       0xa400010aUL
+
+/* Data registers */
+#define PORT_PADR       0xa4000120UL
+#define PORT_PBDR       0xa4000122UL
+#define PORT_PCDR       0xa4000124UL
+#define PORT_PFDR       0xa400012aUL
+
 #endif
 
 #endif
diff --git a/arch/sh/include/mach-se/mach/se.h b/arch/sh/include/mach-se/mach/se.h
index eb23000..14be91c 100644
--- a/arch/sh/include/mach-se/mach/se.h
+++ b/arch/sh/include/mach-se/mach/se.h
@@ -68,6 +68,24 @@
 #define BCR_ILCRF	(PA_BCR + 10)
 #define BCR_ILCRG	(PA_BCR + 12)
 
+#if defined(CONFIG_CPU_SUBTYPE_SH7709)
+#define INTC_IRR0       0xa4000004UL
+#define INTC_IRR1       0xa4000006UL
+#define INTC_IRR2       0xa4000008UL
+
+#define INTC_ICR0       0xfffffee0UL
+#define INTC_ICR1       0xa4000010UL
+#define INTC_ICR2       0xa4000012UL
+#define INTC_INTER      0xa4000014UL
+
+#define INTC_IPRC       0xa4000016UL
+#define INTC_IPRD       0xa4000018UL
+#define INTC_IPRE       0xa400001aUL
+
+#define IRQ0_IRQ        32
+#define IRQ1_IRQ        33
+#endif
+
 #if defined(CONFIG_CPU_SUBTYPE_SH7705)
 #define IRQ_STNIC	12
 #define IRQ_CFCARD	14
-- 
1.5.6.5

