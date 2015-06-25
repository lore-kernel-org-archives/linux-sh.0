From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 25 Jun 2015 08:58:02 +0000
Subject: [PATCH v2 04/06] ARM: shmobile: marzen-reference: Remove C board code
Message-Id: <20150625085802.24543.27224.sendpatchset@little-apple>
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

 Changes since V1:
 - none

 arch/arm/mach-shmobile/Kconfig                  |    7 --
 arch/arm/mach-shmobile/Makefile                 |    4 -
 arch/arm/mach-shmobile/board-marzen-reference.c |   56 -----------------------
 3 files changed, 1 insertion(+), 66 deletions(-)

--- 0001/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2015-06-25 17:31:39.152366518 +0900
@@ -96,13 +96,6 @@ config ARCH_SH73A0
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
+++ work/arch/arm/mach-shmobile/Makefile	2015-06-25 17:31:39.152366518 +0900
@@ -51,9 +51,7 @@ obj-$(CONFIG_PM_RMOBILE)	+= pm-rmobile.o
 obj-$(CONFIG_ARCH_RCAR_GEN2)	+= pm-rcar-gen2.o
 
 # Board objects
-ifdef CONFIG_ARCH_SHMOBILE_MULTI
-obj-$(CONFIG_MACH_MARZEN)	+= board-marzen-reference.o
-else
+ifndef CONFIG_ARCH_SHMOBILE_MULTI
 obj-$(CONFIG_MACH_BOCKW)	+= board-bockw.o
 obj-$(CONFIG_MACH_BOCKW_REFERENCE)	+= board-bockw-reference.o
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen.o
--- 0001/arch/arm/mach-shmobile/board-marzen-reference.c
+++ /dev/null	2015-01-13 15:44:39.280208949 +0900
@@ -1,56 +0,0 @@
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
-static void __init marzen_init(void)
-{
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-	r8a7779_init_irq_extpin_dt(1); /* IRQ1 as individual interrupt */
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
-	.init_machine	= marzen_init,
-	.init_late	= shmobile_init_late,
-	.dt_compat	= marzen_boards_compat_dt,
-MACHINE_END
