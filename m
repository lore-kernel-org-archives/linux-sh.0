From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Fri, 06 Mar 2009 05:30:18 +0000
Subject: [PATCH v2] sh: multiple vectors per irq - sh7763
Message-Id: <49B0B4EA.1090506@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi, Paul.

Sorry, I sent old other patch.
I resend new patch.

Best regards,
 Nobuhiro

---
Update intc tables and platform data to use one linux irq
per maskable interrupt source instead of keeping the one-to-one
mapping between vectors and linux irqs.

This fixes potential irq masking issues for sh7763 hardware
blocks such as RTC/SCIF/DMAC/GETHER/PCIC5/MMCIF/SIM/GPIO/USBF.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c |  114 +++++++++++---------------------
 1 files changed, 38 insertions(+), 76 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7763.c b/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
index 3c5b629..740f994 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
@@ -3,7 +3,7 @@
  *
  *  Copyright (C) 2006  Paul Mundt
  *  Copyright (C) 2007  Yoshihiro Shimoda
- *  Copyright (C) 2008  Nobuhiro Iwamatsu
+ *  Copyright (C) 2008,2009  Nobuhiro Iwamatsu
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
@@ -22,18 +22,8 @@ static struct resource rtc_resources[] = {
 		.flags	= IORESOURCE_IO,
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
-		.start	= 20,
+		/* Shared Period/Carry/Alarm IRQ */
+		.start  = 20,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -50,17 +40,17 @@ static struct plat_sci_port sci_platform_data[] = {
 		.mapbase	= 0xffe00000,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.type		= PORT_SCIF,
-		.irqs		= { 40, 41, 43, 42 },
+		.irqs		= { 40, 40, 40, 40 },
 	}, {
 		.mapbase	= 0xffe08000,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.type		= PORT_SCIF,
-		.irqs		= { 76, 77, 79, 78 },
+		.irqs		= { 76, 76, 76, 76 },
 	}, {
 		.mapbase	= 0xffe10000,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.type		= PORT_SCIF,
-		.irqs		= { 104, 105, 107, 106 },
+		.irqs		= { 104, 104, 104, 104 },
 	}, {
 		.flags = 0,
 	}
@@ -148,93 +138,65 @@ enum {
 	IRL_HHLL, IRL_HHLH, IRL_HHHL,

 	IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7,
-	RTC_ATI, RTC_PRI, RTC_CUI,
-	WDT, TMU0, TMU1, TMU2, TMU2_TICPI,
-	HUDI, LCDC,
-	DMAC0_DMINT0, DMAC0_DMINT1, DMAC0_DMINT2, DMAC0_DMINT3, DMAC0_DMAE,
-	SCIF0_ERI, SCIF0_RXI, SCIF0_BRI, SCIF0_TXI,
-	DMAC0_DMINT4, DMAC0_DMINT5,
-	IIC0, IIC1,
-	CMT,
-	GEINT0, GEINT1, GEINT2,
-	HAC,
-	PCISERR, PCIINTA, PCIINTB, PCIINTC, PCIINTD,
-	PCIERR, PCIPWD3, PCIPWD2, PCIPWD1, PCIPWD0,
-	STIF0, STIF1,
-	SCIF1_ERI, SCIF1_RXI, SCIF1_BRI, SCIF1_TXI,
-	SIOF0, SIOF1, SIOF2,
-	USBH, USBFI0, USBFI1,
-	TPU, PCC,
-	MMCIF_FSTAT, MMCIF_TRAN, MMCIF_ERR, MMCIF_FRDY,
-	SIM_ERI, SIM_RXI, SIM_TXI, SIM_TEND,
+	RTC, WDT, TMU0, TMU1, TMU2, TMU2_TICPI,
+	HUDI, LCDC, DMAC, SCIF0, IIC0, IIC1, CMT, GETHER, HAC,
+	PCISERR, PCIINTA, PCIINTB, PCIINTC, PCIINTD, PCIC5,
+	STIF0, STIF1, SCIF1, SIOF0, SIOF1, SIOF2,
+	USBH, USBF, TPU, PCC, MMCIF, SIM,
 	TMU3, TMU4, TMU5, ADC, SSI0, SSI1, SSI2, SSI3,
-	SCIF2_ERI, SCIF2_RXI, SCIF2_BRI, SCIF2_TXI,
-	GPIO_CH0, GPIO_CH1, GPIO_CH2, GPIO_CH3,
+	SCIF2, GPIO,

 	/* interrupt groups */

-	TMU012, TMU345, RTC, DMAC, SCIF0, GETHER, PCIC5,
-	SCIF1, USBF, MMCIF, SIM, SCIF2, GPIO,
+	TMU012, TMU345,
 };

 static struct intc_vect vectors[] __initdata = {
-	INTC_VECT(RTC_ATI, 0x480), INTC_VECT(RTC_PRI, 0x4a0),
-	INTC_VECT(RTC_CUI, 0x4c0),
+	INTC_VECT(RTC, 0x480), INTC_VECT(RTC, 0x4a0),
+	INTC_VECT(RTC, 0x4c0),
 	INTC_VECT(WDT, 0x560), INTC_VECT(TMU0, 0x580),
 	INTC_VECT(TMU1, 0x5a0), INTC_VECT(TMU2, 0x5c0),
 	INTC_VECT(TMU2_TICPI, 0x5e0), INTC_VECT(HUDI, 0x600),
 	INTC_VECT(LCDC, 0x620),
-	INTC_VECT(DMAC0_DMINT0, 0x640), INTC_VECT(DMAC0_DMINT1, 0x660),
-	INTC_VECT(DMAC0_DMINT2, 0x680), INTC_VECT(DMAC0_DMINT3, 0x6a0),
-	INTC_VECT(DMAC0_DMAE, 0x6c0),
-	INTC_VECT(SCIF0_ERI, 0x700), INTC_VECT(SCIF0_RXI, 0x720),
-	INTC_VECT(SCIF0_BRI, 0x740), INTC_VECT(SCIF0_TXI, 0x760),
-	INTC_VECT(DMAC0_DMINT4, 0x780), INTC_VECT(DMAC0_DMINT5, 0x7a0),
+	INTC_VECT(DMAC, 0x640), INTC_VECT(DMAC, 0x660),
+	INTC_VECT(DMAC, 0x680), INTC_VECT(DMAC, 0x6a0),
+	INTC_VECT(DMAC, 0x6c0),
+	INTC_VECT(SCIF0, 0x700), INTC_VECT(SCIF0, 0x720),
+	INTC_VECT(SCIF0, 0x740), INTC_VECT(SCIF0, 0x760),
+	INTC_VECT(DMAC, 0x780), INTC_VECT(DMAC, 0x7a0),
 	INTC_VECT(IIC0, 0x8A0), INTC_VECT(IIC1, 0x8C0),
-	INTC_VECT(CMT, 0x900), INTC_VECT(GEINT0, 0x920),
-	INTC_VECT(GEINT1, 0x940), INTC_VECT(GEINT2, 0x960),
+	INTC_VECT(CMT, 0x900), INTC_VECT(GETHER, 0x920),
+	INTC_VECT(GETHER, 0x940), INTC_VECT(GETHER, 0x960),
 	INTC_VECT(HAC, 0x980),
 	INTC_VECT(PCISERR, 0xa00), INTC_VECT(PCIINTA, 0xa20),
 	INTC_VECT(PCIINTB, 0xa40), INTC_VECT(PCIINTC, 0xa60),
-	INTC_VECT(PCIINTD, 0xa80), INTC_VECT(PCIERR, 0xaa0),
-	INTC_VECT(PCIPWD3, 0xac0), INTC_VECT(PCIPWD2, 0xae0),
-	INTC_VECT(PCIPWD1, 0xb00), INTC_VECT(PCIPWD0, 0xb20),
+	INTC_VECT(PCIINTD, 0xa80), INTC_VECT(PCIC5, 0xaa0),
+	INTC_VECT(PCIC5, 0xac0), INTC_VECT(PCIC5, 0xae0),
+	INTC_VECT(PCIC5, 0xb00), INTC_VECT(PCIC5, 0xb20),
 	INTC_VECT(STIF0, 0xb40), INTC_VECT(STIF1, 0xb60),
-	INTC_VECT(SCIF1_ERI, 0xb80), INTC_VECT(SCIF1_RXI, 0xba0),
-	INTC_VECT(SCIF1_BRI, 0xbc0), INTC_VECT(SCIF1_TXI, 0xbe0),
+	INTC_VECT(SCIF1, 0xb80), INTC_VECT(SCIF1, 0xba0),
+	INTC_VECT(SCIF1, 0xbc0), INTC_VECT(SCIF1, 0xbe0),
 	INTC_VECT(SIOF0, 0xc00), INTC_VECT(SIOF1, 0xc20),
-	INTC_VECT(USBH, 0xc60), INTC_VECT(USBFI0, 0xc80),
-	INTC_VECT(USBFI1, 0xca0),
+	INTC_VECT(USBH, 0xc60), INTC_VECT(USBF, 0xc80),
+	INTC_VECT(USBF, 0xca0),
 	INTC_VECT(TPU, 0xcc0), INTC_VECT(PCC, 0xce0),
-	INTC_VECT(MMCIF_FSTAT, 0xd00), INTC_VECT(MMCIF_TRAN, 0xd20),
-	INTC_VECT(MMCIF_ERR, 0xd40), INTC_VECT(MMCIF_FRDY, 0xd60),
-	INTC_VECT(SIM_ERI, 0xd80), INTC_VECT(SIM_RXI, 0xda0),
-	INTC_VECT(SIM_TXI, 0xdc0), INTC_VECT(SIM_TEND, 0xde0),
+	INTC_VECT(MMCIF, 0xd00), INTC_VECT(MMCIF, 0xd20),
+	INTC_VECT(MMCIF, 0xd40), INTC_VECT(MMCIF, 0xd60),
+	INTC_VECT(SIM, 0xd80), INTC_VECT(SIM, 0xda0),
+	INTC_VECT(SIM, 0xdc0), INTC_VECT(SIM, 0xde0),
 	INTC_VECT(TMU3, 0xe00), INTC_VECT(TMU4, 0xe20),
 	INTC_VECT(TMU5, 0xe40), INTC_VECT(ADC, 0xe60),
 	INTC_VECT(SSI0, 0xe80), INTC_VECT(SSI1, 0xea0),
 	INTC_VECT(SSI2, 0xec0), INTC_VECT(SSI3, 0xee0),
-	INTC_VECT(SCIF2_ERI, 0xf00), INTC_VECT(SCIF2_RXI, 0xf20),
-	INTC_VECT(SCIF2_BRI, 0xf40), INTC_VECT(SCIF2_TXI, 0xf60),
-	INTC_VECT(GPIO_CH0, 0xf80), INTC_VECT(GPIO_CH1, 0xfa0),
-	INTC_VECT(GPIO_CH2, 0xfc0), INTC_VECT(GPIO_CH3, 0xfe0),
+	INTC_VECT(SCIF2, 0xf00), INTC_VECT(SCIF2, 0xf20),
+	INTC_VECT(SCIF2, 0xf40), INTC_VECT(SCIF2, 0xf60),
+	INTC_VECT(GPIO, 0xf80), INTC_VECT(GPIO, 0xfa0),
+	INTC_VECT(GPIO, 0xfc0), INTC_VECT(GPIO, 0xfe0),
 };

 static struct intc_group groups[] __initdata = {
 	INTC_GROUP(TMU012, TMU0, TMU1, TMU2, TMU2_TICPI),
 	INTC_GROUP(TMU345, TMU3, TMU4, TMU5),
-	INTC_GROUP(RTC, RTC_ATI, RTC_PRI, RTC_CUI),
-	INTC_GROUP(DMAC, DMAC0_DMINT0, DMAC0_DMINT1, DMAC0_DMINT2,
-		   DMAC0_DMINT3, DMAC0_DMINT4, DMAC0_DMINT5, DMAC0_DMAE),
-	INTC_GROUP(SCIF0, SCIF0_ERI, SCIF0_RXI, SCIF0_BRI, SCIF0_TXI),
-	INTC_GROUP(GETHER, GEINT0, GEINT1, GEINT2),
-	INTC_GROUP(PCIC5, PCIERR, PCIPWD3, PCIPWD2, PCIPWD1, PCIPWD0),
-	INTC_GROUP(SCIF1, SCIF1_ERI, SCIF1_RXI, SCIF1_BRI, SCIF1_TXI),
-	INTC_GROUP(USBF, USBFI0, USBFI1),
-	INTC_GROUP(MMCIF, MMCIF_FSTAT, MMCIF_TRAN, MMCIF_ERR, MMCIF_FRDY),
-	INTC_GROUP(SIM, SIM_ERI, SIM_RXI, SIM_TXI, SIM_TEND),
-	INTC_GROUP(SCIF2, SCIF2_ERI, SCIF2_RXI, SCIF2_BRI, SCIF2_TXI),
-	INTC_GROUP(GPIO, GPIO_CH0, GPIO_CH1, GPIO_CH2, GPIO_CH3),
 };

 static struct intc_mask_reg mask_registers[] __initdata = {
-- 1.6.1.3
