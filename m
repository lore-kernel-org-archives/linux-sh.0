From: Christoph Hellwig <hch@lst.de>
Date: Thu, 08 Aug 2019 16:00:01 +0000
Subject: [PATCH 4/8] dma-mapping: add a dma_can_mmap helper
Message-Id: <20190808160005.10325-5-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190808160005.10325-1-hch@lst.de>
In-Reply-To: <20190808160005.10325-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, Vladimir Murzin <vladimir.murzin@arm.com>, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org, Helge Deller <deller@gmx.de>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org

Add a helper to check if DMA allocations for a specific device can be
mapped to userspace using dma_mmap_*.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-mapping.h |  5 +++++
 kernel/dma/mapping.c        | 23 +++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f7d1eea32c78..17271857be5d 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -462,6 +462,7 @@ int dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt,
 int dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs);
+bool dma_can_mmap(struct device *dev);
 int dma_supported(struct device *dev, u64 mask);
 int dma_set_mask(struct device *dev, u64 mask);
 int dma_set_coherent_mask(struct device *dev, u64 mask);
@@ -552,6 +553,10 @@ static inline int dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 {
 	return -ENXIO;
 }
+static inline bool dma_can_mmap(struct device *dev)
+{
+	return false;
+}
 static inline int dma_supported(struct device *dev, u64 mask)
 {
 	return 0;
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 67b900ad0836..64d1de59e133 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -220,6 +220,29 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 #endif /* !CONFIG_ARCH_NO_COHERENT_DMA_MMAP */
 }
 
+/**
+ * dma_can_mmap - check if a given device supports dma_mmap_*
+ * @dev: device to check
+ *
+ * Returns %true if @dev supports dma_mmap_coherent() and dma_mmap_attrs() to
+ * map DMA allocations to userspace.
+ */
+bool dma_can_mmap(struct device *dev)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	if (IS_ENABLED(CONFIG_ARCH_NO_COHERENT_DMA_MMAP))
+		return false;
+
+	if (dma_is_direct(ops)) {
+		return dev_is_dma_coherent(dev) ||
+			IS_ENABLED(CONFIG_ARCH_HAS_DMA_COHERENT_TO_PFN);
+	}
+
+	return ops->mmap != NULL;
+}
+EXPORT_SYMBOL_GPL(dma_can_mmap);
+
 /**
  * dma_mmap_attrs - map a coherent DMA allocation into user space
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
-- 
2.20.1
