From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 24 Jul 2014 15:27:04 +0000
Subject: [PATCH 2/3] iommu/ipmmu-vmsa: Flush P[UM]D entry before freeing the child page table
Message-Id: <1406215625-13982-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1406215625-13982-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1406215625-13982-1-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

When clearing PUD or PMD entries the child page table (if any) is freed
and the PUD or PMD entry is then cleared. This result in a small race
condition window during which a free page table could be accessed by the
IPMMU.

Fix it by clearing and flushing the PUD or PMD entry before freeing the
child page table.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/ipmmu-vmsa.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 7dc77a6..eb605e5 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -678,30 +678,32 @@ done:
 
 static void ipmmu_clear_pud(struct ipmmu_vmsa_device *mmu, pud_t *pud)
 {
-	/* Free the page table. */
 	pgtable_t table = pud_pgtable(*pud);
-	__free_page(table);
 
 	/* Clear the PUD. */
 	*pud = __pud(0);
 	ipmmu_flush_pgtable(mmu, pud, sizeof(*pud));
+
+	/* Free the page table. */
+	__free_page(table);
 }
 
 static void ipmmu_clear_pmd(struct ipmmu_vmsa_device *mmu, pud_t *pud,
 			    pmd_t *pmd)
 {
+	pmd_t pmdval = *pmd;
 	unsigned int i;
 
-	/* Free the page table. */
-	if (pmd_table(*pmd)) {
-		pgtable_t table = pmd_pgtable(*pmd);
-		__free_page(table);
-	}
-
 	/* Clear the PMD. */
 	*pmd = __pmd(0);
 	ipmmu_flush_pgtable(mmu, pmd, sizeof(*pmd));
 
+	/* Free the page table. */
+	if (pmd_table(pmdval)) {
+		pgtable_t table = pmd_pgtable(pmdval);
+		__free_page(table);
+	}
+
 	/* Check whether the PUD is still needed. */
 	pmd = pmd_offset(pud, 0);
 	for (i = 0; i < IPMMU_PTRS_PER_PMD; ++i) {
-- 
1.8.5.5

