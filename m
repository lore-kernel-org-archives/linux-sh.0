From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 07 May 2010 09:22:51 +0000
Subject: [PATCH] sh: add some INTC_VECT for SH7757
Message-Id: <4BE3DBEB.5060209@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

And I also add the setting of mv_nr_irqs because SH7757 has irqs
more than 256.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |  217 ++++++++++++++++++++++----------
 1 files changed, 148 insertions(+), 69 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
index 93b7aa4..829ccb4 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
@@ -143,6 +143,7 @@ static struct platform_device *sh7757_early_devices[] __initdata = {

 void __init plat_early_device_setup(void)
 {
+	sh_mv.mv_nr_irqs = 386;
 	early_platform_add_devices(sh7757_early_devices,
 				   ARRAY_SIZE(sh7757_early_devices));
 }
@@ -163,39 +164,23 @@ enum {
 	IRL4_HHLL, IRL4_HHLH, IRL4_HHHL,
 	IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7,

-	SDHI,
-	DVC,
-	IRQ8, IRQ9, IRQ10,
-	WDT0,
-	TMU0, TMU1, TMU2, TMU2_TICPI,
+	SDHI, DVC,
+	IRQ8, IRQ9, IRQ11, IRQ10, IRQ12, IRQ13, IRQ14, IRQ15,
+	TMU0, TMU1, TMU2, TMU2_TICPI, TMU3, TMU4, TMU5,
 	HUDI,
-
 	ARC4,
-	DMAC0,
-	IRQ11,
-	SCIF2,
-	DMAC1_6,
-	USB0,
-	IRQ12,
+	DMAC0_5, DMAC6_7, DMAC8_11,
+	SCIF0, SCIF1, SCIF2, SCIF3, SCIF4,
+	USB0, USB1,
 	JMC,
-	SPI1,
-	IRQ13, IRQ14,
-	USB1,
+	SPI0, SPI1,
 	TMR01, TMR23, TMR45,
-	WDT1,
 	FRT,
-	LPC,
-	SCIF0, SCIF1, SCIF3,
-	PECI0I, PECI1I, PECI2I,
-	IRQ15,
+	LPC, LPC5, LPC6, LPC7, LPC8,
+	PECI0, PECI1, PECI2, PECI3, PECI4, PECI5,
 	ETHERC,
-	SPI0,
-	ADC1,
-	DMAC1_8,
+	ADC0, ADC1,
 	SIM,
-	TMU3, TMU4, TMU5,
-	ADC0,
-	SCIF4,
 	IIC0_0, IIC0_1, IIC0_2, IIC0_3,
 	IIC1_0, IIC1_1, IIC1_2, IIC1_3,
 	IIC2_0, IIC2_1, IIC2_2, IIC2_3,
@@ -206,9 +191,23 @@ enum {
 	IIC7_0, IIC7_1, IIC7_2, IIC7_3,
 	IIC8_0, IIC8_1, IIC8_2, IIC8_3,
 	IIC9_0, IIC9_1, IIC9_2, IIC9_3,
-	PCIINTA,
-	PCIE,
+	ONFICTL,
+	MMC1, MMC2,
+	ECCU,
+	PCIC,
+	G200,
+	RSPI,
 	SGPIO,
+	DMINT12, DMINT13, DMINT14, DMINT15, DMINT16, DMINT17, DMINT18, DMINT19,
+	DMINT20, DMINT21, DMINT22, DMINT23,
+	DDRECC,
+	TSIP,
+	PCIE_BRIDGE,
+	WDT0B, WDT1B, WDT2B, WDT3B, WDT4B, WDT5B, WDT6B, WDT7B, WDT8B,
+	GETHER0, GETHER1, GETHER2,
+	PBIA, PBIB, PBIC,
+	DMAE2, DMAE3,
+	SERMUX2, SERMUX3,

 	/* interrupt groups */

@@ -221,19 +220,18 @@ static struct intc_vect vectors[] __initdata = {
 	INTC_VECT(DVC, 0x4e0),
 	INTC_VECT(IRQ8, 0x500), INTC_VECT(IRQ9, 0x520),
 	INTC_VECT(IRQ10, 0x540),
-	INTC_VECT(WDT0, 0x560),
 	INTC_VECT(TMU0, 0x580), INTC_VECT(TMU1, 0x5a0),
 	INTC_VECT(TMU2, 0x5c0), INTC_VECT(TMU2_TICPI, 0x5e0),
 	INTC_VECT(HUDI, 0x600),
 	INTC_VECT(ARC4, 0x620),
-	INTC_VECT(DMAC0, 0x640), INTC_VECT(DMAC0, 0x660),
-	INTC_VECT(DMAC0, 0x680), INTC_VECT(DMAC0, 0x6a0),
-	INTC_VECT(DMAC0, 0x6c0),
+	INTC_VECT(DMAC0_5, 0x640), INTC_VECT(DMAC0_5, 0x660),
+	INTC_VECT(DMAC0_5, 0x680), INTC_VECT(DMAC0_5, 0x6a0),
+	INTC_VECT(DMAC0_5, 0x6c0),
 	INTC_VECT(IRQ11, 0x6e0),
 	INTC_VECT(SCIF2, 0x700), INTC_VECT(SCIF2, 0x720),
 	INTC_VECT(SCIF2, 0x740), INTC_VECT(SCIF2, 0x760),
-	INTC_VECT(DMAC0, 0x780), INTC_VECT(DMAC0, 0x7a0),
-	INTC_VECT(DMAC1_6, 0x7c0), INTC_VECT(DMAC1_6, 0x7e0),
+	INTC_VECT(DMAC0_5, 0x780), INTC_VECT(DMAC0_5, 0x7a0),
+	INTC_VECT(DMAC6_7, 0x7c0), INTC_VECT(DMAC6_7, 0x7e0),
 	INTC_VECT(USB0, 0x840),
 	INTC_VECT(IRQ12, 0x880),
 	INTC_VECT(JMC, 0x8a0),
@@ -242,7 +240,6 @@ static struct intc_vect vectors[] __initdata = {
 	INTC_VECT(USB1, 0x920),
 	INTC_VECT(TMR01, 0xa00), INTC_VECT(TMR23, 0xa20),
 	INTC_VECT(TMR45, 0xa40),
-	INTC_VECT(WDT1, 0xa60),
 	INTC_VECT(FRT, 0xa80),
 	INTC_VECT(LPC, 0xaa0), INTC_VECT(LPC, 0xac0),
 	INTC_VECT(LPC, 0xae0), INTC_VECT(LPC, 0xb00),
@@ -250,14 +247,14 @@ static struct intc_vect vectors[] __initdata = {
 	INTC_VECT(SCIF0, 0xb40), INTC_VECT(SCIF1, 0xb60),
 	INTC_VECT(SCIF3, 0xb80), INTC_VECT(SCIF3, 0xba0),
 	INTC_VECT(SCIF3, 0xbc0), INTC_VECT(SCIF3, 0xbe0),
-	INTC_VECT(PECI0I, 0xc00), INTC_VECT(PECI1I, 0xc20),
-	INTC_VECT(PECI2I, 0xc40),
+	INTC_VECT(PECI0, 0xc00), INTC_VECT(PECI1, 0xc20),
+	INTC_VECT(PECI2, 0xc40),
 	INTC_VECT(IRQ15, 0xc60),
 	INTC_VECT(ETHERC, 0xc80), INTC_VECT(ETHERC, 0xca0),
 	INTC_VECT(SPI0, 0xcc0),
 	INTC_VECT(ADC1, 0xce0),
-	INTC_VECT(DMAC1_8, 0xd00), INTC_VECT(DMAC1_8, 0xd20),
-	INTC_VECT(DMAC1_8, 0xd40), INTC_VECT(DMAC1_8, 0xd60),
+	INTC_VECT(DMAC8_11, 0xd00), INTC_VECT(DMAC8_11, 0xd20),
+	INTC_VECT(DMAC8_11, 0xd40), INTC_VECT(DMAC8_11, 0xd60),
 	INTC_VECT(SIM, 0xd80), INTC_VECT(SIM, 0xda0),
 	INTC_VECT(SIM, 0xdc0), INTC_VECT(SIM, 0xde0),
 	INTC_VECT(TMU3, 0xe00), INTC_VECT(TMU4, 0xe20),
@@ -278,17 +275,47 @@ static struct intc_vect vectors[] __initdata = {
 	INTC_VECT(IIC5_0, 0x1860), INTC_VECT(IIC5_1, 0x1880),
 	INTC_VECT(IIC5_2, 0x18a0), INTC_VECT(IIC5_3, 0x18c0),
 	INTC_VECT(IIC6_0, 0x18e0), INTC_VECT(IIC6_1, 0x1900),
-	INTC_VECT(IIC6_2, 0x1920), INTC_VECT(IIC6_3, 0x1980),
+	INTC_VECT(IIC6_2, 0x1920),
+	INTC_VECT(ONFICTL, 0x1960),
+	INTC_VECT(IIC6_3, 0x1980),
 	INTC_VECT(IIC7_0, 0x19a0), INTC_VECT(IIC7_1, 0x1a00),
 	INTC_VECT(IIC7_2, 0x1a20), INTC_VECT(IIC7_3, 0x1a40),
 	INTC_VECT(IIC8_0, 0x1a60), INTC_VECT(IIC8_1, 0x1a80),
 	INTC_VECT(IIC8_2, 0x1aa0), INTC_VECT(IIC8_3, 0x1b40),
 	INTC_VECT(IIC9_0, 0x1b60), INTC_VECT(IIC9_1, 0x1b80),
 	INTC_VECT(IIC9_2, 0x1c00), INTC_VECT(IIC9_3, 0x1c20),
-	INTC_VECT(PCIINTA, 0x1ce0),
-	INTC_VECT(PCIE, 0x1e00),
-	INTC_VECT(SGPIO, 0x1f80),
-	INTC_VECT(SGPIO, 0x1fa0),
+	INTC_VECT(MMC1, 0x1c60), INTC_VECT(MMC2, 0x1c80),
+	INTC_VECT(ECCU, 0x1cc0),
+	INTC_VECT(PCIC, 0x1ce0),
+	INTC_VECT(G200, 0x1d00),
+	INTC_VECT(RSPI, 0x1d80), INTC_VECT(RSPI, 0x1da0),
+	INTC_VECT(RSPI, 0x1dc0), INTC_VECT(RSPI, 0x1de0),
+	INTC_VECT(PECI3, 0x1ec0), INTC_VECT(PECI4, 0x1ee0),
+	INTC_VECT(PECI5, 0x1f00),
+	INTC_VECT(SGPIO, 0x1f80), INTC_VECT(SGPIO, 0x1fa0),
+	INTC_VECT(SGPIO, 0x1fc0),
+	INTC_VECT(DMINT12, 0x2400), INTC_VECT(DMINT13, 0x2420),
+	INTC_VECT(DMINT14, 0x2440), INTC_VECT(DMINT15, 0x2460),
+	INTC_VECT(DMINT16, 0x2480), INTC_VECT(DMINT17, 0x24e0),
+	INTC_VECT(DMINT18, 0x2500), INTC_VECT(DMINT19, 0x2520),
+	INTC_VECT(DMINT20, 0x2540), INTC_VECT(DMINT21, 0x2560),
+	INTC_VECT(DMINT22, 0x2580), INTC_VECT(DMINT23, 0x2600),
+	INTC_VECT(DDRECC, 0x2620),
+	INTC_VECT(TSIP, 0x2640),
+	INTC_VECT(PCIE_BRIDGE, 0x27c0),
+	INTC_VECT(WDT0B, 0x2800), INTC_VECT(WDT1B, 0x2820),
+	INTC_VECT(WDT2B, 0x2840), INTC_VECT(WDT3B, 0x2860),
+	INTC_VECT(WDT4B, 0x2880), INTC_VECT(WDT5B, 0x28a0),
+	INTC_VECT(WDT6B, 0x28c0), INTC_VECT(WDT7B, 0x28e0),
+	INTC_VECT(WDT8B, 0x2900),
+	INTC_VECT(GETHER0, 0x2960), INTC_VECT(GETHER1, 0x2980),
+	INTC_VECT(GETHER2, 0x29a0),
+	INTC_VECT(PBIA, 0x2a00), INTC_VECT(PBIB, 0x2a20),
+	INTC_VECT(PBIC, 0x2a40),
+	INTC_VECT(DMAE2, 0x2a60), INTC_VECT(DMAE3, 0x2a80),
+	INTC_VECT(SERMUX2, 0x2aa0), INTC_VECT(SERMUX3, 0x2b40),
+	INTC_VECT(LPC5, 0x2b60), INTC_VECT(LPC6, 0x2b80),
+	INTC_VECT(LPC7, 0x2c00), INTC_VECT(LPC8, 0x2c20),
 };

 static struct intc_group groups[] __initdata = {
@@ -312,31 +339,45 @@ static struct intc_mask_reg mask_registers[] __initdata = {

 	{ 0xffd40038, 0xffd4003c, 32, /* INT2MSKR / INT2MSKCR */
 	  { 0, 0, 0, 0, 0, 0, 0, 0,
-	    0, DMAC1_8, 0, PECI0I, LPC, FRT, WDT1, TMR45,
-	    TMR23, TMR01, 0, 0, 0, 0, 0, DMAC0,
-	    HUDI, 0, WDT0, SCIF3, SCIF2, SDHI, TMU345, TMU012
+	    0, DMAC8_11, 0, PECI0, LPC, FRT, 0, TMR45,
+	    TMR23, TMR01, 0, 0, 0, 0, 0, DMAC0_5,
+	    HUDI, 0, 0, SCIF3, SCIF2, SDHI, TMU345, TMU012
 	     } },

 	{ 0xffd400d0, 0xffd400d4, 32, /* INT2MSKR1 / INT2MSKCR1 */
 	  { IRQ15, IRQ14, IRQ13, IRQ12, IRQ11, IRQ10, SCIF4, ETHERC,
 	    IRQ9, IRQ8, SCIF1, SCIF0, USB0, 0, 0, USB1,
-	    ADC1, 0, DMAC1_6, ADC0, SPI0, SIM, PECI2I, PECI1I,
+	    ADC1, 0, DMAC6_7, ADC0, SPI0, SIM, PECI2, PECI1,
 	    ARC4, 0, SPI1, JMC, 0, 0, 0, DVC
 	     } },

 	{ 0xffd10038, 0xffd1003c, 32, /* INT2MSKR2 / INT2MSKCR2 */
-	  { IIC4_1, IIC4_2, IIC5_0, 0, 0, 0, SGPIO, 0,
-	    0, 0, 0, IIC9_2, IIC8_2, IIC8_1, IIC8_0, IIC7_3,
+	  { IIC4_1, IIC4_2, IIC5_0, ONFICTL, 0, 0, SGPIO, 0,
+	    0, G200, 0, IIC9_2, IIC8_2, IIC8_1, IIC8_0, IIC7_3,
 	    IIC7_2, IIC7_1, IIC6_3, IIC0_0, IIC0_1, IIC0_2, IIC0_3, IIC3_1,
-	    IIC2_3, 0, IIC2_1, IIC9_1, IIC3_3, IIC1_0, PCIE, IIC2_2
+	    IIC2_3, 0, IIC2_1, IIC9_1, IIC3_3, IIC1_0, 0, IIC2_2
 	     } },

-	{ 0xffd100d0, 0xff1400d4, 32, /* INT2MSKR3 / INT2MSKCR4 */
-	  { 0, IIC6_1, IIC6_0, IIC5_1, IIC3_2, IIC2_0, 0, 0,
+	{ 0xffd100d0, 0xffd100d4, 32, /* INT2MSKR3 / INT2MSKCR3 */
+	  { MMC1, IIC6_1, IIC6_0, IIC5_1, IIC3_2, IIC2_0, PECI5, MMC2,
 	    IIC1_3, IIC1_2, IIC9_0, IIC8_3, IIC4_3, IIC7_0, 0, IIC6_2,
-	    PCIINTA, 0, IIC4_0, 0, 0, 0, 0, IIC9_3,
+	    PCIC, 0, IIC4_0, 0, ECCU, RSPI, 0, IIC9_3,
 	    IIC3_0, 0, IIC5_3, IIC5_2, 0, 0, 0, IIC1_1
 	     } },
+
+	{ 0xffd20038, 0xffd2003c, 32, /* INT2MSKR4 / INT2MSKCR4 */
+	  { WDT0B, WDT1B, WDT3B, GETHER0, 0, 0, 0, 0,
+	    0, 0, 0, LPC7, SERMUX2, DMAE3, DMAE2, PBIC,
+	    PBIB, PBIA, GETHER1, DMINT12, DMINT13, DMINT14, DMINT15, TSIP,
+	    DMINT23, 0, DMINT21, LPC6, 0, DMINT16, 0, DMINT22
+	     } },
+
+	{ 0xffd200d0, 0xffd200d4, 32, /* INT2MSKR5 / INT2MSKCR5 */
+	  { 0, WDT8B, WDT7B, WDT4B, 0, DMINT20, 0, 0,
+	    DMINT19, DMINT18, LPC5, SERMUX3, WDT2B, GETHER2, 0, 0,
+	    0, 0, PCIE_BRIDGE, 0, 0, 0, 0, LPC8,
+	    DDRECC, 0, WDT6B, WDT5B, 0, 0, 0, DMINT17
+	     } },
 };

 #define INTPRI		0xffd00010
@@ -372,6 +413,22 @@ static struct intc_mask_reg mask_registers[] __initdata = {
 #define INT2PRI29	0xffd100b4
 #define INT2PRI30	0xffd100b8
 #define INT2PRI31	0xffd100bc
+#define INT2PRI32	0xffd20000
+#define INT2PRI33	0xffd20004
+#define INT2PRI34	0xffd20008
+#define INT2PRI35	0xffd2000c
+#define INT2PRI36	0xffd20010
+#define INT2PRI37	0xffd20014
+#define INT2PRI38	0xffd20018
+#define INT2PRI39	0xffd2001c
+#define INT2PRI40	0xffd200a0
+#define INT2PRI41	0xffd200a4
+#define INT2PRI42	0xffd200a8
+#define INT2PRI43	0xffd200ac
+#define INT2PRI44	0xffd200b0
+#define INT2PRI45	0xffd200b4
+#define INT2PRI46	0xffd200b8
+#define INT2PRI47	0xffd200bc

 static struct intc_prio_reg prio_registers[] __initdata = {
 	{ INTPRI, 0, 32, 4, { IRQ0, IRQ1, IRQ2, IRQ3,
@@ -379,39 +436,61 @@ static struct intc_prio_reg prio_registers[] __initdata = {

 	{ INT2PRI0, 0, 32, 8, { TMU0, TMU1, TMU2, TMU2_TICPI } },
 	{ INT2PRI1, 0, 32, 8, { TMU3, TMU4, TMU5, SDHI } },
-	{ INT2PRI2, 0, 32, 8, { SCIF2, SCIF3, WDT0, IRQ8 } },
-	{ INT2PRI3, 0, 32, 8, { HUDI, DMAC0, ADC0, IRQ9 } },
+	{ INT2PRI2, 0, 32, 8, { SCIF2, SCIF3, 0, IRQ8 } },
+	{ INT2PRI3, 0, 32, 8, { HUDI, DMAC0_5, ADC0, IRQ9 } },
 	{ INT2PRI4, 0, 32, 8, { IRQ10, 0, TMR01, TMR23 } },
-	{ INT2PRI5, 0, 32, 8, { TMR45, WDT1, FRT, LPC } },
-	{ INT2PRI6, 0, 32, 8, { PECI0I, ETHERC, DMAC1_8, 0 } },
+	{ INT2PRI5, 0, 32, 8, { TMR45, 0, FRT, LPC } },
+	{ INT2PRI6, 0, 32, 8, { PECI0, ETHERC, DMAC8_11, 0 } },
 	{ INT2PRI7, 0, 32, 8, { SCIF4, 0, IRQ11, IRQ12 } },
 	{ INT2PRI8, 0, 32, 8, { 0, 0, 0, DVC } },
 	{ INT2PRI9, 0, 32, 8, { ARC4, 0, SPI1, JMC } },
-	{ INT2PRI10, 0, 32, 8, { SPI0, SIM, PECI2I, PECI1I } },
-	{ INT2PRI11, 0, 32, 8, { ADC1, IRQ13, DMAC1_6, IRQ14 } },
+	{ INT2PRI10, 0, 32, 8, { SPI0, SIM, PECI2, PECI1 } },
+	{ INT2PRI11, 0, 32, 8, { ADC1, IRQ13, DMAC6_7, IRQ14 } },
 	{ INT2PRI12, 0, 32, 8, { USB0, 0, IRQ15, USB1 } },
 	{ INT2PRI13, 0, 32, 8, { 0, 0, SCIF1, SCIF0 } },

 	{ INT2PRI16, 0, 32, 8, { IIC2_2, 0, 0, 0 } },
-	{ INT2PRI17, 0, 32, 8, { PCIE, 0, 0, IIC1_0 } },
+	{ INT2PRI17, 0, 32, 8, { 0, 0, 0, IIC1_0 } },
 	{ INT2PRI18, 0, 32, 8, { IIC3_3, IIC9_1, IIC2_1, IIC1_2 } },
 	{ INT2PRI19, 0, 32, 8, { IIC2_3, IIC3_1, 0, IIC1_3 } },
 	{ INT2PRI20, 0, 32, 8, { IIC2_0, IIC6_3, IIC7_1, IIC7_2 } },
 	{ INT2PRI21, 0, 32, 8, { IIC7_3, IIC8_0, IIC8_1, IIC8_2 } },
-	{ INT2PRI22, 0, 32, 8, { IIC9_2, 0, 0, 0 } },
-	{ INT2PRI23, 0, 32, 8, { 0, SGPIO, IIC3_2, IIC5_1 } },
-	{ INT2PRI24, 0, 32, 8, { 0, 0, 0, IIC1_1 } },
+	{ INT2PRI22, 0, 32, 8, { IIC9_2, MMC2, G200, 0 } },
+	{ INT2PRI23, 0, 32, 8, { PECI5, SGPIO, IIC3_2, IIC5_1 } },
+	{ INT2PRI24, 0, 32, 8, { PECI4, PECI3, 0, IIC1_1 } },
 	{ INT2PRI25, 0, 32, 8, { IIC3_0, 0, IIC5_3, IIC5_2 } },
-	{ INT2PRI26, 0, 32, 8, { 0, 0, 0, IIC9_3 } },
-	{ INT2PRI27, 0, 32, 8, { PCIINTA, IIC6_0, IIC4_0, IIC6_1 } },
-	{ INT2PRI28, 0, 32, 8, { IIC4_3, IIC7_0, 0, IIC6_2 } },
+	{ INT2PRI26, 0, 32, 8, { ECCU, RSPI, 0, IIC9_3 } },
+	{ INT2PRI27, 0, 32, 8, { PCIC, IIC6_0, IIC4_0, IIC6_1 } },
+	{ INT2PRI28, 0, 32, 8, { IIC4_3, IIC7_0, MMC1, IIC6_2 } },
 	{ INT2PRI29, 0, 32, 8, { 0, 0, IIC9_0, IIC8_3 } },
-	{ INT2PRI30, 0, 32, 8, { IIC4_1, IIC4_2, IIC5_0, 0 } },
+	{ INT2PRI30, 0, 32, 8, { IIC4_1, IIC4_2, IIC5_0, ONFICTL } },
 	{ INT2PRI31, 0, 32, 8, { IIC0_0, IIC0_1, IIC0_2, IIC0_3 } },
+	{ INT2PRI32, 0, 32, 8, { DMINT22, 0, 0, 0 } },
+	{ INT2PRI33, 0, 32, 8, { 0, 0, 0, DMINT16 } },
+	{ INT2PRI34, 0, 32, 8, { 0, LPC6, DMINT21, DMINT18 } },
+	{ INT2PRI35, 0, 32, 8, { DMINT23, TSIP, 0, DMINT19 } },
+	{ INT2PRI36, 0, 32, 8, { DMINT20, GETHER1, PBIA, PBIB } },
+	{ INT2PRI37, 0, 32, 8, { PBIC, DMAE2, DMAE3, SERMUX2 } },
+	{ INT2PRI38, 0, 32, 8, { LPC7, 0, 0, 0 } },
+	{ INT2PRI39, 0, 32, 8, { 0, 0, 0, WDT4B } },
+	{ INT2PRI40, 0, 32, 8, { 0, 0, 0, DMINT17 } },
+	{ INT2PRI41, 0, 32, 8, { DDRECC, 0, WDT6B, WDT5B } },
+	{ INT2PRI42, 0, 32, 8, { 0, 0, 0, LPC8 } },
+	{ INT2PRI43, 0, 32, 8, { 0, WDT7B, PCIE_BRIDGE, WDT8B } },
+	{ INT2PRI44, 0, 32, 8, { WDT2B, GETHER2, 0, 0 } },
+	{ INT2PRI45, 0, 32, 8, { 0, 0, LPC5, SERMUX3 } },
+	{ INT2PRI46, 0, 32, 8, { WDT0B, WDT1B, WDT3B, GETHER0 } },
+	{ INT2PRI47, 0, 32, 8, { DMINT12, DMINT13, DMINT14, DMINT15 } },
+};
+
+static struct intc_sense_reg sense_registers_irq8to15[] __initdata = {
+	{ 0xffd100f8, 32, 2, /* ICR2 */   { IRQ15, IRQ14, IRQ13, IRQ12,
+					    IRQ11, IRQ10, IRQ9, IRQ8 } },
 };

 static DECLARE_INTC_DESC(intc_desc, "sh7757", vectors, groups,
-			 mask_registers, prio_registers, NULL);
+			 mask_registers, prio_registers,
+			 sense_registers_irq8to15);

 /* Support for external interrupt pins in IRQ mode */
 static struct intc_vect vectors_irq0123[] __initdata = {
-- 
1.5.5
