From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Fri, 12 Feb 2010 09:55:08 +0000
Subject: [PATCH] ARM: mach-shmobile: intc-sh7372 tidyup
Message-Id: <u7hqi7p8j.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch is based on Rev 0.5 manual

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/arm/mach-shmobile/intc-sh7372.c |   90 +++++++++++++++++----------------
 1 files changed, 46 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-shmobile/intc-sh7372.c b/arch/arm/mach-shmobile/intc-sh7372.c
index c6e747f..c57a923 100644
--- a/arch/arm/mach-shmobile/intc-sh7372.c
+++ b/arch/arm/mach-shmobile/intc-sh7372.c
@@ -39,8 +39,7 @@ enum {
 	AP_ARM_IRQPMU, AP_ARM_COMMTX, AP_ARM_COMMRX,
 	MFI_MFIM, MFI_MFIS,
 	BBIF1, BBIF2,
-	USBHSDMAC_USHDMI,
-	USBHS_USHI0, USBHS_USHI1,
+	USBHSDMAC0_USHDMI,
 	_3DG_SGX540,
 	CMT1_CMT10, CMT1_CMT11, CMT1_CMT12, CMT1_CMT13, CMT2, CMT3,
 	KEYSC_KEY,
@@ -57,8 +56,8 @@ enum {
 	DDM,
 	SDHI2_SDHI2I0, SDHI2_SDHI2I1, SDHI2_SDHI2I2, SDHI2_SDHI2I3,
 	RWDT0,
-	DMAC_1_DEI0, DMAC_1_DEI1, DMAC_1_DEI2, DMAC_1_DEI3,
-	DMAC_2_DEI4, DMAC_2_DEI5, DMAC_2_DADERR,
+	DMAC1_1_DEI0, DMAC1_1_DEI1, DMAC1_1_DEI2, DMAC1_1_DEI3,
+	DMAC1_2_DEI4, DMAC1_2_DEI5, DMAC1_2_DADERR,
 	DMAC2_1_DEI0, DMAC2_1_DEI1, DMAC2_1_DEI2, DMAC2_1_DEI3,
 	DMAC2_2_DEI4, DMAC2_2_DEI5, DMAC2_2_DADERR,
 	DMAC3_1_DEI0, DMAC3_1_DEI1, DMAC3_1_DEI2, DMAC3_1_DEI3,
@@ -69,7 +68,7 @@ enum {
 	FSI, FMSI,
 	MIPI_HSI,
 	IPMMU_IPMMUD,
-	CEC_CEC_1, CEC_CEC_2,
+	CEC_1, CEC_2,
 	AP_ARM_CTIIRQ, AP_ARM_DMAEXTERRIRQ, AP_ARM_DMAIRQ, AP_ARM_DMASIRQ,
 	MFIS2,
 	CPORTR2S,
@@ -79,14 +78,14 @@ enum {
 	IIC3_ALI3, IIC3_TACKI3, IIC3_WAITI3, IIC3_DTEI3,
 	USB0_USB0I1, USB0_USB0I0,
 	USB1_USB1I1, USB1_USB1I0,
-	USHSDMI,
+	USBHSDMAC1_USHDMI,
 
 	/* interrupt groups INTCA */
-	DMAC_1, DMAC_2,	DMAC2_1, DMAC2_2, DMAC3_1, DMAC3_2, SHWYSTAT,
-	AP_ARM1, AP_ARM2, USBHS, SPU2, FLCTL, IIC1, SDHI0, SDHI1, SDHI2
+	DMAC1_1, DMAC1_2, DMAC2_1, DMAC2_2, DMAC3_1, DMAC3_2, SHWYSTAT,
+	AP_ARM1, AP_ARM2, SPU2, FLCTL, IIC1, SDHI0, SDHI1, SDHI2
 };
 
-static struct intc_vect intca_vectors[] = {
+static struct intc_vect intca_vectors[] __initdata = {
 	INTC_VECT(IRQ0A, 0x0200), INTC_VECT(IRQ1A, 0x0220),
 	INTC_VECT(IRQ2A, 0x0240), INTC_VECT(IRQ3A, 0x0260),
 	INTC_VECT(IRQ4A, 0x0280), INTC_VECT(IRQ5A, 0x02a0),
@@ -111,8 +110,7 @@ static struct intc_vect intca_vectors[] = {
 	INTC_VECT(AP_ARM_COMMRX, 0x0860),
 	INTC_VECT(MFI_MFIM, 0x0900), INTC_VECT(MFI_MFIS, 0x0920),
 	INTC_VECT(BBIF1, 0x0940), INTC_VECT(BBIF2, 0x0960),
-	INTC_VECT(USBHSDMAC_USHDMI, 0x0a00),
-	INTC_VECT(USBHS_USHI0, 0x0a20), INTC_VECT(USBHS_USHI1, 0x0a40),
+	INTC_VECT(USBHSDMAC0_USHDMI, 0x0a00),
 	INTC_VECT(_3DG_SGX540, 0x0a60),
 	INTC_VECT(CMT1_CMT10, 0x0b00), INTC_VECT(CMT1_CMT11, 0x0b20),
 	INTC_VECT(CMT1_CMT12, 0x0b40), INTC_VECT(CMT1_CMT13, 0x0b60),
@@ -137,10 +135,10 @@ static struct intc_vect intca_vectors[] = {
 	INTC_VECT(SDHI2_SDHI2I0, 0x1200), INTC_VECT(SDHI2_SDHI2I1, 0x1220),
 	INTC_VECT(SDHI2_SDHI2I2, 0x1240), INTC_VECT(SDHI2_SDHI2I3, 0x1260),
 	INTC_VECT(RWDT0, 0x1280),
-	INTC_VECT(DMAC_1_DEI0, 0x2000), INTC_VECT(DMAC_1_DEI1, 0x2020),
-	INTC_VECT(DMAC_1_DEI2, 0x2040), INTC_VECT(DMAC_1_DEI3, 0x2060),
-	INTC_VECT(DMAC_2_DEI4, 0x2080), INTC_VECT(DMAC_2_DEI5, 0x20a0),
-	INTC_VECT(DMAC_2_DADERR, 0x20c0),
+	INTC_VECT(DMAC1_1_DEI0, 0x2000), INTC_VECT(DMAC1_1_DEI1, 0x2020),
+	INTC_VECT(DMAC1_1_DEI2, 0x2040), INTC_VECT(DMAC1_1_DEI3, 0x2060),
+	INTC_VECT(DMAC1_2_DEI4, 0x2080), INTC_VECT(DMAC1_2_DEI5, 0x20a0),
+	INTC_VECT(DMAC1_2_DADERR, 0x20c0),
 	INTC_VECT(DMAC2_1_DEI0, 0x2100), INTC_VECT(DMAC2_1_DEI1, 0x2120),
 	INTC_VECT(DMAC2_1_DEI2, 0x2140), INTC_VECT(DMAC2_1_DEI3, 0x2160),
 	INTC_VECT(DMAC2_2_DEI4, 0x2180), INTC_VECT(DMAC2_2_DEI5, 0x21a0),
@@ -149,7 +147,7 @@ static struct intc_vect intca_vectors[] = {
 	INTC_VECT(DMAC3_1_DEI2, 0x2240), INTC_VECT(DMAC3_1_DEI3, 0x2260),
 	INTC_VECT(DMAC3_2_DEI4, 0x2280), INTC_VECT(DMAC3_2_DEI5, 0x22a0),
 	INTC_VECT(DMAC3_2_DADERR, 0x22c0),
-	INTC_VECT(SHWYSTAT_RT, 0x1300), INTC_VECT(SHWYSTAT_HS, 0x1d20),
+	INTC_VECT(SHWYSTAT_RT, 0x1300), INTC_VECT(SHWYSTAT_HS, 0x1320),
 	INTC_VECT(SHWYSTAT_COM, 0x1340),
 	INTC_VECT(HDMI, 0x17e0),
 	INTC_VECT(SPU2_SPU0, 0x1800), INTC_VECT(SPU2_SPU1, 0x1820),
@@ -157,7 +155,7 @@ static struct intc_vect intca_vectors[] = {
 	INTC_VECT(FMSI, 0x1860),
 	INTC_VECT(MIPI_HSI, 0x18e0),
 	INTC_VECT(IPMMU_IPMMUD, 0x1920),
-	INTC_VECT(CEC_CEC_1, 0x1940), INTC_VECT(CEC_CEC_2, 0x1960),
+	INTC_VECT(CEC_1, 0x1940), INTC_VECT(CEC_2, 0x1960),
 	INTC_VECT(AP_ARM_CTIIRQ, 0x1980),
 	INTC_VECT(AP_ARM_DMAEXTERRIRQ, 0x19a0),
 	INTC_VECT(AP_ARM_DMAIRQ, 0x19c0),
@@ -172,14 +170,14 @@ static struct intc_vect intca_vectors[] = {
 	INTC_VECT(IIC3_WAITI3, 0x1bc0), INTC_VECT(IIC3_DTEI3, 0x1be0),
 	INTC_VECT(USB0_USB0I1, 0x1c80), INTC_VECT(USB0_USB0I0, 0x1ca0),
 	INTC_VECT(USB1_USB1I1, 0x1cc0), INTC_VECT(USB1_USB1I0, 0x1ce0),
-	INTC_VECT(USHSDMI, 0x1d00),
+	INTC_VECT(USBHSDMAC1_USHDMI, 0x1d00),
 };
 
 static struct intc_group intca_groups[] __initdata = {
-	INTC_GROUP(DMAC_1, DMAC_1_DEI0,
-		   DMAC_1_DEI1, DMAC_1_DEI2, DMAC_1_DEI3),
-	INTC_GROUP(DMAC_2, DMAC_2_DEI4,
-		   DMAC_2_DEI5, DMAC_2_DADERR),
+	INTC_GROUP(DMAC1_1, DMAC1_1_DEI0,
+		   DMAC1_1_DEI1, DMAC1_1_DEI2, DMAC1_1_DEI3),
+	INTC_GROUP(DMAC1_2, DMAC1_2_DEI4,
+		   DMAC1_2_DEI5, DMAC1_2_DADERR),
 	INTC_GROUP(DMAC2_1, DMAC2_1_DEI0,
 		   DMAC2_1_DEI1, DMAC2_1_DEI2, DMAC2_1_DEI3),
 	INTC_GROUP(DMAC2_2, DMAC2_2_DEI4,
@@ -188,8 +186,9 @@ static struct intc_group intca_groups[] __initdata = {
 		   DMAC3_1_DEI1, DMAC3_1_DEI2, DMAC3_1_DEI3),
 	INTC_GROUP(DMAC3_2, DMAC3_2_DEI4,
 		   DMAC3_2_DEI5, DMAC3_2_DADERR),
-	INTC_GROUP(AP_ARM1, AP_ARM_IRQPMU, AP_ARM_COMMTX, AP_ARM_COMMTX),
-	INTC_GROUP(USBHS, USBHS_USHI0, USBHS_USHI1),
+	INTC_GROUP(AP_ARM1, AP_ARM_IRQPMU, AP_ARM_COMMTX, AP_ARM_COMMRX),
+	INTC_GROUP(AP_ARM2, AP_ARM_CTIIRQ, AP_ARM_DMAEXTERRIRQ,
+		   AP_ARM_DMAIRQ, AP_ARM_DMASIRQ),
 	INTC_GROUP(SPU2, SPU2_SPU0, SPU2_SPU1),
 	INTC_GROUP(FLCTL, FLCTL_FLSTEI, FLCTL_FLTENDI,
 		   FLCTL_FLTREQ0I, FLCTL_FLTREQ1I),
@@ -203,7 +202,7 @@ static struct intc_group intca_groups[] __initdata = {
 	INTC_GROUP(SHWYSTAT, SHWYSTAT_RT, SHWYSTAT_HS, SHWYSTAT_COM),
 };
 
-static struct intc_mask_reg intca_mask_registers[] = {
+static struct intc_mask_reg intca_mask_registers[] __initdata = {
 	{ 0xe6900040, 0xe6900060, 8, /* INTMSK00A / INTMSKCLR00A */
 	  { IRQ0A, IRQ1A, IRQ2A, IRQ3A, IRQ4A, IRQ5A, IRQ6A, IRQ7A } },
 	{ 0xe6900044, 0xe6900064, 8, /* INTMSK10A / INTMSKCLR10A */
@@ -218,7 +217,7 @@ static struct intc_mask_reg intca_mask_registers[] = {
 	    AP_ARM_IRQPMU, 0, AP_ARM_COMMTX, AP_ARM_COMMRX } },
 	{ 0xe6940084, 0xe69400c4, 8, /* IMR1A / IMCR1A */
 	  { 0, CRYPT_STD, DIRC, 0,
-	    DMAC_1_DEI3, DMAC_1_DEI2, DMAC_1_DEI1, DMAC_1_DEI0 } },
+	    DMAC1_1_DEI3, DMAC1_1_DEI2, DMAC1_1_DEI1, DMAC1_1_DEI0 } },
 	{ 0xe6940088, 0xe69400c8, 8, /* IMR2A / IMCR2A */
 	  { 0, 0, 0, 0,
 	    BBIF1, BBIF2, MFI_MFIS, MFI_MFIM } },
@@ -229,7 +228,7 @@ static struct intc_mask_reg intca_mask_registers[] = {
 	  { DDM, 0, 0, 0,
 	    0, 0, 0, 0 } },
 	{ 0xe6940094, 0xe69400d4, 8, /* IMR5A / IMCR5A */
-	  { KEYSC_KEY, DMAC_2_DADERR, DMAC_2_DEI5, DMAC_2_DEI4,
+	  { KEYSC_KEY, DMAC1_2_DADERR, DMAC1_2_DEI5, DMAC1_2_DEI4,
 	    SCIFA3, SCIFA2, SCIFA1, SCIFA0 } },
 	{ 0xe6940098, 0xe69400d8, 8, /* IMR6A / IMCR6A */
 	  { SCIFB, SCIFA5, SCIFA4, MSIOF1,
@@ -239,7 +238,7 @@ static struct intc_mask_reg intca_mask_registers[] = {
 	    FLCTL_FLTREQ1I, FLCTL_FLTREQ0I, FLCTL_FLTENDI, FLCTL_FLSTEI } },
 	{ 0xe69400a0, 0xe69400e0, 8, /* IMR8A / IMCR8A */
 	  { 0, SDHI1_SDHI1I2, SDHI1_SDHI1I1, SDHI1_SDHI1I0,
-	    TTI20, USBHSDMAC_USHDMI, 0, 0 } },
+	    TTI20, USBHSDMAC0_USHDMI, 0, 0 } },
 	{ 0xe69400a4, 0xe69400e4, 8, /* IMR9A / IMCR9A */
 	  { CMT1_CMT13, CMT1_CMT12, CMT1_CMT11, CMT1_CMT10,
 	    CMT2, 0, 0, _3DG_SGX540 } },
@@ -265,7 +264,7 @@ static struct intc_mask_reg intca_mask_registers[] = {
 	  { SPU2_SPU0, SPU2_SPU1, FSI, FMSI,
 	    0, 0, 0, MIPI_HSI } },
 	{ 0xe6950098, 0xe69500d8, 8, /* IMR6A3 / IMCR6A3 */
-	  { 0, IPMMU_IPMMUD, CEC_CEC_1, CEC_CEC_2,
+	  { 0, IPMMU_IPMMUD, CEC_1, CEC_2,
 	    AP_ARM_CTIIRQ, AP_ARM_DMAEXTERRIRQ,
 	    AP_ARM_DMAIRQ, AP_ARM_DMASIRQ } },
 	{ 0xe695009c, 0xe69500dc, 8, /* IMR7A3 / IMCR7A3 */
@@ -278,16 +277,16 @@ static struct intc_mask_reg intca_mask_registers[] = {
 	  { 0, 0, 0, 0,
 	    USB0_USB0I1, USB0_USB0I0, USB1_USB1I1, USB1_USB1I0 } },
 	{ 0xe69500a8, 0xe69500e8, 8, /* IMR10A3 / IMCR10A3 */
-	  { USBHSDMAC_USHDMI, 0, 0, 0,
+	  { USBHSDMAC1_USHDMI, 0, 0, 0,
 	    0, 0, 0, 0 } },
 };
 
-static struct intc_prio_reg intca_prio_registers[] = {
+static struct intc_prio_reg intca_prio_registers[] __initdata = {
 	{ 0xe6900010, 0, 32, 4, /* INTPRI00A */
 	  { IRQ0A, IRQ1A, IRQ2A, IRQ3A, IRQ4A, IRQ5A, IRQ6A, IRQ7A } },
 	{ 0xe6900014, 0, 32, 4, /* INTPRI10A */
 	  { IRQ8A, IRQ9A, IRQ10A, IRQ11A, IRQ12A, IRQ13A, IRQ14A, IRQ15A } },
-	{ 0xe6900018, 0, 32, 4, /* INTPRI10A */
+	{ 0xe6900018, 0, 32, 4, /* INTPRI20A */
 	  { IRQ16A, IRQ17A, IRQ18A, IRQ19A, IRQ20A, IRQ21A, IRQ22A, IRQ23A } },
 	{ 0xe690001c, 0, 32, 4, /* INTPRI30A */
 	  { IRQ24A, IRQ25A, IRQ26A, IRQ27A, IRQ28A, IRQ29A, IRQ30A, IRQ31A } },
@@ -298,16 +297,18 @@ static struct intc_prio_reg intca_prio_registers[] = {
 					      CMT1_CMT11, AP_ARM1 } },
 	{ 0xe694000c, 0, 16, 4, /* IPRDA */ { 0, 0,
 					      CMT1_CMT12, 0 } },
-	{ 0xe6940010, 0, 16, 4, /* IPREA */ { DMAC_1, MFI_MFIS,
+	{ 0xe6940010, 0, 16, 4, /* IPREA */ { DMAC1_1, MFI_MFIS,
 					      MFI_MFIM, 0 } },
-	{ 0xe6940014, 0, 16, 4, /* IPRFA */ { KEYSC_KEY, DMAC_2,
+	{ 0xe6940014, 0, 16, 4, /* IPRFA */ { KEYSC_KEY, DMAC1_2,
 					      _3DG_SGX540, CMT1_CMT10 } },
 	{ 0xe6940018, 0, 16, 4, /* IPRGA */ { SCIFA0, SCIFA1,
 					      SCIFA2, SCIFA3 } },
-	{ 0xe694001c, 0, 16, 4, /* IPRGH */ { MSIOF2, USBHSDMAC_USHDMI,
+	{ 0xe694001c, 0, 16, 4, /* IPRGH */ { MSIOF2, USBHSDMAC0_USHDMI,
 					      FLCTL, SDHI0 } },
-	{ 0xe6940020, 0, 16, 4, /* IPRIA */ { MSIOF1, SCIFA4, 0, IIC1 } },
-	{ 0xe6940024, 0, 16, 4, /* IPRJA */ { DMAC2_1, DMAC2_2, 0, TTI20 } },
+	{ 0xe6940020, 0, 16, 4, /* IPRIA */ { MSIOF1, SCIFA4,
+					      0/* MSU */, IIC1 } },
+	{ 0xe6940024, 0, 16, 4, /* IPRJA */ { DMAC2_1, DMAC2_2,
+					      0/* MSUG */, TTI20 } },
 	{ 0xe6940028, 0, 16, 4, /* IPRKA */ { 0, CMT1_CMT13, IRREM, SDHI1 } },
 	{ 0xe694002c, 0, 16, 4, /* IPRLA */ { TPU0, 0, 0, 0 } },
 	{ 0xe6940030, 0, 16, 4, /* IPRMA */ { 0, CMT3, 0, RWDT0 } },
@@ -318,7 +319,7 @@ static struct intc_prio_reg intca_prio_registers[] = {
 	{ 0xe6950028, 0, 16, 4, /* IPRKA3 */ { SPU2, 0, FSI, FMSI } },
 	{ 0xe695002c, 0, 16, 4, /* IPRLA3 */ { 0, 0, 0, MIPI_HSI } },
 	{ 0xe6950030, 0, 16, 4, /* IPRMA3 */ { IPMMU_IPMMUD, 0,
-					       CEC_CEC_1, CEC_CEC_2 } },
+					       CEC_1, CEC_2 } },
 	{ 0xe6950034, 0, 16, 4, /* IPRNA3 */ { AP_ARM2, 0, 0, 0 } },
 	{ 0xe6950038, 0, 16, 4, /* IPROA3 */ { MFIS2, CPORTR2S,
 					       CMT14, CMT15 } },
@@ -328,20 +329,21 @@ static struct intc_prio_reg intca_prio_registers[] = {
 					       IIC4_WAITI4, IIC4_DTEI4 } },
 	{ 0xe6940044, 0, 16, 4, /* IPRRA3 */ { IIC3_ALI3, IIC3_TACKI3,
 					       IIC3_WAITI3, IIC3_DTEI3 } },
-	{ 0xe6940048, 0, 16, 4, /* IPRSA3 */ { 0, 0, 0, 0 } },
+	{ 0xe6940048, 0, 16, 4, /* IPRSA3 */ { 0/*ERI*/, 0/*RXI*/,
+					       0/*TXI*/, 0/*TEI*/} },
 	{ 0xe694004c, 0, 16, 4, /* IPRTA3 */ { USB0_USB0I1, USB0_USB0I0,
 					       USB1_USB1I1, USB1_USB1I0 } },
-	{ 0xe6940050, 0, 16, 4, /* IPRUA3 */ { USBHSDMAC_USHDMI, 0, 0, 0 } },
+	{ 0xe6940050, 0, 16, 4, /* IPRUA3 */ { USBHSDMAC1_USHDMI, 0, 0, 0 } },
 };
 
 static struct intc_sense_reg intca_sense_registers[] __initdata = {
-	{ 0xe6900000, 16, 2, /* ICR1A */
+	{ 0xe6900000, 32, 4, /* ICR1A */
 	  { IRQ0A, IRQ1A, IRQ2A, IRQ3A, IRQ4A, IRQ5A, IRQ6A, IRQ7A } },
-	{ 0xe6900004, 16, 2, /* ICR2A */
+	{ 0xe6900004, 32, 4, /* ICR2A */
 	  { IRQ8A, IRQ9A, IRQ10A, IRQ11A, IRQ12A, IRQ13A, IRQ14A, IRQ15A } },
-	{ 0xe6900008, 16, 2, /* ICR3A */
+	{ 0xe6900008, 32, 4, /* ICR3A */
 	  { IRQ16A, IRQ17A, IRQ18A, IRQ19A, IRQ20A, IRQ21A, IRQ22A, IRQ23A } },
-	{ 0xe690000c, 16, 2, /* ICR4A */
+	{ 0xe690000c, 32, 4, /* ICR4A */
 	  { IRQ24A, IRQ25A, IRQ26A, IRQ27A, IRQ28A, IRQ29A, IRQ30A, IRQ31A } },
 };
 
-- 
1.6.3.3

