From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 17 Oct 2011 08:59:54 +0000
Subject: [PATCH] sh: intc: Add IRQ trigger bit field check
Message-Id: <20111017085954.21977.43477.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

R-Mobile SoCs such as sh73a0 include PINT blocks in INTC
that come with 2-bit IRQ trigger support. Add code to make
sure the bit width is checked so 4-bit only modes like for
instance EDGE_BOTH will fail for PINT.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/sh/intc/chip.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- 0009/drivers/sh/intc/chip.c
+++ work/drivers/sh/intc/chip.c	2011-10-14 11:52:20.000000000 +0900
@@ -202,11 +202,16 @@ static int intc_set_type(struct irq_data
 	if (!value)
 		return -EINVAL;
 
+	value &= ~SENSE_VALID_FLAG;
+
 	ihp = intc_find_irq(d->sense, d->nr_sense, irq);
 	if (ihp) {
+		/* PINT has 2-bit sense registers, should fail on EDGE_BOTH */
+		if (value >= (1 << _INTC_WIDTH(ihp->handle)))
+			return -EINVAL;
+
 		addr = INTC_REG(d, _INTC_ADDR_E(ihp->handle), 0);
-		intc_reg_fns[_INTC_FN(ihp->handle)](addr, ihp->handle,
-						    value & ~SENSE_VALID_FLAG);
+		intc_reg_fns[_INTC_FN(ihp->handle)](addr, ihp->handle, value);
 	}
 
 	return 0;
