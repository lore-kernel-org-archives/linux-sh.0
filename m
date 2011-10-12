From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 12 Oct 2011 07:21:34 +0000
Subject: [PATCH 05/07] ARM: mach-shmobile: Use common INTC IRQ code on sh7372
Message-Id: <20111012072134.25511.37553.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Make use of INTC_IRQ_PINS_32() for INTCA on sh7372.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/intc-sh7372.c |   72 +++-------------------------------
 1 file changed, 8 insertions(+), 64 deletions(-)

--- 0001/arch/arm/mach-shmobile/intc-sh7372.c
+++ work/arch/arm/mach-shmobile/intc-sh7372.c	2011-10-12 15:10:56.000000000 +0900
@@ -22,6 +22,7 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/sh_intc.h>
+#include <mach/intc.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
@@ -29,10 +30,6 @@ enum {
 	UNUSED_INTCA = 0,
 
 	/* interrupt sources INTCA */
-	IRQ0A, IRQ1A, IRQ2A, IRQ3A, IRQ4A, IRQ5A, IRQ6A, IRQ7A,
-	IRQ8A, IRQ9A, IRQ10A, IRQ11A, IRQ12A, IRQ13A, IRQ14A, IRQ15A,
-	IRQ16A, IRQ17A, IRQ18A, IRQ19A, IRQ20A, IRQ21A, IRQ22A, IRQ23A,
-	IRQ24A, IRQ25A, IRQ26A, IRQ27A, IRQ28A, IRQ29A, IRQ30A, IRQ31A,
 	DIRC,
 	CRYPT_STD,
 	IIC1_ALI1, IIC1_TACKI1, IIC1_WAITI1, IIC1_DTEI1,
@@ -86,22 +83,6 @@ enum {
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
-	INTC_VECT(IRQ16A, 0x3200), INTC_VECT(IRQ17A, 0x3220),
-	INTC_VECT(IRQ18A, 0x3240), INTC_VECT(IRQ19A, 0x3260),
-	INTC_VECT(IRQ20A, 0x3280), INTC_VECT(IRQ21A, 0x32a0),
-	INTC_VECT(IRQ22A, 0x32c0), INTC_VECT(IRQ23A, 0x32e0),
-	INTC_VECT(IRQ24A, 0x3300), INTC_VECT(IRQ25A, 0x3320),
-	INTC_VECT(IRQ26A, 0x3340), INTC_VECT(IRQ27A, 0x3360),
-	INTC_VECT(IRQ28A, 0x3380), INTC_VECT(IRQ29A, 0x33a0),
-	INTC_VECT(IRQ30A, 0x33c0), INTC_VECT(IRQ31A, 0x33e0),
 	INTC_VECT(DIRC, 0x0560),
 	INTC_VECT(CRYPT_STD, 0x0700),
 	INTC_VECT(IIC1_ALI1, 0x0780), INTC_VECT(IIC1_TACKI1, 0x07a0),
@@ -203,15 +184,6 @@ static struct intc_group intca_groups[]
 };
 
 static struct intc_mask_reg intca_mask_registers[] __initdata = {
-	{ 0xe6900040, 0xe6900060, 8, /* INTMSK00A / INTMSKCLR00A */
-	  { IRQ0A, IRQ1A, IRQ2A, IRQ3A, IRQ4A, IRQ5A, IRQ6A, IRQ7A } },
-	{ 0xe6900044, 0xe6900064, 8, /* INTMSK10A / INTMSKCLR10A */
-	  { IRQ8A, IRQ9A, IRQ10A, IRQ11A, IRQ12A, IRQ13A, IRQ14A, IRQ15A } },
-	{ 0xe6900048, 0xe6900068, 8, /* INTMSK20A / INTMSKCLR20A */
-	  { IRQ16A, IRQ17A, IRQ18A, IRQ19A, IRQ20A, IRQ21A, IRQ22A, IRQ23A } },
-	{ 0xe690004c, 0xe690006c, 8, /* INTMSK30A / INTMSKCLR30A */
-	  { IRQ24A, IRQ25A, IRQ26A, IRQ27A, IRQ28A, IRQ29A, IRQ30A, IRQ31A } },
-
 	{ 0xe6940080, 0xe69400c0, 8, /* IMR0A / IMCR0A */
 	  { DMAC2_1_DEI3, DMAC2_1_DEI2, DMAC2_1_DEI1, DMAC2_1_DEI0,
 	    AP_ARM_IRQPMU, 0, AP_ARM_COMMTX, AP_ARM_COMMRX } },
@@ -282,15 +254,6 @@ static struct intc_mask_reg intca_mask_r
 };
 
 static struct intc_prio_reg intca_prio_registers[] __initdata = {
-	{ 0xe6900010, 0, 32, 4, /* INTPRI00A */
-	  { IRQ0A, IRQ1A, IRQ2A, IRQ3A, IRQ4A, IRQ5A, IRQ6A, IRQ7A } },
-	{ 0xe6900014, 0, 32, 4, /* INTPRI10A */
-	  { IRQ8A, IRQ9A, IRQ10A, IRQ11A, IRQ12A, IRQ13A, IRQ14A, IRQ15A } },
-	{ 0xe6900018, 0, 32, 4, /* INTPRI20A */
-	  { IRQ16A, IRQ17A, IRQ18A, IRQ19A, IRQ20A, IRQ21A, IRQ22A, IRQ23A } },
-	{ 0xe690001c, 0, 32, 4, /* INTPRI30A */
-	  { IRQ24A, IRQ25A, IRQ26A, IRQ27A, IRQ28A, IRQ29A, IRQ30A, IRQ31A } },
-
 	{ 0xe6940000, 0, 16, 4, /* IPRAA */ { DMAC3_1, DMAC3_2, CMT2, 0 } },
 	{ 0xe6940004, 0, 16, 4, /* IPRBA */ { IRDA, 0, BBIF1, BBIF2 } },
 	{ 0xe6940008, 0, 16, 4, /* IPRCA */ { 0, CRYPT_STD,
@@ -336,33 +299,13 @@ static struct intc_prio_reg intca_prio_r
 	{ 0xe6950050, 0, 16, 4, /* IPRUA3 */ { USBHSDMAC1_USHDMI, 0, 0, 0 } },
 };
 
-static struct intc_sense_reg intca_sense_registers[] __initdata = {
-	{ 0xe6900000, 32, 4, /* ICR1A */
-	  { IRQ0A, IRQ1A, IRQ2A, IRQ3A, IRQ4A, IRQ5A, IRQ6A, IRQ7A } },
-	{ 0xe6900004, 32, 4, /* ICR2A */
-	  { IRQ8A, IRQ9A, IRQ10A, IRQ11A, IRQ12A, IRQ13A, IRQ14A, IRQ15A } },
-	{ 0xe6900008, 32, 4, /* ICR3A */
-	  { IRQ16A, IRQ17A, IRQ18A, IRQ19A, IRQ20A, IRQ21A, IRQ22A, IRQ23A } },
-	{ 0xe690000c, 32, 4, /* ICR4A */
-	  { IRQ24A, IRQ25A, IRQ26A, IRQ27A, IRQ28A, IRQ29A, IRQ30A, IRQ31A } },
-};
-
-static struct intc_mask_reg intca_ack_registers[] __initdata = {
-	{ 0xe6900020, 0, 8, /* INTREQ00A */
-	  { IRQ0A, IRQ1A, IRQ2A, IRQ3A, IRQ4A, IRQ5A, IRQ6A, IRQ7A } },
-	{ 0xe6900024, 0, 8, /* INTREQ10A */
-	  { IRQ8A, IRQ9A, IRQ10A, IRQ11A, IRQ12A, IRQ13A, IRQ14A, IRQ15A } },
-	{ 0xe6900028, 0, 8, /* INTREQ20A */
-	  { IRQ16A, IRQ17A, IRQ18A, IRQ19A, IRQ20A, IRQ21A, IRQ22A, IRQ23A } },
-	{ 0xe690002c, 0, 8, /* INTREQ30A */
-	  { IRQ24A, IRQ25A, IRQ26A, IRQ27A, IRQ28A, IRQ29A, IRQ30A, IRQ31A } },
-};
-
-static DECLARE_INTC_DESC_ACK(intca_desc, "sh7372-intca",
-			     intca_vectors, intca_groups,
-			     intca_mask_registers, intca_prio_registers,
-			     intca_sense_registers, intca_ack_registers);
+static DECLARE_INTC_DESC(intca_desc, "sh7372-intca",
+			 intca_vectors, intca_groups,
+			 intca_mask_registers, intca_prio_registers,
+			 NULL);
 
+INTC_IRQ_PINS_32(intca_irq_pins, 0xe6900000,
+		 INTC_VECT, "sh7372-intca-irq-pins");
 enum {
 	UNUSED_INTCS = 0,
 	ENABLED_INTCS,
@@ -611,6 +554,7 @@ void __init sh7372_init_irq(void)
 	void __iomem *intevtsa = ioremap_nocache(0xffd20100, PAGE_SIZE);
 
 	register_intc_controller(&intca_desc);
+	register_intc_controller(&intca_irq_pins_desc);
 	register_intc_controller(&intcs_desc);
 
 	/* demux using INTEVTSA */
