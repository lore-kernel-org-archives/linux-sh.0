From: Christoph Hellwig <hch@lst.de>
Date: Thu, 10 Sep 2020 05:40:36 +0000
Subject: [PATCH 1/3] ARM/dma-mapping: move various helpers from dma-mapping.h to dma-direct.h
Message-Id: <20200910054038.324517-2-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200910054038.324517-1-hch@lst.de>
In-Reply-To: <20200910054038.324517-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Jim Quinlan <james.quinlan@broadcom.com>, Nathan Chancellor <natechancellor@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org

Move the helpers to translate to and from direct mapping DMA addresses
to dma-direct.h.  This not only is the most logical place, but the new
placement also avoids dependency loops with pending commits.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/common/dmabounce.c        |  2 +-
 arch/arm/include/asm/dma-direct.h  | 70 ++++++++++++++++++++++++++++++
 arch/arm/include/asm/dma-mapping.h | 70 ------------------------------
 3 files changed, 71 insertions(+), 71 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index f4b719bde76367..d3e00ea9208834 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -24,7 +24,7 @@
 #include <linux/slab.h>
 #include <linux/page-flags.h>
 #include <linux/device.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-direct.h>
 #include <linux/dmapool.h>
 #include <linux/list.h>
 #include <linux/scatterlist.h>
diff --git a/arch/arm/include/asm/dma-direct.h b/arch/arm/include/asm/dma-direct.h
index 7c3001a6a775bf..de0f4ff9279615 100644
--- a/arch/arm/include/asm/dma-direct.h
+++ b/arch/arm/include/asm/dma-direct.h
@@ -2,6 +2,76 @@
 #ifndef ASM_ARM_DMA_DIRECT_H
 #define ASM_ARM_DMA_DIRECT_H 1
 
+#include <asm/memory.h>
+
+#ifdef __arch_page_to_dma
+#error Please update to __arch_pfn_to_dma
+#endif
+
+/*
+ * dma_to_pfn/pfn_to_dma/dma_to_virt/virt_to_dma are architecture private
+ * functions used internally by the DMA-mapping API to provide DMA
+ * addresses. They must not be used by drivers.
+ */
+#ifndef __arch_pfn_to_dma
+static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
+{
+	if (dev)
+		pfn -= dev->dma_pfn_offset;
+	return (dma_addr_t)__pfn_to_bus(pfn);
+}
+
+static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
+{
+	unsigned long pfn = __bus_to_pfn(addr);
+
+	if (dev)
+		pfn += dev->dma_pfn_offset;
+
+	return pfn;
+}
+
+static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
+{
+	if (dev) {
+		unsigned long pfn = dma_to_pfn(dev, addr);
+
+		return phys_to_virt(__pfn_to_phys(pfn));
+	}
+
+	return (void *)__bus_to_virt((unsigned long)addr);
+}
+
+static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
+{
+	if (dev)
+		return pfn_to_dma(dev, virt_to_pfn(addr));
+
+	return (dma_addr_t)__virt_to_bus((unsigned long)(addr));
+}
+
+#else
+static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
+{
+	return __arch_pfn_to_dma(dev, pfn);
+}
+
+static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
+{
+	return __arch_dma_to_pfn(dev, addr);
+}
+
+static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
+{
+	return __arch_dma_to_virt(dev, addr);
+}
+
+static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
+{
+	return __arch_virt_to_dma(dev, addr);
+}
+#endif
+
 static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
 	unsigned int offset = paddr & ~PAGE_MASK;
diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index bdd80ddbca3451..0a1a536368c3a4 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -8,8 +8,6 @@
 #include <linux/scatterlist.h>
 #include <linux/dma-debug.h>
 
-#include <asm/memory.h>
-
 #include <xen/xen.h>
 #include <asm/xen/hypervisor.h>
 
@@ -23,74 +21,6 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return NULL;
 }
 
-#ifdef __arch_page_to_dma
-#error Please update to __arch_pfn_to_dma
-#endif
-
-/*
- * dma_to_pfn/pfn_to_dma/dma_to_virt/virt_to_dma are architecture private
- * functions used internally by the DMA-mapping API to provide DMA
- * addresses. They must not be used by drivers.
- */
-#ifndef __arch_pfn_to_dma
-static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
-{
-	if (dev)
-		pfn -= dev->dma_pfn_offset;
-	return (dma_addr_t)__pfn_to_bus(pfn);
-}
-
-static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
-{
-	unsigned long pfn = __bus_to_pfn(addr);
-
-	if (dev)
-		pfn += dev->dma_pfn_offset;
-
-	return pfn;
-}
-
-static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
-{
-	if (dev) {
-		unsigned long pfn = dma_to_pfn(dev, addr);
-
-		return phys_to_virt(__pfn_to_phys(pfn));
-	}
-
-	return (void *)__bus_to_virt((unsigned long)addr);
-}
-
-static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
-{
-	if (dev)
-		return pfn_to_dma(dev, virt_to_pfn(addr));
-
-	return (dma_addr_t)__virt_to_bus((unsigned long)(addr));
-}
-
-#else
-static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
-{
-	return __arch_pfn_to_dma(dev, pfn);
-}
-
-static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
-{
-	return __arch_dma_to_pfn(dev, addr);
-}
-
-static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
-{
-	return __arch_dma_to_virt(dev, addr);
-}
-
-static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
-{
-	return __arch_virt_to_dma(dev, addr);
-}
-#endif
-
 /**
  * arm_dma_alloc - allocate consistent memory for DMA
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
-- 
2.28.0
