From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 11 Mar 2010 05:42:21 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7372 INTCS support
Message-Id: <20100311054221.27152.9839.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add support for the sh7372 INTCS interrupt controller.

INTCS is the interrupt controller for the sh7372 SuperH
processor core. It is tied into the INTCA interrupt
controller which interfaces to the ARM processor.

INTCS support is implemented using a new INTC table
together with a chained interrupt handler that ties
into the already supported INTCA controller.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on:
 "[PATCH] ARM: Add support for 10 hardirq bits"
 "[PATCH] ARM: mach-shmobile: bump up NR_IRQS to 640"
 "[PATCH] ARM: mach-shmobile: add INTCS macros"
 "[PATCH] sh: INTC ioremap support V2"

 arch/arm/mach-shmobile/intc-sh7372.c |  220 ++++++++++++++++++++++++++++++++++
 1 file changed, 220 insertions(+)

--- 0007/arch/arm/mach-shmobile/intc-sh7372.c
+++ work/arch/arm/mach-shmobile/intc-sh7372.c	2010-03-10 00:00:22.000000000 +0900
@@ -363,7 +363,227 @@ static struct intc_desc intca_desc __ini
 			   intca_sense_registers, intca_ack_registers),
 };
 
+enum {
+	UNUSED_INTCS = 0,
+
+	INTCS,
+
+	/* interrupt sources INTCS */
+	VEU_VEU0, VEU_VEU1, VEU_VEU2, VEU_VEU3,
+	RTDMAC_1_DEI0, RTDMAC_1_DEI1, RTDMAC_1_DEI2, RTDMAC_1_DEI3,
+	CEU, BEU_BEU0, BEU_BEU1, BEU_BEU2,
+	VPU,
+	TSIF1,
+	_3DG_SGX530,
+	_2DDMAC,
+	IIC2_ALI2, IIC2_TACKI2, IIC2_WAITI2, IIC2_DTEI2,
+	IPMMU_IPMMUR, IPMMU_IPMMUR2,
+	RTDMAC_2_DEI4, RTDMAC_2_DEI5, RTDMAC_2_DADERR,
+	MSIOF,
+	IIC0_ALI0, IIC0_TACKI0, IIC0_WAITI0, IIC0_DTEI0,
+	TMU_TUNI0, TMU_TUNI1, TMU_TUNI2,
+	CMT0,
+	TSIF0,
+	LMB,
+	CTI,
+	ICB,
+	JPU_JPEG,
+	LCDC,
+	LCRC,
+	RTDMAC2_1_DEI0, RTDMAC2_1_DEI1, RTDMAC2_1_DEI2, RTDMAC2_1_DEI3,
+	RTDMAC2_2_DEI4, RTDMAC2_2_DEI5, RTDMAC2_2_DADERR,
+	ISP,
+	LCDC1,
+	CSIRX,
+	DSITX_DSITX0,
+	DSITX_DSITX1,
+	TMU1_TUNI0, TMU1_TUNI1, TMU1_TUNI2,
+	CMT4,
+	DSITX1_DSITX1_0,
+	DSITX1_DSITX1_1,
+	CPORTS2R,
+	JPU6E,
+
+	/* interrupt groups INTCS */
+	RTDMAC_1, RTDMAC_2, VEU, BEU, IIC0, IPMMU, IIC2,
+	RTDMAC2_1, RTDMAC2_2, TMU1, DSITX,
+};
+
+static struct intc_vect intcs_vectors[] = {
+	INTCS_VECT(VEU_VEU0, 0x700), INTCS_VECT(VEU_VEU1, 0x720),
+	INTCS_VECT(VEU_VEU2, 0x740), INTCS_VECT(VEU_VEU3, 0x760),
+	INTCS_VECT(RTDMAC_1_DEI0, 0x800), INTCS_VECT(RTDMAC_1_DEI1, 0x820),
+	INTCS_VECT(RTDMAC_1_DEI2, 0x840), INTCS_VECT(RTDMAC_1_DEI3, 0x860),
+	INTCS_VECT(CEU, 0x880), INTCS_VECT(BEU_BEU0, 0x8a0),
+	INTCS_VECT(BEU_BEU1, 0x8c0), INTCS_VECT(BEU_BEU2, 0x8e0),
+	INTCS_VECT(VPU, 0x980),
+	INTCS_VECT(TSIF1, 0x9a0),
+	INTCS_VECT(_3DG_SGX530, 0x9e0),
+	INTCS_VECT(_2DDMAC, 0xa00),
+	INTCS_VECT(IIC2_ALI2, 0xa80), INTCS_VECT(IIC2_TACKI2, 0xaa0),
+	INTCS_VECT(IIC2_WAITI2, 0xac0), INTCS_VECT(IIC2_DTEI2, 0xae0),
+	INTCS_VECT(IPMMU_IPMMUR, 0xb00), INTCS_VECT(IPMMU_IPMMUR2, 0xb20),
+	INTCS_VECT(RTDMAC_2_DEI4, 0xb80), INTCS_VECT(RTDMAC_2_DEI5, 0xba0),
+	INTCS_VECT(RTDMAC_2_DADERR, 0xbc0),
+	INTCS_VECT(IIC0_ALI0, 0xe00), INTCS_VECT(IIC0_TACKI0, 0xe20),
+	INTCS_VECT(IIC0_WAITI0, 0xe40), INTCS_VECT(IIC0_DTEI0, 0xe60),
+	INTCS_VECT(TMU_TUNI0, 0xe80), INTCS_VECT(TMU_TUNI1, 0xea0),
+	INTCS_VECT(TMU_TUNI2, 0xec0),
+	INTCS_VECT(CMT0, 0xf00),
+	INTCS_VECT(TSIF0, 0xf20),
+	INTCS_VECT(LMB, 0xf60),
+	INTCS_VECT(CTI, 0x400),
+	INTCS_VECT(ICB, 0x480),
+	INTCS_VECT(JPU_JPEG, 0x560),
+	INTCS_VECT(LCDC, 0x580),
+	INTCS_VECT(LCRC, 0x5a0),
+	INTCS_VECT(RTDMAC2_1_DEI0, 0x1300), INTCS_VECT(RTDMAC2_1_DEI1, 0x1320),
+	INTCS_VECT(RTDMAC2_1_DEI2, 0x1340), INTCS_VECT(RTDMAC2_1_DEI3, 0x1360),
+	INTCS_VECT(RTDMAC2_2_DEI4, 0x1380), INTCS_VECT(RTDMAC2_2_DEI5, 0x13a0),
+	INTCS_VECT(RTDMAC2_2_DADERR, 0x13c0),
+	INTCS_VECT(ISP, 0x1720),
+	INTCS_VECT(LCDC1, 0x1780),
+	INTCS_VECT(CSIRX, 0x17a0),
+	INTCS_VECT(DSITX_DSITX0, 0x17c0),
+	INTCS_VECT(DSITX_DSITX1, 0x17e0),
+	INTCS_VECT(TMU1_TUNI0, 0x1900), INTCS_VECT(TMU1_TUNI1, 0x1920),
+	INTCS_VECT(TMU1_TUNI2, 0x1940),
+	INTCS_VECT(CMT4, 0x1980),
+	INTCS_VECT(DSITX1_DSITX1_0, 0x19a0),
+	INTCS_VECT(DSITX1_DSITX1_1, 0x19c0),
+	INTCS_VECT(CPORTS2R, 0x1a20),
+	INTCS_VECT(JPU6E, 0x1a80),
+
+	INTC_VECT(INTCS, 0xf80),
+};
+
+static struct intc_group intcs_groups[] __initdata = {
+	INTC_GROUP(RTDMAC_1, RTDMAC_1_DEI0, RTDMAC_1_DEI1,
+		   RTDMAC_1_DEI2, RTDMAC_1_DEI3),
+	INTC_GROUP(RTDMAC_2, RTDMAC_2_DEI4, RTDMAC_2_DEI5, RTDMAC_2_DADERR),
+	INTC_GROUP(VEU, VEU_VEU0, VEU_VEU1, VEU_VEU2, VEU_VEU3),
+	INTC_GROUP(BEU, BEU_BEU0, BEU_BEU1, BEU_BEU2),
+	INTC_GROUP(IIC0, IIC0_ALI0, IIC0_TACKI0, IIC0_WAITI0, IIC0_DTEI0),
+	INTC_GROUP(IPMMU, IPMMU_IPMMUR, IPMMU_IPMMUR2),
+	INTC_GROUP(IIC2, IIC2_ALI2, IIC2_TACKI2, IIC2_WAITI2, IIC2_DTEI2),
+	INTC_GROUP(RTDMAC2_1, RTDMAC2_1_DEI0, RTDMAC2_1_DEI1,
+		   RTDMAC2_1_DEI2, RTDMAC2_1_DEI3),
+	INTC_GROUP(RTDMAC2_2, RTDMAC2_2_DEI4,
+		   RTDMAC2_2_DEI5, RTDMAC2_2_DADERR),
+	INTC_GROUP(TMU1, TMU1_TUNI2, TMU1_TUNI1, TMU1_TUNI0),
+	INTC_GROUP(DSITX, DSITX_DSITX0, DSITX_DSITX1),
+};
+
+static struct intc_mask_reg intcs_mask_registers[] = {
+	{ 0xffd20184, 0xffd201c4, 8, /* IMR1SA / IMCR1SA */
+	  { BEU_BEU2, BEU_BEU1, BEU_BEU0, CEU,
+	    VEU_VEU3, VEU_VEU2, VEU_VEU1, VEU_VEU0 } },
+	{ 0xffd20188, 0xffd201c8, 8, /* IMR2SA / IMCR2SA */
+	  { 0, 0, 0, VPU,
+	    0, 0, 0, 0 } },
+	{ 0xffd2018c, 0xffd201cc, 8, /* IMR3SA / IMCR3SA */
+	  { 0, 0, 0, _2DDMAC,
+	    0, 0, 0, ICB } },
+	{ 0xffd20190, 0xffd201d0, 8, /* IMR4SA / IMCR4SA */
+	  { 0, 0, 0, CTI,
+	    JPU_JPEG, 0, LCRC, LCDC } },
+	{ 0xffd20194, 0xffd201d4, 8, /* IMR5SA / IMCR5SA */
+	  { 0, RTDMAC_2_DADERR, RTDMAC_2_DEI5, RTDMAC_2_DEI4,
+	    RTDMAC_1_DEI3, RTDMAC_1_DEI2, RTDMAC_1_DEI1, RTDMAC_1_DEI0 } },
+	{ 0xffd20198, 0xffd201d8, 8, /* IMR6SA / IMCR6SA */
+	  { 0, 0, MSIOF, 0,
+	    _3DG_SGX530, 0, 0, 0 } },
+	{ 0xffd2019c, 0xffd201dc, 8, /* IMR7SA / IMCR7SA */
+	  { 0, TMU_TUNI2, TMU_TUNI1, TMU_TUNI0,
+	    0, 0, 0, 0 } },
+	{ 0xffd201a4, 0xffd201e4, 8, /* IMR9SA / IMCR9SA */
+	  { 0, 0, 0, CMT0,
+	    IIC2_DTEI2, IIC2_WAITI2, IIC2_TACKI2, IIC2_ALI2 } },
+	{ 0xffd201a8, 0xffd201e8, 8, /* IMR10SA / IMCR10SA */
+	  { 0, 0, IPMMU_IPMMUR2, IPMMU_IPMMUR,
+	    0, 0, 0, 0 } },
+	{ 0xffd201ac, 0xffd201ec, 8, /* IMR11SA / IMCR11SA */
+	  { IIC0_DTEI0, IIC0_WAITI0, IIC0_TACKI0, IIC0_ALI0,
+	    0, TSIF1, LMB, TSIF0 } },
+	{ 0xffd50180, 0xffd501c0, 8, /* IMR0SA3 / IMCR0SA3 */
+	  { 0, RTDMAC2_2_DADERR, RTDMAC2_2_DEI5, RTDMAC2_2_DEI4,
+	    RTDMAC2_1_DEI3, RTDMAC2_1_DEI2, RTDMAC2_1_DEI1, RTDMAC2_1_DEI0 } },
+	{ 0xffd50190, 0xffd501d0, 8, /* IMR4SA3 / IMCR4SA3 */
+	  { 0, ISP, 0, 0,
+	    LCDC1, CSIRX, DSITX_DSITX0, DSITX_DSITX1 } },
+	{ 0xffd50198, 0xffd501d8, 8, /* IMR6SA3 / IMCR6SA3 */
+	  { 0, TMU1_TUNI2, TMU1_TUNI1, TMU1_TUNI0,
+	    CMT4, DSITX1_DSITX1_0, DSITX1_DSITX1_1, 0 } },
+	{ 0xffd5019c, 0xffd501dc, 8, /* IMR7SA3 / IMCR7SA3 */
+	  { 0, CPORTS2R, 0, 0,
+	    JPU6E, 0, 0, 0 } },
+	{ 0xffd20104, 0, 16, /* INTAMASK */
+	  { 0, 0, 0, 0, 0, 0, 0, 0,
+	    0, 0, 0, 0, 0, 0, 0, INTCS } },
+};
+
+/* Priority is needed for INTCA to receive the INTCS interrupt */
+static struct intc_prio_reg intcs_prio_registers[] = {
+	{ 0xffd20000, 0, 16, 4, /* IPRAS */ { CTI, 0, _2DDMAC, ICB } },
+	{ 0xffd20004, 0, 16, 4, /* IPRBS */ { JPU_JPEG, LCDC, 0, LCRC } },
+	{ 0xffd20010, 0, 16, 4, /* IPRES */ { RTDMAC_1, CEU, 0, VPU } },
+	{ 0xffd20014, 0, 16, 4, /* IPRFS */ { 0, RTDMAC_2, 0, CMT0 } },
+	{ 0xffd20018, 0, 16, 4, /* IPRGS */ { TMU_TUNI0, TMU_TUNI1,
+					      TMU_TUNI2, TSIF1 } },
+	{ 0xffd2001c, 0, 16, 4, /* IPRHS */ { 0, 0, VEU, BEU } },
+	{ 0xffd20020, 0, 16, 4, /* IPRIS */ { 0, MSIOF, TSIF0, IIC0 } },
+	{ 0xffd20024, 0, 16, 4, /* IPRJS */ { 0, _3DG_SGX530, 0, 0 } },
+	{ 0xffd20028, 0, 16, 4, /* IPRKS */ { 0, 0, LMB, 0 } },
+	{ 0xffd2002c, 0, 16, 4, /* IPRLS */ { IPMMU, 0, 0, 0 } },
+	{ 0xffd20030, 0, 16, 4, /* IPRMS */ { IIC2, 0, 0, 0 } },
+	{ 0xffd50000, 0, 16, 4, /* IPRAS3 */ { RTDMAC2_1, 0, 0, 0 } },
+	{ 0xffd50004, 0, 16, 4, /* IPRBS3 */ { RTDMAC2_2, 0, 0, 0 } },
+	{ 0xffd50020, 0, 16, 4, /* IPRIS3 */ { 0, ISP, 0, 0 } },
+	{ 0xffd50024, 0, 16, 4, /* IPRJS3 */ { LCDC1, CSIRX, DSITX, 0 } },
+	{ 0xffd50030, 0, 16, 4, /* IPRMS3 */ { TMU1, 0, 0, 0 } },
+	{ 0xffd50034, 0, 16, 4, /* IPRNS3 */ { CMT4, DSITX1_DSITX1_0,
+					       DSITX1_DSITX1_1, 0 } },
+	{ 0xffd50038, 0, 16, 4, /* IPROS3 */ { 0, CPORTS2R, 0, 0 } },
+	{ 0xffd5003c, 0, 16, 4, /* IPRPS3 */ { JPU6E, 0, 0, 0 } },
+};
+
+static struct resource intcs_resources[] __initdata = {
+	[0] = {
+		.start	= 0xffd20000,
+		.end	= 0xffd201ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 0xffd50000,
+		.end	= 0xffd501ff,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
+static struct intc_desc intcs_desc __initdata = {
+	.name = "sh7372-intcs",
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
 void __init sh7372_init_irq(void)
 {
+	void __iomem *intevtsa = ioremap_nocache(0xffd20100, PAGE_SIZE);
+
 	register_intc_controller(&intca_desc);
+	register_intc_controller(&intcs_desc);
+
+	/* demux using INTEVTSA */
+	set_irq_data(evt2irq(0xf80), (void *)intevtsa);
+	set_irq_chained_handler(evt2irq(0xf80), intcs_demux);
 }
