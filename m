From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Date: Wed, 13 Jul 2016 08:41:30 +0000
Subject: [PATCH v6 39/46] sh: dma-mapping: Use unsigned long for dma_attrs
Message-Id: <1468399300-5399-39-git-send-email-k.kozlowski@samsung.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1468399167-28083-1-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-1-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-2-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-3-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-4-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-5-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-6-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-7-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-8-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-9-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-10-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-11-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-12-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-13-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-14-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-15-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-16-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-17-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-18-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-19-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-20-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-21-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-22-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-23-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-24-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-25-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-26-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-27-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-28-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-29-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-30-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-31-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-32-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-33-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-34-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-35-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-36-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-37-git-send-email-k.kozlowski@samsung.com>
 <1468399300-5399-38-git-send-email-k.kozlowski@samsung.com>
In-Reply-To: <1468399300-5399-38-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

Split out subsystem specific changes for easier reviews. This will be
squashed with main commit.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/sh/include/asm/dma-mapping.h | 4 ++--
 arch/sh/kernel/dma-nommu.c        | 4 ++--
 arch/sh/mm/consistent.c           | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/sh/include/asm/dma-mapping.h b/arch/sh/include/asm/dma-mapping.h
index e11cf0c8206b..0052ad40e86d 100644
--- a/arch/sh/include/asm/dma-mapping.h
+++ b/arch/sh/include/asm/dma-mapping.h
@@ -17,9 +17,9 @@ void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 /* arch/sh/mm/consistent.c */
 extern void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 					dma_addr_t *dma_addr, gfp_t flag,
-					struct dma_attrs *attrs);
+					unsigned long attrs);
 extern void dma_generic_free_coherent(struct device *dev, size_t size,
 				      void *vaddr, dma_addr_t dma_handle,
-				      struct dma_attrs *attrs);
+				      unsigned long attrs);
 
 #endif /* __ASM_SH_DMA_MAPPING_H */
diff --git a/arch/sh/kernel/dma-nommu.c b/arch/sh/kernel/dma-nommu.c
index 5b0bfcda6d0b..eadb669a7329 100644
--- a/arch/sh/kernel/dma-nommu.c
+++ b/arch/sh/kernel/dma-nommu.c
@@ -13,7 +13,7 @@
 static dma_addr_t nommu_map_page(struct device *dev, struct page *page,
 				 unsigned long offset, size_t size,
 				 enum dma_data_direction dir,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	dma_addr_t addr = page_to_phys(page) + offset;
 
@@ -25,7 +25,7 @@ static dma_addr_t nommu_map_page(struct device *dev, struct page *page,
 
 static int nommu_map_sg(struct device *dev, struct scatterlist *sg,
 			int nents, enum dma_data_direction dir,
-			struct dma_attrs *attrs)
+			unsigned long attrs)
 {
 	struct scatterlist *s;
 	int i;
diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index b81d9dbf9fef..92b6976fde59 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -34,7 +34,7 @@ fs_initcall(dma_init);
 
 void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 				 dma_addr_t *dma_handle, gfp_t gfp,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	void *ret, *ret_nocache;
 	int order = get_order(size);
@@ -66,7 +66,7 @@ void *dma_generic_alloc_coherent(struct device *dev, size_t size,
 
 void dma_generic_free_coherent(struct device *dev, size_t size,
 			       void *vaddr, dma_addr_t dma_handle,
-			       struct dma_attrs *attrs)
+			       unsigned long attrs)
 {
 	int order = get_order(size);
 	unsigned long pfn = dma_handle >> PAGE_SHIFT;
-- 
1.9.1

