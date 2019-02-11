From: Christoph Hellwig <hch@lst.de>
Date: Mon, 11 Feb 2019 13:35:47 +0000
Subject: [PATCH 05/12] dma-mapping: remove an incorrect __iommem annotation
Message-Id: <20190211133554.30055-6-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190211133554.30055-1-hch@lst.de>
In-Reply-To: <20190211133554.30055-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org

memmap return a regular void pointer, not and __iomem one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/coherent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 66f0fb7e9a3a..4b76aba574c2 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -43,7 +43,7 @@ static int dma_init_coherent_memory(
 	struct dma_coherent_mem **mem)
 {
 	struct dma_coherent_mem *dma_mem = NULL;
-	void __iomem *mem_base = NULL;
+	void *mem_base = NULL;
 	int pages = size >> PAGE_SHIFT;
 	int bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
 	int ret;
-- 
2.20.1
