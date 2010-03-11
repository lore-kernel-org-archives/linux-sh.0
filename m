From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 11 Mar 2010 06:52:33 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7367 INTCS support
Message-Id: <20100311065233.31275.37948.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add support for the sh7367 INTCS interrupt controller.

INTCS is the interrupt controller for the sh7367 SuperH
processor core. It is tied into the INTCA interrupt
controller which interfaces to the ARM processor.

INTCS support is implemented using a new INTC table
together with a chained interrupt handler that ties
into the already supported INTCA controller.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on:
 "[PATCH] ARM: mach-shmobile: add INTCS macros"
 "[PATCH] sh: INTC ioremap support V2"

 arch/arm/mach-shmobile/intc-sh7367.c |  172 +++++++++++++++++++++++++++++++++-
 1 file changed, 171 insertions(+), 1 deletion(-)

--- 0012/arch/arm/mach-shmobile/intc-sh7367.c
+++ work/arch/arm/mach-shmobile/intc-sh7367.c	2010-03-09 21:21:00.000000000 +0900
@@ -263,8 +263,178 @@ static struct intc_desc intca_desc __ini
 			   intca_sense_registers, intca_ack_registers),
 };
 
+enum {
+	UNUSED_INTCS = 0,
+
+	INTCS,
+
+	/* interrupt sources INTCS */
+	VIO2_VEU0, VIO2_VEU1, VIO2_VEU2, VIO2_VEU3,
+	VIO3_VOU,
+	RTDMAC_1_DEI0, RTDMAC_1_DEI1, RTDMAC_1_DEI2, RTDMAC_1_DEI3,
+	VIO1_CEU, VIO1_BEU0, VIO1_BEU1, VIO1_BEU2,
+	VPU,
+	SGX530,
+	_2DDMAC_2DDM0, _2DDMAC_2DDM1, _2DDMAC_2DDM2, _2DDMAC_2DDM3,
+	IIC2_ALI2, IIC2_TACKI2, IIC2_WAITI2, IIC2_DTEI2,
+	IPMMU_IPMMUB, IPMMU_IPMMUS,
+	RTDMAC_2_DEI4, RTDMAC_2_DEI5, RTDMAC_2_DADERR,
+	MSIOF,
+	IIC0_ALI0, IIC0_TACKI0, IIC0_WAITI0, IIC0_DTEI0,
+	TMU_TUNI0, TMU_TUNI1, TMU_TUNI2,
+	CMT,
+	TSIF,
+	IPMMUI,
+	MVI3,
+	ICB,
+	PEP,
+	ASA,
+	BEM,
+	VE2HO,
+	HQE,
+	JPEG,
+	LCDC,
+
+	/* interrupt groups INTCS */
+	_2DDMAC, RTDMAC_1, RTDMAC_2, VEU, BEU, IIC0, IPMMU, IIC2,
+};
+
+static struct intc_vect intcs_vectors[] = {
+	INTCS_VECT(VIO2_VEU0, 0x700), INTCS_VECT(VIO2_VEU1, 0x720),
+	INTCS_VECT(VIO2_VEU2, 0x740), INTCS_VECT(VIO2_VEU3, 0x760),
+	INTCS_VECT(VIO3_VOU, 0x780),
+	INTCS_VECT(RTDMAC_1_DEI0, 0x800), INTCS_VECT(RTDMAC_1_DEI1, 0x820),
+	INTCS_VECT(RTDMAC_1_DEI2, 0x840), INTCS_VECT(RTDMAC_1_DEI3, 0x860),
+	INTCS_VECT(VIO1_CEU, 0x880), INTCS_VECT(VIO1_BEU0, 0x8a0),
+	INTCS_VECT(VIO1_BEU1, 0x8c0), INTCS_VECT(VIO1_BEU2, 0x8e0),
+	INTCS_VECT(VPU, 0x980),
+	INTCS_VECT(SGX530, 0x9e0),
+	INTCS_VECT(_2DDMAC_2DDM0, 0xa00), INTCS_VECT(_2DDMAC_2DDM1, 0xa20),
+	INTCS_VECT(_2DDMAC_2DDM2, 0xa40), INTCS_VECT(_2DDMAC_2DDM3, 0xa60),
+	INTCS_VECT(IIC2_ALI2, 0xa80), INTCS_VECT(IIC2_TACKI2, 0xaa0),
+	INTCS_VECT(IIC2_WAITI2, 0xac0), INTCS_VECT(IIC2_DTEI2, 0xae0),
+	INTCS_VECT(IPMMU_IPMMUB, 0xb20), INTCS_VECT(IPMMU_IPMMUS, 0xb60),
+	INTCS_VECT(RTDMAC_2_DEI4, 0xb80), INTCS_VECT(RTDMAC_2_DEI5, 0xba0),
+	INTCS_VECT(RTDMAC_2_DADERR, 0xbc0),
+	INTCS_VECT(MSIOF, 0xd20),
+	INTCS_VECT(IIC0_ALI0, 0xe00), INTCS_VECT(IIC0_TACKI0, 0xe20),
+	INTCS_VECT(IIC0_WAITI0, 0xe40), INTCS_VECT(IIC0_DTEI0, 0xe60),
+	INTCS_VECT(TMU_TUNI0, 0xe80), INTCS_VECT(TMU_TUNI1, 0xea0),
+	INTCS_VECT(TMU_TUNI2, 0xec0),
+	INTCS_VECT(CMT, 0xf00),
+	INTCS_VECT(TSIF, 0xf20),
+	INTCS_VECT(IPMMUI, 0xf60),
+	INTCS_VECT(MVI3, 0x420),
+	INTCS_VECT(ICB, 0x480),
+	INTCS_VECT(PEP, 0x4a0),
+	INTCS_VECT(ASA, 0x4c0),
+	INTCS_VECT(BEM, 0x4e0),
+	INTCS_VECT(VE2HO, 0x520),
+	INTCS_VECT(HQE, 0x540),
+	INTCS_VECT(JPEG, 0x560),
+	INTCS_VECT(LCDC, 0x580),
+
+	INTC_VECT(INTCS, 0xf80),
+};
+
+static struct intc_group intcs_groups[] __initdata = {
+	INTC_GROUP(_2DDMAC, _2DDMAC_2DDM0, _2DDMAC_2DDM1,
+		   _2DDMAC_2DDM2, _2DDMAC_2DDM3),
+	INTC_GROUP(RTDMAC_1, RTDMAC_1_DEI0, RTDMAC_1_DEI1,
+		   RTDMAC_1_DEI2, RTDMAC_1_DEI3),
+	INTC_GROUP(RTDMAC_2, RTDMAC_2_DEI4, RTDMAC_2_DEI5, RTDMAC_2_DADERR),
+	INTC_GROUP(VEU, VIO2_VEU0, VIO2_VEU1, VIO2_VEU2, VIO2_VEU3),
+	INTC_GROUP(BEU, VIO1_BEU0, VIO1_BEU1, VIO1_BEU2),
+	INTC_GROUP(IIC0, IIC0_ALI0, IIC0_TACKI0, IIC0_WAITI0, IIC0_DTEI0),
+	INTC_GROUP(IPMMU, IPMMU_IPMMUS, IPMMU_IPMMUB),
+	INTC_GROUP(IIC2, IIC2_ALI2, IIC2_TACKI2, IIC2_WAITI2, IIC2_DTEI2),
+};
+
+static struct intc_mask_reg intcs_mask_registers[] = {
+	{ 0xffd20184, 0xffd201c4, 8, /* IMR1SA / IMCR1SA */
+	  { VIO1_BEU2, VIO1_BEU1, VIO1_BEU0, VIO1_CEU,
+	    VIO2_VEU3, VIO2_VEU2, VIO2_VEU1, VIO2_VEU0 } },
+	{ 0xffd20188, 0xffd201c8, 8, /* IMR2SA / IMCR2SA */
+	  { VIO3_VOU, 0, VE2HO, VPU,
+	    0, 0, 0, 0 } },
+	{ 0xffd2018c, 0xffd201cc, 8, /* IMR3SA / IMCR3SA */
+	  { _2DDMAC_2DDM3, _2DDMAC_2DDM2, _2DDMAC_2DDM1, _2DDMAC_2DDM0,
+	    BEM, ASA, PEP, ICB } },
+	{ 0xffd20190, 0xffd201d0, 8, /* IMR4SA / IMCR4SA */
+	  { 0, 0, MVI3, 0,
+	    JPEG, HQE, 0, LCDC } },
+	{ 0xffd20194, 0xffd201d4, 8, /* IMR5SA / IMCR5SA */
+	  { 0, RTDMAC_2_DADERR, RTDMAC_2_DEI5, RTDMAC_2_DEI4,
+	    RTDMAC_1_DEI3, RTDMAC_1_DEI2, RTDMAC_1_DEI1, RTDMAC_1_DEI0 } },
+	{ 0xffd20198, 0xffd201d8, 8, /* IMR6SA / IMCR6SA */
+	  { 0, 0, MSIOF, 0,
+	    SGX530, 0, 0, 0 } },
+	{ 0xffd2019c, 0xffd201dc, 8, /* IMR7SA / IMCR7SA */
+	  { 0, TMU_TUNI2, TMU_TUNI1, TMU_TUNI0,
+	    0, 0, 0, 0 } },
+	{ 0xffd201a4, 0xffd201e4, 8, /* IMR9SA / IMCR9SA */
+	  { 0, 0, 0, CMT,
+	    IIC2_DTEI2, IIC2_WAITI2, IIC2_TACKI2, IIC2_ALI2 } },
+	{ 0xffd201a8, 0xffd201e8, 8, /* IMR10SA / IMCR10SA */
+	  { IPMMU_IPMMUS, 0, IPMMU_IPMMUB, 0,
+	    0, 0, 0, 0 } },
+	{ 0xffd201ac, 0xffd201ec, 8, /* IMR11SA / IMCR11SA */
+	  { IIC0_DTEI0, IIC0_WAITI0, IIC0_TACKI0, IIC0_ALI0,
+	    0, 0, IPMMUI, TSIF } },
+	{ 0xffd20104, 0, 16, /* INTAMASK */
+	  { 0, 0, 0, 0, 0, 0, 0, 0,
+	    0, 0, 0, 0, 0, 0, 0, INTCS } },
+};
+
+/* Priority is needed for INTCA to receive the INTCS interrupt */
+static struct intc_prio_reg intcs_prio_registers[] = {
+	{ 0xffd20000, 0, 16, 4, /* IPRAS */ { 0, MVI3, _2DDMAC, ICB } },
+	{ 0xffd20004, 0, 16, 4, /* IPRBS */ { JPEG, LCDC, 0, 0 } },
+	{ 0xffd20008, 0, 16, 4, /* IPRCS */ { BBIF2, 0, 0, 0 } },
+	{ 0xffd20010, 0, 16, 4, /* IPRES */ { RTDMAC_1, VIO1_CEU, 0, VPU } },
+	{ 0xffd20014, 0, 16, 4, /* IPRFS */ { 0, RTDMAC_2, 0, CMT } },
+	{ 0xffd20018, 0, 16, 4, /* IPRGS */ { TMU_TUNI0, TMU_TUNI1,
+					      TMU_TUNI2, 0 } },
+	{ 0xffd2001c, 0, 16, 4, /* IPRHS */ { 0, VIO3_VOU, VEU, BEU } },
+	{ 0xffd20020, 0, 16, 4, /* IPRIS */ { 0, MSIOF, TSIF, IIC0 } },
+	{ 0xffd20024, 0, 16, 4, /* IPRJS */ { 0, SGX530, 0, 0 } },
+	{ 0xffd20028, 0, 16, 4, /* IPRKS */ { BEM, ASA, IPMMUI, PEP } },
+	{ 0xffd2002c, 0, 16, 4, /* IPRLS */ { IPMMU, 0, VE2HO, HQE } },
+	{ 0xffd20030, 0, 16, 4, /* IPRMS */ { IIC2, 0, 0, 0 } },
+};
+
+static struct resource intcs_resources[] __initdata = {
+	[0] = {
+		.start	= 0xffd20000,
+		.end	= 0xffd2ffff,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
+static struct intc_desc intcs_desc __initdata = {
+	.name = "sh7367-intcs",
+	.resource = intcs_resources,
+	.num_resources = ARRAY_SIZE(intcs_resources),
+	.hw = INTC_HW_DESC(intcs_vectors, intcs_groups, intcs_mask_registers,
+			   intcs_prio_registers, NULL, NULL),
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
 void __init sh7367_init_irq(void)
 {
-	/* INTCA */
+	void __iomem *intevtsa = ioremap_nocache(0xffd20100, PAGE_SIZE);
+
 	register_intc_controller(&intca_desc);
+	register_intc_controller(&intcs_desc);
+
+	/* demux using INTEVTSA */
+	set_irq_data(evt2irq(0xf80), (void *)intevtsa);
+	set_irq_chained_handler(evt2irq(0xf80), intcs_demux);
 }
