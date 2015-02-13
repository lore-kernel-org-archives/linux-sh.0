From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Fri, 13 Feb 2015 01:40:21 +0000
Subject: [PATCH 1/2 v2] ARM: shmobile: Add function to get SoCs revision data for R-Car Gen2
Message-Id: <1423791622-30610-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SoCs of R-Car Gen2 have some revision. This adds function to get SoCs revision
data, and change so that user can confirm from /proc/cpuinfo.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 V2: - Dont remove lower 4bit.
     - Change function name from rcar_gen2_get_revision to rcar_gen2_get_cut.

 arch/arm/mach-shmobile/rcar-gen2.h       |  1 +
 arch/arm/mach-shmobile/setup-r8a7790.c   |  1 +
 arch/arm/mach-shmobile/setup-r8a7791.c   |  1 +
 arch/arm/mach-shmobile/setup-r8a7794.c   |  1 +
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 21 +++++++++++++++++++++
 5 files changed, 25 insertions(+)

diff --git a/arch/arm/mach-shmobile/rcar-gen2.h b/arch/arm/mach-shmobile/rcar-gen2.h
index ce53cb5..b232956 100644
--- a/arch/arm/mach-shmobile/rcar-gen2.h
+++ b/arch/arm/mach-shmobile/rcar-gen2.h
@@ -5,5 +5,6 @@ void rcar_gen2_timer_init(void);
 #define MD(nr) BIT(nr)
 u32 rcar_gen2_read_mode_pins(void);
 void rcar_gen2_reserve(void);
+void __init rcar_gen2_init_machine(void);
 
 #endif /* __ASM_RCAR_GEN2_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index ec7d97d..58e9b0f 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -311,6 +311,7 @@ static const char * const r8a7790_boards_compat_dt[] __initconst = {
 DT_MACHINE_START(R8A7790_DT, "Generic R8A7790 (Flattened Device Tree)")
 	.smp		= smp_ops(r8a7790_smp_ops),
 	.init_early	= shmobile_init_delay,
+	.init_machine	= rcar_gen2_init_machine,
 	.init_time	= rcar_gen2_timer_init,
 	.init_late	= shmobile_init_late,
 	.reserve	= rcar_gen2_reserve,
diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index ef8eb3a..c528b0f 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -33,6 +33,7 @@ DT_MACHINE_START(R8A7791_DT, "Generic R8A7791 (Flattened Device Tree)")
 	.init_early	= shmobile_init_delay,
 	.init_time	= rcar_gen2_timer_init,
 	.init_late	= shmobile_init_late,
+	.init_machine   = rcar_gen2_init_machine,
 	.reserve	= rcar_gen2_reserve,
 	.dt_compat	= r8a7791_boards_compat_dt,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/setup-r8a7794.c b/arch/arm/mach-shmobile/setup-r8a7794.c
index d2b0930..eb86656 100644
--- a/arch/arm/mach-shmobile/setup-r8a7794.c
+++ b/arch/arm/mach-shmobile/setup-r8a7794.c
@@ -27,6 +27,7 @@ static const char * const r8a7794_boards_compat_dt[] __initconst = {
 DT_MACHINE_START(R8A7794_DT, "Generic R8A7794 (Flattened Device Tree)")
 	.init_early	= shmobile_init_delay,
 	.init_late	= shmobile_init_late,
+	.init_machine	= rcar_gen2_init_machine,
 	.init_time	= rcar_gen2_timer_init,
 	.reserve	= rcar_gen2_reserve,
 	.dt_compat	= r8a7794_boards_compat_dt,
diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 3dd6edd..4cc8492 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2013  Renesas Solutions Corp.
  * Copyright (C) 2013  Magnus Damm
  * Copyright (C) 2014  Ulrich Hecht
+ * Copyright (C) 2015  Nobuhiro Iwamatsu
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -23,6 +24,8 @@
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
+#include <linux/of_platform.h>
+#include <asm/system_info.h>
 #include <asm/mach/arch.h>
 #include "common.h"
 #include "rcar-gen2.h"
@@ -204,3 +207,21 @@ void __init rcar_gen2_reserve(void)
 					    &rcar_gen2_dma_contiguous, true);
 #endif
 }
+
+#define PRR 0xFF000044
+static unsigned int __init rcar_gen2_get_cut(void)
+{
+	void __iomem *addr = ioremap_nocache(PRR, 4);
+	u32 data = ioread32(addr);
+
+	iounmap(addr);
+
+	return (data & 0xFF) + 0x10;
+}
+
+void __init rcar_gen2_init_machine(void)
+{
+	system_rev = rcar_gen2_get_cut();
+
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
-- 
2.1.3

