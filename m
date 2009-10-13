From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 13 Oct 2009 10:25:04 +0000
Subject: Re: Possibly icahe/dcache synchronization problem on sh7785lcr
Message-Id: <20091013102503.GA31887@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4ACF32C2.9010501@siemens.com>
In-Reply-To: <4ACF32C2.9010501@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Oct 13, 2009 at 12:13:52PM +0400, Valentin R Sitsikov wrote:
> Hello Paul.
> Thanks a lot i will try it.
> I am a little bit confused about 4096.  Page size  is not always  equal 
> to 4096.
> In my particular case page size is equal to 8192.
> How do you think if it might be a problem ?
> 
The code itself is a bit misleading, the 4096 there does not relate to
the page size, only that the routine in question is flushing 4k at a
time. The way increment >> 12 gives us the number of iterations that need
to be done to cover the way. However, you are correct that this bit of
code is suspect, as it only implements a 1-way flush! Somewhere in all
the noise I stupidly killed off the way loop.

Your patch to switch this over to PAGE_SIZE looks fine, although
flush_dcache_page() still needs a bit of refactoring, as the loop is no
longer necessary.

It still needs a bit of a think, but this is roughly what I'm thinking:

---

diff --git a/arch/sh/mm/cache-sh4.c b/arch/sh/mm/cache-sh4.c
index 56dd55a..7dd99d1 100644
--- a/arch/sh/mm/cache-sh4.c
+++ b/arch/sh/mm/cache-sh4.c
@@ -16,6 +16,7 @@
 #include <linux/mutex.h>
 #include <linux/fs.h>
 #include <linux/highmem.h>
+#include <linux/pagemap.h>
 #include <asm/pgtable.h>
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
@@ -27,8 +28,11 @@
  */
 #define MAX_ICACHE_PAGES	32
 
-static void __flush_cache_4096(unsigned long addr, unsigned long phys,
-			       unsigned long exec_offset);
+static void __flush_cache_alias(unsigned long addr,
+		unsigned long kaddr, struct cache_info *ci);
+
+static void (*__flush_cache_alias_uncached)(unsigned long addr,
+		unsigned long kaddr, struct cache_info *ci);
 
 /*
  * Write back the range of D-cache, and purge the I-cache.
@@ -82,53 +86,6 @@ static void __uses_jump_to_uncached sh4_flush_icache_range(void *args)
 	local_irq_restore(flags);
 }
 
-static inline void flush_cache_4096(unsigned long start,
-				    unsigned long phys)
-{
-	unsigned long flags, exec_offset = 0;
-
-	/*
-	 * All types of SH-4 require PC to be uncached to operate on the I-cache.
-	 * Some types of SH-4 require PC to be uncached to operate on the D-cache.
-	 */
-	if ((boot_cpu_data.flags & CPU_HAS_P2_FLUSH_BUG) ||
-	    (start < CACHE_OC_ADDRESS_ARRAY))
-		exec_offset = cached_to_uncached;
-
-	local_irq_save(flags);
-	__flush_cache_4096(start | SH_CACHE_ASSOC,
-			   virt_to_phys(phys), exec_offset);
-	local_irq_restore(flags);
-}
-
-/*
- * Write back & invalidate the D-cache of the page.
- * (To avoid "alias" issues)
- */
-static void sh4_flush_dcache_page(void *arg)
-{
-	struct page *page = arg;
-#ifndef CONFIG_SMP
-	struct address_space *mapping = page_mapping(page);
-
-	if (mapping && !mapping_mapped(mapping))
-		set_bit(PG_dcache_dirty, &page->flags);
-	else
-#endif
-	{
-		unsigned long phys = page_to_phys(page);
-		unsigned long addr = CACHE_OC_ADDRESS_ARRAY;
-		int i, n;
-
-		/* Loop all the D-cache */
-		n = boot_cpu_data.dcache.way_incr >> 12;
-		for (i = 0; i < n; i++, addr += 4096)
-			flush_cache_4096(addr, phys);
-	}
-
-	wmb();
-}
-
 /* TODO: Selective icache invalidation through IC address array.. */
 static void __uses_jump_to_uncached flush_icache_all(void)
 {
@@ -180,6 +137,63 @@ static void sh4_flush_cache_all(void *unused)
 	flush_icache_all();
 }
 
+static inline void flush_cache_alias(unsigned long start, unsigned long kaddr)
+{
+	void (*__flush_cache_alias_wrapper)(unsigned long addr,
+			unsigned long kaddr, struct cache_info *ci);
+	struct cache_info *ci;
+	unsigned long flags;
+
+	/*
+	 * All types of SH-4 require PC to be uncached to operate on the I-cache.
+	 * Some types of SH-4 require PC to be uncached to operate on the D-cache.
+	 */
+	if (start < CACHE_OC_ADDRESS_ARRAY) {
+		ci = &boot_cpu_data.icache;
+		__flush_cache_alias_wrapper = __flush_cache_alias_uncached;
+	} else {
+		ci = &boot_cpu_data.dcache;
+		if (boot_cpu_data.flags & CPU_HAS_P2_FLUSH_BUG)
+			__flush_cache_alias_wrapper +				__flush_cache_alias_uncached;
+		else
+			__flush_cache_alias_wrapper = __flush_cache_alias;
+	}
+
+	local_irq_save(flags);
+	__flush_cache_alias_wrapper(start | SH_CACHE_ASSOC, kaddr, ci);
+	local_irq_restore(flags);
+}
+
+/*
+ * Write back & invalidate the D-cache of the page.
+ * (To avoid "alias" issues)
+ */
+static void sh4_flush_dcache_page(void *arg)
+{
+	struct page *page = arg;
+	struct address_space *mapping = page_mapping(page);
+
+#ifndef CONFIG_SMP
+	if (mapping && !mapping_mapped(mapping))
+		set_bit(PG_dcache_dirty, &page->flags);
+	else
+#endif
+	{
+		unsigned long phys = page_to_phys(page);
+		unsigned long pgoff = page->index << PAGE_CACHE_SHIFT;
+
+		flush_cache_alias(CACHE_OC_ADDRESS_ARRAY |
+				  (unsigned long)page_address(page), phys);
+
+		if (mapping) {
+			flush_cache_alias(CACHE_OC_ADDRESS_ARRAY |
+					  (pgoff & shm_align_mask), phys);
+			flush_icache_all();
+		}
+	}
+}
+
 /*
  * Note : (RPC) since the caches are physically tagged, the only point
  * of flush_cache_mm for SH-4 is to get rid of aliases from the
@@ -257,7 +271,7 @@ static void sh4_flush_cache_page(void *args)
 	}
 
 	if (pages_do_alias(address, phys))
-		flush_cache_4096(CACHE_OC_ADDRESS_ARRAY |
+		flush_cache_alias(CACHE_OC_ADDRESS_ARRAY |
 			(address & shm_align_mask), phys);
 
 	if (vma->vm_flags & VM_EXEC)
@@ -306,60 +320,26 @@ static void sh4_flush_cache_range(void *args)
 		flush_icache_all();
 }
 
-/**
- * __flush_cache_4096
- *
- * @addr:  address in memory mapped cache array
- * @phys:  P1 address to flush (has to match tags if addr has 'A' bit
- *         set i.e. associative write)
- * @exec_offset: set to 0x20000000 if flush has to be executed from P2
- *               region else 0x0
- *
- * The offset into the cache array implied by 'addr' selects the
- * 'colour' of the virtual address range that will be flushed.  The
- * operation (purge/write-back) is selected by the lower 2 bits of
- * 'phys'.
- */
-static void __flush_cache_4096(unsigned long addr, unsigned long phys,
-			       unsigned long exec_offset)
+static void __uses_jump_to_uncached
+__flush_cache_alias(unsigned long addr, unsigned long kaddr, struct cache_info *ci)
 {
 	int way_count;
 	unsigned long base_addr = addr;
-	struct cache_info *dcache;
 	unsigned long way_incr;
 	unsigned long a, ea, p;
-	unsigned long temp_pc;
 
-	dcache = &boot_cpu_data.dcache;
 	/* Write this way for better assembly. */
-	way_count = dcache->ways;
-	way_incr = dcache->way_incr;
-
-	/*
-	 * Apply exec_offset (i.e. branch to P2 if required.).
-	 *
-	 * FIXME:
-	 *
-	 *	If I write "=r" for the (temp_pc), it puts this in r6 hence
-	 *	trashing exec_offset before it's been added on - why?  Hence
-	 *	"=&r" as a 'workaround'
-	 */
-	asm volatile("mov.l 1f, %0\n\t"
-		     "add   %1, %0\n\t"
-		     "jmp   @%0\n\t"
-		     "nop\n\t"
-		     ".balign 4\n\t"
-		     "1:  .long 2f\n\t"
-		     "2:\n" : "=&r" (temp_pc) : "r" (exec_offset));
+	way_count = ci->ways;
+	way_incr = ci->way_incr;
 
 	/*
 	 * We know there will be >=1 iteration, so write as do-while to avoid
 	 * pointless nead-of-loop check for 0 iterations.
 	 */
 	do {
-		ea = base_addr + 4096;
+		ea = base_addr + PAGE_SIZE;
 		a = base_addr;
-		p = phys;
+		p = kaddr;
 
 		do {
 			*(volatile unsigned long *)a = p;
@@ -389,6 +369,13 @@ void __init sh4_cache_init(void)
 		ctrl_inl(CCN_CVR),
 		ctrl_inl(CCN_PRR));
 
+	/*
+	 * Pre-calculate the uncached version so it can be called
+	 * directly.
+	 */
+	__flush_cache_alias_uncached = &__flush_cache_alias +
+				       cached_to_uncached;
+
 	local_flush_icache_range	= sh4_flush_icache_range;
 	local_flush_dcache_page		= sh4_flush_dcache_page;
 	local_flush_cache_all		= sh4_flush_cache_all;
