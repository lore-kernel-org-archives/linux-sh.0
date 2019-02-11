From: Christoph Hellwig <hch@lst.de>
Date: Mon, 11 Feb 2019 13:35:54 +0000
Subject: [PATCH 12/12] dma-mapping: remove dma_assign_coherent_memory
Message-Id: <20190211133554.30055-13-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190211133554.30055-1-hch@lst.de>
In-Reply-To: <20190211133554.30055-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org

The only useful bit in this function was the already assigned check.
Once that is moved to dma_init_coherent_memory thee rest can easily
be handled in the two callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/coherent.c | 47 +++++++++++++------------------------------
 1 file changed, 14 insertions(+), 33 deletions(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index d7a27008f228..1e3ce71cd993 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -41,6 +41,9 @@ static int dma_init_coherent_memory(phys_addr_t phys_addr,
 	int bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
 	int ret;
 
+	if (*mem)
+		return -EBUSY;
+
 	if (!size) {
 		ret = -EINVAL;
 		goto out;
@@ -88,33 +91,11 @@ static void dma_release_coherent_memory(struct dma_coherent_mem *mem)
 	kfree(mem);
 }
 
-static int dma_assign_coherent_memory(struct device *dev,
-				      struct dma_coherent_mem *mem)
-{
-	if (!dev)
-		return -ENODEV;
-
-	if (dev->dma_mem)
-		return -EBUSY;
-
-	dev->dma_mem = mem;
-	return 0;
-}
-
 int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 				dma_addr_t device_addr, size_t size)
 {
-	struct dma_coherent_mem *mem;
-	int ret;
-
-	ret = dma_init_coherent_memory(phys_addr, device_addr, size, &mem);
-	if (ret)
-		return ret;
-
-	ret = dma_assign_coherent_memory(dev, mem);
-	if (ret)
-		dma_release_coherent_memory(mem);
-	return ret;
+	return dma_init_coherent_memory(phys_addr, device_addr, size,
+					&dev->dma_mem);
 }
 EXPORT_SYMBOL(dma_declare_coherent_memory);
 
@@ -238,18 +219,18 @@ static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
 	struct dma_coherent_mem *mem = rmem->priv;
 	int ret;
 
-	if (!mem) {
-		ret = dma_init_coherent_memory(rmem->base, rmem->base,
-					       rmem->size, &mem);
-		if (ret) {
-			pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %ld MiB\n",
-				&rmem->base, (unsigned long)rmem->size / SZ_1M);
-			return ret;
-		}
+	ret = dma_init_coherent_memory(rmem->base, rmem->base, rmem->size,
+			&mem);
+	if (ret && ret != -EBUSY) {
+		pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %ld MiB\n",
+			&rmem->base, (unsigned long)rmem->size / SZ_1M);
+		return ret;
 	}
+
 	mem->use_dev_dma_pfn_offset = true;
+	if (dev)
+		dev->dma_mem = mem;
 	rmem->priv = mem;
-	dma_assign_coherent_memory(dev, mem);
 	return 0;
 }
 
-- 
2.20.1
