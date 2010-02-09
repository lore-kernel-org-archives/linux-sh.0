From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 09 Feb 2010 06:50:04 +0000
Subject: [PATCH 03/03] sh: sh7724/Ecovec24/KFR2R09/MS7724SE SDHI vector merge
Message-Id: <20100209065004.31154.36394.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Merge the SDHI vectors in the sh7724 INTC table
and update the SDHI platform data for Ecovec24,
KFR2R09 and MS7724SE.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/mach-ecovec24/setup.c   |    4 ++--
 arch/sh/boards/mach-kfr2r09/setup.c    |    2 +-
 arch/sh/boards/mach-se/7724/setup.c    |    4 ++--
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   32 ++++++++++++++++----------------
 4 files changed, 21 insertions(+), 21 deletions(-)

--- 0001/arch/sh/boards/mach-ecovec24/setup.c
+++ work/arch/sh/boards/mach-ecovec24/setup.c	2010-02-08 19:17:34.000000000 +0900
@@ -453,7 +453,7 @@ static struct resource sdhi0_resources[]
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start  = 101,
+		.start  = 100,
 		.flags  = IORESOURCE_IRQ,
 	},
 };
@@ -489,7 +489,7 @@ static struct resource sdhi1_resources[]
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start  = 24,
+		.start  = 23,
 		.flags  = IORESOURCE_IRQ,
 	},
 };
--- 0001/arch/sh/boards/mach-kfr2r09/setup.c
+++ work/arch/sh/boards/mach-kfr2r09/setup.c	2010-02-08 19:26:52.000000000 +0900
@@ -351,7 +351,7 @@ static struct resource kfr2r09_sh_sdhi0_
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start  = 101,
+		.start  = 100,
 		.flags  = IORESOURCE_IRQ,
 	},
 };
--- 0001/arch/sh/boards/mach-se/7724/setup.c
+++ work/arch/sh/boards/mach-se/7724/setup.c	2010-02-08 19:27:17.000000000 +0900
@@ -451,7 +451,7 @@ static struct resource sdhi0_cn7_resourc
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start  = 101,
+		.start  = 100,
 		.flags  = IORESOURCE_IRQ,
 	},
 };
@@ -474,7 +474,7 @@ static struct resource sdhi1_cn8_resourc
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start  = 24,
+		.start  = 23,
 		.flags  = IORESOURCE_IRQ,
 	},
 };
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7724.c	2010-02-08 19:17:53.000000000 +0900
@@ -723,6 +723,7 @@ void l2_cache_init(void)
 
 enum {
 	UNUSED = 0,
+	ENABLED,
 
 	/* interrupt sources */
 	IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7,
@@ -751,14 +752,12 @@ enum {
 	ETHI,
 	I2C1_ALI, I2C1_TACKI, I2C1_WAITI, I2C1_DTEI,
 	I2C0_ALI, I2C0_TACKI, I2C0_WAITI, I2C0_DTEI,
-	SDHI0_SDHII0, SDHI0_SDHII1, SDHI0_SDHII2, SDHI0_SDHII3,
 	CMT,
 	TSIF,
 	FSI,
 	SCIFA5,
 	TMU0_TUNI0, TMU0_TUNI1, TMU0_TUNI2,
 	IRDA,
-	SDHI1_SDHII0, SDHI1_SDHII1, SDHI1_SDHII2,
 	JPU,
 	_2DDMAC,
 	MMC_MMC2I, MMC_MMC3I,
@@ -840,10 +839,10 @@ static struct intc_vect vectors[] __init
 	INTC_VECT(I2C0_WAITI, 0xE40),
 	INTC_VECT(I2C0_DTEI, 0xE60),
 
-	INTC_VECT(SDHI0_SDHII0, 0xE80),
-	INTC_VECT(SDHI0_SDHII1, 0xEA0),
-	INTC_VECT(SDHI0_SDHII2, 0xEC0),
-	INTC_VECT(SDHI0_SDHII3, 0xEE0),
+	INTC_VECT(SDHI0, 0xE80),
+	INTC_VECT(SDHI0, 0xEA0),
+	INTC_VECT(SDHI0, 0xEC0),
+	INTC_VECT(SDHI0, 0xEE0),
 
 	INTC_VECT(CMT,    0xF00),
 	INTC_VECT(TSIF,   0xF20),
@@ -856,9 +855,9 @@ static struct intc_vect vectors[] __init
 
 	INTC_VECT(IRDA,    0x480),
 
-	INTC_VECT(SDHI1_SDHII0, 0x4E0),
-	INTC_VECT(SDHI1_SDHII1, 0x500),
-	INTC_VECT(SDHI1_SDHII2, 0x520),
+	INTC_VECT(SDHI1, 0x4E0),
+	INTC_VECT(SDHI1, 0x500),
+	INTC_VECT(SDHI1, 0x520),
 
 	INTC_VECT(JPU, 0x560),
 	INTC_VECT(_2DDMAC, 0x4A0),
@@ -884,8 +883,6 @@ static struct intc_group groups[] __init
 	INTC_GROUP(DMAC0B, DMAC0B_DEI4, DMAC0B_DEI5, DMAC0B_DADERR),
 	INTC_GROUP(I2C0, I2C0_ALI, I2C0_TACKI, I2C0_WAITI, I2C0_DTEI),
 	INTC_GROUP(I2C1, I2C1_ALI, I2C1_TACKI, I2C1_WAITI, I2C1_DTEI),
-	INTC_GROUP(SDHI0, SDHI0_SDHII0, SDHI0_SDHII1, SDHI0_SDHII2, SDHI0_SDHII3),
-	INTC_GROUP(SDHI1, SDHI1_SDHII0, SDHI1_SDHII1, SDHI1_SDHII2),
 	INTC_GROUP(SPU, SPU_SPUI0, SPU_SPUI1),
 	INTC_GROUP(MMCIF, MMC_MMC2I, MMC_MMC3I),
 };
@@ -893,7 +890,7 @@ static struct intc_group groups[] __init
 static struct intc_mask_reg mask_registers[] __initdata = {
 	{ 0xa4080080, 0xa40800c0, 8, /* IMR0 / IMCR0 */
 	  { 0, TMU1_TUNI2, TMU1_TUNI1, TMU1_TUNI0,
-	    0, SDHI1_SDHII2, SDHI1_SDHII1, SDHI1_SDHII0 } },
+	    0, 0, ENABLED, ENABLED } },
 	{ 0xa4080084, 0xa40800c4, 8, /* IMR1 / IMCR1 */
 	  { VIO_VOU, VIO_VEU1, VIO_BEU0, VIO_CEU0,
 	    DMAC0A_DEI3, DMAC0A_DEI2, DMAC0A_DEI1, DMAC0A_DEI0 } },
@@ -915,7 +912,7 @@ static struct intc_mask_reg mask_registe
 	  { I2C0_DTEI, I2C0_WAITI, I2C0_TACKI, I2C0_ALI,
 	    I2C1_DTEI, I2C1_WAITI, I2C1_TACKI, I2C1_ALI } },
 	{ 0xa40800a0, 0xa40800e0, 8, /* IMR8 / IMCR8 */
-	  { SDHI0_SDHII3, SDHI0_SDHII2, SDHI0_SDHII1, SDHI0_SDHII0,
+	  { 0, 0, ENABLED, ENABLED,
 	    0, 0, SCIFA5, FSI } },
 	{ 0xa40800a4, 0xa40800e4, 8, /* IMR9 / IMCR9 */
 	  { 0, 0, 0, CMT, 0, USB1, USB0, 0 } },
@@ -962,9 +959,12 @@ static struct intc_mask_reg ack_register
 	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
 };
 
-static DECLARE_INTC_DESC_ACK(intc_desc, "sh7724", vectors, groups,
-			     mask_registers, prio_registers, sense_registers,
-			     ack_registers);
+static struct intc_desc intc_desc __initdata = {
+	.name = "sh7724",
+	.force_enable = ENABLED,
+	.hw = INTC_HW_DESC(vectors, groups, mask_registers,
+			   prio_registers, sense_registers, ack_registers),
+};
 
 void __init plat_irq_setup(void)
 {
