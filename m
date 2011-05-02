From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 02 May 2011 07:59:02 +0000
Subject: [PATCH/RFC] dmaengine: shdma: synchronize RCU before freeing, simplify
Message-Id: <Pine.LNX.4.64.1105020950420.13244@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

List elements, deleted using list_del_rcu(), cannot be freed without
synchronising RCU. Further, the spinlock, used to protect the RCU
writer, is called in process context, so, we don't have to save flags.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Paul, you added the NMI handler to shdma, using RCU and a global spinlock. 
Please, have a look, whether this patch is correct.

 drivers/dma/shdma.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index d50da41..b7f27f5 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -1045,7 +1045,6 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
 	struct sh_dmae_pdata *pdata = pdev->dev.platform_data;
 	unsigned long irqflags = IRQF_DISABLED,
 		chan_flag[SH_DMAC_MAX_CHANNELS] = {};
-	unsigned long flags;
 	int errirq, chan_irq[SH_DMAC_MAX_CHANNELS];
 	int err, i, irq_cnt = 0, irqres = 0;
 	struct sh_dmae_device *shdev;
@@ -1111,9 +1110,9 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
-	spin_lock_irqsave(&sh_dmae_lock, flags);
+	spin_lock_irq(&sh_dmae_lock);
 	list_add_tail_rcu(&shdev->node, &sh_dmae_devices);
-	spin_unlock_irqrestore(&sh_dmae_lock, flags);
+	spin_unlock_irq(&sh_dmae_lock);
 
 	/* reset dma controller */
 	err = sh_dmae_rst(shdev);
@@ -1218,15 +1217,16 @@ eirqres:
 eirq_err:
 #endif
 rst_err:
-	spin_lock_irqsave(&sh_dmae_lock, flags);
+	spin_lock_irq(&sh_dmae_lock);
 	list_del_rcu(&shdev->node);
-	spin_unlock_irqrestore(&sh_dmae_lock, flags);
+	spin_unlock_irq(&sh_dmae_lock);
 
 	pm_runtime_put(&pdev->dev);
 	if (dmars)
 		iounmap(shdev->dmars);
 emapdmars:
 	iounmap(shdev->chan_reg);
+	synchronize_rcu();
 emapchan:
 	kfree(shdev);
 ealloc:
@@ -1242,7 +1242,6 @@ static int __exit sh_dmae_remove(struct platform_device *pdev)
 {
 	struct sh_dmae_device *shdev = platform_get_drvdata(pdev);
 	struct resource *res;
-	unsigned long flags;
 	int errirq = platform_get_irq(pdev, 0);
 
 	dma_async_device_unregister(&shdev->common);
@@ -1250,9 +1249,9 @@ static int __exit sh_dmae_remove(struct platform_device *pdev)
 	if (errirq > 0)
 		free_irq(errirq, shdev);
 
-	spin_lock_irqsave(&sh_dmae_lock, flags);
+	spin_lock_irq(&sh_dmae_lock);
 	list_del_rcu(&shdev->node);
-	spin_unlock_irqrestore(&sh_dmae_lock, flags);
+	spin_unlock_irq(&sh_dmae_lock);
 
 	/* channel data remove */
 	sh_dmae_chan_remove(shdev);
@@ -1263,6 +1262,7 @@ static int __exit sh_dmae_remove(struct platform_device *pdev)
 		iounmap(shdev->dmars);
 	iounmap(shdev->chan_reg);
 
+	synchronize_rcu();
 	kfree(shdev);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.7.2.5

