From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 25 Jan 2008 03:42:48 +0000
Subject: [PATCH] sh: declared coherent memory support V2 fix
Message-Id: <20080125034248.16989.15110.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20080113135447.30289.54583.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080113135447.30289.54583.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh: declared coherent memory support V2 fix

This patch fixes the recently introduced declared coherent memory support.
Without this fix a cached memory area is returned by dma_alloc_coherent() -
unless dma_declare_coherent_memory() has setup a separate area.

This patch makes sure an uncached memory area is returned. With this patch
it is now possible to ping through an rtl8139 interface on r2d-plus.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/mm/consistent.c |   30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

--- 0002/arch/sh/mm/consistent.c
+++ work/arch/sh/mm/consistent.c	2008-01-25 11:21:12.000000000 +0900
@@ -26,7 +26,7 @@ struct dma_coherent_mem {
 void *dma_alloc_coherent(struct device *dev, size_t size,
 			   dma_addr_t *dma_handle, gfp_t gfp)
 {
-	void *ret;
+	void *ret, *ret_nocache;
 	struct dma_coherent_mem *mem = dev ? dev->dma_mem : NULL;
 	int order = get_order(size);
 
@@ -44,17 +44,24 @@ void *dma_alloc_coherent(struct device *
 	}
 
 	ret = (void *)__get_free_pages(gfp, order);
+	if (!ret)
+		return NULL;
 
-	if (ret != NULL) {
-		memset(ret, 0, size);
-		/*
-		 * Pages from the page allocator may have data present in
-		 * cache. So flush the cache before using uncached memory.
-		 */
-		dma_cache_sync(NULL, ret, size, DMA_BIDIRECTIONAL);
-		*dma_handle = virt_to_phys(ret);
+	memset(ret, 0, size);
+	/*
+	 * Pages from the page allocator may have data present in
+	 * cache. So flush the cache before using uncached memory.
+	 */
+	dma_cache_sync(dev, ret, size, DMA_BIDIRECTIONAL);
+
+	ret_nocache = ioremap_nocache(virt_to_phys(ret), size);
+	if (!ret_nocache) {
+		free_pages((unsigned long)ret, order);
+		return NULL;
 	}
-	return ret;
+
+	*dma_handle = virt_to_phys(ret);
+	return ret_nocache;
 }
 EXPORT_SYMBOL(dma_alloc_coherent);
 
@@ -71,7 +78,8 @@ void dma_free_coherent(struct device *de
 	} else {
 		WARN_ON(irqs_disabled());	/* for portability */
 		BUG_ON(mem && mem->flags & DMA_MEMORY_EXCLUSIVE);
-		free_pages((unsigned long)vaddr, order);
+		free_pages((unsigned long)phys_to_virt(dma_handle), order);
+		iounmap(vaddr);
 	}
 }
 EXPORT_SYMBOL(dma_free_coherent);
