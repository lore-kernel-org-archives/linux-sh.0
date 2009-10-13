From: Valentin R Sitsikov <valentin.sitdikov@siemens.com>
Date: Tue, 13 Oct 2009 09:48:36 +0000
Subject: [PATCH] sh4:  using PAGE_SIZE during flushing cache related to a
Message-Id: <4AD44CF4.7050802@siemens.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Valentin Sitdikov <valentin.sitdikov@siemens.com>
---
 arch/sh/mm/cache-sh4.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/sh/mm/cache-sh4.c b/arch/sh/mm/cache-sh4.c
index 56dd55a..2cb050d 100644
--- a/arch/sh/mm/cache-sh4.c
+++ b/arch/sh/mm/cache-sh4.c
@@ -27,7 +27,7 @@
  */
 #define MAX_ICACHE_PAGES    32
 
-static void __flush_cache_4096(unsigned long addr, unsigned long phys,
+static void __flush_cache_page(unsigned long addr, unsigned long phys,
                    unsigned long exec_offset);
 
 /*
@@ -82,7 +82,7 @@ static void __uses_jump_to_uncached 
sh4_flush_icache_range(void *args)
     local_irq_restore(flags);
 }
 
-static inline void flush_cache_4096(unsigned long start,
+static inline void _flush_cache_page(unsigned long start,
                     unsigned long phys)
 {
     unsigned long flags, exec_offset = 0;
@@ -96,7 +96,7 @@ static inline void flush_cache_4096(unsigned long start,
         exec_offset = cached_to_uncached;
 
     local_irq_save(flags);
-    __flush_cache_4096(start | SH_CACHE_ASSOC,
+    __flush_cache_page(start | SH_CACHE_ASSOC,
                virt_to_phys(phys), exec_offset);
     local_irq_restore(flags);
 }
@@ -122,8 +122,8 @@ static void sh4_flush_dcache_page(void *arg)
 
         /* Loop all the D-cache */
         n = boot_cpu_data.dcache.way_incr >> 12;
-        for (i = 0; i < n; i++, addr += 4096)
-            flush_cache_4096(addr, phys);
+        for (i = 0; i < n; i++, addr += PAGE_SIZE)
+            _flush_cache_page(addr, phys);
     }
 
     wmb();
@@ -257,7 +257,7 @@ static void sh4_flush_cache_page(void *args)
     }
 
     if (pages_do_alias(address, phys))
-        flush_cache_4096(CACHE_OC_ADDRESS_ARRAY |
+        _flush_cache_page(CACHE_OC_ADDRESS_ARRAY |
             (address & shm_align_mask), phys);
 
     if (vma->vm_flags & VM_EXEC)
@@ -320,7 +320,7 @@ static void sh4_flush_cache_range(void *args)
  * operation (purge/write-back) is selected by the lower 2 bits of
  * 'phys'.
  */
-static void __flush_cache_4096(unsigned long addr, unsigned long phys,
+static void __flush_cache_page(unsigned long addr, unsigned long phys,
                    unsigned long exec_offset)
 {
     int way_count;
@@ -357,7 +357,7 @@ static void __flush_cache_4096(unsigned long addr, 
unsigned long phys,
      * pointless nead-of-loop check for 0 iterations.
      */
     do {
-        ea = base_addr + 4096;
+        ea = base_addr + PAGE_SIZE;
         a = base_addr;
         p = phys;
 
-- 
1.6.3.3

