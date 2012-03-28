From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 28 Mar 2012 06:40:58 +0000
Subject: [PATCH 05/06] ARM: mach-shmobile: Use INTC_IRQ_PINS_16H on sh7372
Message-Id: <20120328064058.28557.73461.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Use INTC_IRQ_PINS_16H on sh7372 to have two separate
interrupt controllers for the external IRQ pins.

This is preparation work for future IRQ domain support.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/intc-sh7372.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- 0001/arch/arm/mach-shmobile/intc-sh7372.c
+++ work/arch/arm/mach-shmobile/intc-sh7372.c	2012-03-27 17:45:14.000000000 +0900
@@ -304,8 +304,12 @@ static DECLARE_INTC_DESC(intca_desc, "sh
 			 intca_mask_registers, intca_prio_registers,
 			 NULL);
 
-INTC_IRQ_PINS_32(intca_irq_pins, 0xe6900000,
-		 INTC_VECT, "sh7372-intca-irq-pins");
+INTC_IRQ_PINS_16(intca_irq_pins_lo, 0xe6900000,
+		 INTC_VECT, "sh7372-intca-irq-lo");
+
+INTC_IRQ_PINS_16H(intca_irq_pins_hi, 0xe6900000,
+		 INTC_VECT, "sh7372-intca-irq-hi");
+
 enum {
 	UNUSED_INTCS = 0,
 	ENABLED_INTCS,
@@ -562,7 +566,8 @@ void __init sh7372_init_irq(void)
 	intcs_ffd5 = ioremap_nocache(0xffd50000, PAGE_SIZE);
 
 	register_intc_controller(&intca_desc);
-	register_intc_controller(&intca_irq_pins_desc);
+	register_intc_controller(&intca_irq_pins_lo_desc);
+	register_intc_controller(&intca_irq_pins_hi_desc);
 	register_intc_controller(&intcs_desc);
 
 	/* demux using INTEVTSA */
