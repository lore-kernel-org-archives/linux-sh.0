From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 11 Feb 2010 16:50:18 +0000
Subject: [PATCH 4/5] dmaengine: add runtime PM support to the shdma driver
Message-Id: <Pine.LNX.4.64.1002111738260.4484@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Provided platforms implement runtime PM, this disables the controller, when not
in use.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

No change - version 1 perserved.

 drivers/dma/shdma.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index b419afa..ea6779f 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -24,7 +24,10 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+
 #include <asm/dmaengine.h>
+
 #include "shdma.h"
 
 /* DMA descriptor control */
@@ -287,6 +290,8 @@ static int sh_dmae_alloc_chan_resources(struct dma_chan *chan)
 	struct sh_desc *desc;
 	struct sh_dmae_slave *param = chan->private;
 
+	pm_runtime_get_sync(sh_chan->dev);
+
 	/*
 	 * This relies on the guarantee from dmaengine that alloc_chan_resources
 	 * never runs concurrently with itself or free_chan_resources.
@@ -328,6 +333,9 @@ static int sh_dmae_alloc_chan_resources(struct dma_chan *chan)
 	}
 	spin_unlock_bh(&sh_chan->desc_lock);
 
+	if (!sh_chan->descs_allocated)
+		pm_runtime_put(sh_chan->dev);
+
 	return sh_chan->descs_allocated;
 }
 
@@ -339,6 +347,7 @@ static void sh_dmae_free_chan_resources(struct dma_chan *chan)
 	struct sh_dmae_chan *sh_chan = to_sh_chan(chan);
 	struct sh_desc *desc, *_desc;
 	LIST_HEAD(list);
+	int descs = sh_chan->descs_allocated;
 
 	dmae_halt(sh_chan);
 
@@ -359,6 +368,9 @@ static void sh_dmae_free_chan_resources(struct dma_chan *chan)
 
 	spin_unlock_bh(&sh_chan->desc_lock);
 
+	if (descs > 0)
+		pm_runtime_put(sh_chan->dev);
+
 	list_for_each_entry_safe(desc, _desc, &list, node)
 		kfree(desc);
 }
@@ -978,6 +990,9 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
 	/* platform data */
 	shdev->pdata = pdata;
 
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
+
 	/* reset dma controller */
 	err = sh_dmae_rst(shdev);
 	if (err)
@@ -1066,6 +1081,8 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
 			goto chan_probe_err;
 	}
 
+	pm_runtime_put(&pdev->dev);
+
 	platform_set_drvdata(pdev, shdev);
 	dma_async_device_register(&shdev->common);
 
@@ -1079,6 +1096,7 @@ eirqres:
 eirq_err:
 #endif
 rst_err:
+	pm_runtime_put(&pdev->dev);
 	if (dmars)
 		iounmap(shdev->dmars);
 emapdmars:
@@ -1108,6 +1126,8 @@ static int __exit sh_dmae_remove(struct platform_device *pdev)
 	/* channel data remove */
 	sh_dmae_chan_remove(shdev);
 
+	pm_runtime_disable(&pdev->dev);
+
 	if (shdev->dmars)
 		iounmap(shdev->dmars);
 	iounmap(shdev->chan_reg);
-- 
1.6.2.4

