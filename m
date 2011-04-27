From: Simon Horman <horms@verge.net.au>
Date: Wed, 27 Apr 2011 07:43:58 +0000
Subject: [PATCH 2/2] ARM: arch-shmobile: Use multiple irq vectors for SDHI
Message-Id: <1303890238-8372-3-git-send-email-horms@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch reverts "ARM: mach-shmobile: sh7372 SDHI vector merge" and
supplies 3 IRQ resources for each SDHI block.

Some blocks have a 4th IRQ, but this is used for DRM feathres
that I do not have access tot he documentation for and are almost
certainly tainted by licensing issues. So the 4th IRQ is not
hooked-up even if it exists.

Cc: Chris Ball <cjb@laptop.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

---

Depends on "mmc: tmio: Allow SDHI MMC to use multiple IRQ vectors"
---
 arch/arm/mach-shmobile/board-ap4evb.c   |   24 +++++++++++++---
 arch/arm/mach-shmobile/board-mackerel.c |   30 ++++++++++++++++++--
 arch/arm/mach-shmobile/intc-sh7372.c    |   46 +++++++++++++++---------------
 3 files changed, 70 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 1e35fa9..8acb44f 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -316,8 +316,16 @@ static struct resource sdhi0_resources[] = {
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start  = evt2irq(0x0e00) /* SDHI0 */,
-		.flags  = IORESOURCE_IRQ,
+		.start	= evt2irq(0x0e00) /* SDHI0_SDHI0I0 */,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= evt2irq(0x0e20) /* SDHI0_SDHI0I1 */,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[3] = {
+		.start	= evt2irq(0x0e40) /* SDHI0_SDHI0I2 */,
+		.flags	= IORESOURCE_IRQ,
 	},
 };
 
@@ -349,8 +357,16 @@ static struct resource sdhi1_resources[] = {
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start  = evt2irq(0x0e80),
-		.flags  = IORESOURCE_IRQ,
+		.start	= evt2irq(0x0e80), /* SDHI1_SDHI1I0 */
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= evt2irq(0x0ea0), /* SDHI1_SDHI1I1 */
+		.flags	= IORESOURCE_IRQ,
+	},
+	[3] = {
+		.start	= evt2irq(0x0ec0), /* SDHI1_SDHI1I2 */
+		.flags	= IORESOURCE_IRQ,
 	},
 };
 
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 7da2ca2..4a49ac5 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -690,7 +690,15 @@ static struct resource sdhi0_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= evt2irq(0x0e00) /* SDHI0 */,
+		.start	= evt2irq(0x0e00) /* SDHI0_SDHI0I0 */,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= evt2irq(0x0e20) /* SDHI0_SDHI0I1 */,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[3] = {
+		.start	= evt2irq(0x0e40) /* SDHI0_SDHI0I2 */,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -725,7 +733,15 @@ static struct resource sdhi1_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= evt2irq(0x0e80),
+		.start	= evt2irq(0x0e80), /* SDHI1_SDHI1I0 */
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= evt2irq(0x0ea0), /* SDHI1_SDHI1I1 */
+		.flags	= IORESOURCE_IRQ,
+	},
+	[3] = {
+		.start	= evt2irq(0x0ec0), /* SDHI1_SDHI1I2 */
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -768,7 +784,15 @@ static struct resource sdhi2_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= evt2irq(0x1200),
+		.start	= evt2irq(0x1200), /* SDHI2_SDHI2I0 */
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= evt2irq(0x1220), /* SDHI2_SDHI2I1 */
+		.flags	= IORESOURCE_IRQ,
+	},
+	[3] = {
+		.start	= evt2irq(0x1240), /* SDHI2_SDHI2I2 */
 		.flags	= IORESOURCE_IRQ,
 	},
 };
diff --git a/arch/arm/mach-shmobile/intc-sh7372.c b/arch/arm/mach-shmobile/intc-sh7372.c
index 7a4960f..3b28743 100644
--- a/arch/arm/mach-shmobile/intc-sh7372.c
+++ b/arch/arm/mach-shmobile/intc-sh7372.c
@@ -27,8 +27,6 @@
 
 enum {
 	UNUSED_INTCA = 0,
-	ENABLED,
-	DISABLED,
 
 	/* interrupt sources INTCA */
 	IRQ0A, IRQ1A, IRQ2A, IRQ3A, IRQ4A, IRQ5A, IRQ6A, IRQ7A,
@@ -49,14 +47,14 @@ enum {
 	MSIOF2, MSIOF1,
 	SCIFA4, SCIFA5, SCIFB,
 	FLCTL_FLSTEI, FLCTL_FLTENDI, FLCTL_FLTREQ0I, FLCTL_FLTREQ1I,
-	SDHI0,
-	SDHI1,
+	SDHI0_SDHI0I0, SDHI0_SDHI0I1, SDHI0_SDHI0I2, SDHI0_SDHI0I3,
+	SDHI1_SDHI1I0, SDHI1_SDHI1I1, SDHI1_SDHI1I2,
 	IRREM,
 	IRDA,
 	TPU0,
 	TTI20,
 	DDM,
-	SDHI2,
+	SDHI2_SDHI2I0, SDHI2_SDHI2I1, SDHI2_SDHI2I2, SDHI2_SDHI2I3,
 	RWDT0,
 	DMAC1_1_DEI0, DMAC1_1_DEI1, DMAC1_1_DEI2, DMAC1_1_DEI3,
 	DMAC1_2_DEI4, DMAC1_2_DEI5, DMAC1_2_DADERR,
@@ -84,7 +82,7 @@ enum {
 
 	/* interrupt groups INTCA */
 	DMAC1_1, DMAC1_2, DMAC2_1, DMAC2_2, DMAC3_1, DMAC3_2, SHWYSTAT,
-	AP_ARM1, AP_ARM2, SPU2, FLCTL, IIC1
+	AP_ARM1, AP_ARM2, SPU2, FLCTL, IIC1, SDHI0, SDHI1, SDHI2
 };
 
 static struct intc_vect intca_vectors[] __initdata = {
@@ -125,17 +123,17 @@ static struct intc_vect intca_vectors[] __initdata = {
 	INTC_VECT(SCIFB, 0x0d60),
 	INTC_VECT(FLCTL_FLSTEI, 0x0d80), INTC_VECT(FLCTL_FLTENDI, 0x0da0),
 	INTC_VECT(FLCTL_FLTREQ0I, 0x0dc0), INTC_VECT(FLCTL_FLTREQ1I, 0x0de0),
-	INTC_VECT(SDHI0, 0x0e00), INTC_VECT(SDHI0, 0x0e20),
-	INTC_VECT(SDHI0, 0x0e40), INTC_VECT(SDHI0, 0x0e60),
-	INTC_VECT(SDHI1, 0x0e80), INTC_VECT(SDHI1, 0x0ea0),
-	INTC_VECT(SDHI1, 0x0ec0),
+	INTC_VECT(SDHI0_SDHI0I0, 0x0e00), INTC_VECT(SDHI0_SDHI0I1, 0x0e20),
+	INTC_VECT(SDHI0_SDHI0I2, 0x0e40), INTC_VECT(SDHI0_SDHI0I3, 0x0e60),
+	INTC_VECT(SDHI1_SDHI1I0, 0x0e80), INTC_VECT(SDHI1_SDHI1I1, 0x0ea0),
+	INTC_VECT(SDHI1_SDHI1I2, 0x0ec0),
 	INTC_VECT(IRREM, 0x0f60),
 	INTC_VECT(IRDA, 0x0480),
 	INTC_VECT(TPU0, 0x04a0),
 	INTC_VECT(TTI20, 0x1100),
 	INTC_VECT(DDM, 0x1140),
-	INTC_VECT(SDHI2, 0x1200), INTC_VECT(SDHI2, 0x1220),
-	INTC_VECT(SDHI2, 0x1240), INTC_VECT(SDHI2, 0x1260),
+	INTC_VECT(SDHI2_SDHI2I0, 0x1200), INTC_VECT(SDHI2_SDHI2I1, 0x1220),
+	INTC_VECT(SDHI2_SDHI2I2, 0x1240), INTC_VECT(SDHI2_SDHI2I3, 0x1260),
 	INTC_VECT(RWDT0, 0x1280),
 	INTC_VECT(DMAC1_1_DEI0, 0x2000), INTC_VECT(DMAC1_1_DEI1, 0x2020),
 	INTC_VECT(DMAC1_1_DEI2, 0x2040), INTC_VECT(DMAC1_1_DEI3, 0x2060),
@@ -195,6 +193,12 @@ static struct intc_group intca_groups[] __initdata = {
 	INTC_GROUP(FLCTL, FLCTL_FLSTEI, FLCTL_FLTENDI,
 		   FLCTL_FLTREQ0I, FLCTL_FLTREQ1I),
 	INTC_GROUP(IIC1, IIC1_ALI1, IIC1_TACKI1, IIC1_WAITI1, IIC1_DTEI1),
+	INTC_GROUP(SDHI0, SDHI0_SDHI0I0, SDHI0_SDHI0I1,
+		   SDHI0_SDHI0I2, SDHI0_SDHI0I3),
+	INTC_GROUP(SDHI1, SDHI1_SDHI1I0, SDHI1_SDHI1I1,
+		   SDHI1_SDHI1I2),
+	INTC_GROUP(SDHI2, SDHI2_SDHI2I0, SDHI2_SDHI2I1,
+		   SDHI2_SDHI2I2, SDHI2_SDHI2I3),
 	INTC_GROUP(SHWYSTAT, SHWYSTAT_RT, SHWYSTAT_HS, SHWYSTAT_COM),
 };
 
@@ -230,10 +234,10 @@ static struct intc_mask_reg intca_mask_registers[] __initdata = {
 	  { SCIFB, SCIFA5, SCIFA4, MSIOF1,
 	    0, 0, MSIOF2, 0 } },
 	{ 0xe694009c, 0xe69400dc, 8, /* IMR7A / IMCR7A */
-	  { DISABLED, ENABLED, ENABLED, ENABLED,
+	  { SDHI0_SDHI0I3, SDHI0_SDHI0I2, SDHI0_SDHI0I1, SDHI0_SDHI0I0,
 	    FLCTL_FLTREQ1I, FLCTL_FLTREQ0I, FLCTL_FLTENDI, FLCTL_FLSTEI } },
 	{ 0xe69400a0, 0xe69400e0, 8, /* IMR8A / IMCR8A */
-	  { 0, ENABLED, ENABLED, ENABLED,
+	  { 0, SDHI1_SDHI1I2, SDHI1_SDHI1I1, SDHI1_SDHI1I0,
 	    TTI20, USBHSDMAC0_USHDMI, 0, 0 } },
 	{ 0xe69400a4, 0xe69400e4, 8, /* IMR9A / IMCR9A */
 	  { CMT1_CMT13, CMT1_CMT12, CMT1_CMT11, CMT1_CMT10,
@@ -248,7 +252,7 @@ static struct intc_mask_reg intca_mask_registers[] __initdata = {
 	  { 0, 0, TPU0, 0,
 	    0, 0, 0, 0 } },
 	{ 0xe69400b4, 0xe69400f4, 8, /* IMR13A / IMCR13A */
-	  { DISABLED, DISABLED, ENABLED, ENABLED,
+	  { SDHI2_SDHI2I3, SDHI2_SDHI2I2, SDHI2_SDHI2I1, SDHI2_SDHI2I0,
 	    0, CMT3, 0, RWDT0 } },
 	{ 0xe6950080, 0xe69500c0, 8, /* IMR0A3 / IMCR0A3 */
 	  { SHWYSTAT_RT, SHWYSTAT_HS, SHWYSTAT_COM, 0,
@@ -354,14 +358,10 @@ static struct intc_mask_reg intca_ack_registers[] __initdata = {
 	  { IRQ24A, IRQ25A, IRQ26A, IRQ27A, IRQ28A, IRQ29A, IRQ30A, IRQ31A } },
 };
 
-static struct intc_desc intca_desc __initdata = {
-	.name = "sh7372-intca",
-	.force_enable = ENABLED,
-	.force_disable = DISABLED,
-	.hw = INTC_HW_DESC(intca_vectors, intca_groups,
-			   intca_mask_registers, intca_prio_registers,
-			   intca_sense_registers, intca_ack_registers),
-};
+static DECLARE_INTC_DESC_ACK(intca_desc, "sh7372-intca",
+			     intca_vectors, intca_groups,
+			     intca_mask_registers, intca_prio_registers,
+			     intca_sense_registers, intca_ack_registers);
 
 enum {
 	UNUSED_INTCS = 0,
-- 
1.7.4.1

