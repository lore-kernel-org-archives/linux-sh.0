From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 11 May 2009 09:01:08 +0000
Subject: [PATCH] sh: multiple vectors per irq - sh7760
Message-Id: <20090511090108.32745.14458.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <49B0AF53.9090007@renesas.com>
In-Reply-To: <49B0AF53.9090007@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Update intc tables and platform data to use one linux irq
per maskable interrupt source instead of keeping the one-to-one
mapping between vectors and linux irqs.

This fixes potential irq masking issues for sh7760 hardware
blocks such as DMAC/TMU2/REF.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4/setup-sh7760.c |   31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh4/setup-sh7760.c
+++ work/arch/sh/kernel/cpu/sh4/setup-sh7760.c	2009-05-11 16:36:18.000000000 +0900
@@ -18,10 +18,7 @@ enum {
 
 	/* interrupt sources */
 	IRL0, IRL1, IRL2, IRL3,
-	HUDI, GPIOI,
-	DMAC_DMTE0, DMAC_DMTE1, DMAC_DMTE2, DMAC_DMTE3,
-	DMAC_DMTE4, DMAC_DMTE5, DMAC_DMTE6, DMAC_DMTE7,
-	DMAC_DMAE,
+	HUDI, GPIOI, DMAC,
 	IRQ4, IRQ5, IRQ6, IRQ7,
 	HCAN20, HCAN21,
 	SSI0, SSI1,
@@ -36,21 +33,20 @@ enum {
 	HSPI,
 	MMCIF0, MMCIF1, MMCIF2, MMCIF3,
 	MFI, ADC, CMT,
-	TMU0, TMU1, TMU2_TUNI, TMU2_TICPI,
-	WDT,
-	REF_RCMI, REF_ROVI,
+	TMU0, TMU1, TMU2,
+	WDT, REF,
 
 	/* interrupt groups */
-	DMAC, DMABRG, SCIF0, SCIF1, SCIF2, SIM, MMCIF, TMU2, REF,
+	DMABRG, SCIF0, SCIF1, SCIF2, SIM, MMCIF,
 };
 
 static struct intc_vect vectors[] __initdata = {
 	INTC_VECT(HUDI, 0x600), INTC_VECT(GPIOI, 0x620),
-	INTC_VECT(DMAC_DMTE0, 0x640), INTC_VECT(DMAC_DMTE1, 0x660),
-	INTC_VECT(DMAC_DMTE2, 0x680), INTC_VECT(DMAC_DMTE3, 0x6a0),
-	INTC_VECT(DMAC_DMTE4, 0x780), INTC_VECT(DMAC_DMTE5, 0x7a0),
-	INTC_VECT(DMAC_DMTE6, 0x7c0), INTC_VECT(DMAC_DMTE7, 0x7e0),
-	INTC_VECT(DMAC_DMAE, 0x6c0),
+	INTC_VECT(DMAC, 0x640), INTC_VECT(DMAC, 0x660),
+	INTC_VECT(DMAC, 0x680), INTC_VECT(DMAC, 0x6a0),
+	INTC_VECT(DMAC, 0x780), INTC_VECT(DMAC, 0x7a0),
+	INTC_VECT(DMAC, 0x7c0), INTC_VECT(DMAC, 0x7e0),
+	INTC_VECT(DMAC, 0x6c0),
 	INTC_VECT(IRQ4, 0x800), INTC_VECT(IRQ5, 0x820),
 	INTC_VECT(IRQ6, 0x840), INTC_VECT(IRQ6, 0x860),
 	INTC_VECT(HCAN20, 0x900), INTC_VECT(HCAN21, 0x920),
@@ -74,23 +70,18 @@ static struct intc_vect vectors[] __init
 	INTC_VECT(MFI, 0xe80), /* 0xf80 according to data sheet */
 	INTC_VECT(ADC, 0xf80), INTC_VECT(CMT, 0xfa0),
 	INTC_VECT(TMU0, 0x400), INTC_VECT(TMU1, 0x420),
-	INTC_VECT(TMU2_TUNI, 0x440), INTC_VECT(TMU2_TICPI, 0x460),
+	INTC_VECT(TMU2, 0x440), INTC_VECT(TMU2, 0x460),
 	INTC_VECT(WDT, 0x560),
-	INTC_VECT(REF_RCMI, 0x580), INTC_VECT(REF_ROVI, 0x5a0),
+	INTC_VECT(REF, 0x580), INTC_VECT(REF, 0x5a0),
 };
 
 static struct intc_group groups[] __initdata = {
-	INTC_GROUP(DMAC, DMAC_DMTE0, DMAC_DMTE1, DMAC_DMTE2,
-		   DMAC_DMTE3, DMAC_DMTE4, DMAC_DMTE5,
-		   DMAC_DMTE6, DMAC_DMTE7, DMAC_DMAE),
 	INTC_GROUP(DMABRG, DMABRG0, DMABRG1, DMABRG2),
 	INTC_GROUP(SCIF0, SCIF0_ERI, SCIF0_RXI, SCIF0_BRI, SCIF0_TXI),
 	INTC_GROUP(SCIF1, SCIF1_ERI, SCIF1_RXI, SCIF1_BRI, SCIF1_TXI),
 	INTC_GROUP(SCIF2, SCIF2_ERI, SCIF2_RXI, SCIF2_BRI, SCIF2_TXI),
 	INTC_GROUP(SIM, SIM_ERI, SIM_RXI, SIM_TXI, SIM_TEI),
 	INTC_GROUP(MMCIF, MMCIF0, MMCIF1, MMCIF2, MMCIF3),
-	INTC_GROUP(TMU2, TMU2_TUNI, TMU2_TICPI),
-	INTC_GROUP(REF, REF_RCMI, REF_ROVI),
 };
 
 static struct intc_mask_reg mask_registers[] __initdata = {
