From: Rich Felker <dalias@libc.org>
Date: Tue, 26 Apr 2016 01:22:52 +0000
Subject: [PATCH] sh: disable aliased page logic on NOMMU models
Message-Id: <20160426012252.GA3892@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SH3/4 (with MMU) have a virtually indexed cache, requiring explicit
work to avoid consistency problems arising from having the same
physical address range cached in multiple cache lines. This is
unneeded for the NOMMU case, and some of the resulting code paths
(kmap_coherent) don't work. SH2 only avoided this problem by having a
4-way associative cache with way size equal to the page size (4k),
yielding no cache index bits outside of the page offset and thus no
aliases.

Signed-off-by: Rich Felker <dalias@libc.org>
---

See also the linux-sh thread "Fixing SH cache assumptions" from March
2016. I plan to include this patch as part of the patch series for J2
support now, and in the next (4.7) merge window. If/when there are SH
models (J4?) with PIPT cache we can revisit extending the code to
handle that case, but for now just handling nommu suffices.

 arch/sh/kernel/cpu/init.c | 4 ++++
 arch/sh/mm/cache.c        | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/sh/kernel/cpu/init.c b/arch/sh/kernel/cpu/init.c
index 0d7360d..bfd9e27 100644
--- a/arch/sh/kernel/cpu/init.c
+++ b/arch/sh/kernel/cpu/init.c
@@ -323,9 +323,13 @@ asmlinkage void cpu_init(void)
 	cache_init();
 
 	if (raw_smp_processor_id() = 0) {
+#ifdef CONFIG_MMU
 		shm_align_mask = max_t(unsigned long,
 				       current_cpu_data.dcache.way_size - 1,
 				       PAGE_SIZE - 1);
+#else
+		shm_align_mask = PAGE_SIZE - 1;
+#endif
 
 		/* Boot CPU sets the cache shape */
 		detect_cache_shape();
diff --git a/arch/sh/mm/cache.c b/arch/sh/mm/cache.c
index e58cfbf..776d664 100644
--- a/arch/sh/mm/cache.c
+++ b/arch/sh/mm/cache.c
@@ -244,7 +244,11 @@ void flush_cache_sigtramp(unsigned long address)
 
 static void compute_alias(struct cache_info *c)
 {
+#ifdef CONFIG_MMU
 	c->alias_mask = ((c->sets - 1) << c->entry_shift) & ~(PAGE_SIZE - 1);
+#else
+	c->alias_mask = 0;
+#endif
 	c->n_aliases = c->alias_mask ? (c->alias_mask >> PAGE_SHIFT) + 1 : 0;
 }
 
-- 
2.8.1

