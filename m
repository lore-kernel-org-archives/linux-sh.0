From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 28 Dec 2010 08:27:01 +0000
Subject: [PATCH 02/04] ARM: mach-shmobile: Run-time IRQ handler for INTCA
Message-Id: <20101228082701.11806.31618.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Break-out INTC specific IRQ demux code from the file
entry-macro-intc.S and register during run-time.

Covers sh7367, sh7377 and sh7372.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile              |    5 ++
 arch/arm/mach-shmobile/board-ap4evb.c        |    1 
 arch/arm/mach-shmobile/board-g3evm.c         |    1 
 arch/arm/mach-shmobile/board-g4evm.c         |    1 
 arch/arm/mach-shmobile/board-mackerel.c      |    1 
 arch/arm/mach-shmobile/entry-intc.S          |   57 ++++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h |    1 
 7 files changed, 67 insertions(+)

--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2010-12-28 14:45:16.000000000 +0900
@@ -18,6 +18,11 @@ pfc-$(CONFIG_ARCH_SH7377)	+= pfc-sh7377.
 pfc-$(CONFIG_ARCH_SH7372)	+= pfc-sh7372.o
 pfc-$(CONFIG_ARCH_SH73A0)	+= pfc-sh73a0.o
 
+# IRQ objects
+obj-$(CONFIG_ARCH_SH7367)	+= entry-intc.o
+obj-$(CONFIG_ARCH_SH7377)	+= entry-intc.o
+obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.o
+
 # Board objects
 obj-$(CONFIG_MACH_G3EVM)	+= board-g3evm.o
 obj-$(CONFIG_MACH_G4EVM)	+= board-g4evm.o
--- 0001/arch/arm/mach-shmobile/board-ap4evb.c
+++ work/arch/arm/mach-shmobile/board-ap4evb.c	2010-12-28 14:45:16.000000000 +0900
@@ -1365,6 +1365,7 @@ static struct sys_timer ap4evb_timer = {
 MACHINE_START(AP4EVB, "ap4evb")
 	.map_io		= ap4evb_map_io,
 	.init_irq	= sh7372_init_irq,
+	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= ap4evb_init,
 	.timer		= &ap4evb_timer,
 MACHINE_END
--- 0001/arch/arm/mach-shmobile/board-g3evm.c
+++ work/arch/arm/mach-shmobile/board-g3evm.c	2010-12-28 14:45:16.000000000 +0900
@@ -367,6 +367,7 @@ static struct sys_timer g3evm_timer = {
 MACHINE_START(G3EVM, "g3evm")
 	.map_io		= g3evm_map_io,
 	.init_irq	= sh7367_init_irq,
+	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= g3evm_init,
 	.timer		= &g3evm_timer,
 MACHINE_END
--- 0001/arch/arm/mach-shmobile/board-g4evm.c
+++ work/arch/arm/mach-shmobile/board-g4evm.c	2010-12-28 14:45:16.000000000 +0900
@@ -394,6 +394,7 @@ static struct sys_timer g4evm_timer = {
 MACHINE_START(G4EVM, "g4evm")
 	.map_io		= g4evm_map_io,
 	.init_irq	= sh7377_init_irq,
+	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= g4evm_init,
 	.timer		= &g4evm_timer,
 MACHINE_END
--- 0001/arch/arm/mach-shmobile/board-mackerel.c
+++ work/arch/arm/mach-shmobile/board-mackerel.c	2010-12-28 14:45:16.000000000 +0900
@@ -590,6 +590,7 @@ static struct sys_timer mackerel_timer  MACHINE_START(MACKEREL, "mackerel")
 	.map_io		= mackerel_map_io,
 	.init_irq	= sh7372_init_irq,
+	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= mackerel_init,
 	.timer		= &mackerel_timer,
 MACHINE_END
--- /dev/null
+++ work/arch/arm/mach-shmobile/entry-intc.S	2010-12-28 14:48:52.000000000 +0900
@@ -0,0 +1,57 @@
+/*
+ * ARM Interrupt demux handler using INTC
+ *
+ * Copyright (C) 2010 Magnus Damm
+ * Copyright (C) 2008 Renesas Solutions Corp.
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <asm/entry-macro-multi.S>
+
+#define INTCA_BASE	0xe6980000
+#define INTFLGA_OFFS	0x00000018 /* accept pending interrupt */
+#define INTEVTA_OFFS	0x00000020 /* vector number of accepted interrupt */
+#define INTLVLA_OFFS	0x00000030 /* priority level of accepted interrupt */
+#define INTLVLB_OFFS	0x00000034 /* previous priority level */
+
+	.macro  get_irqnr_preamble, base, tmp
+	ldr     \base, =INTCA_BASE
+	.endm
+
+	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
+	/* The single INTFLGA read access below results in the following:
+	 *
+	 * 1. INTLVLB is updated with old priority value from INTLVLA
+	 * 2. Highest priority interrupt is accepted
+	 * 3. INTLVLA is updated to contain priority of accepted interrupt
+	 * 4. Accepted interrupt vector is stored in INTFLGA and INTEVTA
+	 */
+	ldr     \irqnr, [\base, #INTFLGA_OFFS]
+
+	/* Restore INTLVLA with the value saved in INTLVLB.
+	 * This is required to support interrupt priorities properly.
+	 */
+	ldrb	\tmp, [\base, #INTLVLB_OFFS]
+	strb    \tmp, [\base, #INTLVLA_OFFS]
+
+	/* Handle invalid vector number case */
+	cmp	\irqnr, #0
+	beq	1000f
+
+	/* Convert vector to irq number, same as the evt2irq() macro */
+	lsr	\irqnr, \irqnr, #0x5
+	subs	\irqnr, \irqnr, #16
+
+1000:
+	.endm
+
+	.macro  test_for_ipi, irqnr, irqstat, base, tmp
+	.endm
+
+	.macro  test_for_ltirq, irqnr, irqstat, base, tmp
+	.endm
+
+	arch_irq_handler shmobile_handle_irq_intc
--- 0001/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2010-12-28 14:45:16.000000000 +0900
@@ -5,6 +5,7 @@ extern struct sys_timer shmobile_timer;
 extern void shmobile_setup_console(void);
 struct clk;
 extern int clk_init(void);
+extern void shmobile_handle_irq_intc(struct pt_regs *);
 
 extern void sh7367_init_irq(void);
 extern void sh7367_add_early_devices(void);
