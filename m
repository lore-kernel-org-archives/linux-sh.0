From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 13 Jan 2008 13:54:47 +0000
Subject: [PATCH] sh: declared coherent memory support
Message-Id: <20080113135447.30289.54583.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh: declared coherent memory support

This patch adds declared coherent memory support to the sh architecture. All
functions are copied straight from the x86 implementation and the header files
are adjusted to use the newfunctions instead of the former consistent_alloc()
code.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/mm/consistent.c      |  174 ++++++++++++++++++++++++++++++------------
 include/asm-sh/dma-mapping.h |   56 ++++---------
 2 files changed, 147 insertions(+), 83 deletions(-)

--- 0001/arch/sh/mm/consistent.c
+++ work/arch/sh/mm/consistent.c	2008-01-13 22:07:34.000000000 +0900
@@ -3,6 +3,8 @@
  *
  * Copyright (C) 2004 - 2007  Paul Mundt
  *
+ * Declared coherent memory functions taken from arch/x86/kernel/pci-dma_32.c
+ *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
@@ -13,66 +15,144 @@
 #include <asm/addrspace.h>
 #include <asm/io.h>
 
-void *consistent_alloc(gfp_t gfp, size_t size, dma_addr_t *handle)
+struct dma_coherent_mem {
+	void		*virt_base;
+	u32		device_base;
+	int		size;
+	int		flags;
+	unsigned long	*bitmap;
+};
+
+void *dma_alloc_coherent(struct device *dev, size_t size,
+			   dma_addr_t *dma_handle, gfp_t gfp)
 {
-	struct page *page, *end, *free;
-	void *ret, *vp;
-	int order;
-
-	size = PAGE_ALIGN(size);
-	order = get_order(size);
-
-	page = alloc_pages(gfp, order);
-	if (!page)
-		return NULL;
-	split_page(page, order);
-
-	ret = page_address(page);
-	*handle = virt_to_phys(ret);
-
-	vp = ioremap_nocache(*handle, size);
-	if (!vp) {
-		free_pages((unsigned long)ret, order);
-		return NULL;
+	void *ret;
+	struct dma_coherent_mem *mem = dev ? dev->dma_mem : NULL;
+	int order = get_order(size);
+	/* ignore region specifiers */
+	gfp &= ~(__GFP_DMA | __GFP_HIGHMEM);
+
+	if (mem) {
+		int page = bitmap_find_free_region(mem->bitmap, mem->size,
+						     order);
+		if (page >= 0) {
+			*dma_handle = mem->device_base + (page << PAGE_SHIFT);
+			ret = mem->virt_base + (page << PAGE_SHIFT);
+			memset(ret, 0, size);
+			return ret;
+		}
+		if (mem->flags & DMA_MEMORY_EXCLUSIVE)
+			return NULL;
 	}
 
-	memset(vp, 0, size);
+	if (dev = NULL || (dev->coherent_dma_mask < 0xffffffff))
+		gfp |= GFP_DMA;
 
-	/*
-	 * We must flush the cache before we pass it on to the device
-	 */
-	dma_cache_sync(NULL, ret, size, DMA_BIDIRECTIONAL);
-
-	page = virt_to_page(ret);
-	free = page + (size >> PAGE_SHIFT);
-	end  = page + (1 << order);
-
-	while (++page < end) {
-		/* Free any unused pages */
-		if (page >= free) {
-			__free_page(page);
-		}
+	ret = (void *)__get_free_pages(gfp, order);
+
+	if (ret != NULL) {
+		memset(ret, 0, size);
+		*dma_handle = virt_to_phys(ret);
 	}
+	return ret;
+}
+EXPORT_SYMBOL(dma_alloc_coherent);
 
-	return vp;
+void dma_free_coherent(struct device *dev, size_t size,
+			 void *vaddr, dma_addr_t dma_handle)
+{
+	struct dma_coherent_mem *mem = dev ? dev->dma_mem : NULL;
+	int order = get_order(size);
+
+	WARN_ON(irqs_disabled());	/* for portability */
+	if (mem && vaddr >= mem->virt_base && vaddr < (mem->virt_base + (mem->size << PAGE_SHIFT))) {
+		int page = (vaddr - mem->virt_base) >> PAGE_SHIFT;
+
+		bitmap_release_region(mem->bitmap, page, order);
+	} else
+		free_pages((unsigned long)vaddr, order);
 }
-EXPORT_SYMBOL(consistent_alloc);
+EXPORT_SYMBOL(dma_free_coherent);
 
-void consistent_free(void *vaddr, size_t size, dma_addr_t dma_handle)
+int dma_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
+				dma_addr_t device_addr, size_t size, int flags)
 {
-	struct page *page;
-	unsigned long addr;
+	void __iomem *mem_base = NULL;
+	int pages = size >> PAGE_SHIFT;
+	int bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
+
+	if ((flags & (DMA_MEMORY_MAP | DMA_MEMORY_IO)) = 0)
+		goto out;
+	if (!size)
+		goto out;
+	if (dev->dma_mem)
+		goto out;
+
+	/* FIXME: this routine just ignores DMA_MEMORY_INCLUDES_CHILDREN */
+
+	mem_base = ioremap(bus_addr, size);
+	if (!mem_base)
+		goto out;
+
+	dev->dma_mem = kzalloc(sizeof(struct dma_coherent_mem), GFP_KERNEL);
+	if (!dev->dma_mem)
+		goto out;
+	dev->dma_mem->bitmap = kzalloc(bitmap_size, GFP_KERNEL);
+	if (!dev->dma_mem->bitmap)
+		goto free1_out;
+
+	dev->dma_mem->virt_base = mem_base;
+	dev->dma_mem->device_base = device_addr;
+	dev->dma_mem->size = pages;
+	dev->dma_mem->flags = flags;
+
+	if (flags & DMA_MEMORY_MAP)
+		return DMA_MEMORY_MAP;
+
+	return DMA_MEMORY_IO;
+
+ free1_out:
+	kfree(dev->dma_mem);
+ out:
+	if (mem_base)
+		iounmap(mem_base);
+	return 0;
+}
+EXPORT_SYMBOL(dma_declare_coherent_memory);
 
-	addr = (unsigned long)phys_to_virt((unsigned long)dma_handle);
-	page = virt_to_page(addr);
+void dma_release_declared_memory(struct device *dev)
+{
+	struct dma_coherent_mem *mem = dev->dma_mem;
 
-	free_pages(addr, get_order(size));
+	if (!mem)
+		return;
+	dev->dma_mem = NULL;
+	iounmap(mem->virt_base);
+	kfree(mem->bitmap);
+	kfree(mem);
+}
+EXPORT_SYMBOL(dma_release_declared_memory);
 
-	iounmap(vaddr);
+void *dma_mark_declared_memory_occupied(struct device *dev,
+					dma_addr_t device_addr, size_t size)
+{
+	struct dma_coherent_mem *mem = dev->dma_mem;
+	int pages = (size + (device_addr & ~PAGE_MASK) + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	int pos, err;
+
+	if (!mem)
+		return ERR_PTR(-EINVAL);
+
+	pos = (device_addr - mem->device_base) >> PAGE_SHIFT;
+	err = bitmap_allocate_region(mem->bitmap, pos, get_order(pages));
+	if (err != 0)
+		return ERR_PTR(err);
+	return mem->virt_base + (pos << PAGE_SHIFT);
 }
-EXPORT_SYMBOL(consistent_free);
+EXPORT_SYMBOL(dma_mark_declared_memory_occupied);
 
-void consistent_sync(void *vaddr, size_t size, int direction)
+void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
+		    enum dma_data_direction direction)
 {
 #ifdef CONFIG_CPU_SH5
 	void *p1addr = vaddr;
@@ -94,4 +174,4 @@ void consistent_sync(void *vaddr, size_t
 		BUG();
 	}
 }
-EXPORT_SYMBOL(consistent_sync);
+EXPORT_SYMBOL(dma_cache_sync);
--- 0001/include/asm-sh/dma-mapping.h
+++ work/include/asm-sh/dma-mapping.h	2008-01-13 22:06:45.000000000 +0900
@@ -8,11 +8,6 @@
 
 extern struct bus_type pci_bus_type;
 
-/* arch/sh/mm/consistent.c */
-extern void *consistent_alloc(gfp_t gfp, size_t size, dma_addr_t *handle);
-extern void consistent_free(void *vaddr, size_t size, dma_addr_t handle);
-extern void consistent_sync(void *vaddr, size_t size, int direction);
-
 #define dma_supported(dev, mask)	(1)
 
 static inline int dma_set_mask(struct device *dev, u64 mask)
@@ -25,44 +20,19 @@ static inline int dma_set_mask(struct de
 	return 0;
 }
 
-static inline void *dma_alloc_coherent(struct device *dev, size_t size,
-			 dma_addr_t *dma_handle, gfp_t flag)
-{
-	if (sh_mv.mv_consistent_alloc) {
-		void *ret;
-
-		ret = sh_mv.mv_consistent_alloc(dev, size, dma_handle, flag);
-		if (ret != NULL)
-			return ret;
-	}
-
-	return consistent_alloc(flag, size, dma_handle);
-}
-
-static inline void dma_free_coherent(struct device *dev, size_t size,
-		       void *vaddr, dma_addr_t dma_handle)
-{
-	if (sh_mv.mv_consistent_free) {
-		int ret;
+void *dma_alloc_coherent(struct device *dev, size_t size,
+			 dma_addr_t *dma_handle, gfp_t flag);
 
-		ret = sh_mv.mv_consistent_free(dev, size, vaddr, dma_handle);
-		if (ret = 0)
-			return;
-	}
+void dma_free_coherent(struct device *dev, size_t size,
+		       void *vaddr, dma_addr_t dma_handle);
 
-	consistent_free(vaddr, size, dma_handle);
-}
+void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
+		    enum dma_data_direction dir);
 
 #define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
 #define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
 #define dma_is_consistent(d, h) (1)
 
-static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-				  enum dma_data_direction dir)
-{
-	consistent_sync(vaddr, size, (int)dir);
-}
-
 static inline dma_addr_t dma_map_single(struct device *dev,
 					void *ptr, size_t size,
 					enum dma_data_direction dir)
@@ -205,4 +175,18 @@ static inline int dma_mapping_error(dma_
 {
 	return dma_addr = 0;
 }
+
+#define ARCH_HAS_DMA_DECLARE_COHERENT_MEMORY
+
+extern int
+dma_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
+			    dma_addr_t device_addr, size_t size, int flags);
+
+extern void
+dma_release_declared_memory(struct device *dev);
+
+extern void *
+dma_mark_declared_memory_occupied(struct device *dev,
+				  dma_addr_t device_addr, size_t size);
+
 #endif /* __ASM_SH_DMA_MAPPING_H */
