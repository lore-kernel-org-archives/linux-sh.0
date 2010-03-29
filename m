From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Mon, 29 Mar 2010 07:58:13 +0000
Subject: [PATCH] ARM: mach-shmobile: intc-sh7377: Add INTCS support
Message-Id: <u1vf3v9t7.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Add support for the sh7377 INTCS interrupt controller.

INTCS is the interrupt controller for the sh7377 SuperH
processor core. It is tied into the INTCA interrupt
controller which interfaces to the ARM processor.

INTCS support is implemented using a new INTC table
together with a chained interrupt handler that ties
into the already supported INTCA controller.

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/arm/mach-shmobile/intc-sh7377.c |  294 ++++++++++++++++++++++++++++++++++
 1 files changed, 294 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/intc-sh7377.c b/arch/arm/mach-shmobile/intc-sh7377.c
index 68901a4..2cdeb8c 100644
--- a/arch/arm/mach-shmobile/intc-sh7377.c
+++ b/arch/arm/mach-shmobile/intc-sh7377.c
@@ -346,7 +346,301 @@ static struct intc_desc intca_desc __initdata = {
 			   intca_sense_registers, intca_ack_registers),
 };
 
+/* this macro ignore entry which is also in INTCA */
+#define __IGNORE(a...)
+#define __IGNORE0(a...) 0
+
+enum {
+	UNUSED_INTCS = 0,
+
+	INTCS,
+
+	/* interrupt sources INTCS */
+	VEU_VEU0, VEU_VEU1, VEU_VEU2, VEU_VEU3,
+	RTDMAC1_1_DEI0, RTDMAC1_1_DEI1, RTDMAC1_1_DEI2, RTDMAC1_1_DEI3,
+	CEU,
+	BEU_BEU0, BEU_BEU1, BEU_BEU2,
+	__IGNORE(MFI)
+	__IGNORE(BBIF2)
+	VPU,
+	TSIF1,
+	__IGNORE(SGX540)
+	_2DDMAC,
+	IIC2_ALI2, IIC2_TACKI2, IIC2_WAITI2, IIC2_DTEI2,
+	IPMMU_IPMMUR, IPMMU_IPMMUR2,
+	RTDMAC1_2_DEI4, RTDMAC1_2_DEI5, RTDMAC1_2_DADERR,
+	__IGNORE(KEYSC)
+	__IGNORE(TTI20)
+	__IGNORE(MSIOF)
+	IIC0_ALI0, IIC0_TACKI0, IIC0_WAITI0, IIC0_DTEI0,
+	TMU_TUNI0, TMU_TUNI1, TMU_TUNI2,
+	CMT0,
+	TSIF0,
+	__IGNORE(CMT2)
+	LMB,
+	__IGNORE(MSUG)
+	__IGNORE(MSU_MSU, MSU_MSU2)
+	__IGNORE(CTI)
+	MVI3,
+	__IGNORE(RWDT0)
+	__IGNORE(RWDT1)
+	ICB,
+	PEP,
+	ASA,
+	__IGNORE(_2DG)
+	HQE,
+	JPU,
+	LCDC0,
+	__IGNORE(LCRC)
+	RTDMAC2_1_DEI0, RTDMAC2_1_DEI1, RTDMAC2_1_DEI2, RTDMAC2_1_DEI3,
+	RTDMAC2_2_DEI4, RTDMAC2_2_DEI5, RTDMAC2_2_DADERR,
+	FRC,
+	LCDC1,
+	CSIRX,
+	DSITX_DSITX0, DSITX_DSITX1,
+	__IGNORE(SPU2_SPU0, SPU2_SPU1)
+	__IGNORE(FSI)
+	__IGNORE(FMSI)
+	__IGNORE(SCUV)
+	TMU1_TUNI10, TMU1_TUNI11, TMU1_TUNI12,
+	TSIF2,
+	CMT4,
+	__IGNORE(MFIS2)
+	CPORTS2R,
+
+	/* interrupt groups INTCS */
+	RTDMAC1_1, RTDMAC1_2, VEU, BEU, IIC0, __IGNORE(MSU) IPMMU,
+	IIC2, RTDMAC2_1, RTDMAC2_2, DSITX, __IGNORE(SPU2) TMU1,
+};
+
+#define INTCS_INTVECT 0x0F80
+static struct intc_vect intcs_vectors[] __initdata = {
+	INTCS_VECT(VEU_VEU0, 0x0700), INTCS_VECT(VEU_VEU1, 0x0720),
+	INTCS_VECT(VEU_VEU2, 0x0740), INTCS_VECT(VEU_VEU3, 0x0760),
+	INTCS_VECT(RTDMAC1_1_DEI0, 0x0800), INTCS_VECT(RTDMAC1_1_DEI1, 0x0820),
+	INTCS_VECT(RTDMAC1_1_DEI2, 0x0840), INTCS_VECT(RTDMAC1_1_DEI3, 0x0860),
+	INTCS_VECT(CEU, 0x0880),
+	INTCS_VECT(BEU_BEU0, 0x08A0),
+	INTCS_VECT(BEU_BEU1, 0x08C0),
+	INTCS_VECT(BEU_BEU2, 0x08E0),
+	__IGNORE(INTCS_VECT(MFI, 0x0900))
+	__IGNORE(INTCS_VECT(BBIF2, 0x0960))
+	INTCS_VECT(VPU, 0x0980),
+	INTCS_VECT(TSIF1, 0x09A0),
+	__IGNORE(INTCS_VECT(SGX540, 0x09E0))
+	INTCS_VECT(_2DDMAC, 0x0A00),
+	INTCS_VECT(IIC2_ALI2, 0x0A80), INTCS_VECT(IIC2_TACKI2, 0x0AA0),
+	INTCS_VECT(IIC2_WAITI2, 0x0AC0), INTCS_VECT(IIC2_DTEI2, 0x0AE0),
+	INTCS_VECT(IPMMU_IPMMUR, 0x0B00), INTCS_VECT(IPMMU_IPMMUR2, 0x0B20),
+	INTCS_VECT(RTDMAC1_2_DEI4, 0x0B80),
+	INTCS_VECT(RTDMAC1_2_DEI5, 0x0BA0),
+	INTCS_VECT(RTDMAC1_2_DADERR, 0x0BC0),
+	__IGNORE(INTCS_VECT(KEYSC 0x0BE0))
+	__IGNORE(INTCS_VECT(TTI20, 0x0C80))
+	__IGNORE(INTCS_VECT(MSIOF, 0x0D20))
+	INTCS_VECT(IIC0_ALI0, 0x0E00), INTCS_VECT(IIC0_TACKI0, 0x0E20),
+	INTCS_VECT(IIC0_WAITI0, 0x0E40), INTCS_VECT(IIC0_DTEI0, 0x0E60),
+	INTCS_VECT(TMU_TUNI0, 0x0E80),
+	INTCS_VECT(TMU_TUNI1, 0x0EA0),
+	INTCS_VECT(TMU_TUNI2, 0x0EC0),
+	INTCS_VECT(CMT0, 0x0F00),
+	INTCS_VECT(TSIF0, 0x0F20),
+	__IGNORE(INTCS_VECT(CMT2, 0x0F40))
+	INTCS_VECT(LMB, 0x0F60),
+	__IGNORE(INTCS_VECT(MSUG, 0x0F80))
+	__IGNORE(INTCS_VECT(MSU_MSU, 0x0FA0))
+	__IGNORE(INTCS_VECT(MSU_MSU2, 0x0FC0))
+	__IGNORE(INTCS_VECT(CTI, 0x0400))
+	INTCS_VECT(MVI3, 0x0420),
+	__IGNORE(INTCS_VECT(RWDT0, 0x0440))
+	__IGNORE(INTCS_VECT(RWDT1, 0x0460))
+	INTCS_VECT(ICB, 0x0480),
+	INTCS_VECT(PEP, 0x04A0),
+	INTCS_VECT(ASA, 0x04C0),
+	__IGNORE(INTCS_VECT(_2DG, 0x04E0))
+	INTCS_VECT(HQE, 0x0540),
+	INTCS_VECT(JPU, 0x0560),
+	INTCS_VECT(LCDC0, 0x0580),
+	__IGNORE(INTCS_VECT(LCRC, 0x05A0))
+	INTCS_VECT(RTDMAC2_1_DEI0, 0x1300), INTCS_VECT(RTDMAC2_1_DEI1, 0x1320),
+	INTCS_VECT(RTDMAC2_1_DEI2, 0x1340), INTCS_VECT(RTDMAC2_1_DEI3, 0x1360),
+	INTCS_VECT(RTDMAC2_2_DEI4, 0x1380), INTCS_VECT(RTDMAC2_2_DEI5, 0x13A0),
+	INTCS_VECT(RTDMAC2_2_DADERR, 0x13C0),
+	INTCS_VECT(FRC, 0x1700),
+	INTCS_VECT(LCDC1, 0x1780),
+	INTCS_VECT(CSIRX, 0x17A0),
+	INTCS_VECT(DSITX_DSITX0, 0x17C0), INTCS_VECT(DSITX_DSITX1, 0x17E0),
+	__IGNORE(INTCS_VECT(SPU2_SPU0, 0x1800))
+	__IGNORE(INTCS_VECT(SPU2_SPU1, 0x1820))
+	__IGNORE(INTCS_VECT(FSI, 0x1840))
+	__IGNORE(INTCS_VECT(FMSI, 0x1860))
+	__IGNORE(INTCS_VECT(SCUV, 0x1880))
+	INTCS_VECT(TMU1_TUNI10, 0x1900), INTCS_VECT(TMU1_TUNI11, 0x1920),
+	INTCS_VECT(TMU1_TUNI12, 0x1940),
+	INTCS_VECT(TSIF2, 0x1960),
+	INTCS_VECT(CMT4, 0x1980),
+	__IGNORE(INTCS_VECT(MFIS2, 0x1A00))
+	INTCS_VECT(CPORTS2R, 0x1A20),
+
+	INTC_VECT(INTCS, INTCS_INTVECT),
+};
+
+static struct intc_group intcs_groups[] __initdata = {
+	INTC_GROUP(RTDMAC1_1,
+		   RTDMAC1_1_DEI0, RTDMAC1_1_DEI1,
+		   RTDMAC1_1_DEI2, RTDMAC1_1_DEI3),
+	INTC_GROUP(RTDMAC1_2,
+		   RTDMAC1_2_DEI4, RTDMAC1_2_DEI5, RTDMAC1_2_DADERR),
+	INTC_GROUP(VEU, VEU_VEU0, VEU_VEU1, VEU_VEU2, VEU_VEU3),
+	INTC_GROUP(BEU, BEU_BEU0, BEU_BEU1, BEU_BEU2),
+	INTC_GROUP(IIC0, IIC0_ALI0, IIC0_TACKI0, IIC0_WAITI0, IIC0_DTEI0),
+	__IGNORE(INTC_GROUP(MSU, MSU_MSU, MSU_MSU2))
+	INTC_GROUP(IPMMU, IPMMU_IPMMUR, IPMMU_IPMMUR2),
+	INTC_GROUP(IIC2, IIC2_ALI2, IIC2_TACKI2, IIC2_WAITI2, IIC2_DTEI2),
+	INTC_GROUP(RTDMAC2_1,
+		   RTDMAC2_1_DEI0, RTDMAC2_1_DEI1,
+		   RTDMAC2_1_DEI2, RTDMAC2_1_DEI3),
+	INTC_GROUP(RTDMAC2_2, RTDMAC2_2_DEI4, RTDMAC2_2_DEI5, RTDMAC2_2_DADERR),
+	INTC_GROUP(DSITX, DSITX_DSITX0, DSITX_DSITX1),
+	__IGNORE(INTC_GROUP(SPU2, SPU2_SPU0, SPU2_SPU1))
+	INTC_GROUP(TMU1, TMU1_TUNI10, TMU1_TUNI11, TMU1_TUNI12),
+};
+
+static struct intc_mask_reg intcs_mask_registers[] __initdata = {
+	{ 0xE6940184, 0xE69401C4, 8, /* IMR1AS / IMCR1AS  */
+	  { BEU_BEU2, BEU_BEU1, BEU_BEU0, CEU,
+	    VEU_VEU3, VEU_VEU2, VEU_VEU1, VEU_VEU0 } },
+	{ 0xE6940188, 0xE69401C8, 8, /* IMR2AS / IMCR2AS */
+	  { 0, 0, 0, VPU,
+	    __IGNORE0(BBIF2), 0, 0, __IGNORE0(MFI) } },
+	{ 0xE694018C, 0xE69401CC, 8, /* IMR3AS / IMCR3AS */
+	  { 0, 0, 0, _2DDMAC,
+	    __IGNORE0(_2DG), ASA, PEP, ICB } },
+	{ 0xE6940190, 0xE69401D0, 8, /* IMR4AS / IMCR4AS */
+	  { 0, 0, MVI3, __IGNORE0(CTI),
+	    JPU, HQE, __IGNORE0(LCRC), LCDC0 } },
+	{ 0xE6940194, 0xE69401D4, 8, /* IMR5AS / IMCR5AS */
+	  { __IGNORE0(KEYSC), RTDMAC1_2_DADERR, RTDMAC1_2_DEI5, RTDMAC1_2_DEI4,
+	    RTDMAC1_1_DEI3, RTDMAC1_1_DEI2, RTDMAC1_1_DEI1, RTDMAC1_1_DEI0 } },
+	__IGNORE({ 0xE6940198, 0xE69401D8, 8, /* IMR6AS / IMCR6AS */
+	  { 0, 0, MSIOF, 0,
+	    SGX540, 0, TTI20, 0 } })
+	{ 0xE694019C, 0xE69401DC, 8, /* IMR7AS / IMCR7AS */
+	  { 0, TMU_TUNI2, TMU_TUNI1, TMU_TUNI0,
+	    0, 0, 0, 0 } },
+	__IGNORE({ 0xE69401A0, 0xE69401E0, 8, /* IMR8AS / IMCR8AS */
+	  { 0, 0, 0, 0,
+	    0, MSU_MSU, MSU_MSU2, MSUG } })
+	{ 0xE69401A4, 0xE69401E4, 8, /* IMR9AS / IMCR9AS */
+	  { __IGNORE0(RWDT1), __IGNORE0(RWDT0), __IGNORE0(CMT2), CMT0,
+	    IIC2_DTEI2, IIC2_WAITI2, IIC2_TACKI2, IIC2_ALI2 } },
+	{ 0xE69401A8, 0xE69401E8, 8, /* IMR10AS / IMCR10AS */
+	  { 0, 0, IPMMU_IPMMUR, IPMMU_IPMMUR2,
+	    0, 0, 0, 0 } },
+	{ 0xE69401AC, 0xE69401EC, 8, /* IMR11AS / IMCR11AS */
+	  { IIC0_DTEI0, IIC0_WAITI0, IIC0_TACKI0, IIC0_ALI0,
+	    0, TSIF1, LMB, TSIF0 } },
+	{ 0xE6950180, 0xE69501C0, 8, /* IMR0AS3 / IMCR0AS3 */
+	  { RTDMAC2_1_DEI0, RTDMAC2_1_DEI1, RTDMAC2_1_DEI2, RTDMAC2_1_DEI3,
+	    RTDMAC2_2_DEI4, RTDMAC2_2_DEI5, RTDMAC2_2_DADERR, 0 } },
+	{ 0xE6950190, 0xE69501D0, 8, /* IMR4AS3 / IMCR4AS3 */
+	  { FRC, 0, 0, 0,
+	    LCDC1, CSIRX, DSITX_DSITX0, DSITX_DSITX1 } },
+	__IGNORE({ 0xE6950194, 0xE69501D4, 8, /* IMR5AS3 / IMCR5AS3 */
+	  {SPU2_SPU0, SPU2_SPU1, FSI, FMSI,
+	   SCUV, 0, 0, 0 } })
+	{ 0xE6950198, 0xE69501D8, 8, /* IMR6AS3 / IMCR6AS3 */
+	  { TMU1_TUNI10, TMU1_TUNI11, TMU1_TUNI12, TSIF2,
+	    CMT4, 0, 0, 0 } },
+	{ 0xE695019C, 0xE69501DC, 8, /* IMR7AS3 / IMCR7AS3 */
+	  { __IGNORE0(MFIS2), CPORTS2R, 0, 0,
+	    0, 0, 0, 0 } },
+	{ 0xFFD20104, 0, 16, /* INTAMASK */
+	  { 0, 0, 0, 0, 0, 0, 0, 0,
+	    0, 0, 0, 0, 0, 0, 0, INTCS } }
+};
+
+static struct intc_prio_reg intcs_prio_registers[] __initdata = {
+	/* IPRAS */
+	{ 0xFFD20000, 0, 16, 4, { __IGNORE0(CTI), MVI3, _2DDMAC, ICB } },
+	/* IPRBS */
+	{ 0xFFD20004, 0, 16, 4, { JPU, LCDC0, 0, __IGNORE0(LCRC) } },
+	/* IPRCS */
+	__IGNORE({ 0xFFD20008, 0, 16, 4, { BBIF2, 0, 0, 0 } })
+	/* IPRES */
+	{ 0xFFD20010, 0, 16, 4, { RTDMAC1_1, CEU, __IGNORE0(MFI), VPU } },
+	/* IPRFS */
+	{ 0xFFD20014, 0, 16, 4,
+	  { __IGNORE0(KEYSC), RTDMAC1_2, __IGNORE0(CMT2), CMT0 } },
+	/* IPRGS */
+	{ 0xFFD20018, 0, 16, 4, { TMU_TUNI0, TMU_TUNI1, TMU_TUNI2, TSIF1 } },
+	/* IPRHS */
+	{ 0xFFD2001C, 0, 16, 4, { __IGNORE0(TTI20), 0, VEU, BEU } },
+	/* IPRIS */
+	{ 0xFFD20020, 0, 16, 4, { 0, __IGNORE0(MSIOF), TSIF0, IIC0 } },
+	/* IPRJS */
+	__IGNORE({ 0xFFD20024, 0, 16, 4, { 0, SGX540, MSUG, MSU } })
+	/* IPRKS */
+	{ 0xFFD20028, 0, 16, 4, { __IGNORE0(_2DG), ASA, LMB, PEP } },
+	/* IPRLS */
+	{ 0xFFD2002C, 0, 16, 4, { IPMMU, 0, 0, HQE } },
+	/* IPRMS */
+	{ 0xFFD20030, 0, 16, 4,
+	  { IIC2, 0, __IGNORE0(RWDT1), __IGNORE0(RWDT0) } },
+	/* IPRAS3 */
+	{ 0xFFD50000, 0, 16, 4, { RTDMAC2_1, 0, 0, 0 } },
+	/* IPRBS3 */
+	{ 0xFFD50004, 0, 16, 4, { RTDMAC2_2, 0, 0, 0 } },
+	/* IPRIS3 */
+	{ 0xFFD50020, 0, 16, 4, { FRC, 0, 0, 0 } },
+	/* IPRJS3 */
+	{ 0xFFD50024, 0, 16, 4, { LCDC1, CSIRX, DSITX, 0 } },
+	/* IPRKS3 */
+	__IGNORE({ 0xFFD50028, 0, 16, 4, { SPU2, 0, FSI, FMSI } })
+	/* IPRLS3 */
+	__IGNORE({ 0xFFD5002C, 0, 16, 4, { SCUV, 0, 0, 0 } })
+	/* IPRMS3 */
+	{ 0xFFD50030, 0, 16, 4, { TMU1, 0, 0, TSIF2 } },
+	/* IPRNS3 */
+	{ 0xFFD50034, 0, 16, 4, { CMT4, 0, 0, 0 } },
+	/* IPROS3 */
+	{ 0xFFD50038, 0, 16, 4, { __IGNORE0(MFIS2), CPORTS2R, 0, 0 } },
+};
+
+static struct resource intcs_resources[] __initdata = {
+	[0] = {
+		.start	= 0xffd20000,
+		.end	= 0xffd500ff,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
+static struct intc_desc intcs_desc __initdata = {
+	.name = "sh7377-intcs",
+	.resource = intcs_resources,
+	.num_resources = ARRAY_SIZE(intcs_resources),
+	.hw = INTC_HW_DESC(intcs_vectors, intcs_groups,
+			   intcs_mask_registers, intcs_prio_registers,
+			   NULL, NULL),
+};
+
+static void intcs_demux(unsigned int irq, struct irq_desc *desc)
+{
+	void __iomem *reg = (void *)get_irq_data(irq);
+	unsigned int evtcodeas = ioread32(reg);
+
+	generic_handle_irq(intcs_evt2irq(evtcodeas));
+}
+
+#define INTEVTSA 0xFFD20100
 void __init sh7377_init_irq(void)
 {
+	void __iomem *intevtsa = ioremap_nocache(INTEVTSA, PAGE_SIZE);
+
 	register_intc_controller(&intca_desc);
+	register_intc_controller(&intcs_desc);
+
+	/* demux using INTEVTSA */
+	set_irq_data(evt2irq(INTCS_INTVECT), (void *)intevtsa);
+	set_irq_chained_handler(evt2irq(INTCS_INTVECT), intcs_demux);
 }
-- 
1.6.3.3

