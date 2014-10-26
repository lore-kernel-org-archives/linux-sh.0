From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 26 Oct 2014 14:11:19 +0000
Subject: [PATCH v5 14/14] ARM: shmobile: koelsch: Remove reference board code
Message-Id: <1414332679-15497-15-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The Koelsch board is supported by the r8a7791 generic DT platform
definition. Remove the board-specific definition along with its board
file.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/configs/shmobile_defconfig              |  1 -
 arch/arm/mach-shmobile/Kconfig                   |  5 ---
 arch/arm/mach-shmobile/Makefile                  |  1 -
 arch/arm/mach-shmobile/Makefile.boot             |  1 -
 arch/arm/mach-shmobile/board-koelsch-reference.c | 44 ------------------------
 5 files changed, 52 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/board-koelsch-reference.c

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index d7346ad51043..c8201a93b54d 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -17,7 +17,6 @@ CONFIG_ARCH_R8A7779=y
 CONFIG_ARCH_R8A7790=y
 CONFIG_ARCH_R8A7791=y
 CONFIG_ARCH_R8A7794=y
-CONFIG_MACH_KOELSCH=y
 CONFIG_MACH_LAGER=y
 CONFIG_MACH_MARZEN=y
 # CONFIG_SWP_EMULATE is not set
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 46c71c2dc2a0..7cb0a484da53 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -73,11 +73,6 @@ config ARCH_R8A7794
 
 comment "Renesas ARM SoCs Board Type"
 
-config MACH_KOELSCH
-	bool "Koelsch board"
-	depends on ARCH_R8A7791
-	select MICREL_PHY if SH_ETH
-
 config MACH_LAGER
 	bool "Lager board"
 	depends on ARCH_R8A7790
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index fbb7f85a4e7c..7d68eba53be3 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -56,7 +56,6 @@ obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.o sleep-sh7372.o
 
 # Board objects
 ifdef CONFIG_ARCH_SHMOBILE_MULTI
-obj-$(CONFIG_MACH_KOELSCH)	+= board-koelsch-reference.o
 obj-$(CONFIG_MACH_LAGER)	+= board-lager-reference.o
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen-reference.o
 else
diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
index de9a23852fc8..57d00ed6ec0c 100644
--- a/arch/arm/mach-shmobile/Makefile.boot
+++ b/arch/arm/mach-shmobile/Makefile.boot
@@ -5,7 +5,6 @@ loadaddr-$(CONFIG_MACH_APE6EVM_REFERENCE) += 0x40008000
 loadaddr-$(CONFIG_MACH_ARMADILLO800EVA) += 0x40008000
 loadaddr-$(CONFIG_MACH_BOCKW) += 0x60008000
 loadaddr-$(CONFIG_MACH_BOCKW_REFERENCE) += 0x60008000
-loadaddr-$(CONFIG_MACH_KOELSCH) += 0x40008000
 loadaddr-$(CONFIG_MACH_KZM9G) += 0x41008000
 loadaddr-$(CONFIG_MACH_KZM9G_REFERENCE) += 0x41008000
 loadaddr-$(CONFIG_MACH_LAGER) += 0x40008000
diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
deleted file mode 100644
index c3708180e69e..000000000000
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- * Koelsch board support - Reference DT implementation
- *
- * Copyright (C) 2013  Renesas Electronics Corporation
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
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <linux/kernel.h>
-#include <linux/of_platform.h>
-
-#include <asm/mach/arch.h>
-
-#include "common.h"
-#include "r8a7791.h"
-#include "rcar-gen2.h"
-
-static const char * const koelsch_boards_compat_dt[] __initconst = {
-	"renesas,koelsch",
-	"renesas,koelsch-reference",
-	NULL,
-};
-
-DT_MACHINE_START(KOELSCH_DT, "koelsch")
-	.smp		= smp_ops(r8a7791_smp_ops),
-	.init_early	= shmobile_init_delay,
-	.init_time	= rcar_gen2_timer_init,
-	.init_late	= shmobile_init_late,
-	.reserve	= rcar_gen2_reserve,
-	.dt_compat	= koelsch_boards_compat_dt,
-MACHINE_END
-- 
2.0.4

