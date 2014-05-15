From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 15 May 2014 10:40:43 +0000
Subject: [PATCH v2 02/10] iommu/ipmmu-vmsa: Cleanup failures of ARM mapping creation or attachment
Message-Id: <1400150451-13469-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1400150451-13469-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1400150451-13469-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/ipmmu-vmsa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 49e00f7..49dbedd 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -917,7 +917,8 @@ static int ipmmu_add_device(struct device *dev)
 							SZ_1G, SZ_2G);
 		if (IS_ERR(mapping)) {
 			dev_err(mmu->dev, "failed to create ARM IOMMU mapping\n");
-			return PTR_ERR(mapping);
+			ret = PTR_ERR(mapping);
+			goto error;
 		}
 
 		mmu->mapping = mapping;
@@ -933,6 +934,7 @@ static int ipmmu_add_device(struct device *dev)
 	return 0;
 
 error:
+	arm_iommu_release_mapping(mmu->mapping);
 	kfree(dev->archdata.iommu);
 	dev->archdata.iommu = NULL;
 	iommu_group_remove_device(dev);
-- 
1.8.5.5

