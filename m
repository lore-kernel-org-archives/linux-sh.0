From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 02 Apr 2014 23:49:22 +0000
Subject: [PATCH 3/3] iommu/shmobile: Use devm_ioremap_resource()
Message-Id: <1396482562-1851-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1396482562-1851-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1396482562-1851-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org

Replace the devm_ioremap_nocache() call with devm_ioremap_resource().
This simplifies error checking.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/shmobile-ipmmu.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/shmobile-ipmmu.c b/drivers/iommu/shmobile-ipmmu.c
index 6ba6110..bd97ade 100644
--- a/drivers/iommu/shmobile-ipmmu.c
+++ b/drivers/iommu/shmobile-ipmmu.c
@@ -94,11 +94,6 @@ static int ipmmu_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct shmobile_ipmmu_platform_data *pdata = pdev->dev.platform_data;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "cannot get platform resources\n");
-		return -ENOENT;
-	}
 	ipmmu = devm_kzalloc(&pdev->dev, sizeof(*ipmmu), GFP_KERNEL);
 	if (!ipmmu) {
 		dev_err(&pdev->dev, "cannot allocate device data\n");
@@ -106,12 +101,12 @@ static int ipmmu_probe(struct platform_device *pdev)
 	}
 	spin_lock_init(&ipmmu->flush_lock);
 	ipmmu->dev = &pdev->dev;
-	ipmmu->ipmmu_base = devm_ioremap_nocache(&pdev->dev, res->start,
-						resource_size(res));
-	if (!ipmmu->ipmmu_base) {
-		dev_err(&pdev->dev, "ioremap_nocache failed\n");
-		return -ENOMEM;
-	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ipmmu->ipmmu_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(ipmmu->ipmmu_base))
+		return PTR_ERR(ipmmu->ipmmu_base);
+
 	ipmmu->dev_names = pdata->dev_names;
 	ipmmu->num_dev_names = pdata->num_dev_names;
 	platform_set_drvdata(pdev, ipmmu);
-- 
1.8.3.2

