From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Fri, 06 Feb 2015 01:33:08 +0000
Subject: [PATCH 1/2] ARM: shmobile: Add function to get SoCs revision data for R-Car Gen2
Message-Id: <1423186389-12861-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130107023101.GM2935@verge.net.au>
In-Reply-To: <20130107023101.GM2935@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SoCs of R-Car Gen2 have some revision. This adds function to get SoCs revision
data, and change so that user can confirm from /proc/cpuinfo.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
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
index 3a18af4..8d26ab0 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -30,6 +30,7 @@ static const char * const r8a7790_boards_compat_dt[] __initconst = {
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
index aa33392..2230948 100644
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
@@ -24,6 +25,8 @@
 #include <linux/memblock.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
+#include <linux/of_platform.h>
+#include <asm/system_info.h>
 #include <asm/mach/arch.h>
 #include "common.h"
 #include "rcar-gen2.h"
@@ -199,3 +202,21 @@ void __init rcar_gen2_reserve(void)
 					    &rcar_gen2_dma_contiguous, true);
 #endif
 }
+
+#define PRR 0xFF000044
+static unsigned int __init rcar_gen2_get_revision(void)
+{
+	void __iomem *addr = ioremap_nocache(PRR, 4);
+	u32 data = ioread32(addr);
+
+	iounmap(addr);
+
+	return ((data & 0xF0) >> 4) + 1;
+}
+
+void __init rcar_gen2_init_machine(void)
+{
+	system_rev = rcar_gen2_get_revision();
+
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
-- 
2.1.3

