From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 10 Mar 2010 05:17:24 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7372 SDHI vector merge
Message-Id: <20100310051724.23840.68979.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Merge the SDHI vectors for sh7372 using the recently
merged INTC force_enable/disable feature.

With this in place SDHI hotplug is supported using
the drivers sh_mobile_sdhi and tmio_mmc.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on INTC patches available in 2.6.34-rc1

 arch/arm/mach-shmobile/intc-sh7372.c |   46 +++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 23 deletions(-)

--- 0001/arch/arm/mach-shmobile/intc-sh7372.c
+++ work/arch/arm/mach-shmobile/intc-sh7372.c	2010-03-09 19:01:36.000000000 +0900
@@ -27,6 +27,8 @@
 
 enum {
 	UNUSED_INTCA = 0,
+	ENABLED,
+	DISABLED,
 
 	/* interrupt sources INTCA */
 	IRQ0A, IRQ1A, IRQ2A, IRQ3A, IRQ4A, IRQ5A, IRQ6A, IRQ7A,
@@ -47,14 +49,14 @@ enum {
 	MSIOF2, MSIOF1,
 	SCIFA4, SCIFA5, SCIFB,
 	FLCTL_FLSTEI, FLCTL_FLTENDI, FLCTL_FLTREQ0I, FLCTL_FLTREQ1I,
-	SDHI0_SDHI0I0, SDHI0_SDHI0I1, SDHI0_SDHI0I2, SDHI0_SDHI0I3,
-	SDHI1_SDHI1I0, SDHI1_SDHI1I1, SDHI1_SDHI1I2,
+	SDHI0,
+	SDHI1,
 	IRREM,
 	IRDA,
 	TPU0,
 	TTI20,
 	DDM,
-	SDHI2_SDHI2I0, SDHI2_SDHI2I1, SDHI2_SDHI2I2, SDHI2_SDHI2I3,
+	SDHI2,
 	RWDT0,
 	DMAC1_1_DEI0, DMAC1_1_DEI1, DMAC1_1_DEI2, DMAC1_1_DEI3,
 	DMAC1_2_DEI4, DMAC1_2_DEI5, DMAC1_2_DADERR,
@@ -82,7 +84,7 @@ enum {
 
 	/* interrupt groups INTCA */
 	DMAC1_1, DMAC1_2, DMAC2_1, DMAC2_2, DMAC3_1, DMAC3_2, SHWYSTAT,
-	AP_ARM1, AP_ARM2, SPU2, FLCTL, IIC1, SDHI0, SDHI1, SDHI2
+	AP_ARM1, AP_ARM2, SPU2, FLCTL, IIC1
 };
 
 static struct intc_vect intca_vectors[] __initdata = {
@@ -123,17 +125,17 @@ static struct intc_vect intca_vectors[] 
 	INTC_VECT(SCIFB, 0x0d60),
 	INTC_VECT(FLCTL_FLSTEI, 0x0d80), INTC_VECT(FLCTL_FLTENDI, 0x0da0),
 	INTC_VECT(FLCTL_FLTREQ0I, 0x0dc0), INTC_VECT(FLCTL_FLTREQ1I, 0x0de0),
-	INTC_VECT(SDHI0_SDHI0I0, 0x0e00), INTC_VECT(SDHI0_SDHI0I1, 0x0e20),
-	INTC_VECT(SDHI0_SDHI0I2, 0x0e40), INTC_VECT(SDHI0_SDHI0I3, 0x0e60),
-	INTC_VECT(SDHI1_SDHI1I0, 0x0e80), INTC_VECT(SDHI1_SDHI1I1, 0x0ea0),
-	INTC_VECT(SDHI1_SDHI1I2, 0x0ec0),
+	INTC_VECT(SDHI0, 0x0e00), INTC_VECT(SDHI0, 0x0e20),
+	INTC_VECT(SDHI0, 0x0e40), INTC_VECT(SDHI0, 0x0e60),
+	INTC_VECT(SDHI1, 0x0e80), INTC_VECT(SDHI1, 0x0ea0),
+	INTC_VECT(SDHI1, 0x0ec0),
 	INTC_VECT(IRREM, 0x0f60),
 	INTC_VECT(IRDA, 0x0480),
 	INTC_VECT(TPU0, 0x04a0),
 	INTC_VECT(TTI20, 0x1100),
 	INTC_VECT(DDM, 0x1140),
-	INTC_VECT(SDHI2_SDHI2I0, 0x1200), INTC_VECT(SDHI2_SDHI2I1, 0x1220),
-	INTC_VECT(SDHI2_SDHI2I2, 0x1240), INTC_VECT(SDHI2_SDHI2I3, 0x1260),
+	INTC_VECT(SDHI2, 0x1200), INTC_VECT(SDHI2, 0x1220),
+	INTC_VECT(SDHI2, 0x1240), INTC_VECT(SDHI2, 0x1260),
 	INTC_VECT(RWDT0, 0x1280),
 	INTC_VECT(DMAC1_1_DEI0, 0x2000), INTC_VECT(DMAC1_1_DEI1, 0x2020),
 	INTC_VECT(DMAC1_1_DEI2, 0x2040), INTC_VECT(DMAC1_1_DEI3, 0x2060),
@@ -193,12 +195,6 @@ static struct intc_group intca_groups[] 
 	INTC_GROUP(FLCTL, FLCTL_FLSTEI, FLCTL_FLTENDI,
 		   FLCTL_FLTREQ0I, FLCTL_FLTREQ1I),
 	INTC_GROUP(IIC1, IIC1_ALI1, IIC1_TACKI1, IIC1_WAITI1, IIC1_DTEI1),
-	INTC_GROUP(SDHI0, SDHI0_SDHI0I0, SDHI0_SDHI0I1,
-		   SDHI0_SDHI0I2, SDHI0_SDHI0I3),
-	INTC_GROUP(SDHI1, SDHI1_SDHI1I0, SDHI1_SDHI1I1,
-		   SDHI1_SDHI1I2),
-	INTC_GROUP(SDHI2, SDHI2_SDHI2I0, SDHI2_SDHI2I1,
-		   SDHI2_SDHI2I2, SDHI2_SDHI2I3),
 	INTC_GROUP(SHWYSTAT, SHWYSTAT_RT, SHWYSTAT_HS, SHWYSTAT_COM),
 };
 
@@ -234,10 +230,10 @@ static struct intc_mask_reg intca_mask_r
 	  { SCIFB, SCIFA5, SCIFA4, MSIOF1,
 	    0, 0, MSIOF2, 0 } },
 	{ 0xe694009c, 0xe69400dc, 8, /* IMR7A / IMCR7A */
-	  { SDHI0_SDHI0I3, SDHI0_SDHI0I2, SDHI0_SDHI0I1, SDHI0_SDHI0I0,
+	  { DISABLED, DISABLED, ENABLED, ENABLED,
 	    FLCTL_FLTREQ1I, FLCTL_FLTREQ0I, FLCTL_FLTENDI, FLCTL_FLSTEI } },
 	{ 0xe69400a0, 0xe69400e0, 8, /* IMR8A / IMCR8A */
-	  { 0, SDHI1_SDHI1I2, SDHI1_SDHI1I1, SDHI1_SDHI1I0,
+	  { 0, DISABLED, ENABLED, ENABLED,
 	    TTI20, USBHSDMAC0_USHDMI, 0, 0 } },
 	{ 0xe69400a4, 0xe69400e4, 8, /* IMR9A / IMCR9A */
 	  { CMT1_CMT13, CMT1_CMT12, CMT1_CMT11, CMT1_CMT10,
@@ -252,7 +248,7 @@ static struct intc_mask_reg intca_mask_r
 	  { 0, 0, TPU0, 0,
 	    0, 0, 0, 0 } },
 	{ 0xe69400b4, 0xe69400f4, 8, /* IMR13A / IMCR13A */
-	  { SDHI2_SDHI2I3, SDHI2_SDHI2I2, SDHI2_SDHI2I1, SDHI2_SDHI2I0,
+	  { DISABLED, DISABLED, ENABLED, ENABLED,
 	    0, CMT3, 0, RWDT0 } },
 	{ 0xe6950080, 0xe69500c0, 8, /* IMR0A3 / IMCR0A3 */
 	  { SHWYSTAT_RT, SHWYSTAT_HS, SHWYSTAT_COM, 0,
@@ -358,10 +354,14 @@ static struct intc_mask_reg intca_ack_re
 	  { IRQ24A, IRQ25A, IRQ26A, IRQ27A, IRQ28A, IRQ29A, IRQ30A, IRQ31A } },
 };
 
-static DECLARE_INTC_DESC_ACK(intca_desc, "sh7372-intca",
-			     intca_vectors, intca_groups,
-			     intca_mask_registers, intca_prio_registers,
-			     intca_sense_registers, intca_ack_registers);
+static struct intc_desc intca_desc __initdata = {
+	.name = "sh7372-intca",
+	.force_enable = ENABLED,
+	.force_disable = DISABLED,
+	.hw = INTC_HW_DESC(intca_vectors, intca_groups,
+			   intca_mask_registers, intca_prio_registers,
+			   intca_sense_registers, intca_ack_registers),
+};
 
 void __init sh7372_init_irq(void)
 {
