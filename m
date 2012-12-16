From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 16 Dec 2012 17:25:50 +0000
Subject: [PATCH/WIP/RFC 04/14] shmobile-iommu: Use devm_* managed functions
Message-Id: <1355678760-27357-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1350290093-998-1-git-send-email-hdk@igel.co.jp>
 <1355678760-27357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1355678760-27357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/shmobile-ipmmu.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/shmobile-ipmmu.c b/drivers/iommu/shmobile-ipmmu.c
index 2339f91..d6df0b4 100644
--- a/drivers/iommu/shmobile-ipmmu.c
+++ b/drivers/iommu/shmobile-ipmmu.c
@@ -116,16 +116,16 @@ static int ipmmu_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "cannot get platform resources\n");
 		return -ENOENT;
 	}
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
 		dev_err(&pdev->dev, "cannot allocate device data\n");
 		return -ENOMEM;
 	}
 	mutex_init(&priv->flush_lock);
-	priv->ipmmu_base = ioremap_nocache(res->start, resource_size(res));
+	priv->ipmmu_base = devm_ioremap_nocache(&pdev->dev, res->start,
+						resource_size(res));
 	if (!priv->ipmmu_base) {
 		dev_err(&pdev->dev, "ioremap_nocache failed\n");
-		kfree(priv);
 		return -ENOMEM;
 	}
 	platform_set_drvdata(pdev, priv);
-- 
1.7.8.6

