From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Mon, 09 Jan 2012 16:08:47 +0000
Subject: [PATCH v3] sh: sh2a: Improve cache flush/invalidate functions
Message-Id: <1326125327-30189-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The cache functions lock out interrupts for long periods; this patch
reduces the impact when operating on large address ranges. In such
cases it will:
- Invalidate the entire cache rather than individual addresses.
- Do nothing when flushing the operand cache in write-through mode.
- When flushing the operand cache in write-back mdoe, index the
  search for matching addresses on the cache entires instead of the
  addresses to flush

Note: sh2a__flush_purge_region was only invalidating the operand
cache, this adds flush.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
v3:
1. Refactored code to make it readable and correct formatting.
2. Added code to handle flushing large address ranges in
   write-back mode.

 arch/sh/mm/cache-sh2a.c |  123 ++++++++++++++++++++++++++++++++---------------
 1 files changed, 84 insertions(+), 39 deletions(-)

diff --git a/arch/sh/mm/cache-sh2a.c b/arch/sh/mm/cache-sh2a.c
index 1f51225..ae08cbb 100644
--- a/arch/sh/mm/cache-sh2a.c
+++ b/arch/sh/mm/cache-sh2a.c
@@ -15,35 +15,78 @@
 #include <asm/cacheflush.h>
 #include <asm/io.h>
 
+/*
+ * The maximum number of pages we support up to when doing ranged dcache
+ * flushing. Anything exceeding this will simply flush the dcache in its
+ * entirety.
+ */
+#define MAX_OCACHE_PAGES	32
+#define MAX_ICACHE_PAGES	32
+
+static void sh2a_flush_oc_line(unsigned long v, int way)
+{
+	unsigned long addr = (v & 0x000007f0) | (way << 11);
+	unsigned long data;
+
+	data = __raw_readl(CACHE_OC_ADDRESS_ARRAY | addr);
+	if ((data & CACHE_PHYSADDR_MASK) = (v & CACHE_PHYSADDR_MASK)) {
+		data &= ~SH_CACHE_UPDATED;
+		__raw_writel(data, CACHE_OC_ADDRESS_ARRAY | addr);
+	}
+}
+
+static void sh2a_invalidate_line(unsigned long cache_addr, unsigned long v)
+{
+	/* Set associative bit to hit all ways */
+	unsigned long addr = (v & 0x000007f0) | SH_CACHE_ASSOC;
+	__raw_writel((addr & CACHE_PHYSADDR_MASK), cache_addr | addr);
+}
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
+	int nr_ways;
 
 	begin = (unsigned long)start & ~(L1_CACHE_BYTES-1);
 	end = ((unsigned long)start + size + L1_CACHE_BYTES-1)
 		& ~(L1_CACHE_BYTES-1);
+	nr_ways = current_cpu_data.dcache.ways;
 
 	local_irq_save(flags);
 	jump_to_uncached();
 
-	for (v = begin; v < end; v+=L1_CACHE_BYTES) {
-		unsigned long addr = CACHE_OC_ADDRESS_ARRAY | (v & 0x000007f0);
+	/* If there are too many pages then flush the entire cache */
+	if (((end - begin) >> PAGE_SHIFT) >= MAX_OCACHE_PAGES) {
+		begin = CACHE_OC_ADDRESS_ARRAY;
+		end = begin + (nr_ways * current_cpu_data.dcache.way_size);
+
+		for (v = begin; v < end; v += L1_CACHE_BYTES) {
+			unsigned long data = __raw_readl(v);
+			if (data & SH_CACHE_UPDATED)
+				__raw_writel(data & ~SH_CACHE_UPDATED, v);
+		}
+	} else {
 		int way;
-		for (way = 0; way < 4; way++) {
-			unsigned long data =  __raw_readl(addr | (way << 11));
-			if ((data & CACHE_PHYSADDR_MASK) = (v & CACHE_PHYSADDR_MASK)) {
-				data &= ~SH_CACHE_UPDATED;
-				__raw_writel(data, addr | (way << 11));
-			}
+		for (way = 0; way < nr_ways; way++) {
+			for (v = begin; v < end; v += L1_CACHE_BYTES)
+				sh2a_flush_oc_line(v, way);
 		}
 	}
 
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
@@ -58,13 +101,22 @@ static void sh2a__flush_purge_region(void *start, int size)
 	jump_to_uncached();
 
 	for (v = begin; v < end; v+=L1_CACHE_BYTES) {
-		__raw_writel((v & CACHE_PHYSADDR_MASK),
-			  CACHE_OC_ADDRESS_ARRAY | (v & 0x000007f0) | 0x00000008);
+#ifdef CONFIG_CACHE_WRITEBACK
+		int way;
+		int nr_ways = current_cpu_data.dcache.ways;
+		for (way = 0; way < nr_ways; way++)
+			sh2a_flush_oc_line(v, way);
+#endif
+		sh2a_invalidate_line(CACHE_OC_ADDRESS_ARRAY, v);
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
@@ -74,29 +126,25 @@ static void sh2a__flush_invalidate_region(void *start, int size)
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
+		for (v = begin; v < end; v += L1_CACHE_BYTES)
+			sh2a_invalidate_line(CACHE_OC_ADDRESS_ARRAY, v);
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
@@ -107,23 +155,20 @@ static void sh2a_flush_icache_range(void *args)
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
-		}
-		/* I-Cache invalidate */
-		__raw_writel(addr,
-			  CACHE_IC_ADDRESS_ARRAY | addr | 0x00000008);
+	/* I-Cache invalidate */
+	/* If there are too many pages then just blow the cache */
+	if (((end - start) >> PAGE_SHIFT) >= MAX_ICACHE_PAGES) {
+		__raw_writel(__raw_readl(CCR) | CCR_ICACHE_INVALIDATE, CCR);
+	} else {
+		for (v = start; v < end; v += L1_CACHE_BYTES)
+			sh2a_invalidate_line(CACHE_IC_ADDRESS_ARRAY, v);
 	}
 
 	back_to_cached();
-- 
1.7.0.4

