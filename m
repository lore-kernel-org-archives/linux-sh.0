From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Oct 2014 07:46:56 +0000
Subject: [PATCH 01/03] ARM: shmobile: lager-reference: DTS-only board support
Message-Id: <20141029074656.405.76219.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Remove redundant C board code for Lager Multiplatform,
everything is supported via DT these days anyway so it
is fine to rely on the MACHINE_START in setup-r8a7790.c.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig                 |    5 ---
 arch/arm/mach-shmobile/Makefile                |    1 
 arch/arm/mach-shmobile/board-lager-reference.c |   39 ------------------------
 3 files changed, 45 deletions(-)

--- 0001/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2014-10-29 16:09:12.000000000 +0900
@@ -73,11 +73,6 @@ config ARCH_R8A7794
 
 comment "Renesas ARM SoCs Board Type"
 
-config MACH_LAGER
-	bool "Lager board"
-	depends on ARCH_R8A7790
-	select MICREL_PHY if SH_ETH
-
 config MACH_MARZEN
 	bool "MARZEN board"
 	depends on ARCH_R8A7779
--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2014-10-29 16:09:22.000000000 +0900
@@ -56,7 +56,6 @@ obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.
 
 # Board objects
 ifdef CONFIG_ARCH_SHMOBILE_MULTI
-obj-$(CONFIG_MACH_LAGER)	+= board-lager-reference.o
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen-reference.o
 else
 obj-$(CONFIG_MACH_APE6EVM)	+= board-ape6evm.o
--- 0001/arch/arm/mach-shmobile/board-lager-reference.c
+++ /dev/null	2013-06-03 21:41:10.638032047 +0900
@@ -1,39 +0,0 @@
-/*
- * Lager board support - Reference DT implementation
- *
- * Copyright (C) 2013  Renesas Solutions Corp.
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
-#include <linux/init.h>
-#include <linux/of_platform.h>
-
-#include <asm/mach/arch.h>
-
-#include "common.h"
-#include "r8a7790.h"
-#include "rcar-gen2.h"
-
-static const char *lager_boards_compat_dt[] __initdata = {
-	"renesas,lager",
-	"renesas,lager-reference",
-	NULL,
-};
-
-DT_MACHINE_START(LAGER_DT, "lager")
-	.smp		= smp_ops(r8a7790_smp_ops),
-	.init_early	= shmobile_init_delay,
-	.init_time	= rcar_gen2_timer_init,
-	.init_late	= shmobile_init_late,
-	.reserve	= rcar_gen2_reserve,
-	.dt_compat	= lager_boards_compat_dt,
-MACHINE_END
