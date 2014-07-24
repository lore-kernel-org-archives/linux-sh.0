From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 24 Jul 2014 15:27:05 +0000
Subject: [PATCH 3/3] iommu/ipmmu-vmsa: Invalidate TLB after unmapping
Message-Id: <1406215625-13982-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1406215625-13982-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1406215625-13982-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org

The TLB must be invalidated after unmapping memory to remove stale TLB
entries. this was supposed to be performed already, but a bug in the
driver prevented the TLB invalidate function from being called. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/ipmmu-vmsa.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index eb605e5..a010e47 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -784,7 +784,6 @@ static int ipmmu_clear_mapping(struct ipmmu_vmsa_domain *domain,
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
-	int ret = 0;
 
 	if (!pgd)
 		return -EINVAL;
@@ -846,8 +845,7 @@ static int ipmmu_clear_mapping(struct ipmmu_vmsa_domain *domain,
 done:
 	spin_unlock_irqrestore(&domain->lock, flags);
 
-	if (ret)
-		ipmmu_tlb_invalidate(domain);
+	ipmmu_tlb_invalidate(domain);
 
 	return 0;
 }
-- 
1.8.5.5

