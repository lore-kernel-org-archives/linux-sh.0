From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 10 Nov 2008 08:30:11 +0000
Subject: Re: repeated oops under load on SH4 system
Message-Id: <20081110083011.GA17279@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <fd0635d10811040431l45e7b41fvee0a78650b15bacc@mail.gmail.com>
In-Reply-To: <fd0635d10811040431l45e7b41fvee0a78650b15bacc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Nov 10, 2008 at 05:11:59PM +0900, Paul Mundt wrote:
> On Mon, Nov 10, 2008 at 05:06:23PM +0900, Paul Mundt wrote:
> > On Tue, Nov 04, 2008 at 09:31:44PM +0900, CHIKAMA Masaki wrote:
> > > Hello all.
> > > 
> > > I've got repeated oops message  under a load on kernel 2.6.26.7.
> > > It happens once or twice per a week with the below message.
> > > 
> > > >Unable to handle kernel paging request at virtual address dfff0700
> > > >Unable to handle kernel paging request at virtual address dfff1000
> > > >Unable to handle kernel paging request at virtual address dfff0a00
> > > 
> > > I have been gotten this message from around kernel 2.6.23. I didn't
> > > test before it.
> > > My hardware is mach-landisk with attached .config.
> > > The root file system is on nfs server.
> > > Please let me know if  you need more information to investigating the problem.
> > > Could somebody give me a hint to resolve the issue ?
> > > 
> > > Thanks in advance.
> > > 
> > This suggests you are getting a TLB miss on various fixmap entries. Based
> > on your call chain, these are related to the cache colouring in the page
> > copying. update_mmu_cache() specifically faults the translation in, so
> > you should not be making it all the way up to the TLB miss handler in the
> > first place. This points to something evicting the entry from the TLB
> > during your copy, which while it is not something I have seen in
> > practice, is interesting to know that it remains a possibility under
> > other workloads. A simple but expensive fix for this would be blowing out
> > the TLB and speculatively bumping up the UTLB replace boundary prior to
> > pre-faulting the fixmap translation. I'll look at this some more over the
> > next couple days and send you a patch for testing.
> 
> Now I remember where I saw this before.. try this patch:
> 
> http://marc.info/?l=linux-sh&m0400865707505&w=2
> 
> There was never any feedback on it, and I was not able to reproduce the
> issues.

Updated version, against current git:

---

 arch/sh/include/asm/pgtable.h |    6 ++++++
 arch/sh/mm/init.c             |   12 +++++++++---
 arch/sh/mm/pg-sh4.c           |   17 +++++++++++++++++
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/sh/include/asm/pgtable.h b/arch/sh/include/asm/pgtable.h
index 52220d7..b517ae0 100644
--- a/arch/sh/include/asm/pgtable.h
+++ b/arch/sh/include/asm/pgtable.h
@@ -148,6 +148,12 @@ extern void paging_init(void);
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
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 4abf000..6cbef8c 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -137,6 +137,7 @@ void __init page_table_range_init(unsigned long start, unsigned long end,
 void __init paging_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES];
+	unsigned long vaddr;
 	int nid;
 
 	/* We don't need to map the kernel through the TLB, as
@@ -148,10 +149,15 @@ void __init paging_init(void)
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
index 38870e0..2fe14da 100644
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
 
+#define kmap_get_fixmap_pte(vaddr)                                     \
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
 
