From: Matthew Wilcox <willy@infradead.org>
Date: Mon, 08 Jun 2020 13:04:08 +0000
Subject: [PATCH] sh: Fix page table allocation
Message-Id: <20200608130408.20951-1-willy@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

The pgd kmem_cache allocation both specified __GFP_ZERO and had a
constructor which makes no sense.  Remove __GFP_ZERO and zero the user
parts of the pgd explicitly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/sh/mm/pgtable.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/sh/mm/pgtable.c b/arch/sh/mm/pgtable.c
index 5c8f9247c3c2..cf7ce4b57359 100644
--- a/arch/sh/mm/pgtable.c
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
 
+	memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
 	memcpy(pgd + USER_PTRS_PER_PGD,
 	       swapper_pg_dir + USER_PTRS_PER_PGD,
 	       (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
@@ -32,7 +31,7 @@ void pgtable_cache_init(void)
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	return kmem_cache_alloc(pgd_cachep, PGALLOC_GFP);
+	return kmem_cache_alloc(pgd_cachep, GFP_KERNEL);
 }
 
 void pgd_free(struct mm_struct *mm, pgd_t *pgd)
@@ -48,7 +47,7 @@ void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 
 pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	return kmem_cache_alloc(pmd_cachep, PGALLOC_GFP);
+	return kmem_cache_alloc(pmd_cachep, GFP_KERNEL | __GFP_ZERO);
 }
 
 void pmd_free(struct mm_struct *mm, pmd_t *pmd)
-- 
2.26.2
