From: Christoph Hellwig <hch@lst.de>
Date: Mon, 11 Feb 2019 13:35:45 +0000
Subject: [PATCH 03/12] of: mark early_init_dt_alloc_reserved_memory_arch static
Message-Id: <20190211133554.30055-4-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190211133554.30055-1-hch@lst.de>
In-Reply-To: <20190211133554.30055-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org

This function is only used in of_reserved_mem.c, and never overridden
despite the __weak marker.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/of/of_reserved_mem.c    | 2 +-
 include/linux/of_reserved_mem.h | 7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 1977ee0adcb1..9f165fc1d1a2 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -26,7 +26,7 @@
 static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
 static int reserved_mem_count;
 
-int __init __weak early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
+static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
 	phys_addr_t align, phys_addr_t start, phys_addr_t end, bool nomap,
 	phys_addr_t *res_base)
 {
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 67ab8d271df3..60f541912ccf 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -35,13 +35,6 @@ int of_reserved_mem_device_init_by_idx(struct device *dev,
 				       struct device_node *np, int idx);
 void of_reserved_mem_device_release(struct device *dev);
 
-int early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
-					     phys_addr_t align,
-					     phys_addr_t start,
-					     phys_addr_t end,
-					     bool nomap,
-					     phys_addr_t *res_base);
-
 void fdt_init_reserved_mem(void);
 void fdt_reserved_mem_save_node(unsigned long node, const char *uname,
 			       phys_addr_t base, phys_addr_t size);
-- 
2.20.1
