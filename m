From: Christoph Hellwig <hch@lst.de>
Date: Mon, 11 Feb 2019 13:35:44 +0000
Subject: [PATCH 02/12] device.h: dma_mem is only needed for HAVE_GENERIC_DMA_COHERENT
Message-Id: <20190211133554.30055-3-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190211133554.30055-1-hch@lst.de>
In-Reply-To: <20190211133554.30055-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org

No need to carry an unused field around.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/device.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 6cb4640b6160..be544400acdd 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1017,8 +1017,10 @@ struct device {
 
 	struct list_head	dma_pools;	/* dma pools (if dma'ble) */
 
+#ifdef CONFIG_HAVE_GENERIC_DMA_COHERENT
 	struct dma_coherent_mem	*dma_mem; /* internal for coherent mem
 					     override */
+#endif
 #ifdef CONFIG_DMA_CMA
 	struct cma *cma_area;		/* contiguous memory area for dma
 					   allocations */
-- 
2.20.1
