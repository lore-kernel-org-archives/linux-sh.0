From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 19 Jan 2011 08:16:29 +0000
Subject: [PATCH] sh: update INTC to clear IRQ sense valid flag
Message-Id: <20110119081629.13270.23386.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Clear the valid flag is in the INTC code.
Without this fix bit 7 of the sense register
is mistakenly set.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/sh/intc/chip.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- 0001/drivers/sh/intc/chip.c
+++ work/drivers/sh/intc/chip.c	2011-01-18 14:45:38.000000000 +0900
@@ -173,7 +173,8 @@ int intc_set_priority(unsigned int irq, 
 	return 0;
 }
 
-#define VALID(x) (x | 0x80)
+#define SENSE_VALID_FLAG 0x80
+#define VALID(x) (x | SENSE_VALID_FLAG)
 
 static unsigned char intc_irq_sense_table[IRQ_TYPE_SENSE_MASK + 1] = {
 	[IRQ_TYPE_EDGE_FALLING] = VALID(0),
@@ -201,7 +202,8 @@ static int intc_set_type(struct irq_data
 	ihp = intc_find_irq(d->sense, d->nr_sense, irq);
 	if (ihp) {
 		addr = INTC_REG(d, _INTC_ADDR_E(ihp->handle), 0);
-		intc_reg_fns[_INTC_FN(ihp->handle)](addr, ihp->handle, value);
+		intc_reg_fns[_INTC_FN(ihp->handle)](addr, ihp->handle,
+						    value & ~SENSE_VALID_FLAG);
 	}
 
 	return 0;
