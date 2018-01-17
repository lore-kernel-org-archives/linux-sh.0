From: Matthew Wilcox <willy@infradead.org>
Date: Wed, 17 Jan 2018 20:21:29 +0000
Subject: [PATCH v6 65/99] dax: Fix sparse warning
Message-Id: <20180117202203.19756-66-willy@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20180117202203.19756-1-willy@infradead.org>
In-Reply-To: <20180117202203.19756-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-nilfs@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>, linux-sh@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-usb@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Stefano Stabellini <sstabellini@kernel.org>, linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-btrfs@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

sparse doesn't know that follow_pte_pmd() conditionally acquires the ptl,
because it's in a separate compilation unit.  Move follow_pte_pmd() to
mm.h where sparse can see it.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 include/linux/mm.h | 15 ++++++++++++++-
 mm/memory.c        | 16 +---------------
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fe1ee4313add..9c384c486edf 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1314,7 +1314,7 @@ int copy_page_range(struct mm_struct *dst, struct mm_struct *src,
 			struct vm_area_struct *vma);
 void unmap_mapping_range(struct address_space *mapping,
 		loff_t const holebegin, loff_t const holelen, int even_cows);
-int follow_pte_pmd(struct mm_struct *mm, unsigned long address,
+int __follow_pte_pmd(struct mm_struct *mm, unsigned long address,
 			     unsigned long *start, unsigned long *end,
 			     pte_t **ptepp, pmd_t **pmdpp, spinlock_t **ptlp);
 int follow_pfn(struct vm_area_struct *vma, unsigned long address,
@@ -1324,6 +1324,19 @@ int follow_phys(struct vm_area_struct *vma, unsigned long address,
 int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 			void *buf, int len, int write);
 
+static inline int follow_pte_pmd(struct mm_struct *mm, unsigned long address,
+			     unsigned long *start, unsigned long *end,
+			     pte_t **ptepp, pmd_t **pmdpp, spinlock_t **ptlp)
+{
+	int res;
+
+	/* (void) is needed to make gcc happy */
+	(void) __cond_lock(*ptlp,
+			   !(res = __follow_pte_pmd(mm, address, start, end,
+						    ptepp, pmdpp, ptlp)));
+	return res;
+}
+
 static inline void unmap_shared_mapping_range(struct address_space *mapping,
 		loff_t const holebegin, loff_t const holelen)
 {
diff --git a/mm/memory.c b/mm/memory.c
index ca5674cbaff2..66184601ac03 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4201,7 +4201,7 @@ int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 }
 #endif /* __PAGETABLE_PMD_FOLDED */
 
-static int __follow_pte_pmd(struct mm_struct *mm, unsigned long address,
+int __follow_pte_pmd(struct mm_struct *mm, unsigned long address,
 			    unsigned long *start, unsigned long *end,
 			    pte_t **ptepp, pmd_t **pmdpp, spinlock_t **ptlp)
 {
@@ -4278,20 +4278,6 @@ static inline int follow_pte(struct mm_struct *mm, unsigned long address,
 	return res;
 }
 
-int follow_pte_pmd(struct mm_struct *mm, unsigned long address,
-			     unsigned long *start, unsigned long *end,
-			     pte_t **ptepp, pmd_t **pmdpp, spinlock_t **ptlp)
-{
-	int res;
-
-	/* (void) is needed to make gcc happy */
-	(void) __cond_lock(*ptlp,
-			   !(res = __follow_pte_pmd(mm, address, start, end,
-						    ptepp, pmdpp, ptlp)));
-	return res;
-}
-EXPORT_SYMBOL(follow_pte_pmd);
-
 /**
  * follow_pfn - look up PFN at a user virtual address
  * @vma: memory mapping
-- 
2.15.1

