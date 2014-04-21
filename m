From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 21 Apr 2014 14:13:02 +0000
Subject: [PATCH 2/9] iommu/ipmmu-vmsa: Fix the supported page sizes
Message-Id: <1398089589-9181-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1398089589-9181-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1398089589-9181-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The hardware supports 2MB page sizes, not 1MB.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/ipmmu-vmsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 1e0a757..1ae97d8 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -977,7 +977,7 @@ static struct iommu_ops ipmmu_ops = {
 	.iova_to_phys = ipmmu_iova_to_phys,
 	.add_device = ipmmu_add_device,
 	.remove_device = ipmmu_remove_device,
-	.pgsize_bitmap = SZ_1M | SZ_64K | SZ_4K,
+	.pgsize_bitmap = SZ_2M | SZ_64K | SZ_4K,
 };
 
 /* -----------------------------------------------------------------------------
-- 
1.8.3.2

