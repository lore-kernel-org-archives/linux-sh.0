From: Matt Fleming <matt@console-pimps.org>
Date: Tue, 06 Oct 2009 21:22:21 +0000
Subject: [PATCH 01/14] sh: Sprinkle __uses_jump_to_uncached
Message-Id: <1db0a1123393575aec324e0d808b6369f9837fe4.1254861984.git.matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Fix some callers of jump_to_uncached() and back_to_cached() that were
not annotated with __uses_jump_to_uncached.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/mm/cache-sh4.c    |    2 +-
 arch/sh/mm/cache-sh7705.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/mm/cache-sh4.c b/arch/sh/mm/cache-sh4.c
index b2453bb..a98c7d8 100644
--- a/arch/sh/mm/cache-sh4.c
+++ b/arch/sh/mm/cache-sh4.c
@@ -43,7 +43,7 @@ static void (*__flush_dcache_segment_fn)(unsigned long, unsigned long)   * Called from kernel/module.c:sys_init_module and routine for a.out format,
  * signal handler code and kprobes code
  */
-static void sh4_flush_icache_range(void *args)
+static void __uses_jump_to_uncached sh4_flush_icache_range(void *args)
 {
 	struct flusher_data *data = args;
 	unsigned long start, end;
diff --git a/arch/sh/mm/cache-sh7705.c b/arch/sh/mm/cache-sh7705.c
index 2cadee2..2601935 100644
--- a/arch/sh/mm/cache-sh7705.c
+++ b/arch/sh/mm/cache-sh7705.c
@@ -78,7 +78,7 @@ static void sh7705_flush_icache_range(void *args)
 /*
  * Writeback&Invalidate the D-cache of the page
  */
-static void __flush_dcache_page(unsigned long phys)
+static void __uses_jump_to_uncached __flush_dcache_page(unsigned long phys)
 {
 	unsigned long ways, waysize, addrstart;
 	unsigned long flags;
@@ -144,7 +144,7 @@ static void sh7705_flush_dcache_page(void *arg)
 		__flush_dcache_page(PHYSADDR(page_address(page)));
 }
 
-static void sh7705_flush_cache_all(void *args)
+static void __uses_jump_to_uncached sh7705_flush_cache_all(void *args)
 {
 	unsigned long flags;
 
-- 
1.6.3.3

