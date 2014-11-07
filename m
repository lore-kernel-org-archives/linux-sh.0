From: Kevin Cernekee <cernekee@gmail.com>
Date: Fri, 07 Nov 2014 06:44:21 +0000
Subject: [PATCH V4 06/14] irqchip: bcm7120-l2: Eliminate bad IRQ check
Message-Id: <1415342669-30640-7-git-send-email-cernekee@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
In-Reply-To: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tglx@linutronix.de, jason@lakedaemon.net, linux-sh@vger.kernel.org
Cc: arnd@arndb.de, f.fainelli@gmail.com, ralf@linux-mips.org, sergei.shtylyov@cogentembedded.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org

This check may be prone to race conditions, e.g.

1) Some external event (e.g. GPIO level) causes an IRQ to become pending
2) Peripheral asserts the L2 IRQ
3) CPU takes an interrupt
4) The event from #1 goes away
5) bcm7120_l2_intc_irq_handle() reads back a 0 status

Unlike the hardware supported by brcmstb-l2, the bcm7120-l2 controller
does not latch the IRQ status.  Bits can change if the inputs to the
controller change.  Also, do_bad_IRQ() is an ARM-specific macro.

So let's just nuke it.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/irq-bcm7120-l2.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index b9f4fb8..7086fe0 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -27,8 +27,6 @@
 
 #include "irqchip.h"
 
-#include <asm/mach/irq.h>
-
 /* Register offset in the L2 interrupt controller */
 #define IRQEN		0x00
 #define IRQSTAT		0x04
@@ -51,19 +49,12 @@ static void bcm7120_l2_intc_irq_handle(unsigned int irq, struct irq_desc *desc)
 	chained_irq_enter(chip, desc);
 
 	status = __raw_readl(b->base + IRQSTAT);
-
-	if (status = 0) {
-		do_bad_IRQ(irq, desc);
-		goto out;
-	}
-
-	do {
+	while (status) {
 		irq = ffs(status) - 1;
 		status &= ~(1 << irq);
 		generic_handle_irq(irq_find_mapping(b->domain, irq));
-	} while (status);
+	}
 
-out:
 	chained_irq_exit(chip, desc);
 }
 
-- 
2.1.1

