From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 09 Jun 2014 12:38:45 +0000
Subject: [PATCH 01/02] ARM: shmobile: Add shared R-Car Gen2 CMA reservation code
Message-Id: <20140609123845.31532.36468.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20140306032824.10814.21953.sendpatchset@w520>
In-Reply-To: <20140306032824.10814.21953.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Add R-Car Gen2 CMA memory reservation code that can be
shared between multiple SoCs and boards. At this point
r8a7790 and r8a7791 are supported.

The top 256MiB of the legacy 32-bit physical memory space
is assigned to a separate CMA area that may be assigned
to various devices later on.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/rcar-gen2.h |    1 
 arch/arm/mach-shmobile/setup-r8a7790.c          |    1 
 arch/arm/mach-shmobile/setup-r8a7791.c          |    1 
 arch/arm/mach-shmobile/setup-rcar-gen2.c        |   79 +++++++++++++++++++++++
 4 files changed, 82 insertions(+)

--- 0001/arch/arm/mach-shmobile/include/mach/rcar-gen2.h
+++ work/arch/arm/mach-shmobile/include/mach/rcar-gen2.h	2014-06-09 20:51:34.000000000 +0900
@@ -4,5 +4,6 @@
 void rcar_gen2_timer_init(void);
 #define MD(nr) BIT(nr)
 u32 rcar_gen2_read_mode_pins(void);
+void rcar_gen2_reserve(void);
 
 #endif /* __ASM_RCAR_GEN2_H__ */
--- 0001/arch/arm/mach-shmobile/setup-r8a7790.c
+++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2014-06-09 21:02:30.000000000 +0900
@@ -319,6 +319,7 @@ DT_MACHINE_START(R8A7790_DT, "Generic R8
 	.init_early	= shmobile_init_delay,
 	.init_time	= rcar_gen2_timer_init,
 	.init_late	= shmobile_init_late,
+	.reserve	= rcar_gen2_reserve,
 	.dt_compat	= r8a7790_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
--- 0001/arch/arm/mach-shmobile/setup-r8a7791.c
+++ work/arch/arm/mach-shmobile/setup-r8a7791.c	2014-06-09 21:02:37.000000000 +0900
@@ -218,6 +218,7 @@ DT_MACHINE_START(R8A7791_DT, "Generic R8
 	.init_early	= shmobile_init_delay,
 	.init_time	= rcar_gen2_timer_init,
 	.init_late	= shmobile_init_late,
+	.reserve	= rcar_gen2_reserve,
 	.dt_compat	= r8a7791_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
--- 0001/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ work/arch/arm/mach-shmobile/setup-rcar-gen2.c	2014-06-09 21:01:33.000000000 +0900
@@ -20,8 +20,11 @@
 
 #include <linux/clk/shmobile.h>
 #include <linux/clocksource.h>
+#include <linux/device.h>
+#include <linux/dma-contiguous.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/of_fdt.h>
 #include <mach/common.h>
 #include <mach/rcar-gen2.h>
 #include <asm/mach/arch.h>
@@ -110,3 +113,79 @@ void __init rcar_gen2_timer_init(void)
 #endif
 	clocksource_of_init();
 }
+
+struct memory_reserve_config {
+	u64 reserved;
+	u64 base, size;
+};
+
+static int __init rcar_gen2_scan_mem(unsigned long node, const char *uname,
+				     int depth, void *data)
+{
+	char *type = of_get_flat_dt_prop(node, "device_type", NULL);
+	__be32 *reg, *endp;
+	unsigned long l;
+	struct memory_reserve_config *mrc = data;
+	u64 lpae_start = (u64)1 << 32;
+
+	/* We are scanning "memory" nodes only */
+	if (type = NULL) {
+		/*
+		 * The longtrail doesn't have a device_type on the
+		 * /memory node, so look for the node called /memory@0.
+		 */
+		if (depth != 1 || strcmp(uname, "memory@0") != 0)
+			return 0;
+	} else if (strcmp(type, "memory") != 0)
+		return 0;
+
+	reg = of_get_flat_dt_prop(node, "linux,usable-memory", &l);
+	if (reg = NULL)
+		reg = of_get_flat_dt_prop(node, "reg", &l);
+	if (reg = NULL)
+		return 0;
+
+	endp = reg + (l / sizeof(__be32));
+	while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
+		u64 base, size;
+
+		base = dt_mem_next_cell(dt_root_addr_cells, &reg);
+		size = dt_mem_next_cell(dt_root_size_cells, &reg);
+
+		if (base >= lpae_start)
+			continue;
+
+		if ((base + size) >= lpae_start)
+			size = lpae_start - base;
+
+		if (size < mrc->reserved)
+			continue;
+
+		if (base < mrc->base)
+			continue;
+
+		/* keep the area at top near the 32-bit legacy limit */
+		mrc->base = base + size - mrc->reserved;
+		mrc->size = mrc->reserved;
+	}
+
+	return 0;
+}
+
+struct cma *rcar_gen2_dma_contiguous;
+
+void __init rcar_gen2_reserve(void)
+{
+	struct memory_reserve_config mrc;
+
+	/* reserve 256 MiB at the top of the physical legacy 32-bit space */
+	memset(&mrc, 0, sizeof(mrc));
+	mrc.reserved = SZ_256M;
+
+	of_scan_flat_dt(rcar_gen2_scan_mem, &mrc);
+#ifdef CONFIG_DMA_CMA
+	if (mrc.size)
+		dma_contiguous_reserve_area(mrc.size, mrc.base, 0,
+					    &rcar_gen2_dma_contiguous);
+#endif
+}
