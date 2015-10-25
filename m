From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Sun, 25 Oct 2015 10:09:34 +0000
Subject: [PATCH v2 2/2] dmaengine: sh: usb-dmac: Fix pm_runtime_{enable,disable}() imbalance
Message-Id: <1445767774-24001-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

If the call to pm_runtime_get_sync() failed, Runtime PM was left
enabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.

 drivers/dma/sh/usb-dmac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
index f305738b5adf8cc9..f1bcc2a163b30cef 100644
--- a/drivers/dma/sh/usb-dmac.c
+++ b/drivers/dma/sh/usb-dmac.c
@@ -802,7 +802,7 @@ static int usb_dmac_probe(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "runtime PM get sync failed (%d)\n", ret);
-		return ret;
+		goto error_pm;
 	}
 
 	ret = usb_dmac_init(dmac);
@@ -859,6 +859,7 @@ static int usb_dmac_probe(struct platform_device *pdev)
 error:
 	of_dma_controller_free(pdev->dev.of_node);
 	pm_runtime_put(&pdev->dev);
+error_pm:
 	pm_runtime_disable(&pdev->dev);
 	return ret;
 }
-- 
1.9.1

