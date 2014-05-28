From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 28 May 2014 23:46:19 +0000
Subject: [PATCH] ARM: shmobile: CMA prototype test code for Koelsch
Message-Id: <20140528234619.28433.40375.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

This is some basic prototype code that uses CMA to reserve a 256 MiB
physically contiguous memory window at 0x7000000 on the Koelsch board.

Through some hackish test code it then allocates several 16MiB chunks
with 16MiB alignment from the CMA window.

The following kernel configuration parameters are required:
CONFIG_CMA=y
CONFIG_DMA_CMA=y

A couple of notes about known short comings:
 - The default CMA area is overriden - a new CMA area should be added instead
 - NULL is passed as struct device * - the driver model should be used
 - The test is allocating 15 times to keep some space in the default CMA area

For information about the DMA API and the DMA attributes, please see:
Documentation/DMA-API-HOWTO.txt
Documentation/DMA-API.txt 
Documentation/DMA-attributes.txt

Not for upstream merge. Written to show how CMA can be used to reserve
and allocate memory.

Not-Yet-Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/Makefile                  |    2 
 arch/arm/mach-shmobile/board-koelsch-reference.c |   11 ++++
 arch/arm/mach-shmobile/cma-test.c                |   58 ++++++++++++++++++++++
 3 files changed, 70 insertions(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2014-05-29 08:04:33.000000000 +0900
@@ -5,7 +5,7 @@
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/mach-shmobile/include
 
 # Common objects
-obj-y				:= timer.o console.o
+obj-y				:= timer.o console.o cma-test.o
 
 # CPU objects
 obj-$(CONFIG_ARCH_SH7372)	+= setup-sh7372.o intc-sh7372.o
--- 0001/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ work/arch/arm/mach-shmobile/board-koelsch-reference.c	2014-05-29 07:41:35.000000000 +0900
@@ -23,6 +23,7 @@
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 #include <linux/platform_data/rcar-du.h>
+#include <linux/dma-contiguous.h>
 #include <mach/clock.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
@@ -101,6 +102,15 @@ static void __init koelsch_add_standard_
 	koelsch_add_du_device();
 }
 
+static void __init koelsch_reserve(void)
+{
+#ifdef CONFIG_DMA_CMA
+	/* override default CMA area */
+	dma_contiguous_reserve_area(0x10000000, 0x70000000, 0xffffffff,
+				    &dma_contiguous_default_area);
+#endif
+}
+
 static const char * const koelsch_boards_compat_dt[] __initconst = {
 	"renesas,koelsch",
 	"renesas,koelsch-reference",
@@ -110,6 +120,7 @@ static const char * const koelsch_boards
 DT_MACHINE_START(KOELSCH_DT, "koelsch")
 	.smp		= smp_ops(r8a7791_smp_ops),
 	.init_early	= shmobile_init_delay,
+	.reserve        = koelsch_reserve,
 	.init_time	= rcar_gen2_timer_init,
 	.init_machine	= koelsch_add_standard_devices,
 	.init_late	= shmobile_init_late,
--- /dev/null
+++ work/arch/arm/mach-shmobile/cma-test.c	2014-05-29 08:32:39.000000000 +0900
@@ -0,0 +1,58 @@
+#include <linux/init.h>
+#include <linux/dma-mapping.h>
+#include <linux/dma-contiguous.h>
+#include <linux/platform_device.h>
+#include <linux/iommu.h>
+
+static int do_alloc(struct device *dev, unsigned int size, unsigned int align,
+		    phys_addr_t *paddr)
+{
+	/* use CMA directly if one of the following is true
+	 * - explicit alignment is required
+	 * - no IOMMU is available (dma-mapping.c for ARM ignores attrs)
+	 */
+	if (!iommu_present(&platform_bus_type) || (align != size)) {
+		struct page *p;
+		
+		p = dma_alloc_from_contiguous(dev, size, align);
+		if (!p)
+			return -ENOMEM;
+
+		*paddr = page_to_phys(p);
+	} else {
+		DEFINE_DMA_ATTRS(attrs);
+		void *p;
+
+		/* a few lines derived from drivers/gpu/drm/msm/msm_drv.c */
+		dma_set_attr(DMA_ATTR_NO_KERNEL_MAPPING, &attrs);
+		dma_set_attr(DMA_ATTR_FORCE_CONTIGUOUS, &attrs);
+
+		/* note that for no-kernel-mapping, the vaddr returned
+		 * is bogus, but non-null if allocation succeeded:
+		 */
+		p = dma_alloc_attrs(dev, size, paddr, 0, &attrs);
+		if (!p)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int __init test_cma(void)
+{
+       unsigned int align_order = SZ_16M >> PAGE_SHIFT;
+       unsigned int size_pages = SZ_16M >> PAGE_SHIFT;
+       unsigned int k;
+       unsigned int success = 0;
+       phys_addr_t p;
+
+       for (k = 0; k < ((256 / 16) - 1); k++)
+		if (do_alloc(NULL, size_pages, align_order, &p) = 0)
+			success++;
+
+       pr_info("CMA test succeeded %d times\n", success);
+       
+       return 0;
+}
+
+late_initcall(test_cma)
