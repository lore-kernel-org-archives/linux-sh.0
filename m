From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 17 Nov 2009 22:50:45 +0000
Subject: [patch 05/13] sh: Fixup last users of irq_chip->typename
Message-Id: <20091117224916.528768738@linutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20091117224852.846805939@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org

The typename member of struct irq_chip was kept for migration purposes
and is obsolete since more than 2 years. Fix up the leftovers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/kernel/cpu/irq/imask.c    |    2 +-
 arch/sh/kernel/cpu/irq/intc-sh5.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/arch/sh/kernel/cpu/irq/imask.c
=================================--- linux-2.6.orig/arch/sh/kernel/cpu/irq/imask.c
+++ linux-2.6/arch/sh/kernel/cpu/irq/imask.c
@@ -68,7 +68,7 @@ static void unmask_imask_irq(unsigned in
 }
 
 static struct irq_chip imask_irq_chip = {
-	.typename	= "SR.IMASK",
+	.name		= "SR.IMASK",
 	.mask		= mask_imask_irq,
 	.unmask		= unmask_imask_irq,
 	.mask_ack	= mask_imask_irq,
Index: linux-2.6/arch/sh/kernel/cpu/irq/intc-sh5.c
=================================--- linux-2.6.orig/arch/sh/kernel/cpu/irq/intc-sh5.c
+++ linux-2.6/arch/sh/kernel/cpu/irq/intc-sh5.c
@@ -85,7 +85,7 @@ static void mask_and_ack_intc(unsigned i
 static void end_intc_irq(unsigned int irq);
 
 static struct irq_chip intc_irq_type = {
-	.typename = "INTC",
+	.name = "INTC",
 	.startup = startup_intc_irq,
 	.shutdown = shutdown_intc_irq,
 	.enable = enable_intc_irq,


