From: Matt Fleming <matt@console-pimps.org>
Date: Tue, 06 Oct 2009 21:22:30 +0000
Subject: [PATCH 10/14] sh: Remap physical memory into P1 and P2 in pmb_init()
Message-Id: <f73fcabe42c61f38746864646b8d60dcb1465318.1254861984.git.matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Eventually we'll have complete control over what physical memory gets
mapped where and we can probably do other interesting things. For now
though, when the MMU is in 32-bit mode, we map physical memory into the
P1 and P2 virtual address ranges with the same semantics as they have in
29-bit mode.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/include/asm/io.h |    4 +-
 arch/sh/mm/consistent.c  |    2 +-
 arch/sh/mm/pmb.c         |   54 ++++++++++++---------------------------------
 3 files changed, 18 insertions(+), 42 deletions(-)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 5be45ea..0cf2a57 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -246,7 +246,7 @@ void __iounmap(void __iomem *addr);
 static inline void __iomem *
 __ioremap_mode(unsigned long offset, unsigned long size, unsigned long flags)
 {
-#if defined(CONFIG_SUPERH32) && !defined(CONFIG_PMB_FIXED)
+#if defined(CONFIG_SUPERH32) && !defined(CONFIG_PMB_FIXED) && !defined(CONFIG_PMB)
 	unsigned long last_addr = offset + size - 1;
 #endif
 	void __iomem *ret;
@@ -255,7 +255,7 @@ __ioremap_mode(unsigned long offset, unsigned long size, unsigned long flags)
 	if (ret)
 		return ret;
 
-#if defined(CONFIG_SUPERH32) && !defined(CONFIG_PMB_FIXED)
+#if defined(CONFIG_SUPERH32) && !defined(CONFIG_PMB_FIXED) && !defined(CONFIG_PMB)
 	/*
 	 * For P1 and P2 space this is trivial, as everything is already
 	 * mapped. Uncached access for P1 addresses are done through P2.
diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index e098ec1..9a8403d 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -85,7 +85,7 @@ EXPORT_SYMBOL(dma_free_coherent);
 void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 		    enum dma_data_direction direction)
 {
-#ifdef CONFIG_CPU_SH5
+#if defined(CONFIG_CPU_SH5) || defined(CONFIG_PMB)
 	void *p1addr = vaddr;
 #else
 	void *p1addr = (void*) P1SEGADDR((unsigned long)vaddr);
diff --git a/arch/sh/mm/pmb.c b/arch/sh/mm/pmb.c
index a3c0dfa..f13a18c 100644
--- a/arch/sh/mm/pmb.c
+++ b/arch/sh/mm/pmb.c
@@ -38,26 +38,6 @@ static void __pmb_unmap(struct pmb_entry *);
 static struct pmb_entry pmb_entry_list[NR_PMB_ENTRIES];
 static unsigned long pmb_map;
 
-static struct pmb_entry pmb_init_map[] = {
-	/* vpn         ppn         flags (ub/sz/c/wt) */
-
-	/* P1 Section Mappings */
-	{ 0x80000000, 0x00000000, PMB_SZ_64M  | PMB_C, },
-	{ 0x84000000, 0x04000000, PMB_SZ_64M  | PMB_C, },
-	{ 0x88000000, 0x08000000, PMB_SZ_128M | PMB_C, },
-	{ 0x90000000, 0x10000000, PMB_SZ_64M  | PMB_C, },
-	{ 0x94000000, 0x14000000, PMB_SZ_64M  | PMB_C, },
-	{ 0x98000000, 0x18000000, PMB_SZ_64M  | PMB_C, },
-
-	/* P2 Section Mappings */
-	{ 0xa0000000, 0x00000000, PMB_UB | PMB_SZ_64M  | PMB_WT, },
-	{ 0xa4000000, 0x04000000, PMB_UB | PMB_SZ_64M  | PMB_WT, },
-	{ 0xa8000000, 0x08000000, PMB_UB | PMB_SZ_128M | PMB_WT, },
-	{ 0xb0000000, 0x10000000, PMB_UB | PMB_SZ_64M  | PMB_WT, },
-	{ 0xb4000000, 0x14000000, PMB_UB | PMB_SZ_64M  | PMB_WT, },
-	{ 0xb8000000, 0x18000000, PMB_UB | PMB_SZ_64M  | PMB_WT, },
-};
-
 static inline unsigned long mk_pmb_entry(unsigned int entry)
 {
 	return (entry & PMB_E_MASK) << PMB_E_SHIFT;
@@ -156,13 +136,7 @@ static void __uses_jump_to_uncached clear_pmb_entry(struct pmb_entry *pmbe)
 	unsigned int entry = pmbe->entry;
 	unsigned long addr;
 
-	/*
-	 * Don't allow clearing of wired init entries, P1 or P2 access
-	 * without a corresponding mapping in the PMB will lead to reset
-	 * by the TLB.
-	 */
-	if (unlikely(entry < ARRAY_SIZE(pmb_init_map) ||
-		     entry >= NR_PMB_ENTRIES))
+	if (unlikely(entry >= NR_PMB_ENTRIES))
 		return;
 
 	jump_to_uncached();
@@ -293,28 +267,30 @@ static void __pmb_unmap(struct pmb_entry *pmbe)
 
 int __uses_jump_to_uncached pmb_init(void)
 {
-	unsigned int nr_entries = ARRAY_SIZE(pmb_init_map);
-	unsigned int entry, i;
-
-	BUG_ON(unlikely(nr_entries >= NR_PMB_ENTRIES));
+	unsigned int i;
+	long size;
 
 	jump_to_uncached();
 
 	/*
-	 * Ordering is important, P2 must be mapped in the PMB before we
-	 * can set PMB.SE, and P1 must be mapped before we jump back to
-	 * P1 space.
+	 * Insert PMB entries for the P1 and P2 areas so that, after
+	 * we've switched the MMU to 32-bit mode, the semantics of P1
+	 * and P2 are the same as in 29-bit mode, e.g.
+	 *
+	 *	P1 - provides a cached window onto physical memory
+	 *	P2 - provides an uncached window onto physical memory
 	 */
-	for (entry = 0; entry < nr_entries; entry++) {
-		struct pmb_entry *pmbe = pmb_init_map + entry;
+	size = pmb_remap(P2SEG, __MEMORY_START, __MEMORY_SIZE,
+			 PMB_WT | PMB_UB);
+	BUG_ON(size != __MEMORY_SIZE);
 
-		__set_pmb_entry(pmbe->vpn, pmbe->ppn, pmbe->flags, entry);
-	}
+	size = pmb_remap(P1SEG, __MEMORY_START, __MEMORY_SIZE, PMB_C);
+	BUG_ON(size != __MEMORY_SIZE);
 
 	ctrl_outl(0, PMB_IRMCR);
 
 	/* PMB.SE and UB[7] */
-	ctrl_outl((1 << 31) | (1 << 7), PMB_PASCR);
+	ctrl_outl(PASCR_SE | (1 << 7), PMB_PASCR);
 
 	/* Flush out the TLB */
 	i =  ctrl_inl(MMUCR);
-- 
1.6.3.3

