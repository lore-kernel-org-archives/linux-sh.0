From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 24 Apr 2008 12:47:15 +0000
Subject: [PATCH] sh: no high level trigger on some sh3 cpus
Message-Id: <20080424124715.19669.78584.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The processor models sh7706, sh7707 and sh7709 don't support high
level trigger sense configuration. And the intc code looks like
crap these days so what's the difference.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/irq/intc.c |    5 +++++
 1 file changed, 5 insertions(+)

--- 0011/arch/sh/kernel/cpu/irq/intc.c
+++ work/arch/sh/kernel/cpu/irq/intc.c	2008-04-24 20:40:56.000000000 +0900
@@ -302,7 +302,12 @@ static unsigned char intc_irq_sense_tabl
 	[IRQ_TYPE_EDGE_FALLING] = VALID(0),
 	[IRQ_TYPE_EDGE_RISING] = VALID(1),
 	[IRQ_TYPE_LEVEL_LOW] = VALID(2),
+	/* SH7706, SH7707 and SH7709 do not support high level triggered */
+#if !defined(CONFIG_CPU_SUBTYPE_SH7706) && \
+    !defined(CONFIG_CPU_SUBTYPE_SH7707) && \
+    !defined(CONFIG_CPU_SUBTYPE_SH7709)
 	[IRQ_TYPE_LEVEL_HIGH] = VALID(3),
+#endif
 };
 
 static int intc_set_sense(unsigned int irq, unsigned int type)
