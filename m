From: Christoph Hellwig <hch@lst.de>
Date: Wed, 14 Aug 2019 13:46:15 +0000
Subject: [PATCH] sh: use the generic dma coherent remap allocator
Message-Id: <20190814134615.29442-2-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190814134615.29442-1-hch@lst.de>
In-Reply-To: <20190814134615.29442-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Jacopo Mondi <jacopo+renesas@jmondi.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>

This switches to using common code for the DMA allocations, including
potential use of the CMA allocator if configured.

Switching to the generic code enables DMA allocations from atomic
context, which is required by the DMA API documentation, and also
adds various other minor features drivers start relying upon.  It
also makes sure we have on tested code base for all architectures
that require uncached pte bits for coherent DMA allocations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/Kconfig               |  2 ++
 arch/sh/kernel/dma-coherent.c | 57 +++++------------------------------
 2 files changed, 10 insertions(+), 49 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 6b1b5941b618..21eefe7c4ba6 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -158,7 +158,9 @@ config DMA_COHERENT
 
 config DMA_NONCOHERENT
 	def_bool !DMA_COHERENT
+	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select DMA_DIRECT_REMAP
 
 config PGTABLE_LEVELS
 	default 3 if X2TLB
diff --git a/arch/sh/kernel/dma-coherent.c b/arch/sh/kernel/dma-coherent.c
index b17514619b7e..2f0e2f2d1f9c 100644
--- a/arch/sh/kernel/dma-coherent.c
+++ b/arch/sh/kernel/dma-coherent.c
@@ -3,60 +3,13 @@
  * Copyright (C) 2004 - 2007  Paul Mundt
  */
 #include <linux/mm.h>
-#include <linux/init.h>
 #include <linux/dma-noncoherent.h>
-#include <linux/module.h>
 #include <asm/cacheflush.h>
 #include <asm/addrspace.h>
 
-void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
-		gfp_t gfp, unsigned long attrs)
+void arch_dma_prep_coherent(struct page *page, size_t size)
 {
-	void *ret, *ret_nocache;
-	int order = get_order(size);
-
-	gfp |= __GFP_ZERO;
-
-	ret = (void *)__get_free_pages(gfp, order);
-	if (!ret)
-		return NULL;
-
-	/*
-	 * Pages from the page allocator may have data present in
-	 * cache. So flush the cache before using uncached memory.
-	 */
-	arch_sync_dma_for_device(dev, virt_to_phys(ret), size,
-			DMA_BIDIRECTIONAL);
-
-	ret_nocache = (void __force *)ioremap_nocache(virt_to_phys(ret), size);
-	if (!ret_nocache) {
-		free_pages((unsigned long)ret, order);
-		return NULL;
-	}
-
-	split_page(pfn_to_page(virt_to_phys(ret) >> PAGE_SHIFT), order);
-
-	*dma_handle = virt_to_phys(ret);
-	if (!WARN_ON(!dev))
-		*dma_handle -= PFN_PHYS(dev->dma_pfn_offset);
-
-	return ret_nocache;
-}
-
-void arch_dma_free(struct device *dev, size_t size, void *vaddr,
-		dma_addr_t dma_handle, unsigned long attrs)
-{
-	int order = get_order(size);
-	unsigned long pfn = (dma_handle >> PAGE_SHIFT);
-	int k;
-
-	if (!WARN_ON(!dev))
-		pfn += dev->dma_pfn_offset;
-
-	for (k = 0; k < (1 << order); k++)
-		__free_pages(pfn_to_page(pfn + k), 0);
-
-	iounmap(vaddr);
+	__flush_purge_region(page_address(page), size);
 }
 
 void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
@@ -78,3 +31,9 @@ void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
 		BUG();
 	}
 }
+
+static int __init atomic_pool_init(void)
+{
+	return dma_atomic_pool_init(GFP_KERNEL, pgprot_noncached(PAGE_KERNEL));
+}
+postcore_initcall(atomic_pool_init);
-- 
2.20.1
