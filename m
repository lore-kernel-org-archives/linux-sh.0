From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Thu, 02 Aug 2018 12:21:36 +0000
Subject: [PATCH v2] sh: Update kmem_cache_flag.
Message-Id: <20180802122136.127494-1-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

__GFP_ZERO and the constructor are exclusive relationships,
so it is incorrect to specify them at the same time.
---
 arch/sh/mm/pgtable.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sh/mm/pgtable.c b/arch/sh/mm/pgtable.c
index 5c8f9247c3c2..5a54c2bce2de 100644
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
@@ -32,7 +30,9 @@ void pgtable_cache_init(void)
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	return kmem_cache_alloc(pgd_cachep, PGALLOC_GFP);
+	pgd_t *pgd = kmem_cache_alloc(pgd_cachep, GFP_KERNEL);
+	memset(pgd, 0, kmem_cache_size(pgd_cachep));
+	return pgd;
 }
 
 void pgd_free(struct mm_struct *mm, pgd_t *pgd)
@@ -48,7 +48,7 @@ void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 
 pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	return kmem_cache_alloc(pmd_cachep, PGALLOC_GFP);
+	return kmem_cache_alloc(pmd_cachep, GFP_KERNEL | __GFP_ZERO);
 }
 
 void pmd_free(struct mm_struct *mm, pmd_t *pmd)
-- 
2.11.0

