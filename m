From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 28 Dec 2010 08:27:10 +0000
Subject: [PATCH 03/04] ARM: mach-shmobile: Run-time IRQ handler for GIC
Message-Id: <20101228082710.11806.65512.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Break-out GIC specific IRQ demux code from the file
entry-macro-intc.S and register during run-time.

Covers sh73a0.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile              |    1 +
 arch/arm/mach-shmobile/board-ag5evm.c        |    1 +
 arch/arm/mach-shmobile/entry-gic.S           |   20 ++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 4 files changed, 23 insertions(+)

--- 0007/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2010-12-28 14:53:22.000000000 +0900
@@ -22,6 +22,7 @@ pfc-$(CONFIG_ARCH_SH73A0)	+= pfc-sh73a0.
 obj-$(CONFIG_ARCH_SH7367)	+= entry-intc.o
 obj-$(CONFIG_ARCH_SH7377)	+= entry-intc.o
 obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.o
+obj-$(CONFIG_ARCH_SH73A0)	+= entry-gic.o
 
 # Board objects
 obj-$(CONFIG_MACH_G3EVM)	+= board-g3evm.o
--- 0001/arch/arm/mach-shmobile/board-ag5evm.c
+++ work/arch/arm/mach-shmobile/board-ag5evm.c	2010-12-28 14:52:15.000000000 +0900
@@ -309,6 +309,7 @@ struct sys_timer ag5evm_timer = {
 MACHINE_START(AG5EVM, "ag5evm")
 	.map_io		= ag5evm_map_io,
 	.init_irq	= ag5evm_init_irq,
+	.handle_irq	= shmobile_handle_irq_gic,
 	.init_machine	= ag5evm_init,
 	.timer		= &ag5evm_timer,
 MACHINE_END
--- /dev/null
+++ work/arch/arm/mach-shmobile/entry-gic.S	2010-12-28 14:51:24.000000000 +0900
@@ -0,0 +1,20 @@
+/*
+ * ARM Interrupt demux handler using GIC
+ *
+ * Copyright (C) 2010 Magnus Damm
+ * Copyright (C) 2010 Renesas Solutions Corp.
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <asm/entry-macro-multi.S>
+#include <asm/hardware/gic.h>
+#include <asm/hardware/entry-macro-gic.S>
+
+	.macro	get_irqnr_preamble, base, tmp
+	ldr	\base, =(0xf0000100)
+	.endm
+
+	arch_irq_handler shmobile_handle_irq_gic
--- 0007/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2010-12-28 14:51:36.000000000 +0900
@@ -6,6 +6,7 @@ extern void shmobile_setup_console(void)
 struct clk;
 extern int clk_init(void);
 extern void shmobile_handle_irq_intc(struct pt_regs *);
+extern void shmobile_handle_irq_gic(struct pt_regs *);
 
 extern void sh7367_init_irq(void);
 extern void sh7367_add_early_devices(void);
