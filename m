From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 09 Oct 2008 09:43:57 +0000
Subject: [PATCH] sh: remove consistent alloc cruft
Message-Id: <20081009094357.6473.88353.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Remove left overs from the generic declared coherent rework.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/mm/consistent.c |   10 ----------
 1 file changed, 10 deletions(-)

--- 0001/arch/sh/mm/consistent.c
+++ work/arch/sh/mm/consistent.c	2008-10-09 16:55:55.000000000 +0900
@@ -16,14 +16,6 @@
 #include <asm/addrspace.h>
 #include <asm/io.h>
 
-struct dma_coherent_mem {
-	void		*virt_base;
-	u32		device_base;
-	int		size;
-	int		flags;
-	unsigned long	*bitmap;
-};
-
 void *dma_alloc_coherent(struct device *dev, size_t size,
 			   dma_addr_t *dma_handle, gfp_t gfp)
 {
@@ -58,12 +50,10 @@ EXPORT_SYMBOL(dma_alloc_coherent);
 void dma_free_coherent(struct device *dev, size_t size,
 			 void *vaddr, dma_addr_t dma_handle)
 {
-	struct dma_coherent_mem *mem = dev ? dev->dma_mem : NULL;
 	int order = get_order(size);
 
 	if (!dma_release_from_coherent(dev, order, vaddr)) {
 		WARN_ON(irqs_disabled());	/* for portability */
-		BUG_ON(mem && mem->flags & DMA_MEMORY_EXCLUSIVE);
 		free_pages((unsigned long)phys_to_virt(dma_handle), order);
 		iounmap(vaddr);
 	}
