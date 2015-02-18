From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 18 Feb 2015 02:38:53 +0000
Subject: [PATCH 04/05] ARM: shmobile: marzen-reference: Remove C board code
Message-Id: <20150218023853.12588.57588.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

The generic r8a7779 machine vector is now feature-wise equivalent
to the Marzen-reference case, so simply remove the Marzen C board
code to fall over on the generic r8a7779 machine vector.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig                  |    7 ---
 arch/arm/mach-shmobile/Makefile                 |    2 
 arch/arm/mach-shmobile/board-marzen-reference.c |   49 -----------------------
 3 files changed, 58 deletions(-)

--- 0001/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2015-02-17 02:31:26.496199165 +0900
@@ -84,13 +84,6 @@ config ARCH_SH73A0
 	select ARCH_RMOBILE
 	select RENESAS_INTC_IRQPIN
 
-comment "Renesas ARM SoCs Board Type"
-
-config MACH_MARZEN
-	bool "MARZEN board"
-	depends on ARCH_R8A7779
-	select REGULATOR_FIXED_VOLTAGE if REGULATOR
-
 comment "Renesas ARM SoCs System Configuration"
 endif
 
--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2015-02-17 02:29:29.276199586 +0900
@@ -51,8 +51,6 @@ obj-$(CONFIG_PM_RMOBILE)	+= pm-rmobile.o
 
 # Board objects
 ifdef CONFIG_ARCH_SHMOBILE_MULTI
-obj-$(CONFIG_MACH_MARZEN)	+= board-marzen-reference.o
-else
 obj-$(CONFIG_MACH_APE6EVM)	+= board-ape6evm.o
 obj-$(CONFIG_MACH_APE6EVM_REFERENCE)	+= board-ape6evm-reference.o
 obj-$(CONFIG_MACH_BOCKW)	+= board-bockw.o
--- 0002/arch/arm/mach-shmobile/board-marzen-reference.c
+++ /dev/null	2015-01-13 15:44:39.280208949 +0900
@@ -1,49 +0,0 @@
-/*
- * marzen board support - Reference DT implementation
- *
- * Copyright (C) 2011  Renesas Solutions Corp.
- * Copyright (C) 2011  Magnus Damm
- * Copyright (C) 2013  Simon Horman
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/clk/shmobile.h>
-#include <linux/clocksource.h>
-#include <linux/of_platform.h>
-
-#include <asm/irq.h>
-#include <asm/mach/arch.h>
-
-#include "common.h"
-#include "irqs.h"
-#include "r8a7779.h"
-
-static void __init marzen_init_timer(void)
-{
-	r8a7779_clocks_init(r8a7779_read_mode_pins());
-	clocksource_of_init();
-}
-
-static const char *marzen_boards_compat_dt[] __initdata = {
-	"renesas,marzen",
-	"renesas,marzen-reference",
-	NULL,
-};
-
-DT_MACHINE_START(MARZEN, "marzen")
-	.smp		= smp_ops(r8a7779_smp_ops),
-	.map_io		= r8a7779_map_io,
-	.init_early	= shmobile_init_delay,
-	.init_time	= marzen_init_timer,
-	.init_irq	= r8a7779_init_irq_dt,
-	.init_late	= shmobile_init_late,
-	.dt_compat	= marzen_boards_compat_dt,
-MACHINE_END
