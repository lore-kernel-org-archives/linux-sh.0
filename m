From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Mon, 07 Jul 2008 12:11:51 +0000
Subject: [PATCH 1/2] sh: update sh7343 code
Message-Id: <48720807.4020103@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

updated the following codes for SH7343:
 - add register_intc_controller()
 - add EARLY_SCIF_CONSOLE_PORT
 - add define of CPG register

Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---
 arch/sh/Kconfig.debug                  |    3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |  135 ++++++++++++++++++++++++++++++++
 include/asm-sh/cpu-sh4/freq.h          |    1 +
 3 files changed, 138 insertions(+), 1 deletions(-)

diff --git a/arch/sh/Kconfig.debug b/arch/sh/Kconfig.debug
index 0f45498..36f4b1f 100644
--- a/arch/sh/Kconfig.debug
+++ b/arch/sh/Kconfig.debug
@@ -36,7 +36,8 @@ config EARLY_SCIF_CONSOLE_PORT
 	default "0xff804000" if CPU_SUBTYPE_MXG
 	default "0xffc30000" if CPU_SUBTYPE_SHX3
 	default "0xffe00000" if CPU_SUBTYPE_SH7780 || CPU_SUBTYPE_SH7763 || \
-				CPU_SUBTYPE_SH7722 || CPU_SUBTYPE_SH7366
+				CPU_SUBTYPE_SH7722 || CPU_SUBTYPE_SH7366 || \
+				CPU_SUBTYPE_SH7343
 	default "0xffe80000" if CPU_SH4
 	default "0xffea0000" if CPU_SUBTYPE_SH7785
 	default "0xfffe8000" if CPU_SUBTYPE_SH7203
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7343.c b/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
index 6d4f50c..d55f059 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
@@ -42,6 +42,141 @@ static int __init sh7343_devices_setup(void)
 }
 __initcall(sh7343_devices_setup);

+enum {
+	UNUSED = 0,
+
+	/* interrupt sources */
+	IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7,
+	DMAC0, DMAC1, DMAC2, DMAC3,
+	VIO_CEUI, VIO_BEUI, VIO_VEUI, VOU,
+	MFI, VPU, TPU, Z3D4, USBI0, USBI1,
+	MMC_ERR, MMC_TRAN, MMC_FSTAT, MMC_FRDY,
+	DMAC4, DMAC5, DMAC_DADERR,
+	KEYSC,
+	SCIF, SCIF1, SCIF2, SCIF3, SCIF4,
+	SIOF0, SIOF1, SIO,
+	FLCTL_FLSTEI, FLCTL_FLENDI, FLCTL_FLTREQ0I, FLCTL_FLTREQ1I,
+	I2C0_ALI, I2C0_TACKI, I2C0_WAITI, I2C0_DTEI,
+	I2C1_ALI, I2C1_TACKI, I2C1_WAITI, I2C1_DTEI,
+	SIM_TEI, SIM_TXI, SIM_RXI, SIM_ERI,
+	IRDA,
+	SDHI0, SDHI1, SDHI2, SDHI3,
+	CMT, TSIF, SIU,
+	TMU0, TMU1, TMU2,
+	JPU, LCDC,
+
+	/* interrupt groups */
+
+	DMAC0123, VIOVOU, MMC, DMAC45, FLCTL, I2C0, I2C1, SIM, SDHI, USB,
+};
+
+static struct intc_vect vectors[] __initdata = {
+	INTC_VECT(IRQ0, 0x600), INTC_VECT(IRQ1, 0x620),
+	INTC_VECT(IRQ2, 0x640), INTC_VECT(IRQ3, 0x660),
+	INTC_VECT(IRQ4, 0x680), INTC_VECT(IRQ5, 0x6a0),
+	INTC_VECT(IRQ6, 0x6c0), INTC_VECT(IRQ7, 0x6e0),
+	INTC_VECT(I2C1_ALI, 0x780), INTC_VECT(I2C1_TACKI, 0x7a0),
+	INTC_VECT(I2C1_WAITI, 0x7c0), INTC_VECT(I2C1_DTEI, 0x7e0),
+	INTC_VECT(DMAC0, 0x800), INTC_VECT(DMAC1, 0x820),
+	INTC_VECT(DMAC2, 0x840), INTC_VECT(DMAC3, 0x860),
+	INTC_VECT(VIO_CEUI, 0x880), INTC_VECT(VIO_BEUI, 0x8a0),
+	INTC_VECT(VIO_VEUI, 0x8c0), INTC_VECT(VOU, 0x8e0),
+	INTC_VECT(MFI, 0x900), INTC_VECT(VPU, 0x980),
+	INTC_VECT(TPU, 0x9a0), INTC_VECT(Z3D4, 0x9e0),
+	INTC_VECT(USBI0, 0xa20), INTC_VECT(USBI1, 0xa40),
+	INTC_VECT(MMC_ERR, 0xb00), INTC_VECT(MMC_TRAN, 0xb20),
+	INTC_VECT(MMC_FSTAT, 0xb40), INTC_VECT(MMC_FRDY, 0xb60),
+	INTC_VECT(DMAC4, 0xb80), INTC_VECT(DMAC5, 0xba0),
+	INTC_VECT(DMAC_DADERR, 0xbc0), INTC_VECT(KEYSC, 0xbe0),
+	INTC_VECT(SCIF, 0xc00), INTC_VECT(SCIF1, 0xc20),
+	INTC_VECT(SCIF2, 0xc40), INTC_VECT(SCIF3, 0xc60),
+	INTC_VECT(SIOF0, 0xc80), INTC_VECT(SIOF1, 0xca0),
+	INTC_VECT(SIO, 0xd00),
+	INTC_VECT(FLCTL_FLSTEI, 0xd80), INTC_VECT(FLCTL_FLENDI, 0xda0),
+	INTC_VECT(FLCTL_FLTREQ0I, 0xdc0), INTC_VECT(FLCTL_FLTREQ1I, 0xde0),
+	INTC_VECT(I2C0_ALI, 0xe00), INTC_VECT(I2C0_TACKI, 0xe20),
+	INTC_VECT(I2C0_WAITI, 0xe40), INTC_VECT(I2C0_DTEI, 0xe60),
+	INTC_VECT(SDHI0, 0xe80), INTC_VECT(SDHI1, 0xea0),
+	INTC_VECT(SDHI2, 0xec0), INTC_VECT(SDHI3, 0xee0),
+	INTC_VECT(CMT, 0xf00), INTC_VECT(TSIF, 0xf20),
+	INTC_VECT(SIU, 0xf80),
+	INTC_VECT(TMU0, 0x400), INTC_VECT(TMU1, 0x420),
+	INTC_VECT(TMU2, 0x440),
+	INTC_VECT(JPU, 0x560), INTC_VECT(LCDC, 0x580),
+};
+
+static struct intc_group groups[] __initdata = {
+	INTC_GROUP(DMAC0123, DMAC0, DMAC1, DMAC2, DMAC3),
+	INTC_GROUP(VIOVOU, VIO_CEUI, VIO_BEUI, VIO_VEUI, VOU),
+	INTC_GROUP(MMC, MMC_FRDY, MMC_FSTAT, MMC_TRAN, MMC_ERR),
+	INTC_GROUP(DMAC45, DMAC4, DMAC5, DMAC_DADERR),
+	INTC_GROUP(FLCTL, FLCTL_FLSTEI, FLCTL_FLENDI,
+		   FLCTL_FLTREQ0I, FLCTL_FLTREQ1I),
+	INTC_GROUP(I2C0, I2C0_ALI, I2C0_TACKI, I2C0_WAITI, I2C0_DTEI),
+	INTC_GROUP(I2C1, I2C1_ALI, I2C1_TACKI, I2C1_WAITI, I2C1_DTEI),
+	INTC_GROUP(SIM, SIM_TEI, SIM_TXI, SIM_RXI, SIM_ERI),
+	INTC_GROUP(SDHI, SDHI0, SDHI1, SDHI2, SDHI3),
+	INTC_GROUP(USB, USBI0, USBI1),
+};
+
+static struct intc_mask_reg mask_registers[] __initdata = {
+	{ 0xa4080084, 0xa40800c4, 8, /* IMR1 / IMCR1 */
+	  { VOU, VIO_VEUI, VIO_BEUI, VIO_CEUI, DMAC3, DMAC2, DMAC1, DMAC0 } },
+	{ 0xa4080088, 0xa40800c8, 8, /* IMR2 / IMCR2 */
+	  { 0, 0, 0, VPU, 0, 0, 0, MFI } },
+	{ 0xa408008c, 0xa40800cc, 8, /* IMR3 / IMCR3 */
+	  { SIM_TEI, SIM_TXI, SIM_RXI, SIM_ERI, 0, 0, 0, IRDA } },
+	{ 0xa4080090, 0xa40800d0, 8, /* IMR4 / IMCR4 */
+	  { 0, TMU2, TMU1, TMU0, JPU, 0, 0, LCDC } },
+	{ 0xa4080094, 0xa40800d4, 8, /* IMR5 / IMCR5 */
+	  { KEYSC, DMAC_DADERR, DMAC5, DMAC4, SCIF3, SCIF2, SCIF1, SCIF } },
+	{ 0xa4080098, 0xa40800d8, 8, /* IMR6 / IMCR6 */
+	  { 0, 0, 0, SIO, Z3D4, 0, SIOF1, SIOF0 } },
+	{ 0xa408009c, 0xa40800dc, 8, /* IMR7 / IMCR7 */
+	  { I2C0_DTEI, I2C0_WAITI, I2C0_TACKI, I2C0_ALI,
+	    FLCTL_FLTREQ1I, FLCTL_FLTREQ0I, FLCTL_FLENDI, FLCTL_FLSTEI } },
+	{ 0xa40800a0, 0xa40800e0, 8, /* IMR8 / IMCR8 */
+	  { SDHI3, SDHI2, SDHI1, SDHI0, 0, 0, 0, SIU } },
+	{ 0xa40800a4, 0xa40800e4, 8, /* IMR9 / IMCR9 */
+	  { 0, 0, 0, CMT, 0, USBI1, USBI0 } },
+	{ 0xa40800a8, 0xa40800e8, 8, /* IMR10 / IMCR10 */
+	  { MMC_FRDY, MMC_FSTAT, MMC_TRAN, MMC_ERR } },
+	{ 0xa40800ac, 0xa40800ec, 8, /* IMR11 / IMCR11 */
+	  { I2C1_DTEI, I2C1_WAITI, I2C1_TACKI, I2C1_ALI, TPU, 0, 0, TSIF } },
+	{ 0xa4140044, 0xa4140064, 8, /* INTMSK00 / INTMSKCLR00 */
+	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
+};
+
+static struct intc_prio_reg prio_registers[] __initdata = {
+	{ 0xa4080000, 0, 16, 4, /* IPRA */ { TMU0, TMU1, TMU2 } },
+	{ 0xa4080004, 0, 16, 4, /* IPRB */ { JPU, LCDC, SIM } },
+	{ 0xa4080010, 0, 16, 4, /* IPRE */ { DMAC0123, VIOVOU, MFI, VPU } },
+	{ 0xa4080014, 0, 16, 4, /* IPRF */ { KEYSC, DMAC45, USB, CMT } },
+	{ 0xa4080018, 0, 16, 4, /* IPRG */ { SCIF, SCIF1, SCIF2, SCIF3 } },
+	{ 0xa408001c, 0, 16, 4, /* IPRH */ { SIOF0, SIOF1, FLCTL, I2C0 } },
+	{ 0xa4080020, 0, 16, 4, /* IPRI */ { SIO, 0, TSIF, I2C1 } },
+	{ 0xa4080024, 0, 16, 4, /* IPRJ */ { Z3D4, 0, SIU } },
+	{ 0xa4080028, 0, 16, 4, /* IPRK */ { 0, MMC, 0, SDHI } },
+	{ 0xa408002c, 0, 16, 4, /* IPRL */ { 0, 0, TPU } },
+	{ 0xa4140010, 0, 32, 4, /* INTPRI00 */
+	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
+};
+
+static struct intc_sense_reg sense_registers[] __initdata = {
+	{ 0xa414001c, 16, 2, /* ICR1 */
+	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
+};
+
+static struct intc_mask_reg ack_registers[] __initdata = {
+	{ 0xa4140024, 0, 8, /* INTREQ00 */
+	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
+};
+
+static DECLARE_INTC_DESC_ACK(intc_desc, "sh7343", vectors, groups,
+			     mask_registers, prio_registers, sense_registers,
+			     ack_registers);
+
 void __init plat_irq_setup(void)
 {
+	register_intc_controller(&intc_desc);
 }
diff --git a/include/asm-sh/cpu-sh4/freq.h b/include/asm-sh/cpu-sh4/freq.h
index da46e67..a898105 100644
--- a/include/asm-sh/cpu-sh4/freq.h
+++ b/include/asm-sh/cpu-sh4/freq.h
@@ -12,6 +12,7 @@

 #if defined(CONFIG_CPU_SUBTYPE_SH7722) || \
     defined(CONFIG_CPU_SUBTYPE_SH7723) || \
+    defined(CONFIG_CPU_SUBTYPE_SH7343) || \
     defined(CONFIG_CPU_SUBTYPE_SH7366)
 #define FRQCR		        0xa4150000
 #define VCLKCR			0xa4150004
