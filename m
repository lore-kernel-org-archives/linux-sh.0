From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 15 Dec 2014 00:13:43 +0000
Subject: [PATCH 04/10] iommu/ipmmu-vmsa: Return proper error if devm_request_irq fails
Message-Id: <1418602429-11276-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418602429-11276-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1418602429-11276-1-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: Axel Lin <axel.lin@ingics.com>

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/ipmmu-vmsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 9838d119045d..70bb5ba2aa51 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1187,7 +1187,7 @@ static int ipmmu_probe(struct platform_device *pdev)
 			       dev_name(&pdev->dev), mmu);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to request IRQ %d\n", irq);
-		return irq;
+		return ret;
 	}
 
 	ipmmu_device_reset(mmu);
-- 
2.0.4

