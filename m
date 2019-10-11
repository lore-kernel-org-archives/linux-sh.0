From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date: Fri, 11 Oct 2019 16:51:29 +0000
Subject: [PATCH] sh: use dma_to_phys() instead of dev->dma_pfn_offset
Message-Id: <20191011165129.29655-1-nsaenzjulienne@suse.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: hch@infradead.org, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

It's more explicit and lets dma-direct handle the specifics of how to
translate addresses.

On top of that get rid of warnings as, since the introduction of commit
6fa1d28e38c ("sh: use generic dma_noncoherent_ops"), it's impossible for
the dev to be NULL.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

NOTE: this was only compile tested.

 arch/sh/kernel/dma-coherent.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/sh/kernel/dma-coherent.c b/arch/sh/kernel/dma-coherent.c
index b17514619b7e..f6618ed01a42 100644
--- a/arch/sh/kernel/dma-coherent.c
+++ b/arch/sh/kernel/dma-coherent.c
@@ -4,6 +4,7 @@
  */
 #include <linux/mm.h>
 #include <linux/init.h>
+#include <linux/dma-direct.h>
 #include <linux/dma-noncoherent.h>
 #include <linux/module.h>
 #include <asm/cacheflush.h>
@@ -36,9 +37,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 
 	split_page(pfn_to_page(virt_to_phys(ret) >> PAGE_SHIFT), order);
 
-	*dma_handle = virt_to_phys(ret);
-	if (!WARN_ON(!dev))
-		*dma_handle -= PFN_PHYS(dev->dma_pfn_offset);
+	*dma_handle = phys_to_dma(dev, virt_to_phys(ret));
 
 	return ret_nocache;
 }
@@ -47,12 +46,9 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_handle, unsigned long attrs)
 {
 	int order = get_order(size);
-	unsigned long pfn = (dma_handle >> PAGE_SHIFT);
+	unsigned long pfn = __phys_to_pfn(dma_to_phys(dev, dma_handle));
 	int k;
 
-	if (!WARN_ON(!dev))
-		pfn += dev->dma_pfn_offset;
-
 	for (k = 0; k < (1 << order); k++)
 		__free_pages(pfn_to_page(pfn + k), 0);
 
-- 
2.23.0
