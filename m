From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 12 Oct 2011 07:21:16 +0000
Subject: [PATCH 03/07] ARM: mach-shmobile: Use common INTC IRQ code on sh7367
Message-Id: <20111012072116.25511.15458.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Make use of INTC_IRQ_PINS_16() for INTCA on sh7367.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/intc-sh7367.c |   40 +++++-----------------------------
 1 file changed, 6 insertions(+), 34 deletions(-)

--- 0001/arch/arm/mach-shmobile/intc-sh7367.c
+++ work/arch/arm/mach-shmobile/intc-sh7367.c	2011-10-12 15:07:52.000000000 +0900
@@ -22,6 +22,7 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/sh_intc.h>
+#include <mach/intc.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
@@ -31,8 +32,6 @@ enum {
 	DISABLED,
 
 	/* interrupt sources INTCA */
-	IRQ0A, IRQ1A, IRQ2A, IRQ3A, IRQ4A, IRQ5A, IRQ6A, IRQ7A,
-	IRQ8A, IRQ9A, IRQ10A, IRQ11A, IRQ12A, IRQ13A, IRQ14A, IRQ15A,
 	DIRC,
 	CRYPT1_ERR, CRYPT2_STD,
 	IIC1_ALI1, IIC1_TACKI1, IIC1_WAITI1, IIC1_DTEI1,
@@ -76,14 +75,6 @@ enum {
 };
 
 static struct intc_vect intca_vectors[] __initdata = {
-	INTC_VECT(IRQ0A, 0x0200), INTC_VECT(IRQ1A, 0x0220),
-	INTC_VECT(IRQ2A, 0x0240), INTC_VECT(IRQ3A, 0x0260),
-	INTC_VECT(IRQ4A, 0x0280), INTC_VECT(IRQ5A, 0x02a0),
-	INTC_VECT(IRQ6A, 0x02c0), INTC_VECT(IRQ7A, 0x02e0),
-	INTC_VECT(IRQ8A, 0x0300), INTC_VECT(IRQ9A, 0x0320),
-	INTC_VECT(IRQ10A, 0x0340), INTC_VECT(IRQ11A, 0x0360),
-	INTC_VECT(IRQ12A, 0x0380), INTC_VECT(IRQ13A, 0x03a0),
-	INTC_VECT(IRQ14A, 0x03c0), INTC_VECT(IRQ15A, 0x03e0),
 	INTC_VECT(DIRC, 0x0560),
 	INTC_VECT(CRYPT1_ERR, 0x05e0),
 	INTC_VECT(CRYPT2_STD, 0x0700),
@@ -163,10 +154,6 @@ static struct intc_group intca_groups[]
 };
 
 static struct intc_mask_reg intca_mask_registers[] __initdata = {
-	{ 0xe6900040, 0xe6900060, 8, /* INTMSK00A / INTMSKCLR00A */
-	  { IRQ0A, IRQ1A, IRQ2A, IRQ3A, IRQ4A, IRQ5A, IRQ6A, IRQ7A } },
-	{ 0xe6900044, 0xe6900064, 8, /* INTMSK10A / INTMSKCLR10A */
-	  { IRQ8A, IRQ9A, IRQ10A, IRQ11A, IRQ12A, IRQ13A, IRQ14A, IRQ15A } },
 	{ 0xe6940080, 0xe69400c0, 8, /* IMR0A / IMCR0A */
 	  { DMAC2_1_DEI3, DMAC2_1_DEI2, DMAC2_1_DEI1, DMAC2_1_DEI0,
 	    ARM11_IRQPMU, 0, ARM11_COMMTX, ARM11_COMMRX } },
@@ -212,11 +199,6 @@ static struct intc_mask_reg intca_mask_r
 };
 
 static struct intc_prio_reg intca_prio_registers[] __initdata = {
-	{ 0xe6900010, 0, 32, 4, /* INTPRI00A */
-	  { IRQ0A, IRQ1A, IRQ2A, IRQ3A, IRQ4A, IRQ5A, IRQ6A, IRQ7A } },
-	{ 0xe6900014, 0, 32, 4, /* INTPRI10A */
-	  { IRQ8A, IRQ9A, IRQ10A, IRQ11A, IRQ12A, IRQ13A, IRQ14A, IRQ15A } },
-
 	{ 0xe6940000, 0, 16, 4, /* IPRAA */ { DMAC3_1, DMAC3_2, CMT2, LCRC } },
 	{ 0xe6940004, 0, 16, 4, /* IPRBA */ { IRDA, ETM11, BBIF1, BBIF2 } },
 	{ 0xe6940008, 0, 16, 4, /* IPRCA */ { CRYPT1_ERR, CRYPT2_STD,
@@ -240,29 +222,18 @@ static struct intc_prio_reg intca_prio_r
 	{ 0xe6940038, 0, 16, 4, /* IPROA */ { 0, 0, DIRC, SDHI2 } },
 };
 
-static struct intc_sense_reg intca_sense_registers[] __initdata = {
-	{ 0xe6900000, 16, 2, /* ICR1A */
-	  { IRQ0A, IRQ1A, IRQ2A, IRQ3A, IRQ4A, IRQ5A, IRQ6A, IRQ7A } },
-	{ 0xe6900004, 16, 2, /* ICR2A */
-	  { IRQ8A, IRQ9A, IRQ10A, IRQ11A, IRQ12A, IRQ13A, IRQ14A, IRQ15A } },
-};
-
-static struct intc_mask_reg intca_ack_registers[] __initdata = {
-	{ 0xe6900020, 0, 8, /* INTREQ00A */
-	  { IRQ0A, IRQ1A, IRQ2A, IRQ3A, IRQ4A, IRQ5A, IRQ6A, IRQ7A } },
-	{ 0xe6900024, 0, 8, /* INTREQ10A */
-	  { IRQ8A, IRQ9A, IRQ10A, IRQ11A, IRQ12A, IRQ13A, IRQ14A, IRQ15A } },
-};
-
 static struct intc_desc intca_desc __initdata = {
 	.name = "sh7367-intca",
 	.force_enable = ENABLED,
 	.force_disable = DISABLED,
 	.hw = INTC_HW_DESC(intca_vectors, intca_groups,
 			   intca_mask_registers, intca_prio_registers,
-			   intca_sense_registers, intca_ack_registers),
+			   NULL, NULL),
 };
 
+INTC_IRQ_PINS_16(intca_irq_pins, 0xe6900000,
+		 INTC_VECT, "sh7367-intca-irq-pins");
+
 enum {
 	UNUSED_INTCS = 0,
 
@@ -432,6 +403,7 @@ void __init sh7367_init_irq(void)
 	void __iomem *intevtsa = ioremap_nocache(0xffd20100, PAGE_SIZE);
 
 	register_intc_controller(&intca_desc);
+	register_intc_controller(&intca_irq_pins_desc);
 	register_intc_controller(&intcs_desc);
 
 	/* demux using INTEVTSA */
