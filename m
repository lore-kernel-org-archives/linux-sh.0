From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 24 Feb 2009 13:59:04 +0000
Subject: [PATCH 02/04] sh: multiple vectors per irq - sh7750
Message-Id: <20090224135904.12058.81946.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Update intc tables and platform data to use one linux irq
per maskable interrupt source instead of keeping the one-to-one
mapping between vectors and linux irqs.

This fixes potential irq masking issues for sh775x hardware
blocks such as SCI/SCIF/RTC/DMAC/TMU2/REF.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Depends on the sh-rtc-single-irq-support patch.
 Tested in latest upstream QEMU using -M r2d.

 arch/sh/kernel/cpu/sh4/setup-sh7750.c |   87 +++++++++------------------------
 1 file changed, 25 insertions(+), 62 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh4/setup-sh7750.c
+++ work/arch/sh/kernel/cpu/sh4/setup-sh7750.c	2009-02-24 21:51:58.000000000 +0900
@@ -21,17 +21,7 @@ static struct resource rtc_resources[]  		.flags	= IORESOURCE_IO,
 	},
 	[1] = {
-		/* Period IRQ */
-		.start	= 21,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		/* Carry IRQ */
-		.start	= 22,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[3] = {
-		/* Alarm IRQ */
+		/* Shared Period/Carry/Alarm IRQ */
 		.start	= 20,
 		.flags	= IORESOURCE_IRQ,
 	},
@@ -50,13 +40,13 @@ static struct plat_sci_port sci_platform
 		.mapbase	= 0xffe00000,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.type		= PORT_SCI,
-		.irqs		= { 23, 24, 25, 0 },
+		.irqs		= { 23, 23, 23, 0 },
 	}, {
 #endif
 		.mapbase	= 0xffe80000,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.type		= PORT_SCIF,
-		.irqs		= { 40, 41, 43, 42 },
+		.irqs		= { 40, 40, 40, 40 },
 	}, {
 		.flags = 0,
 	}
@@ -87,43 +77,27 @@ enum {
 
 	/* interrupt sources */
 	IRL0, IRL1, IRL2, IRL3, /* only IRLM mode supported */
-	HUDI, GPIOI,
-	DMAC_DMTE0, DMAC_DMTE1, DMAC_DMTE2, DMAC_DMTE3,
-	DMAC_DMTE4, DMAC_DMTE5, DMAC_DMTE6, DMAC_DMTE7,
-	DMAC_DMAE,
+	HUDI, GPIOI, DMAC,
 	PCIC0_PCISERR, PCIC1_PCIERR, PCIC1_PCIPWDWN, PCIC1_PCIPWON,
 	PCIC1_PCIDMA0, PCIC1_PCIDMA1, PCIC1_PCIDMA2, PCIC1_PCIDMA3,
-	TMU3, TMU4, TMU0, TMU1, TMU2_TUNI, TMU2_TICPI,
-	RTC_ATI, RTC_PRI, RTC_CUI,
-	SCI1_ERI, SCI1_RXI, SCI1_TXI, SCI1_TEI,
-	SCIF_ERI, SCIF_RXI, SCIF_BRI, SCIF_TXI,
-	WDT,
-	REF_RCMI, REF_ROVI,
+	TMU3, TMU4, TMU0, TMU1, TMU2, RTC, SCI1, SCIF, WDT, REF,
 
 	/* interrupt groups */
-	DMAC, PCIC1, TMU2, RTC, SCI1, SCIF, REF,
+	PCIC1,
 };
 
 static struct intc_vect vectors[] __initdata = {
 	INTC_VECT(HUDI, 0x600), INTC_VECT(GPIOI, 0x620),
 	INTC_VECT(TMU0, 0x400), INTC_VECT(TMU1, 0x420),
-	INTC_VECT(TMU2_TUNI, 0x440), INTC_VECT(TMU2_TICPI, 0x460),
-	INTC_VECT(RTC_ATI, 0x480), INTC_VECT(RTC_PRI, 0x4a0),
-	INTC_VECT(RTC_CUI, 0x4c0),
-	INTC_VECT(SCI1_ERI, 0x4e0), INTC_VECT(SCI1_RXI, 0x500),
-	INTC_VECT(SCI1_TXI, 0x520), INTC_VECT(SCI1_TEI, 0x540),
-	INTC_VECT(SCIF_ERI, 0x700), INTC_VECT(SCIF_RXI, 0x720),
-	INTC_VECT(SCIF_BRI, 0x740), INTC_VECT(SCIF_TXI, 0x760),
+	INTC_VECT(TMU2, 0x440), INTC_VECT(TMU2, 0x460),
+	INTC_VECT(RTC, 0x480), INTC_VECT(RTC, 0x4a0),
+	INTC_VECT(RTC, 0x4c0),
+	INTC_VECT(SCI1, 0x4e0), INTC_VECT(SCI1, 0x500),
+	INTC_VECT(SCI1, 0x520), INTC_VECT(SCI1, 0x540),
+	INTC_VECT(SCIF, 0x700), INTC_VECT(SCIF, 0x720),
+	INTC_VECT(SCIF, 0x740), INTC_VECT(SCIF, 0x760),
 	INTC_VECT(WDT, 0x560),
-	INTC_VECT(REF_RCMI, 0x580), INTC_VECT(REF_ROVI, 0x5a0),
-};
-
-static struct intc_group groups[] __initdata = {
-	INTC_GROUP(TMU2, TMU2_TUNI, TMU2_TICPI),
-	INTC_GROUP(RTC, RTC_ATI, RTC_PRI, RTC_CUI),
-	INTC_GROUP(SCI1, SCI1_ERI, SCI1_RXI, SCI1_TXI, SCI1_TEI),
-	INTC_GROUP(SCIF, SCIF_ERI, SCIF_RXI, SCIF_BRI, SCIF_TXI),
-	INTC_GROUP(REF, REF_RCMI, REF_ROVI),
+	INTC_VECT(REF, 0x580), INTC_VECT(REF, 0x5a0),
 };
 
 static struct intc_prio_reg prio_registers[] __initdata = {
@@ -136,7 +110,7 @@ static struct intc_prio_reg prio_registe
 						 PCIC1, PCIC0_PCISERR } },
 };
 
-static DECLARE_INTC_DESC(intc_desc, "sh7750", vectors, groups,
+static DECLARE_INTC_DESC(intc_desc, "sh7750", vectors, NULL,
 			 NULL, prio_registers, NULL);
 
 /* SH7750, SH7750S, SH7751 and SH7091 all have 4-channel DMA controllers */
@@ -145,39 +119,28 @@ static DECLARE_INTC_DESC(intc_desc, "sh7
 	defined(CONFIG_CPU_SUBTYPE_SH7751) || \
 	defined(CONFIG_CPU_SUBTYPE_SH7091)
 static struct intc_vect vectors_dma4[] __initdata = {
-	INTC_VECT(DMAC_DMTE0, 0x640), INTC_VECT(DMAC_DMTE1, 0x660),
-	INTC_VECT(DMAC_DMTE2, 0x680), INTC_VECT(DMAC_DMTE3, 0x6a0),
-	INTC_VECT(DMAC_DMAE, 0x6c0),
-};
-
-static struct intc_group groups_dma4[] __initdata = {
-	INTC_GROUP(DMAC, DMAC_DMTE0, DMAC_DMTE1, DMAC_DMTE2,
-		   DMAC_DMTE3, DMAC_DMAE),
+	INTC_VECT(DMAC, 0x640), INTC_VECT(DMAC, 0x660),
+	INTC_VECT(DMAC, 0x680), INTC_VECT(DMAC, 0x6a0),
+	INTC_VECT(DMAC, 0x6c0),
 };
 
 static DECLARE_INTC_DESC(intc_desc_dma4, "sh7750_dma4",
-			 vectors_dma4, groups_dma4,
+			 vectors_dma4, NULL,
 			 NULL, prio_registers, NULL);
 #endif
 
 /* SH7750R and SH7751R both have 8-channel DMA controllers */
 #if defined(CONFIG_CPU_SUBTYPE_SH7750R) || defined(CONFIG_CPU_SUBTYPE_SH7751R)
 static struct intc_vect vectors_dma8[] __initdata = {
-	INTC_VECT(DMAC_DMTE0, 0x640), INTC_VECT(DMAC_DMTE1, 0x660),
-	INTC_VECT(DMAC_DMTE2, 0x680), INTC_VECT(DMAC_DMTE3, 0x6a0),
-	INTC_VECT(DMAC_DMTE4, 0x780), INTC_VECT(DMAC_DMTE5, 0x7a0),
-	INTC_VECT(DMAC_DMTE6, 0x7c0), INTC_VECT(DMAC_DMTE7, 0x7e0),
-	INTC_VECT(DMAC_DMAE, 0x6c0),
-};
-
-static struct intc_group groups_dma8[] __initdata = {
-	INTC_GROUP(DMAC, DMAC_DMTE0, DMAC_DMTE1, DMAC_DMTE2,
-		   DMAC_DMTE3, DMAC_DMTE4, DMAC_DMTE5,
-		   DMAC_DMTE6, DMAC_DMTE7, DMAC_DMAE),
+	INTC_VECT(DMAC, 0x640), INTC_VECT(DMAC, 0x660),
+	INTC_VECT(DMAC, 0x680), INTC_VECT(DMAC, 0x6a0),
+	INTC_VECT(DMAC, 0x780), INTC_VECT(DMAC, 0x7a0),
+	INTC_VECT(DMAC, 0x7c0), INTC_VECT(DMAC, 0x7e0),
+	INTC_VECT(DMAC, 0x6c0),
 };
 
 static DECLARE_INTC_DESC(intc_desc_dma8, "sh7750_dma8",
-			 vectors_dma8, groups_dma8,
+			 vectors_dma8, NULL,
 			 NULL, prio_registers, NULL);
 #endif
 
