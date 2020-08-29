From: Emin Ghuliev <eminusgh@gmail.com>
Date: Sat, 29 Aug 2020 18:38:38 +0000
Subject: [PATCH] sh: use kmem_cache_zalloc instead of kmem_cache_alloc with GFP_ZERO flag
Message-Id: <20200829183838.10166-1-eminusgh@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp
Cc: dalias@libc.org, eminusgh@gmail.com, linux-kernel@vger.kernel.org, willy@infradead.org, linux-sh@vger.kernel.org

use kmem_cache_zalloc function which does kmem_cache_alloc and zero out
instead of manually setting kmem_cache_alloc with GFP_ZERO flag.

Signed-off-by: Emin Ghuliev <eminusgh@gmail.com>
---
 arch/sh/mm/pgtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/mm/pgtable.c b/arch/sh/mm/pgtable.c
index cf7ce4b57359..6e17d921f5f5 100644
--- a/arch/sh/mm/pgtable.c
+++ b/arch/sh/mm/pgtable.c
@@ -47,7 +47,7 @@ void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 
 pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	return kmem_cache_alloc(pmd_cachep, GFP_KERNEL | __GFP_ZERO);
+	return kmem_cache_zalloc(pmd_cachep, GFP_KERNEL);
 }
 
 void pmd_free(struct mm_struct *mm, pmd_t *pmd)
-- 
2.17.1
