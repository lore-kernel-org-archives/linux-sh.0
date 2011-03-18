From: Prasad Joshi <prasadjoshi124@gmail.com>
Date: Fri, 18 Mar 2011 19:53:07 +0000
Subject: Re: [RFC][PATCH v3 07/22] mm, sh: add gfp flags variant of pmd and
Message-Id: <20110318195307.GH4746@prasad-kvm>
List-Id: <linux-sh.vger.kernel.org>
References: <20110318194135.GA4746@prasad-kvm>
 <20110318194341.GB4746@prasad-kvm>
 <20110318194600.GC4746@prasad-kvm>
 <20110318194740.GD4746@prasad-kvm>
 <20110318194929.GE4746@prasad-kvm>
 <20110318195035.GF4746@prasad-kvm>
 <20110318195141.GG4746@prasad-kvm>
In-Reply-To: <20110318195141.GG4746@prasad-kvm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lethal@linux-sh.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, prasadjoshi124@gmail.com, mitra@kqinfotech.com


- Added __pte_alloc_one_kernel() function to allow caller to allocation flag.
   Like pte_alloc_one_kernel() this newly added function calls
   quicklist_alloc() and passes the allocation flag down the call hierarchy.

- The function pte_alloc_one_kernel() is modified to call
  __pte_alloc_one_kernel() using the correct allocation flag.

- Similar changes for pmd allocations. Added function __pmd_alloc_one().

- The changes help in fixing the Bug 30702.

Signed-off-by: Prasad Joshi <prasadjoshi124@gmail.com>
Signed-off-by: Anand Mitra <mitra@kqinfotech.com>
---
 arch/sh/include/asm/pgalloc.h |    8 +++++++-
 arch/sh/mm/pgtable.c          |    8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
index 8c00785..aaed989 100644
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -31,10 +31,16 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 /*
  * Allocate and free page tables.
  */
+static inline pte_t *__pte_alloc_one_kernel(struct mm_struct *mm,
+					  unsigned long address, gfp_t gfp_mask)
+{
+	return quicklist_alloc(QUICK_PT, gfp_mask, NULL);
+}
+
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
 					  unsigned long address)
 {
-	return quicklist_alloc(QUICK_PT, GFP_KERNEL | __GFP_REPEAT, NULL);
+	return __pte_alloc_one_kernel(mm, address, GFP_KERNEL | __GFP_REPEAT);
 }
 
 static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
diff --git a/arch/sh/mm/pgtable.c b/arch/sh/mm/pgtable.c
index 26e03a1..b938eb8 100644
--- a/arch/sh/mm/pgtable.c
+++ b/arch/sh/mm/pgtable.c
@@ -45,9 +45,15 @@ void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 	set_pud(pud, __pud((unsigned long)pmd));
 }
 
+pmd_t *
+__pmd_alloc_one(struct mm_struct *mm, unsigned long address, gfp_t gfp_mask)
+{
+	return kmem_cache_alloc(pmd_cachep, gfp_mask | __GFP_ZERO);
+}
+
 pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	return kmem_cache_alloc(pmd_cachep, PGALLOC_GFP);
+	return __pmd_alloc_one(mm, address, GFP_KERNEL | __GFP_REPEAT);
 }
 
 void pmd_free(struct mm_struct *mm, pmd_t *pmd)
-- 
1.7.0.4

