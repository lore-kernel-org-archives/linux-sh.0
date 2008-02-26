From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 26 Feb 2008 06:49:21 +0000
Subject: Re: needs caching for fixmap
Message-Id: <20080226064921.GA21542@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080215.130631.125129853.saito@densan.co.jp>
In-Reply-To: <20080215.130631.125129853.saito@densan.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Feb 15, 2008 at 01:06:31PM +0900, Hideo Saito wrote:
> When I start up on linux-2.6.24 for SH7780, there are many assertion
> failed as follows although kernel doesn't hang up.  It seems that the
> failed address is fix-mapping pages and the entry on UTLB is replaced
> before using it at |copy_page_slow|.
> 
[snip]

> --- ./arch/sh/mm/fault.c.org	2008-01-25 07:58:37.000000000 +0900
> +++ ./arch/sh/mm/fault.c	2008-02-15 12:00:43.000000000 +0900
> @@ -266,16 +266,25 @@ asmlinkage int __kprobes __do_page_fault
>  
>  	/*
>  	 * We don't take page faults for P1, P2, and parts of P4, these
>  	 * are always mapped, whether it be due to legacy behaviour in
>  	 * 29-bit mode, or due to PMB configuration in 32-bit mode.
>  	 */
>  	if (address >= P3SEG && address < P3_ADDR_MAX) {
>  		pgd = pgd_offset_k(address);
> +		if (*(int *) pgd = 0) {
> +			pte_t get_fix_cmap_ptes(unsigned long addr);
> +
> +			entry = get_fix_cmap_ptes(address);
> +			if (!pte_none(entry)) {
> +				update_mmu_cache(NULL, address, entry);
> +				return 0;
> +			}
> +		}
>  	} else {
>  		if (unlikely(address >= TASK_SIZE || !current->mm))
>  			return 1;
>  
>  		pgd = pgd_offset(current->mm, address);
>  	}
>  
>  	pud = pud_offset(pgd, address);

We really don't want to shove this in the __do_page_fault() path. We also
do not need a cache for each of the possible colours, how does something
like this look?

---

 arch/sh/mm/init.c        |   12 +++++++++---
 arch/sh/mm/pg-sh4.c      |   17 +++++++++++++++++
 include/asm-sh/pgtable.h |    6 ++++++
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index e2ed6dd..de54536 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -169,6 +169,7 @@ void __init page_table_range_init(unsigned long start, unsigned long end,
 void __init paging_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES];
+	unsigned long vaddr;
 	int nid;
 
 	/* We don't need to map the kernel through the TLB, as
@@ -180,10 +181,15 @@ void __init paging_init(void)
 	 * check for a null value. */
 	set_TTB(swapper_pg_dir);
 
-	/* Populate the relevant portions of swapper_pg_dir so that
+	/*
+	 * Populate the relevant portions of swapper_pg_dir so that
 	 * we can use the fixmap entries without calling kmalloc.
-	 * pte's will be filled in by __set_fixmap(). */
-	page_table_range_init(FIXADDR_START, FIXADDR_TOP, swapper_pg_dir);
+	 * pte's will be filled in by __set_fixmap().
+	 */
+	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
+	page_table_range_init(vaddr, 0, swapper_pg_dir);
+
+	kmap_coherent_init();
 
 	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
 
diff --git a/arch/sh/mm/pg-sh4.c b/arch/sh/mm/pg-sh4.c
index 8c7a9ca..3ecec1d 100644
--- a/arch/sh/mm/pg-sh4.c
+++ b/arch/sh/mm/pg-sh4.c
@@ -7,6 +7,7 @@
  * Released under the terms of the GNU GPL v2.0.
  */
 #include <linux/mm.h>
+#include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/fs.h>
 #include <linux/highmem.h>
@@ -16,6 +17,20 @@
 
 #define CACHE_ALIAS (current_cpu_data.dcache.alias_mask)
 
+#define kmap_get_fixmap_pte(vaddr)					\
+	pte_offset_kernel(pmd_offset(pud_offset(pgd_offset_k(vaddr), (vaddr)), (vaddr)), (vaddr))
+
+static pte_t *kmap_coherent_pte;
+
+void __init kmap_coherent_init(void)
+{
+	unsigned long vaddr;
+
+	/* cache the first coherent kmap pte */
+	vaddr = __fix_to_virt(FIX_CMAP_BEGIN);
+	kmap_coherent_pte = kmap_get_fixmap_pte(vaddr);
+}
+
 static inline void *kmap_coherent(struct page *page, unsigned long addr)
 {
 	enum fixed_addresses idx;
@@ -34,6 +49,8 @@ static inline void *kmap_coherent(struct page *page, unsigned long addr)
 
 	update_mmu_cache(NULL, vaddr, pte);
 
+	set_pte(kmap_coherent_pte - (FIX_CMAP_END - idx), pte);
+
 	return (void *)vaddr;
 }
 
diff --git a/include/asm-sh/pgtable.h b/include/asm-sh/pgtable.h
index a4a8f8b..081c1be 100644
--- a/include/asm-sh/pgtable.h
+++ b/include/asm-sh/pgtable.h
@@ -147,6 +147,12 @@ extern void paging_init(void);
 extern void page_table_range_init(unsigned long start, unsigned long end,
 				  pgd_t *pgd);
 
+#if !defined(CONFIG_CACHE_OFF) && defined(CONFIG_CPU_SH4) && defined(CONFIG_MMU)
+extern void kmap_coherent_init(void);
+#else
+#define kmap_coherent_init()	do { } while (0)
+#endif
+
 #include <asm-generic/pgtable.h>
 
 #endif /* __ASM_SH_PGTABLE_H */
