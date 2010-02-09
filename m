From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 09 Feb 2010 06:49:56 +0000
Subject: [PATCH 02/03] sh: sh7723/AP325 SDHI vector merge
Message-Id: <20100209064956.31154.36475.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Merge the SDHI vectors in the sh7723 INTC table
and update the SDHI platform data for AP325.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/mach-ap325rxa/setup.c   |    4 ++--
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   32 +++++++++++++++++---------------
 2 files changed, 19 insertions(+), 17 deletions(-)

--- 0001/arch/sh/boards/mach-ap325rxa/setup.c
+++ work/arch/sh/boards/mach-ap325rxa/setup.c	2010-02-09 12:49:14.000000000 +0900
@@ -420,7 +420,7 @@ static struct resource sdhi0_cn3_resourc
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= 101,
+		.start	= 100,
 		.flags  = IORESOURCE_IRQ,
 	},
 };
@@ -443,7 +443,7 @@ static struct resource sdhi1_cn7_resourc
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= 24,
+		.start	= 23,
 		.flags  = IORESOURCE_IRQ,
 	},
 };
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7723.c	2010-02-09 12:52:29.000000000 +0900
@@ -601,6 +601,7 @@ void l2_cache_init(void)
 
 enum {
 	UNUSED=0,
+	ENABLED,
 
 	/* interrupt sources */
 	IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7,
@@ -623,7 +624,6 @@ enum {
 	SCIFA_SCIFA1,
 	FLCTL_FLSTEI,FLCTL_FLTENDI,FLCTL_FLTREQ0I,FLCTL_FLTREQ1I,
 	I2C_ALI,I2C_TACKI,I2C_WAITI,I2C_DTEI,
-	SDHI0_SDHII0,SDHI0_SDHII1,SDHI0_SDHII2,
 	CMT_CMTI,
 	TSIF_TSIFI,
 	SIU_SIUI,
@@ -631,7 +631,6 @@ enum {
 	TMU0_TUNI0, TMU0_TUNI1, TMU0_TUNI2,
 	IRDA_IRDAI,
 	ATAPI_ATAPII,
-	SDHI1_SDHII0,SDHI1_SDHII1,SDHI1_SDHII2,
 	VEU2H1_VEU2HI,
 	LCDC_LCDCI,
 	TMU1_TUNI0,TMU1_TUNI1,TMU1_TUNI2,
@@ -702,9 +701,9 @@ static struct intc_vect vectors[] __init
 	INTC_VECT(I2C_WAITI,0xE40),
 	INTC_VECT(I2C_DTEI,0xE60),
 
-	INTC_VECT(SDHI0_SDHII0,0xE80),
-	INTC_VECT(SDHI0_SDHII1,0xEA0),
-	INTC_VECT(SDHI0_SDHII2,0xEC0),
+	INTC_VECT(SDHI0, 0xE80),
+	INTC_VECT(SDHI0, 0xEA0),
+	INTC_VECT(SDHI0, 0xEC0),
 
 	INTC_VECT(CMT_CMTI,0xF00),
 	INTC_VECT(TSIF_TSIFI,0xF20),
@@ -718,9 +717,9 @@ static struct intc_vect vectors[] __init
 	INTC_VECT(IRDA_IRDAI,0x480),
 	INTC_VECT(ATAPI_ATAPII,0x4A0),
 
-	INTC_VECT(SDHI1_SDHII0,0x4E0),
-	INTC_VECT(SDHI1_SDHII1,0x500),
-	INTC_VECT(SDHI1_SDHII2,0x520),
+	INTC_VECT(SDHI1, 0x4E0),
+	INTC_VECT(SDHI1, 0x500),
+	INTC_VECT(SDHI1, 0x520),
 
 	INTC_VECT(VEU2H1_VEU2HI,0x560),
 	INTC_VECT(LCDC_LCDCI,0x580),
@@ -739,15 +738,14 @@ static struct intc_group groups[] __init
 	INTC_GROUP(FLCTL,FLCTL_FLSTEI,FLCTL_FLTENDI,FLCTL_FLTREQ0I,FLCTL_FLTREQ1I),
 	INTC_GROUP(I2C,I2C_ALI,I2C_TACKI,I2C_WAITI,I2C_DTEI),
 	INTC_GROUP(_2DG, _2DG_TRI,_2DG_INI,_2DG_CEI),
-	INTC_GROUP(SDHI1, SDHI1_SDHII0,SDHI1_SDHII1,SDHI1_SDHII2),
 	INTC_GROUP(RTC, RTC_ATI,RTC_PRI,RTC_CUI),
 	INTC_GROUP(DMAC1B, DMAC1B_DEI4,DMAC1B_DEI5,DMAC1B_DADERR),
-	INTC_GROUP(SDHI0,SDHI0_SDHII0,SDHI0_SDHII1,SDHI0_SDHII2),
 };
 
 static struct intc_mask_reg mask_registers[] __initdata = {
 	{ 0xa4080080, 0xa40800c0, 8, /* IMR0 / IMCR0 */
-	  { 0,  TMU1_TUNI2,TMU1_TUNI1,TMU1_TUNI0,0,SDHI1_SDHII2,SDHI1_SDHII1,SDHI1_SDHII0} },
+	  { 0, TMU1_TUNI2, TMU1_TUNI1, TMU1_TUNI0,
+	    0, 0, ENABLED, ENABLED } },
 	{ 0xa4080084, 0xa40800c4, 8, /* IMR1 / IMCR1 */
 	  { VIO_VOUI, VIO_VEU2HI,VIO_BEUI,VIO_CEUI,DMAC0A_DEI3,DMAC0A_DEI2,DMAC0A_DEI1,DMAC0A_DEI0 } },
 	{ 0xa4080088, 0xa40800c8, 8, /* IMR2 / IMCR2 */
@@ -764,7 +762,8 @@ static struct intc_mask_reg mask_registe
 	  { I2C_DTEI, I2C_WAITI, I2C_TACKI, I2C_ALI,
 	    FLCTL_FLTREQ1I, FLCTL_FLTREQ0I, FLCTL_FLTENDI, FLCTL_FLSTEI } },
 	{ 0xa40800a0, 0xa40800e0, 8, /* IMR8 / IMCR8 */
-	  { 0,SDHI0_SDHII2,SDHI0_SDHII1,SDHI0_SDHII0,0,0,SCIFA_SCIFA2,SIU_SIUI } },
+	  { 0, 0, ENABLED, ENABLED,
+	    0, 0, SCIFA_SCIFA2, SIU_SIUI } },
 	{ 0xa40800a4, 0xa40800e4, 8, /* IMR9 / IMCR9 */
 	  { 0, 0, 0, CMT_CMTI, 0, 0, USB_USI0,0 } },
 	{ 0xa40800a8, 0xa40800e8, 8, /* IMR10 / IMCR10 */
@@ -804,9 +803,12 @@ static struct intc_mask_reg ack_register
 	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
 };
 
-static DECLARE_INTC_DESC_ACK(intc_desc, "sh7723", vectors, groups,
-			     mask_registers, prio_registers, sense_registers,
-			     ack_registers);
+static struct intc_desc intc_desc __initdata = {
+	.name = "sh7723",
+	.force_enable = ENABLED,
+	.hw = INTC_HW_DESC(vectors, groups, mask_registers,
+			   prio_registers, sense_registers, ack_registers),
+};
 
 void __init plat_irq_setup(void)
 {
