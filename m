From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 02 Dec 2014 08:37:17 +0000
Subject: [PATCH 3/5] ARM: shmobile: ape6evm reference: Remove C board code
Message-Id: <1417509439-31739-4-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Now that the r8a73a4 generic multiplatform case has the same features as the
APE6EVM DT reference board code, we get rid of the latter.  DT reference
code in the future shall make use of the r8a73a4 multiplatform support code
with the generic SoC machine vector.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/mach-shmobile/Kconfig                   | 12 -----
 arch/arm/mach-shmobile/Makefile                  |  1 -
 arch/arm/mach-shmobile/Makefile.boot             |  1 -
 arch/arm/mach-shmobile/board-ape6evm-reference.c | 61 ------------------------
 4 files changed, 75 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/board-ape6evm-reference.c

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index d107b93..1d56a8f 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -154,18 +154,6 @@ config MACH_APE6EVM
 	select SMSC_PHY if SMSC911X
 	select USE_OF
 
-config MACH_APE6EVM_REFERENCE
-	bool "APE6EVM board - Reference Device Tree Implementation"
-	depends on ARCH_R8A73A4
-	select SMSC_PHY if SMSC911X
-	select USE_OF
-	---help---
-	   Use reference implementation of APE6EVM board support
-	   which makes a greater use of device tree at the expense
-	   of not supporting a number of devices.
-
-	   This is intended to aid developers
-
 config MACH_MACKEREL
 	bool "mackerel board"
 	depends on ARCH_SH7372
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index b55cac0..7f045a3 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -61,7 +61,6 @@ obj-$(CONFIG_MACH_LAGER)	+= board-lager-reference.o
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen-reference.o
 else
 obj-$(CONFIG_MACH_APE6EVM)	+= board-ape6evm.o
-obj-$(CONFIG_MACH_APE6EVM_REFERENCE)	+= board-ape6evm-reference.o
 obj-$(CONFIG_MACH_MACKEREL)	+= board-mackerel.o
 obj-$(CONFIG_MACH_BOCKW)	+= board-bockw.o
 obj-$(CONFIG_MACH_BOCKW_REFERENCE)	+= board-bockw-reference.o
diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
index 57d00ed..60efb23 100644
--- a/arch/arm/mach-shmobile/Makefile.boot
+++ b/arch/arm/mach-shmobile/Makefile.boot
@@ -1,7 +1,6 @@
 # per-board load address for uImage
 loadaddr-y	: loadaddr-$(CONFIG_MACH_APE6EVM) += 0x40008000
-loadaddr-$(CONFIG_MACH_APE6EVM_REFERENCE) += 0x40008000
 loadaddr-$(CONFIG_MACH_ARMADILLO800EVA) += 0x40008000
 loadaddr-$(CONFIG_MACH_BOCKW) += 0x60008000
 loadaddr-$(CONFIG_MACH_BOCKW_REFERENCE) += 0x60008000
diff --git a/arch/arm/mach-shmobile/board-ape6evm-reference.c b/arch/arm/mach-shmobile/board-ape6evm-reference.c
deleted file mode 100644
index dd5bc63..0000000
--- a/arch/arm/mach-shmobile/board-ape6evm-reference.c
+++ /dev/null
@@ -1,61 +0,0 @@
-/*
- * APE6EVM board support
- *
- * Copyright (C) 2013  Renesas Solutions Corp.
- * Copyright (C) 2013  Magnus Damm
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
-#include <linux/gpio.h>
-#include <linux/kernel.h>
-#include <linux/of_platform.h>
-#include <linux/pinctrl/machine.h>
-#include <linux/platform_device.h>
-#include <linux/sh_clk.h>
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-
-#include "common.h"
-#include "r8a73a4.h"
-
-static void __init ape6evm_add_standard_devices(void)
-{
-#ifndef CONFIG_COMMON_CLK
-	struct clk *parent;
-	struct clk *mp;
-
-	r8a73a4_clock_init();
-
-	/* MP clock parent = extal2 */
-	parent      = clk_get(NULL, "extal2");
-	mp          = clk_get(NULL, "mp");
-	BUG_ON(IS_ERR(parent) || IS_ERR(mp));
-
-	clk_set_parent(mp, parent);
-	clk_put(parent);
-	clk_put(mp);
-#endif
-
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
-
-static const char *ape6evm_boards_compat_dt[] __initdata = {
-	"renesas,ape6evm-reference",
-	NULL,
-};
-
-DT_MACHINE_START(APE6EVM_DT, "ape6evm")
-	.init_early	= shmobile_init_delay,
-	.init_machine	= ape6evm_add_standard_devices,
-	.init_late	= shmobile_init_late,
-	.dt_compat	= ape6evm_boards_compat_dt,
-MACHINE_END
-- 
1.8.4.5

