From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 15 Jan 2015 06:24:46 +0000
Subject: [PATCH] ARM: shmobile: No R-Car Gen2 CMA reservation when HIGHMEM=n
Message-Id: <20150115062446.452.7702.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Allow R-Car Gen2 platforms to boot with CMA enabled
and HIGHMEM disabled. This patch adds code to check
if the R-Car Gen2 specific memory reservation window
is included in the kernel memory range or not. When
HIGHMEM is disabled the R-Car Gen2 reservation area is
outside the kernel memory range and in such case the
memory reservation is simply skipped over.

Without this patch the kernel boot hangs when CMA is
enabled and HIGHMEM is disabled on the r8a7791 Koelsch
hardware platform.

In the current shmobile_defconfig HIGHMEM is enabled
while CMA is disabled, so to trigger this the kernel
configuration for both CMA and HIGHMEM needs to be
adjusted.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written on top of renesas-devel-20150114v2-v3.19-rc4

 arch/arm/mach-shmobile/setup-rcar-gen2.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ work/arch/arm/mach-shmobile/setup-rcar-gen2.c	2015-01-15 14:20:47.089397114 +0900
@@ -21,6 +21,7 @@
 #include <linux/dma-contiguous.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/memblock.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <asm/mach/arch.h>
@@ -197,7 +198,7 @@ void __init rcar_gen2_reserve(void)
 
 	of_scan_flat_dt(rcar_gen2_scan_mem, &mrc);
 #ifdef CONFIG_DMA_CMA
-	if (mrc.size)
+	if (mrc.size && memblock_is_region_memory(mrc.base, mrc.size))
 		dma_contiguous_reserve_area(mrc.size, mrc.base, 0,
 					    &rcar_gen2_dma_contiguous, true);
 #endif
