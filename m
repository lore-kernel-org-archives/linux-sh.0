From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Tue, 31 Jul 2018 05:15:19 +0000
Subject: [PATCH] sh: remove unneeded constructor.
Message-Id: <20180731051519.101249-1-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

pgd_cache specifies __GFP_ZERO when allocating.
This constructor is meaningless.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/mm/pgtable.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/sh/mm/pgtable.c b/arch/sh/mm/pgtable.c
index 5c8f9247c3c2..4b8be7525fba 100644
--- a/arch/sh/mm/pgtable.c
+++ b/arch/sh/mm/pgtable.c
@@ -9,20 +9,11 @@ static struct kmem_cache *pgd_cachep;
 static struct kmem_cache *pmd_cachep;
 #endif
 
-void pgd_ctor(void *x)
-{
-	pgd_t *pgd = x;
-
-	memcpy(pgd + USER_PTRS_PER_PGD,
-	       swapper_pg_dir + USER_PTRS_PER_PGD,
-	       (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
-}
-
 void pgtable_cache_init(void)
 {
 	pgd_cachep = kmem_cache_create("pgd_cache",
 				       PTRS_PER_PGD * (1<<PTE_MAGNITUDE),
-				       PAGE_SIZE, SLAB_PANIC, pgd_ctor);
+				       PAGE_SIZE, SLAB_PANIC, NULL);
 #if PAGETABLE_LEVELS > 2
 	pmd_cachep = kmem_cache_create("pmd_cache",
 				       PTRS_PER_PMD * (1<<PTE_MAGNITUDE),
-- 
2.11.0

