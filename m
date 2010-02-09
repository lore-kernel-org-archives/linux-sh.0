From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 09 Feb 2010 06:49:48 +0000
Subject: [PATCH 01/03] sh: sh7722/Migo-R SDHI vector merge
Message-Id: <20100209064948.31154.41733.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Merge the SDHI vectors in the sh7722 INTC table
and update the SDHI platform data for Migo-R.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/mach-migor/setup.c      |    2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   18 ++++++++++--------
 2 files changed, 11 insertions(+), 9 deletions(-)

--- 0001/arch/sh/boards/mach-migor/setup.c
+++ work/arch/sh/boards/mach-migor/setup.c	2010-02-09 13:02:38.000000000 +0900
@@ -397,7 +397,7 @@ static struct resource sdhi_cn9_resource
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= 101,
+		.start	= 100,
 		.flags  = IORESOURCE_IRQ,
 	},
 };
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7722.c	2010-02-09 13:02:13.000000000 +0900
@@ -446,6 +446,7 @@ void __init plat_early_device_setup(void
 
 enum {
 	UNUSED=0,
+	ENABLED,
 
 	/* interrupt sources */
 	IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7,
@@ -461,7 +462,6 @@ enum {
 	SCIF0, SCIF1, SCIF2, SIOF0, SIOF1, SIO,
 	FLCTL_FLSTEI, FLCTL_FLENDI, FLCTL_FLTREQ0I, FLCTL_FLTREQ1I,
 	I2C_ALI, I2C_TACKI, I2C_WAITI, I2C_DTEI,
-	SDHI0, SDHI1, SDHI2, SDHI3,
 	CMT, TSIF, SIU, TWODG,
 	TMU0, TMU1, TMU2,
 	IRDA, JPU, LCDC,
@@ -494,8 +494,8 @@ static struct intc_vect vectors[] __init
 	INTC_VECT(FLCTL_FLTREQ0I, 0xdc0), INTC_VECT(FLCTL_FLTREQ1I, 0xde0),
 	INTC_VECT(I2C_ALI, 0xe00), INTC_VECT(I2C_TACKI, 0xe20),
 	INTC_VECT(I2C_WAITI, 0xe40), INTC_VECT(I2C_DTEI, 0xe60),
-	INTC_VECT(SDHI0, 0xe80), INTC_VECT(SDHI1, 0xea0),
-	INTC_VECT(SDHI2, 0xec0), INTC_VECT(SDHI3, 0xee0),
+	INTC_VECT(SDHI, 0xe80), INTC_VECT(SDHI, 0xea0),
+	INTC_VECT(SDHI, 0xec0), INTC_VECT(SDHI, 0xee0),
 	INTC_VECT(CMT, 0xf00), INTC_VECT(TSIF, 0xf20),
 	INTC_VECT(SIU, 0xf80), INTC_VECT(TWODG, 0xfa0),
 	INTC_VECT(TMU0, 0x400), INTC_VECT(TMU1, 0x420),
@@ -513,7 +513,6 @@ static struct intc_group groups[] __init
 	INTC_GROUP(FLCTL, FLCTL_FLSTEI, FLCTL_FLENDI,
 		   FLCTL_FLTREQ0I, FLCTL_FLTREQ1I),
 	INTC_GROUP(I2C, I2C_ALI, I2C_TACKI, I2C_WAITI, I2C_DTEI),
-	INTC_GROUP(SDHI, SDHI0, SDHI1, SDHI2, SDHI3),
 };
 
 static struct intc_mask_reg mask_registers[] __initdata = {
@@ -535,7 +534,7 @@ static struct intc_mask_reg mask_registe
 	  { I2C_DTEI, I2C_WAITI, I2C_TACKI, I2C_ALI,
 	    FLCTL_FLTREQ1I, FLCTL_FLTREQ0I, FLCTL_FLENDI, FLCTL_FLSTEI } },
 	{ 0xa40800a0, 0xa40800e0, 8, /* IMR8 / IMCR8 */
-	  { SDHI3, SDHI2, SDHI1, SDHI0, 0, 0, TWODG, SIU } },
+	  { 0, 0, ENABLED, ENABLED, 0, 0, TWODG, SIU } },
 	{ 0xa40800a4, 0xa40800e4, 8, /* IMR9 / IMCR9 */
 	  { 0, 0, 0, CMT, 0, USB_USBI1, USB_USBI0, } },
 	{ 0xa40800a8, 0xa40800e8, 8, /* IMR10 / IMCR10 */
@@ -573,9 +572,12 @@ static struct intc_mask_reg ack_register
 	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
 };
 
-static DECLARE_INTC_DESC_ACK(intc_desc, "sh7722", vectors, groups,
-			     mask_registers, prio_registers, sense_registers,
-			     ack_registers);
+static struct intc_desc intc_desc __initdata = {
+	.name = "sh7722",
+	.force_enable = ENABLED,
+	.hw = INTC_HW_DESC(vectors, groups, mask_registers,
+			   prio_registers, sense_registers, ack_registers),
+};
 
 void __init plat_irq_setup(void)
 {
