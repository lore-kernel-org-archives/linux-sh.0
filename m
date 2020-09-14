From: Christoph Hellwig <hch@lst.de>
Date: Mon, 14 Sep 2020 07:33:39 +0000
Subject: [PATCH 2/6] ARM/dma-mapping: remove dma_to_virt
Message-Id: <20200914073343.1579578-3-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200914073343.1579578-1-hch@lst.de>
In-Reply-To: <20200914073343.1579578-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jim Quinlan <james.quinlan@broadcom.com>, Nathan Chancellor <natechancellor@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-remoteproc@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org

dma_to_virt is entirely unused, remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/dma-mapping.h        | 18 +-----------------
 arch/arm/mach-omap1/include/mach/memory.h |  4 ----
 2 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 70d95677656044..cf2535fb8891f5 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -24,7 +24,7 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 }
 
 /*
- * dma_to_pfn/pfn_to_dma/dma_to_virt/virt_to_dma are architecture private
+ * dma_to_pfn/pfn_to_dma/virt_to_dma are architecture private
  * functions used internally by the DMA-mapping API to provide DMA
  * addresses. They must not be used by drivers.
  */
@@ -46,17 +46,6 @@ static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
 	return pfn;
 }
 
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
 static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
 {
 	if (dev)
@@ -76,11 +65,6 @@ static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
 	return __arch_dma_to_pfn(dev, addr);
 }
 
-static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
-{
-	return __arch_dma_to_virt(dev, addr);
-}
-
 static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
 {
 	return __arch_virt_to_dma(dev, addr);
diff --git a/arch/arm/mach-omap1/include/mach/memory.h b/arch/arm/mach-omap1/include/mach/memory.h
index 1142560e0078f5..e43697c3297bf2 100644
--- a/arch/arm/mach-omap1/include/mach/memory.h
+++ b/arch/arm/mach-omap1/include/mach/memory.h
@@ -41,10 +41,6 @@
 	   __phys_to_pfn(__dma);				\
 	})
 
-#define __arch_dma_to_virt(dev, addr)	({ (void *) (is_lbus_device(dev) ? \
-						lbus_to_virt(addr) : \
-						__phys_to_virt(addr)); })
-
 #define __arch_virt_to_dma(dev, addr)	({ unsigned long __addr = (unsigned long)(addr); \
 					   (dma_addr_t) (is_lbus_device(dev) ? \
 						virt_to_lbus(__addr) : \
-- 
2.28.0
