From: Matt Fleming <matt@console-pimps.org>
Date: Thu, 05 Nov 2009 23:14:39 +0000
Subject: [PATCH] sh: Account for cache aliases in flush_icache_range()
Message-Id: <1257462879-16865-1-git-send-email-matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The icache may also contain aliases so we must account for them just
like we do when manipulating the dcache. We usually get away with
aliases in the icache because the instructions that are read from memory
are read-only, i.e. they never change. However, the place where this
bites us is when the code has been modified.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/mm/cache-sh4.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/sh/mm/cache-sh4.c b/arch/sh/mm/cache-sh4.c
index b5abe94..6bfd08d 100644
--- a/arch/sh/mm/cache-sh4.c
+++ b/arch/sh/mm/cache-sh4.c
@@ -65,6 +65,7 @@ static void __uses_jump_to_uncached sh4_flush_icache_range(void *args)
 
 	for (v = start; v < end; v += L1_CACHE_BYTES) {
 		unsigned long icacheaddr;
+		int j, n;
 
 		__ocbwb(v);
 
@@ -72,8 +73,10 @@ static void __uses_jump_to_uncached sh4_flush_icache_range(void *args)
 				cpu_data->icache.entry_mask);
 
 		/* Clear i-cache line valid-bit */
+		n = boot_cpu_data.icache.n_aliases;
 		for (i = 0; i < cpu_data->icache.ways; i++) {
-			__raw_writel(0, icacheaddr);
+			for (j = 0; j < n; j++)
+				__raw_writel(0, icacheaddr + (j * PAGE_SIZE));
 			icacheaddr += cpu_data->icache.way_incr;
 		}
 	}
-- 
1.6.2.5

