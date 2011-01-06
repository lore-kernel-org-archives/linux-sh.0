From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 06 Jan 2011 11:12:27 +0000
Subject: [PATCH] sh: sh7366 Enable SDIO IRQs
Message-Id: <20110106111227.9476.81497.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch enables interrupt generation for SDIO IRQs
of the SDHI block on the sh7366 processor. Use together
with a recent SDHI driver using TMIO_MMC_SDIO_IRQ and
with the MMC_CAP_SDIO_IRQ flag in the board code.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

--- 0011/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7366.c	2011-01-06 20:07:10.000000000 +0900
@@ -324,6 +324,8 @@ void __init sh7366_mem_init(void)
 
 enum {
 	UNUSED=0,
+	ENABLED,
+	DISABLED,
 
 	/* interrupt sources */
 	IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7,
@@ -337,14 +339,13 @@ enum {
 	DENC, MSIOF,
 	FLCTL_FLSTEI, FLCTL_FLENDI, FLCTL_FLTREQ0I, FLCTL_FLTREQ1I,
 	I2C_ALI, I2C_TACKI, I2C_WAITI, I2C_DTEI,
-	SDHI0, SDHI1, SDHI2, SDHI3,
-	CMT, TSIF, SIU,
+	SDHI, CMT, TSIF, SIU,
 	TMU0, TMU1, TMU2,
 	VEU2, LCDC,
 
 	/* interrupt groups */
 
-	DMAC0123, VIOVOU, MMC, DMAC45, FLCTL, I2C, SDHI,
+	DMAC0123, VIOVOU, MMC, DMAC45, FLCTL, I2C,
 };
 
 static struct intc_vect vectors[] __initdata = {
@@ -369,8 +370,8 @@ static struct intc_vect vectors[] __init
 	INTC_VECT(FLCTL_FLTREQ0I, 0xdc0), INTC_VECT(FLCTL_FLTREQ1I, 0xde0),
 	INTC_VECT(I2C_ALI, 0xe00), INTC_VECT(I2C_TACKI, 0xe20),
 	INTC_VECT(I2C_WAITI, 0xe40), INTC_VECT(I2C_DTEI, 0xe60),
-	INTC_VECT(SDHI0, 0xe80), INTC_VECT(SDHI1, 0xea0),
-	INTC_VECT(SDHI2, 0xec0), INTC_VECT(SDHI3, 0xee0),
+	INTC_VECT(SDHI, 0xe80), INTC_VECT(SDHI, 0xea0),
+	INTC_VECT(SDHI, 0xec0), INTC_VECT(SDHI, 0xee0),
 	INTC_VECT(CMT, 0xf00), INTC_VECT(TSIF, 0xf20),
 	INTC_VECT(SIU, 0xf80),
 	INTC_VECT(TMU0, 0x400), INTC_VECT(TMU1, 0x420),
@@ -386,7 +387,6 @@ static struct intc_group groups[] __init
 	INTC_GROUP(FLCTL, FLCTL_FLSTEI, FLCTL_FLENDI,
 		   FLCTL_FLTREQ0I, FLCTL_FLTREQ1I),
 	INTC_GROUP(I2C, I2C_ALI, I2C_TACKI, I2C_WAITI, I2C_DTEI),
-	INTC_GROUP(SDHI, SDHI0, SDHI1, SDHI2, SDHI3),
 };
 
 static struct intc_mask_reg mask_registers[] __initdata = {
@@ -408,7 +408,7 @@ static struct intc_mask_reg mask_registe
 	  { I2C_DTEI, I2C_WAITI, I2C_TACKI, I2C_ALI,
 	    FLCTL_FLTREQ1I, FLCTL_FLTREQ0I, FLCTL_FLENDI, FLCTL_FLSTEI } },
 	{ 0xa40800a0, 0xa40800e0, 8, /* IMR8 / IMCR8 */
-	  { SDHI3, SDHI2, SDHI1, SDHI0, 0, 0, 0, SIU } },
+	  { DISABLED, ENABLED, ENABLED, ENABLED, 0, 0, 0, SIU } },
 	{ 0xa40800a4, 0xa40800e4, 8, /* IMR9 / IMCR9 */
 	  { 0, 0, 0, CMT, 0, USB, } },
 	{ 0xa40800a8, 0xa40800e8, 8, /* IMR10 / IMCR10 */
@@ -446,9 +446,13 @@ static struct intc_mask_reg ack_register
 	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
 };
 
-static DECLARE_INTC_DESC_ACK(intc_desc, "sh7366", vectors, groups,
-			     mask_registers, prio_registers, sense_registers,
-			     ack_registers);
+static struct intc_desc intc_desc __initdata = {
+	.name = "sh7366",
+	.force_enable = ENABLED,
+	.force_disable = DISABLED,
+	.hw = INTC_HW_DESC(vectors, groups, mask_registers,
+			   prio_registers, sense_registers, ack_registers),
+};
 
 void __init plat_irq_setup(void)
 {
