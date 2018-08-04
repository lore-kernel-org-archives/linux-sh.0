From: Matthew Wilcox <willy@infradead.org>
Date: Sat, 04 Aug 2018 10:51:49 +0000
Subject: Re: [PATCH] sh: remove unneeded constructor.
Message-Id: <20180804105149.GB3183@bombadil.infradead.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20180731051519.101249-1-ysato@users.sourceforge.jp>
 <CAMuHMdUQReuzR=x54gnC1XdP77RrT1TaWoFFXUhUQ02A+giPqQ@mail.gmail.com>
 <87600us5k9.wl-ysato@users.sourceforge.jp>
 <20180804103550.GA3183@bombadil.infradead.org>
 <CAMuHMdXsz-+zsxouaLP5tTKA46G34iAACSce+RXrD8AiiQc2+A@mail.gmail.com>
In-Reply-To: <CAMuHMdXsz-+zsxouaLP5tTKA46G34iAACSce+RXrD8AiiQc2+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Rob Landley <rob@landley.net>, Linux-Arch <linux-arch@vger.kernel.org>

On Sat, Aug 04, 2018 at 12:47:08PM +0200, Geert Uytterhoeven wrote:
> You do want to readd the __GFP_ZERO flag to the second user of PGALLOC_GFP,
> don't you?

I missed that!  Probably only relevant for SH-64.  But yes ... probably better
to make this explicit then:

+++ b/arch/sh/mm/pgtable.c
@@ -2,8 +2,6 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 
-#define PGALLOC_GFP GFP_KERNEL | __GFP_ZERO
-
 static struct kmem_cache *pgd_cachep;
 #if PAGETABLE_LEVELS > 2
 static struct kmem_cache *pmd_cachep;
@@ -13,6 +11,7 @@ void pgd_ctor(void *x)
 {
        pgd_t *pgd = x;
 
+       memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
        memcpy(pgd + USER_PTRS_PER_PGD,
               swapper_pg_dir + USER_PTRS_PER_PGD,
               (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
@@ -32,7 +31,7 @@ void pgtable_cache_init(void)
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-       return kmem_cache_alloc(pgd_cachep, PGALLOC_GFP);
+       return kmem_cache_alloc(pgd_cachep, GFP_KERNEL);
 }
 
 void pgd_free(struct mm_struct *mm, pgd_t *pgd)
@@ -48,7 +47,7 @@ void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 
 pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-       return kmem_cache_alloc(pmd_cachep, PGALLOC_GFP);
+       return kmem_cache_alloc(pmd_cachep, GFP_KERNEL | __GFP_ZERO);
 }
 
 void pmd_free(struct mm_struct *mm, pmd_t *pmd)

