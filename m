From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 31 Jul 2013 13:21:46 +0000
Subject: [PATCH v2 02/23] drm/rcar-du: Use devm_ioremap_resource()
Message-Id: <1375276927-20181-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1375276927-20181-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375276927-20181-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Replace the devm_request_mem_region() and devm_ioremap_nocache() calls
with devm_ioremap_resource().

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index dc0fe09..f776b1c 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -107,7 +107,6 @@ static int rcar_du_load(struct drm_device *dev, unsigned long flags)
 	struct platform_device *pdev = dev->platformdev;
 	struct rcar_du_platform_data *pdata = pdev->dev.platform_data;
 	struct rcar_du_device *rcdu;
-	struct resource *ioarea;
 	struct resource *mem;
 	int ret;
 
@@ -129,24 +128,9 @@ static int rcar_du_load(struct drm_device *dev, unsigned long flags)
 
 	/* I/O resources and clocks */
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (mem = NULL) {
-		dev_err(&pdev->dev, "failed to get memory resource\n");
-		return -EINVAL;
-	}
-
-	ioarea = devm_request_mem_region(&pdev->dev, mem->start,
-					 resource_size(mem), pdev->name);
-	if (ioarea = NULL) {
-		dev_err(&pdev->dev, "failed to request memory region\n");
-		return -EBUSY;
-	}
-
-	rcdu->mmio = devm_ioremap_nocache(&pdev->dev, ioarea->start,
-					  resource_size(ioarea));
-	if (rcdu->mmio = NULL) {
-		dev_err(&pdev->dev, "failed to remap memory resource\n");
-		return -ENOMEM;
-	}
+	rcdu->mmio = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(rcdu->mmio))
+		return PTR_ERR(rcdu->mmio);
 
 	rcdu->clock = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(rcdu->clock)) {
-- 
1.8.1.5

