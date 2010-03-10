From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 10 Mar 2010 05:15:16 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7377 SDHI vector merge
Message-Id: <20100310051516.23831.57810.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Merge the SDHI vectors for sh7377 using the recently
merged INTC force_enable/disable feature.

With this in place SDHI hotplug is supported using
the drivers sh_mobile_sdhi and tmio_mmc.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on INTC patches available in 2.6.34-rc1

 arch/arm/mach-shmobile/intc-sh7377.c |   36 +++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

--- 0001/arch/arm/mach-shmobile/intc-sh7377.c
+++ work/arch/arm/mach-shmobile/intc-sh7377.c	2010-03-09 19:28:05.000000000 +0900
@@ -27,6 +27,8 @@
 
 enum {
 	UNUSED_INTCA = 0,
+	ENABLED,
+	DISABLED,
 
 	/* interrupt sources INTCA */
 	IRQ0A, IRQ1A, IRQ2A, IRQ3A, IRQ4A, IRQ5A, IRQ6A, IRQ7A,
@@ -49,8 +51,8 @@ enum {
 	MSIOF2, MSIOF1,
 	SCIFA4, SCIFA5, SCIFB,
 	FLCTL_FLSTEI, FLCTL_FLTENDI, FLCTL_FLTREQ0I, FLCTL_FLTREQ1I,
-	SDHI0_SDHI0I0, SDHI0_SDHI0I1, SDHI0_SDHI0I2, SDHI0_SDHI0I3,
-	SDHI1_SDHI1I0, SDHI1_SDHI1I1, SDHI1_SDHI1I2, SDHI1_SDHI1I3,
+	SDHI0,
+	SDHI1,
 	MSU_MSU, MSU_MSU2,
 	IRREM,
 	MSUG,
@@ -84,7 +86,7 @@ enum {
 
 	/* interrupt groups INTCA */
 	DMAC_1, DMAC_2,	DMAC2_1, DMAC2_2, DMAC3_1, DMAC3_2, SHWYSTAT,
-	AP_ARM1, AP_ARM2, USBHS, SPU2, FLCTL, IIC1, SDHI0, SDHI1,
+	AP_ARM1, AP_ARM2, USBHS, SPU2, FLCTL, IIC1,
 	ICUSB, ICUDMC
 };
 
@@ -128,10 +130,10 @@ static struct intc_vect intca_vectors[] 
 	INTC_VECT(SCIFB, 0x0d60),
 	INTC_VECT(FLCTL_FLSTEI, 0x0d80), INTC_VECT(FLCTL_FLTENDI, 0x0da0),
 	INTC_VECT(FLCTL_FLTREQ0I, 0x0dc0), INTC_VECT(FLCTL_FLTREQ1I, 0x0de0),
-	INTC_VECT(SDHI0_SDHI0I0, 0x0e00), INTC_VECT(SDHI0_SDHI0I1, 0x0e20),
-	INTC_VECT(SDHI0_SDHI0I2, 0x0e40), INTC_VECT(SDHI0_SDHI0I3, 0x0e60),
-	INTC_VECT(SDHI1_SDHI1I0, 0x0e80), INTC_VECT(SDHI1_SDHI1I1, 0x0ea0),
-	INTC_VECT(SDHI1_SDHI1I2, 0x0ec0), INTC_VECT(SDHI1_SDHI1I3, 0x0ee0),
+	INTC_VECT(SDHI0, 0x0e00), INTC_VECT(SDHI0, 0x0e20),
+	INTC_VECT(SDHI0, 0x0e40), INTC_VECT(SDHI0, 0x0e60),
+	INTC_VECT(SDHI1, 0x0e80), INTC_VECT(SDHI1, 0x0ea0),
+	INTC_VECT(SDHI1, 0x0ec0), INTC_VECT(SDHI1, 0x0ee0),
 	INTC_VECT(MSU_MSU, 0x0f20), INTC_VECT(MSU_MSU2, 0x0f40),
 	INTC_VECT(IRREM, 0x0f60),
 	INTC_VECT(MSUG, 0x0fa0),
@@ -195,10 +197,6 @@ static struct intc_group intca_groups[] 
 	INTC_GROUP(FLCTL, FLCTL_FLSTEI, FLCTL_FLTENDI,
 		   FLCTL_FLTREQ0I, FLCTL_FLTREQ1I),
 	INTC_GROUP(IIC1, IIC1_ALI1, IIC1_TACKI1, IIC1_WAITI1, IIC1_DTEI1),
-	INTC_GROUP(SDHI0, SDHI0_SDHI0I0, SDHI0_SDHI0I1,
-		   SDHI0_SDHI0I2, SDHI0_SDHI0I3),
-	INTC_GROUP(SDHI1, SDHI1_SDHI1I0, SDHI1_SDHI1I1,
-		   SDHI1_SDHI1I2, SDHI1_SDHI1I3),
 	INTC_GROUP(SHWYSTAT, SHWYSTAT_RT, SHWYSTAT_HS, SHWYSTAT_COM),
 	INTC_GROUP(ICUSB, ICUSB_ICUSB0, ICUSB_ICUSB1),
 	INTC_GROUP(ICUDMC, ICUDMC_ICUDMC1, ICUDMC_ICUDMC2),
@@ -236,10 +234,10 @@ static struct intc_mask_reg intca_mask_r
 	  { SCIFB, SCIFA5, SCIFA4, MSIOF1,
 	    0, 0, MSIOF2, 0 } },
 	{ 0xe694009c, 0xe69400dc, 8, /* IMR7A / IMCR7A */
-	  { SDHI0_SDHI0I3, SDHI0_SDHI0I2, SDHI0_SDHI0I1, SDHI0_SDHI0I0,
+	  { DISABLED, DISABLED, ENABLED, ENABLED,
 	    FLCTL_FLTREQ1I, FLCTL_FLTREQ0I, FLCTL_FLTENDI, FLCTL_FLSTEI } },
 	{ 0xe69400a0, 0xe69400e0, 8, /* IMR8A / IMCR8A */
-	  { SDHI1_SDHI1I3, SDHI1_SDHI1I2, SDHI1_SDHI1I1, SDHI1_SDHI1I0,
+	  { DISABLED, DISABLED, ENABLED, ENABLED,
 	    TTI20, USBDMAC_USHDMI, 0, MSUG } },
 	{ 0xe69400a4, 0xe69400e4, 8, /* IMR9A / IMCR9A */
 	  { CMT1_CMT13, CMT1_CMT12, CMT1_CMT11, CMT1_CMT10,
@@ -339,10 +337,14 @@ static struct intc_mask_reg intca_ack_re
 	  { IRQ24A, IRQ25A, IRQ26A, IRQ27A, IRQ28A, IRQ29A, IRQ30A, IRQ31A } },
 };
 
-static DECLARE_INTC_DESC_ACK(intca_desc, "sh7377-intca",
-			     intca_vectors, intca_groups,
-			     intca_mask_registers, intca_prio_registers,
-			     intca_sense_registers, intca_ack_registers);
+static struct intc_desc intca_desc __initdata = {
+	.name = "sh7377-intca",
+	.force_enable = ENABLED,
+	.force_disable = DISABLED,
+	.hw = INTC_HW_DESC(intca_vectors, intca_groups,
+			   intca_mask_registers, intca_prio_registers,
+			   intca_sense_registers, intca_ack_registers),
+};
 
 void __init sh7377_init_irq(void)
 {
