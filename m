From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 30 Mar 2011 01:46:18 +0000
Subject: [PATCH] sh: intc: fix build error in interrupts.h
Message-Id: <4D928B6A.0@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Fix the problem that name of some functions changed.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/sh/intc/internals.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/sh/intc/internals.h b/drivers/sh/intc/internals.h
index df36a42..5b93485 100644
--- a/drivers/sh/intc/internals.h
+++ b/drivers/sh/intc/internals.h
@@ -86,7 +86,7 @@ enum {	MODE_ENABLE_REG = 0, /* Bit(s) set -> interrupt enabled */

 static inline struct intc_desc_int *get_intc_desc(unsigned int irq)
 {
-	struct irq_chip *chip = get_irq_chip(irq);
+	struct irq_chip *chip = irq_get_chip(irq);

 	return container_of(chip, struct intc_desc_int, chip);
 }
@@ -103,7 +103,7 @@ static inline void activate_irq(int irq)
 	set_irq_flags(irq, IRQF_VALID);
 #else
 	/* same effect on other architectures */
-	set_irq_noprobe(irq);
+	irq_set_noprobe(irq);
 #endif
 }

-- 
1.7.1

