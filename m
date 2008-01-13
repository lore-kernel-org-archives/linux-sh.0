From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 13 Jan 2008 14:01:37 +0000
Subject: [PATCH] sh: declared coherent memory fixes
Message-Id: <20080113140137.30501.95132.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh: declared coherent memory fixes

Two minor fixes for the recently added declared coherent memory implementation:
 - move the WARN_ON() to avoid triggering with usb storage and bounce buffer
 - add a BUG_ON() to make sure DMA_MEMORY_EXCLUSIVE isn't set

These may be of interest for x86 as well.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/mm/consistent.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- 0005/arch/sh/mm/consistent.c
+++ work/arch/sh/mm/consistent.c	2008-01-13 21:30:11.000000000 +0900
@@ -64,13 +64,15 @@ void dma_free_coherent(struct device *de
 	struct dma_coherent_mem *mem = dev ? dev->dma_mem : NULL;
 	int order = get_order(size);
 
-	WARN_ON(irqs_disabled());	/* for portability */
 	if (mem && vaddr >= mem->virt_base && vaddr < (mem->virt_base + (mem->size << PAGE_SHIFT))) {
 		int page = (vaddr - mem->virt_base) >> PAGE_SHIFT;
 
 		bitmap_release_region(mem->bitmap, page, order);
-	} else
+	} else {
+		WARN_ON(irqs_disabled());	/* for portability */
+		BUG_ON(mem && mem->flags & DMA_MEMORY_EXCLUSIVE);
 		free_pages((unsigned long)vaddr, order);
+	}
 }
 EXPORT_SYMBOL(dma_free_coherent);
 
