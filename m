From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Tue, 20 Dec 2011 08:40:47 +0000
Subject: [PATCH v2] sh: sh2a: Optimise cache functions.
Message-Id: <1324370447-29832-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

When invalidating a large address range, it's better to invalidate
the entire cache rather than individual addresses.

Also, when the operand cache is set to write-though mode, there is
no need to flush data.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/sh/mm/cache-sh2a.c |   74 +++++++++++++++++++++++++++++------------------
 1 files changed, 46 insertions(+), 28 deletions(-)

diff --git a/arch/sh/mm/cache-sh2a.c b/arch/sh/mm/cache-sh2a.c
index 1f51225..b1bdef1 100644
--- a/arch/sh/mm/cache-sh2a.c
+++ b/arch/sh/mm/cache-sh2a.c
@@ -15,8 +15,20 @@
 #include <asm/cacheflush.h>
 #include <asm/io.h>
 
+/*
+ * The maximum number of pages we support up to when doing ranged cache
+ * flushing. Anything exceeding this will simply flush the cache in its
+ * entirety.
+ */
+#define MAX_OCACHE_PAGES	32
+#define MAX_ICACHE_PAGES	32
+
+/*
+ * Write back the dirty D-caches, but not invalidate them.
+ */
 static void sh2a__flush_wback_region(void *start, int size)
 {
+#ifdef CONFIG_CACHE_WRITEBACK
 	unsigned long v;
 	unsigned long begin, end;
 	unsigned long flags;
@@ -42,8 +54,12 @@ static void sh2a__flush_wback_region(void *start, int size)
 
 	back_to_cached();
 	local_irq_restore(flags);
+#endif
 }
 
+/*
+ * Write back the dirty D-caches and invalidate them.
+ */
 static void sh2a__flush_purge_region(void *start, int size)
 {
 	unsigned long v;
@@ -61,10 +77,14 @@ static void sh2a__flush_purge_region(void *start, int size)
 		__raw_writel((v & CACHE_PHYSADDR_MASK),
 			  CACHE_OC_ADDRESS_ARRAY | (v & 0x000007f0) | 0x00000008);
 	}
+
 	back_to_cached();
 	local_irq_restore(flags);
 }
 
+/*
+ * Invalidate the D-caches, but no write back please
+ */
 static void sh2a__flush_invalidate_region(void *start, int size)
 {
 	unsigned long v;
@@ -74,29 +94,27 @@ static void sh2a__flush_invalidate_region(void *start, int size)
 	begin = (unsigned long)start & ~(L1_CACHE_BYTES-1);
 	end = ((unsigned long)start + size + L1_CACHE_BYTES-1)
 		& ~(L1_CACHE_BYTES-1);
+
 	local_irq_save(flags);
 	jump_to_uncached();
 
-#ifdef CONFIG_CACHE_WRITEBACK
-	__raw_writel(__raw_readl(CCR) | CCR_OCACHE_INVALIDATE, CCR);
-	/* I-cache invalidate */
-	for (v = begin; v < end; v+=L1_CACHE_BYTES) {
-		__raw_writel((v & CACHE_PHYSADDR_MASK),
-			  CACHE_IC_ADDRESS_ARRAY | (v & 0x000007f0) | 0x00000008);
-	}
-#else
-	for (v = begin; v < end; v+=L1_CACHE_BYTES) {
-		__raw_writel((v & CACHE_PHYSADDR_MASK),
-			  CACHE_IC_ADDRESS_ARRAY | (v & 0x000007f0) | 0x00000008);
-		__raw_writel((v & CACHE_PHYSADDR_MASK),
-			  CACHE_OC_ADDRESS_ARRAY | (v & 0x000007f0) | 0x00000008);
+	/* If there are too many pages then just blow the cache */
+	if (((end - begin) >> PAGE_SHIFT) >= MAX_OCACHE_PAGES) {
+		__raw_writel(__raw_readl(CCR) | CCR_OCACHE_INVALIDATE, CCR);
+	} else {
+		for (v = begin; v < end; v+=L1_CACHE_BYTES) {
+			__raw_writel((v & CACHE_PHYSADDR_MASK),
+				  CACHE_OC_ADDRESS_ARRAY | (v & 0x000007f0) | 0x00000008);
+		}
 	}
-#endif
+
 	back_to_cached();
 	local_irq_restore(flags);
 }
 
-/* WBack O-Cache and flush I-Cache */
+/*
+ * Write back the range of D-cache, and purge the I-cache.
+ */
 static void sh2a_flush_icache_range(void *args)
 {
 	struct flusher_data *data = args;
@@ -107,23 +125,23 @@ static void sh2a_flush_icache_range(void *args)
 	start = data->addr1 & ~(L1_CACHE_BYTES-1);
 	end = (data->addr2 + L1_CACHE_BYTES-1) & ~(L1_CACHE_BYTES-1);
 
+#ifdef CONFIG_CACHE_WRITEBACK
+	sh2a__flush_wback_region((void *)start, end-start);
+#endif
+
 	local_irq_save(flags);
 	jump_to_uncached();
 
-	for (v = start; v < end; v+=L1_CACHE_BYTES) {
-		unsigned long addr = (v & 0x000007f0);
-		int way;
-		/* O-Cache writeback */
-		for (way = 0; way < 4; way++) {
-			unsigned long data =  __raw_readl(CACHE_OC_ADDRESS_ARRAY | addr | (way << 11));
-			if ((data & CACHE_PHYSADDR_MASK) = (v & CACHE_PHYSADDR_MASK)) {
-				data &= ~SH_CACHE_UPDATED;
-				__raw_writel(data, CACHE_OC_ADDRESS_ARRAY | addr | (way << 11));
-			}
+	/* I-Cache invalidate */
+	/* If there are too many pages then just blow the cache */
+	if (((end - start) >> PAGE_SHIFT) >= MAX_ICACHE_PAGES) {
+		__raw_writel(__raw_readl(CCR) | CCR_ICACHE_INVALIDATE, CCR);
+	} else {
+		for (v = start; v < end; v+=L1_CACHE_BYTES) {
+			unsigned long addr = (v & 0x000007f0);
+			__raw_writel(addr,
+				  CACHE_IC_ADDRESS_ARRAY | addr | 0x00000008);
 		}
-		/* I-Cache invalidate */
-		__raw_writel(addr,
-			  CACHE_IC_ADDRESS_ARRAY | addr | 0x00000008);
 	}
 
 	back_to_cached();
-- 
1.7.0.4

