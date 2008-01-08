From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 08 Jan 2008 06:12:40 +0000
Subject: [PATCH] sh: intc - remove default interrupt priority tables
Message-Id: <20080108061240.14389.51112.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh: intc - remove default interrupt priority tables

This patch removes interrupt priority tables from the intc code. Optimal 
priority assignment varies with embedded application anyway, so keeping the
interrupt priority tables together with cpu-specific code doesn't make sense.

The function intc_set_priority() should be used instead to set the desired
interrupt priority level.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Applies to the sh-2.6 tree. Boots on r2d-plus.

 arch/sh/boards/renesas/r7780rp/irq-r7780mp.c |    2 -
 arch/sh/boards/renesas/r7780rp/irq-r7785rp.c |    2 -
 arch/sh/boards/renesas/rts7751r2d/irq.c      |    4 +--
 arch/sh/cchips/voyagergx/irq.c               |    2 -
 arch/sh/kernel/cpu/irq/intc.c                |   31 +++-----------------------
 arch/sh/kernel/cpu/sh2/setup-sh7619.c        |    2 -
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c       |    2 -
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c       |    2 -
 arch/sh/kernel/cpu/sh3/setup-sh7705.c        |   10 +-------
 arch/sh/kernel/cpu/sh3/setup-sh770x.c        |   11 +--------
 arch/sh/kernel/cpu/sh3/setup-sh7710.c        |   16 +------------
 arch/sh/kernel/cpu/sh3/setup-sh7720.c        |   14 +----------
 arch/sh/kernel/cpu/sh4/setup-sh7750.c        |   18 +++++----------
 arch/sh/kernel/cpu/sh4/setup-sh7760.c        |   13 +---------
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c       |   10 --------
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c       |   13 +++-------
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c       |   19 ++++-----------
 arch/sh/kernel/cpu/sh4a/setup-shx3.c         |   14 ++---------
 include/asm-sh/hw_irq.h                      |   12 ----------
 19 files changed, 42 insertions(+), 155 deletions(-)

--- 0001/arch/sh/boards/renesas/r7780rp/irq-r7780mp.c
+++ work/arch/sh/boards/renesas/r7780rp/irq-r7780mp.c	2008-01-05 20:26:02.000000000 +0900
@@ -47,7 +47,7 @@ static unsigned char irl2irq[HL_NR_IRL] 
 };
 
 static DECLARE_INTC_DESC(intc_desc, "r7780mp", vectors,
-			 NULL, NULL, mask_registers, NULL, NULL);
+			 NULL, mask_registers, NULL, NULL);
 
 unsigned char * __init highlander_init_irq_r7780mp(void)
 {
--- 0001/arch/sh/boards/renesas/r7780rp/irq-r7785rp.c
+++ work/arch/sh/boards/renesas/r7780rp/irq-r7785rp.c	2008-01-05 20:26:02.000000000 +0900
@@ -41,7 +41,7 @@ static unsigned char irl2irq[HL_NR_IRL] 
 };
 
 static DECLARE_INTC_DESC(intc_desc, "r7785rp", vectors,
-			 NULL, NULL, mask_registers, NULL, NULL);
+			 NULL, mask_registers, NULL, NULL);
 
 unsigned char * __init highlander_init_irq_r7785rp(void)
 {
--- 0001/arch/sh/boards/renesas/rts7751r2d/irq.c
+++ work/arch/sh/boards/renesas/rts7751r2d/irq.c	2008-01-05 20:26:02.000000000 +0900
@@ -71,7 +71,7 @@ static unsigned char irl2irq_r2d_1[R2D_N
 };
 
 static DECLARE_INTC_DESC(intc_desc_r2d_1, "r2d-1", vectors_r2d_1,
-			 NULL, NULL, mask_registers_r2d_1, NULL, NULL);
+			 NULL, mask_registers_r2d_1, NULL, NULL);
 
 #endif /* CONFIG_RTS7751R2D_1 */
 
@@ -109,7 +109,7 @@ static unsigned char irl2irq_r2d_plus[R2
 };
 
 static DECLARE_INTC_DESC(intc_desc_r2d_plus, "r2d-plus", vectors_r2d_plus,
-			 NULL, NULL, mask_registers_r2d_plus, NULL, NULL);
+			 NULL, mask_registers_r2d_plus, NULL, NULL);
 
 #endif /* CONFIG_RTS7751R2D_PLUS */
 
--- 0001/arch/sh/cchips/voyagergx/irq.c
+++ work/arch/sh/cchips/voyagergx/irq.c	2008-01-05 20:26:02.000000000 +0900
@@ -58,7 +58,7 @@ static struct intc_mask_reg mask_registe
 };
 
 static DECLARE_INTC_DESC(intc_desc, "voyagergx", vectors,
-			 NULL, NULL, mask_registers, NULL, NULL);
+			 NULL, mask_registers, NULL, NULL);
 
 static unsigned int voyagergx_stat2irq[32] = {
 	IRQ_SM501_CI, IRQ_SM501_PV, IRQ_SM501_ZD, IRQ_SM501_2D,
--- 0001/arch/sh/kernel/cpu/irq/intc.c
+++ work/arch/sh/kernel/cpu/irq/intc.c	2008-01-05 20:30:24.000000000 +0900
@@ -335,31 +335,6 @@ static intc_enum __init intc_grp_id(stru
 	return 0;
 }
 
-static unsigned int __init intc_prio_value(struct intc_desc *desc,
-					   intc_enum enum_id, int do_grps)
-{
-	struct intc_prio *p = desc->priorities;
-	unsigned int i;
-
-	for (i = 0; p && enum_id && i < desc->nr_priorities; i++) {
-		p = desc->priorities + i;
-
-		if (p->enum_id != enum_id)
-			continue;
-
-		return p->priority;
-	}
-
-	if (do_grps)
-		return intc_prio_value(desc, intc_grp_id(desc, enum_id), 0);
-
-	/* default to the lowest priority possible if no priority is set
-	 * - this needs to be at least 2 for 5-bit priorities on 7780
-	 */
-
-	return 2;
-}
-
 static unsigned int __init intc_mask_data(struct intc_desc *desc,
 					  struct intc_desc_int *d,
 					  intc_enum enum_id, int do_grps)
@@ -518,8 +493,10 @@ static void __init intc_register_irq(str
 				      handle_level_irq, "level");
 	set_irq_chip_data(irq, (void *)data[primary]);
 
-	/* record the desired priority level */
-	intc_prio_level[irq] = intc_prio_value(desc, enum_id, 1);
+	/* set priority level
+	 * - this needs to be at least 2 for 5-bit priorities on 7780
+	 */
+	intc_prio_level[irq] = 2;
 
 	/* enable secondary masking method if present */
 	if (data[!primary])
--- 0001/arch/sh/kernel/cpu/sh2/setup-sh7619.c
+++ work/arch/sh/kernel/cpu/sh2/setup-sh7619.c	2008-01-05 20:26:02.000000000 +0900
@@ -65,7 +65,7 @@ static struct intc_prio_reg prio_registe
 };
 
 static DECLARE_INTC_DESC(intc_desc, "sh7619", vectors, groups,
-			 NULL, NULL, prio_registers, NULL);
+			 NULL, prio_registers, NULL);
 
 static struct plat_sci_port sci_platform_data[] = {
 	{
--- 0001/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
+++ work/arch/sh/kernel/cpu/sh2a/setup-sh7203.c	2008-01-05 20:26:02.000000000 +0900
@@ -235,7 +235,7 @@ static struct intc_mask_reg mask_registe
 };
 
 static DECLARE_INTC_DESC(intc_desc, "sh7203", vectors, groups,
-			 NULL, mask_registers, prio_registers, NULL);
+			 mask_registers, prio_registers, NULL);
 
 static struct plat_sci_port sci_platform_data[] = {
 	{
--- 0001/arch/sh/kernel/cpu/sh2a/setup-sh7206.c
+++ work/arch/sh/kernel/cpu/sh2a/setup-sh7206.c	2008-01-05 20:26:02.000000000 +0900
@@ -167,7 +167,7 @@ static struct intc_mask_reg mask_registe
 };
 
 static DECLARE_INTC_DESC(intc_desc, "sh7206", vectors, groups,
-			 NULL, mask_registers, prio_registers, NULL);
+			 mask_registers, prio_registers, NULL);
 
 static struct plat_sci_port sci_platform_data[] = {
 	{
--- 0001/arch/sh/kernel/cpu/sh3/setup-sh7705.c
+++ work/arch/sh/kernel/cpu/sh3/setup-sh7705.c	2008-01-05 20:26:02.000000000 +0900
@@ -66,12 +66,6 @@ static struct intc_group groups[] __init
 	INTC_GROUP(SCIF2, SCIF2_ERI, SCIF2_RXI, SCIF2_TXI),
 };
 
-static struct intc_prio priorities[] __initdata = {
-	INTC_PRIO(DMAC, 7),
-	INTC_PRIO(SCIF2, 3),
-	INTC_PRIO(SCIF0, 3),
-};
-
 static struct intc_prio_reg prio_registers[] __initdata = {
 	{ 0xfffffee2, 0, 16, 4, /* IPRA */ { TMU0, TMU1, TMU2, RTC } },
 	{ 0xfffffee4, 0, 16, 4, /* IPRB */ { WDT, REF_RCMI, 0, 0 } },
@@ -85,7 +79,7 @@ static struct intc_prio_reg prio_registe
 };
 
 static DECLARE_INTC_DESC(intc_desc, "sh7705", vectors, groups,
-			 priorities, NULL, prio_registers, NULL);
+			 NULL, prio_registers, NULL);
 
 static struct intc_vect vectors_irq[] __initdata = {
 	INTC_VECT(IRQ0, 0x600), INTC_VECT(IRQ1, 0x620),
@@ -93,7 +87,7 @@ static struct intc_vect vectors_irq[] __
 };
 
 static DECLARE_INTC_DESC(intc_desc_irq, "sh7705-irq", vectors_irq, NULL,
-			 priorities, NULL, prio_registers, NULL);
+			 NULL, prio_registers, NULL);
 
 static struct plat_sci_port sci_platform_data[] = {
 	{
--- 0001/arch/sh/kernel/cpu/sh3/setup-sh770x.c
+++ work/arch/sh/kernel/cpu/sh3/setup-sh770x.c	2008-01-05 20:26:02.000000000 +0900
@@ -81,13 +81,6 @@ static struct intc_group groups[] __init
 	INTC_GROUP(SCIF2, SCIF2_ERI, SCIF2_RXI, SCIF2_BRI, SCIF2_TXI),
 };
 
-static struct intc_prio priorities[] __initdata = {
-	INTC_PRIO(DMAC, 7),
-	INTC_PRIO(SCI, 3),
-	INTC_PRIO(SCIF2, 3),
-	INTC_PRIO(SCIF0, 3),
-};
-
 static struct intc_prio_reg prio_registers[] __initdata = {
 	{ 0xfffffee2, 0, 16, 4, /* IPRA */ { TMU0, TMU1, TMU2, RTC } },
 	{ 0xfffffee4, 0, 16, 4, /* IPRB */ { WDT, REF, SCI, 0 } },
@@ -109,7 +102,7 @@ static struct intc_prio_reg prio_registe
 };
 
 static DECLARE_INTC_DESC(intc_desc, "sh770x", vectors, groups,
-			 priorities, NULL, prio_registers, NULL);
+			 NULL, prio_registers, NULL);
 
 #if defined(CONFIG_CPU_SUBTYPE_SH7706) || \
     defined(CONFIG_CPU_SUBTYPE_SH7707) || \
@@ -120,7 +113,7 @@ static struct intc_vect vectors_irq[] __
 };
 
 static DECLARE_INTC_DESC(intc_desc_irq, "sh770x-irq", vectors_irq, NULL,
-			 priorities, NULL, prio_registers, NULL);
+			 NULL, prio_registers, NULL);
 #endif
 
 static struct resource rtc_resources[] = {
--- 0001/arch/sh/kernel/cpu/sh3/setup-sh7710.c
+++ work/arch/sh/kernel/cpu/sh3/setup-sh7710.c	2008-01-05 20:26:02.000000000 +0900
@@ -73,18 +73,6 @@ static struct intc_group groups[] __init
 	INTC_GROUP(SIOF1, SIOF1_ERI, SIOF1_TXI, SIOF1_RXI, SIOF1_CCI),
 };
 
-static struct intc_prio priorities[] __initdata = {
-	INTC_PRIO(DMAC1, 7),
-	INTC_PRIO(DMAC2, 7),
-	INTC_PRIO(SCIF0, 3),
-	INTC_PRIO(SCIF1, 3),
-	INTC_PRIO(SIOF0, 3),
-	INTC_PRIO(SIOF1, 3),
-	INTC_PRIO(EDMAC0, 5),
-	INTC_PRIO(EDMAC1, 5),
-	INTC_PRIO(EDMAC2, 5),
-};
-
 static struct intc_prio_reg prio_registers[] __initdata = {
 	{ 0xfffffee2, 0, 16, 4, /* IPRA */ { TMU0, TMU1, TMU2, RTC } },
 	{ 0xfffffee4, 0, 16, 4, /* IPRB */ { WDT, REF, 0, 0 } },
@@ -101,7 +89,7 @@ static struct intc_prio_reg prio_registe
 };
 
 static DECLARE_INTC_DESC(intc_desc, "sh7710", vectors, groups,
-			 priorities, NULL, prio_registers, NULL);
+			 NULL, prio_registers, NULL);
 
 static struct intc_vect vectors_irq[] __initdata = {
 	INTC_VECT(IRQ0, 0x600), INTC_VECT(IRQ1, 0x620),
@@ -109,7 +97,7 @@ static struct intc_vect vectors_irq[] __
 };
 
 static DECLARE_INTC_DESC(intc_desc_irq, "sh7710-irq", vectors_irq, NULL,
-			 priorities, NULL, prio_registers, NULL);
+			 NULL, prio_registers, NULL);
 
 static struct resource rtc_resources[] = {
 	[0] =	{
--- 0001/arch/sh/kernel/cpu/sh3/setup-sh7720.c
+++ work/arch/sh/kernel/cpu/sh3/setup-sh7720.c	2008-01-05 20:26:02.000000000 +0900
@@ -156,16 +156,6 @@ static struct intc_group groups[] __init
 	INTC_GROUP(MMC, MMCI0, MMCI1, MMCI2, MMCI3),
 };
 
-static struct intc_prio priorities[] __initdata = {
-	INTC_PRIO(SCIF0, 2),
-	INTC_PRIO(SCIF1, 2),
-	INTC_PRIO(DMAC1, 1),
-	INTC_PRIO(DMAC2, 1),
-	INTC_PRIO(RTC, 2),
-	INTC_PRIO(TMU, 2),
-	INTC_PRIO(TPU, 2),
-};
-
 static struct intc_prio_reg prio_registers[] __initdata = {
 	{ 0xA414FEE2UL, 0, 16, 4, /* IPRA */ { TMU0, TMU1, TMU2, RTC } },
 	{ 0xA414FEE4UL, 0, 16, 4, /* IPRB */ { WDT, REF_RCMI, SIM, 0 } },
@@ -184,7 +174,7 @@ static struct intc_prio_reg prio_registe
 };
 
 static DECLARE_INTC_DESC(intc_desc, "sh7720", vectors, groups,
-		priorities, NULL, prio_registers, NULL);
+		NULL, prio_registers, NULL);
 
 static struct intc_sense_reg sense_registers[] __initdata = {
 	{ INTC_ICR1, 16, 2, { 0, 0, IRQ5, IRQ4, IRQ3, IRQ2, IRQ1, IRQ0 } },
@@ -197,7 +187,7 @@ static struct intc_vect vectors_irq[] __
 };
 
 static DECLARE_INTC_DESC(intc_irq_desc, "sh7720-irq", vectors_irq,
-		NULL, priorities, NULL, prio_registers, sense_registers);
+		NULL, NULL, prio_registers, sense_registers);
 
 void __init plat_irq_setup_pins(int mode)
 {
--- 0001/arch/sh/kernel/cpu/sh4/setup-sh7750.c
+++ work/arch/sh/kernel/cpu/sh4/setup-sh7750.c	2008-01-05 20:26:02.000000000 +0900
@@ -126,12 +126,6 @@ static struct intc_group groups[] __init
 	INTC_GROUP(REF, REF_RCMI, REF_ROVI),
 };
 
-static struct intc_prio priorities[] __initdata = {
-	INTC_PRIO(SCIF, 3),
-	INTC_PRIO(SCI1, 3),
-	INTC_PRIO(DMAC, 7),
-};
-
 static struct intc_prio_reg prio_registers[] __initdata = {
 	{ 0xffd00004, 0, 16, 4, /* IPRA */ { TMU0, TMU1, TMU2, RTC } },
 	{ 0xffd00008, 0, 16, 4, /* IPRB */ { WDT, REF, SCI1, 0 } },
@@ -143,7 +137,7 @@ static struct intc_prio_reg prio_registe
 };
 
 static DECLARE_INTC_DESC(intc_desc, "sh7750", vectors, groups,
-			 priorities, NULL, prio_registers, NULL);
+			 NULL, prio_registers, NULL);
 
 /* SH7750, SH7750S, SH7751 and SH7091 all have 4-channel DMA controllers */
 #if defined(CONFIG_CPU_SUBTYPE_SH7750) || \
@@ -163,7 +157,7 @@ static struct intc_group groups_dma4[] _
 
 static DECLARE_INTC_DESC(intc_desc_dma4, "sh7750_dma4",
 			 vectors_dma4, groups_dma4,
-			 priorities, NULL, prio_registers, NULL);
+			 NULL, prio_registers, NULL);
 #endif
 
 /* SH7750R and SH7751R both have 8-channel DMA controllers */
@@ -184,7 +178,7 @@ static struct intc_group groups_dma8[] _
 
 static DECLARE_INTC_DESC(intc_desc_dma8, "sh7750_dma8",
 			 vectors_dma8, groups_dma8,
-			 priorities, NULL, prio_registers, NULL);
+			 NULL, prio_registers, NULL);
 #endif
 
 /* SH7750R, SH7751 and SH7751R all have two extra timer channels */
@@ -205,7 +199,7 @@ static struct intc_mask_reg mask_registe
 };
 
 static DECLARE_INTC_DESC(intc_desc_tmu34, "sh7750_tmu34",
-			 vectors_tmu34, NULL, priorities,
+			 vectors_tmu34, NULL,
 			 mask_registers, prio_registers, NULL);
 #endif
 
@@ -216,7 +210,7 @@ static struct intc_vect vectors_irlm[] _
 };
 
 static DECLARE_INTC_DESC(intc_desc_irlm, "sh7750_irlm", vectors_irlm, NULL,
-			 priorities, NULL, prio_registers, NULL);
+			 NULL, prio_registers, NULL);
 
 /* SH7751 and SH7751R both have PCI */
 #if defined(CONFIG_CPU_SUBTYPE_SH7751) || defined(CONFIG_CPU_SUBTYPE_SH7751R)
@@ -233,7 +227,7 @@ static struct intc_group groups_pci[] __
 };
 
 static DECLARE_INTC_DESC(intc_desc_pci, "sh7750_pci", vectors_pci, groups_pci,
-			 priorities, mask_registers, prio_registers, NULL);
+			 mask_registers, prio_registers, NULL);
 #endif
 
 #if defined(CONFIG_CPU_SUBTYPE_SH7750) || \
--- 0001/arch/sh/kernel/cpu/sh4/setup-sh7760.c
+++ work/arch/sh/kernel/cpu/sh4/setup-sh7760.c	2008-01-05 20:26:02.000000000 +0900
@@ -92,15 +92,6 @@ static struct intc_group groups[] __init
 	INTC_GROUP(REF, REF_RCMI, REF_ROVI),
 };
 
-static struct intc_prio priorities[] __initdata = {
-	INTC_PRIO(SCIF0, 3),
-	INTC_PRIO(SCIF1, 3),
-	INTC_PRIO(SCIF2, 3),
-	INTC_PRIO(SIM, 3),
-	INTC_PRIO(DMAC, 7),
-	INTC_PRIO(DMABRG, 13),
-};
-
 static struct intc_mask_reg mask_registers[] __initdata = {
 	{ 0xfe080040, 0xfe080060, 32, /* INTMSK00 / INTMSKCLR00 */
 	  { IRQ4, IRQ5, IRQ6, IRQ7, 0, 0, HCAN20, HCAN21,
@@ -132,7 +123,7 @@ static struct intc_prio_reg prio_registe
 };
 
 static DECLARE_INTC_DESC(intc_desc, "sh7760", vectors, groups,
-			 priorities, mask_registers, prio_registers, NULL);
+			 mask_registers, prio_registers, NULL);
 
 static struct intc_vect vectors_irq[] __initdata = {
 	INTC_VECT(IRL0, 0x240), INTC_VECT(IRL1, 0x2a0),
@@ -140,7 +131,7 @@ static struct intc_vect vectors_irq[] __
 };
 
 static DECLARE_INTC_DESC(intc_desc_irq, "sh7760-irq", vectors_irq, groups,
-			 priorities, mask_registers, prio_registers, NULL);
+			 mask_registers, prio_registers, NULL);
 
 static struct plat_sci_port sci_platform_data[] = {
 	{
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7722.c	2008-01-05 20:26:02.000000000 +0900
@@ -157,14 +157,6 @@ static struct intc_group groups[] __init
 	INTC_GROUP(SDHI, SDHI0, SDHI1, SDHI2, SDHI3),
 };
 
-static struct intc_prio priorities[] __initdata = {
-	INTC_PRIO(SCIF0, 3),
-	INTC_PRIO(SCIF1, 3),
-	INTC_PRIO(SCIF2, 3),
-	INTC_PRIO(TMU0, 2),
-	INTC_PRIO(TMU1, 2),
-};
-
 static struct intc_mask_reg mask_registers[] __initdata = {
 	{ 0xa4080080, 0xa40800c0, 8, /* IMR0 / IMCR0 */
 	  { } },
@@ -217,7 +209,7 @@ static struct intc_sense_reg sense_regis
 	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
 };
 
-static DECLARE_INTC_DESC(intc_desc, "sh7722", vectors, groups, priorities,
+static DECLARE_INTC_DESC(intc_desc, "sh7722", vectors, groups,
 			 mask_registers, prio_registers, sense_registers);
 
 void __init plat_irq_setup(void)
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7780.c	2008-01-05 20:26:02.000000000 +0900
@@ -168,11 +168,6 @@ static struct intc_group groups[] __init
 	INTC_GROUP(GPIO, GPIOI0, GPIOI1, GPIOI2, GPIOI3),
 };
 
-static struct intc_prio priorities[] __initdata = {
-	INTC_PRIO(SCIF0, 3),
-	INTC_PRIO(SCIF1, 3),
-};
-
 static struct intc_mask_reg mask_registers[] __initdata = {
 	{ 0xffd40038, 0xffd4003c, 32, /* INT2MSKR / INT2MSKCR */
 	  { 0, 0, 0, 0, 0, 0, GPIO, FLCTL,
@@ -195,7 +190,7 @@ static struct intc_prio_reg prio_registe
 	{ 0xffd4001c, 0, 32, 8, /* INT2PRI7 */ { FLCTL, GPIO } },
 };
 
-static DECLARE_INTC_DESC(intc_desc, "sh7780", vectors, groups, priorities,
+static DECLARE_INTC_DESC(intc_desc, "sh7780", vectors, groups,
 			 mask_registers, prio_registers, NULL);
 
 /* Support for external interrupt pins in IRQ mode */
@@ -223,7 +218,7 @@ static struct intc_sense_reg irq_sense_r
 };
 
 static DECLARE_INTC_DESC(intc_irq_desc, "sh7780-irq", irq_vectors,
-			 NULL, NULL, irq_mask_registers, irq_prio_registers,
+			 NULL, irq_mask_registers, irq_prio_registers,
 			 irq_sense_registers);
 
 /* External interrupt pins in IRL mode */
@@ -257,10 +252,10 @@ static struct intc_mask_reg irl7654_mask
 };
 
 static DECLARE_INTC_DESC(intc_irl7654_desc, "sh7780-irl7654", irl_vectors,
-			 NULL, NULL, irl7654_mask_registers, NULL, NULL);
+			 NULL, irl7654_mask_registers, NULL, NULL);
 
 static DECLARE_INTC_DESC(intc_irl3210_desc, "sh7780-irl3210", irl_vectors,
-			 NULL, NULL, irl3210_mask_registers, NULL, NULL);
+			 NULL, irl3210_mask_registers, NULL, NULL);
 
 #define INTC_ICR0	0xffd00000
 #define INTC_INTMSK0	0xffd00044
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7785.c	2008-01-05 20:26:02.000000000 +0900
@@ -178,15 +178,6 @@ static struct intc_group groups[] __init
 	INTC_GROUP(GPIO, GPIOI0, GPIOI1, GPIOI2, GPIOI3),
 };
 
-static struct intc_prio priorities[] __initdata = {
-	INTC_PRIO(SCIF0, 3),
-	INTC_PRIO(SCIF1, 3),
-	INTC_PRIO(SCIF2, 3),
-	INTC_PRIO(SCIF3, 3),
-	INTC_PRIO(SCIF4, 3),
-	INTC_PRIO(SCIF5, 3),
-};
-
 static struct intc_mask_reg mask_registers[] __initdata = {
 	{ 0xffd00044, 0xffd00064, 32, /* INTMSK0 / INTMSKCLR0 */
 	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
@@ -227,7 +218,7 @@ static struct intc_prio_reg prio_registe
 	{ 0xffd40024, 0, 32, 8, /* INT2PRI9 */ { DU, GDTA, } },
 };
 
-static DECLARE_INTC_DESC(intc_desc, "sh7785", vectors, groups, priorities,
+static DECLARE_INTC_DESC(intc_desc, "sh7785", vectors, groups,
 			 mask_registers, prio_registers, NULL);
 
 /* Support for external interrupt pins in IRQ mode */
@@ -248,11 +239,11 @@ static struct intc_sense_reg sense_regis
 };
 
 static DECLARE_INTC_DESC(intc_desc_irq0123, "sh7785-irq0123", vectors_irq0123,
-			 NULL, NULL, mask_registers, prio_registers,
+			 NULL, mask_registers, prio_registers,
 			 sense_registers);
 
 static DECLARE_INTC_DESC(intc_desc_irq4567, "sh7785-irq4567", vectors_irq4567,
-			 NULL, NULL, mask_registers, prio_registers,
+			 NULL, mask_registers, prio_registers,
 			 sense_registers);
 
 /* External interrupt pins in IRL mode */
@@ -280,10 +271,10 @@ static struct intc_vect vectors_irl4567[
 };
 
 static DECLARE_INTC_DESC(intc_desc_irl0123, "sh7785-irl0123", vectors_irl0123,
-			 NULL, NULL, mask_registers, NULL, NULL);
+			 NULL, mask_registers, NULL, NULL);
 
 static DECLARE_INTC_DESC(intc_desc_irl4567, "sh7785-irl4567", vectors_irl4567,
-			 NULL, NULL, mask_registers, NULL, NULL);
+			 NULL, mask_registers, NULL, NULL);
 
 #define INTC_ICR0	0xffd00000
 #define INTC_INTMSK0	0xffd00044
--- 0001/arch/sh/kernel/cpu/sh4a/setup-shx3.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-shx3.c	2008-01-05 20:26:02.000000000 +0900
@@ -165,13 +165,6 @@ static struct intc_group groups[] __init
 	INTC_GROUP(DTU3, DTU3_TEND, DTU3_AE, DTU3_TMISS),
 };
 
-static struct intc_prio priorities[] __initdata = {
-	INTC_PRIO(SCIF0, 3),
-	INTC_PRIO(SCIF1, 3),
-	INTC_PRIO(SCIF2, 3),
-	INTC_PRIO(SCIF3, 3),
-};
-
 static struct intc_mask_reg mask_registers[] __initdata = {
 	{ 0xfe410030, 0xfe410050, 32, /* CnINTMSK0 / CnINTMSKCLR0 */
 	  { IRQ0, IRQ1, IRQ2, IRQ3 } },
@@ -218,7 +211,7 @@ static struct intc_prio_reg prio_registe
 	    INTICI3, INTICI2, INTICI1, INTICI0 }, INTC_SMP(4, 4) },
 };
 
-static DECLARE_INTC_DESC(intc_desc, "shx3", vectors, groups, priorities,
+static DECLARE_INTC_DESC(intc_desc, "shx3", vectors, groups,
 			 mask_registers, prio_registers, NULL);
 
 /* Support for external interrupt pins in IRQ mode */
@@ -232,8 +225,7 @@ static struct intc_sense_reg sense_regis
 };
 
 static DECLARE_INTC_DESC(intc_desc_irq, "shx3-irq", vectors_irq, groups,
-			 priorities, mask_registers, prio_registers,
-			 sense_registers);
+			 mask_registers, prio_registers, sense_registers);
 
 /* External interrupt pins in IRL mode */
 static struct intc_vect vectors_irl[] __initdata = {
@@ -248,7 +240,7 @@ static struct intc_vect vectors_irl[] __
 };
 
 static DECLARE_INTC_DESC(intc_desc_irl, "shx3-irl", vectors_irl, groups,
-			 priorities, mask_registers, prio_registers, NULL);
+			 mask_registers, prio_registers, NULL);
 
 void __init plat_irq_setup_pins(int mode)
 {
--- 0001/include/asm-sh/hw_irq.h
+++ work/include/asm-sh/hw_irq.h	2008-01-05 20:26:02.000000000 +0900
@@ -33,13 +33,6 @@ struct intc_vect {
 #define INTC_VECT(enum_id, vect) { enum_id, vect }
 #define INTC_IRQ(enum_id, irq) INTC_VECT(enum_id, irq2evt(irq))
 
-struct intc_prio {
-	intc_enum enum_id;
-	unsigned char priority;
-};
-
-#define INTC_PRIO(enum_id, prio) { enum_id, prio }
-
 struct intc_group {
 	intc_enum enum_id;
 	intc_enum enum_ids[32];
@@ -79,8 +72,6 @@ struct intc_desc {
 	unsigned int nr_vectors;
 	struct intc_group *groups;
 	unsigned int nr_groups;
-	struct intc_prio *priorities;
-	unsigned int nr_priorities;
 	struct intc_mask_reg *mask_regs;
 	unsigned int nr_mask_regs;
 	struct intc_prio_reg *prio_regs;
@@ -92,10 +83,9 @@ struct intc_desc {
 
 #define _INTC_ARRAY(a) a, sizeof(a)/sizeof(*a)
 #define DECLARE_INTC_DESC(symbol, chipname, vectors, groups,		\
-	priorities, mask_regs, prio_regs, sense_regs)			\
+	mask_regs, prio_regs, sense_regs)				\
 struct intc_desc symbol __initdata = {					\
 	_INTC_ARRAY(vectors), _INTC_ARRAY(groups),			\
-	_INTC_ARRAY(priorities),					\
 	_INTC_ARRAY(mask_regs), _INTC_ARRAY(prio_regs),			\
 	_INTC_ARRAY(sense_regs),					\
 	chipname,							\
