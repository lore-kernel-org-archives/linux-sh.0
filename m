From: Shuah Khan <shuah.khan@hp.com>
Date: Fri, 26 Oct 2012 16:20:03 +0000
Subject: [PATCH RFT linux-next] sh: dma-mapping: support debug_dma_mapping_error
Message-Id: <1351268403.4013.24.camel@lorien2>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lethal@linux-sh.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com, arnd@arndb.de, andrzej.p@samsung.com
Cc: linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, shuahkhan@gmail.com

Add support for debug_dma_mapping_error() call to avoid warning from
debug_dma_unmap() interface when it checks for mapping error checked
status. Without this patch, device driver failed to check map error
warning is generated.

Signed-off-by: Shuah Khan <shuah.khan@hp.com>
---
 arch/sh/include/asm/dma-mapping.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/include/asm/dma-mapping.h b/arch/sh/include/asm/dma-mapping.h
index 8bd965e..b437f2c 100644
--- a/arch/sh/include/asm/dma-mapping.h
+++ b/arch/sh/include/asm/dma-mapping.h
@@ -46,6 +46,7 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 
+	debug_dma_mapping_error(dev, dma_addr);
 	if (ops->mapping_error)
 		return ops->mapping_error(dev, dma_addr);
 
-- 
1.7.9.5



