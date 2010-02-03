From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 03 Feb 2010 15:03:54 +0000
Subject: [PATCH 3/4] dmaengine: add runtime PM support to the shdma driver
Message-Id: <Pine.LNX.4.64.1002031559390.6324@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Provided platforms implement runtime PM, this disables the controller, when not
in use.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/dma/shdma.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index 3498cab..7e7ce10 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -24,7 +24,10 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+
 #include <asm/sh-dmaengine.h>
+
 #include "shdma.h"
 
 /* DMA descriptor control */
@@ -266,6 +269,8 @@ static int sh_dmae_alloc_chan_resources(struct dma_chan *chan)
 	struct sh_desc *desc;
 	struct sh_dmae_slave *param = chan->private;
 
+	pm_runtime_get_sync(sh_chan->dev);
+
 	/*
 	 * This relies on the guarantee from dmaengine that alloc_chan_resources
 	 * never runs concurrently with itself or free_chan_resources.
@@ -308,6 +313,9 @@ static int sh_dmae_alloc_chan_resources(struct dma_chan *chan)
 	}
 	spin_unlock_bh(&sh_chan->desc_lock);
 
+	if (!sh_chan->descs_allocated)
+		pm_runtime_put(sh_chan->dev);
+
 	return sh_chan->descs_allocated;
 }
 
@@ -319,6 +327,7 @@ static void sh_dmae_free_chan_resources(struct dma_chan *chan)
 	struct sh_dmae_chan *sh_chan = to_sh_chan(chan);
 	struct sh_desc *desc, *_desc;
 	LIST_HEAD(list);
+	int descs = sh_chan->descs_allocated;
 
 	dmae_halt(sh_chan);
 
@@ -339,6 +348,9 @@ static void sh_dmae_free_chan_resources(struct dma_chan *chan)
 
 	spin_unlock_bh(&sh_chan->desc_lock);
 
+	if (descs > 0)
+		pm_runtime_put(sh_chan->dev);
+
 	list_for_each_entry_safe(desc, _desc, &list, node)
 		kfree(desc);
 }
@@ -920,6 +932,9 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
 	/* platform data */
 	shdev->pdata = pdata;
 
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
+
 	/* reset dma controller */
 	err = sh_dmae_rst(shdev);
 	if (err)
@@ -970,6 +985,8 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
 			goto chan_probe_err;
 	}
 
+	pm_runtime_put(&pdev->dev);
+
 	platform_set_drvdata(pdev, shdev);
 	dma_async_device_register(&shdev->common);
 
@@ -982,6 +999,7 @@ eirq_err:
 	free_irq(errirq, shdev);
 
 rst_err:
+	pm_runtime_put(&pdev->dev);
 	if (dmars)
 		iounmap(shdev->dmars);
 emapdmars:
@@ -1015,6 +1033,8 @@ static int __exit sh_dmae_remove(struct platform_device *pdev)
 	/* channel data remove */
 	sh_dmae_chan_remove(shdev);
 
+	pm_runtime_disable(&pdev->dev);
+
 	if (shdev->dmars)
 		iounmap(shdev->dmars);
 	iounmap(shdev->chan_reg);
-- 
1.6.2.4

