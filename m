From: Rob Herring <robh@kernel.org>
Date: Mon, 27 Jul 2015 20:55:23 +0000
Subject: [PATCH v3] sh: kill off set_irq_flags usage
Message-Id: <1438030523-15853-11-git-send-email-robh@kernel.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

set_irq_flags is ARM specific with custom flags which have genirq
equivalents. Convert drivers to use the genirq interfaces directly, so we
can kill off set_irq_flags. The translation of flags is as follows:

IRQF_VALID -> !IRQ_NOREQUEST
IRQF_PROBE -> !IRQ_NOPROBE
IRQF_NOAUTOEN -> IRQ_NOAUTOEN

For IRQs managed by an irqdomain, the irqdomain core code handles clearing
and setting IRQ_NOREQUEST already, so there is no need to do this in
.map() functions and we can simply remove the set_irq_flags calls. Some
users also modify IRQ_NOPROBE and this has been maintained although it
is not clear that is really needed. There appears to be a great deal of
blind copy and paste of this code.

Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org
---
Thomas asked that this be merged thru subsystem trees instead of arm-soc,
so please apply this to your tree.

Rob

 drivers/sh/intc/internals.h | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/sh/intc/internals.h b/drivers/sh/intc/internals.h
index 7dff08e..6ce7f0d 100644
--- a/drivers/sh/intc/internals.h
+++ b/drivers/sh/intc/internals.h
@@ -99,15 +99,7 @@ static inline struct intc_desc_int *get_intc_desc(unsigned int irq)
  */
 static inline void activate_irq(int irq)
 {
-#ifdef CONFIG_ARM
-	/* ARM requires an extra step to clear IRQ_NOREQUEST, which it
-	 * sets on behalf of every irq_chip.  Also sets IRQ_NOPROBE.
-	 */
-	set_irq_flags(irq, IRQF_VALID);
-#else
-	/* same effect on other architectures */
-	irq_set_noprobe(irq);
-#endif
+	irq_modify_status(irq, IRQ_NOREQUEST, IRQ_NOPROBE);
 }

 static inline int intc_handle_int_cmp(const void *a, const void *b)
--
2.1.0

