From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 26 Apr 2013 15:47:17 +0000
Subject: [PATCH 1/3] mmc: sdhi/tmio: make DMA filter implementation specific
Message-Id: <1366991239-22602-2-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1366991239-22602-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1366991239-22602-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Samuel Ortiz <sameo@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

So far only the SDHI implementation uses TMIO MMC with DMA. That way a DMA
channel filter function, defined in the TMIO driver wasn't a problem.
However, such a filter function is DMA controller specific. Since the SDHI
glue is only running on systems with the SHDMA DMA controller, the filter
function can safely be provided by it. Move it into SDHI.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c |    9 +++++++++
 drivers/mmc/host/tmio_mmc_dma.c   |   12 ++----------
 include/linux/mfd/tmio.h          |    3 +++
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index fe90853..e0088d7 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -20,6 +20,7 @@
 
 #include <linux/kernel.h>
 #include <linux/clk.h>
+#include <linux/dmaengine.h>
 #include <linux/slab.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -124,6 +125,13 @@ static void sh_mobile_sdhi_cd_wakeup(const struct platform_device *pdev)
 	mmc_detect_change(dev_get_drvdata(&pdev->dev), msecs_to_jiffies(100));
 }
 
+static bool sh_mobile_sdhi_filter(struct dma_chan *chan, void *arg)
+{
+	dev_dbg(chan->device->dev, "%s: slave data %p\n", __func__, arg);
+	chan->private = arg;
+	return true;
+}
+
 static const struct sh_mobile_sdhi_ops sdhi_ops = {
 	.cd_wakeup = sh_mobile_sdhi_cd_wakeup,
 };
@@ -191,6 +199,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 			priv->dma_priv.chan_priv_tx = &priv->param_tx.shdma_slave;
 			priv->dma_priv.chan_priv_rx = &priv->param_rx.shdma_slave;
 			priv->dma_priv.alignment_shift = 1; /* 2-byte alignment */
+			priv->dma_priv.filter = sh_mobile_sdhi_filter;
 			mmc_data->dma = &priv->dma_priv;
 		}
 	}
diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index fff9286..dc4b10b 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -261,14 +261,6 @@ out:
 	spin_unlock_irq(&host->lock);
 }
 
-/* It might be necessary to make filter MFD specific */
-static bool tmio_mmc_filter(struct dma_chan *chan, void *arg)
-{
-	dev_dbg(chan->device->dev, "%s: slave data %p\n", __func__, arg);
-	chan->private = arg;
-	return true;
-}
-
 void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdata)
 {
 	/* We can only either use DMA for both Tx and Rx or not use it at all */
@@ -281,7 +273,7 @@ void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdat
 		dma_cap_zero(mask);
 		dma_cap_set(DMA_SLAVE, mask);
 
-		host->chan_tx = dma_request_channel(mask, tmio_mmc_filter,
+		host->chan_tx = dma_request_channel(mask, pdata->dma->filter,
 						    pdata->dma->chan_priv_tx);
 		dev_dbg(&host->pdev->dev, "%s: TX: got channel %p\n", __func__,
 			host->chan_tx);
@@ -289,7 +281,7 @@ void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdat
 		if (!host->chan_tx)
 			return;
 
-		host->chan_rx = dma_request_channel(mask, tmio_mmc_filter,
+		host->chan_rx = dma_request_channel(mask, pdata->dma->filter,
 						    pdata->dma->chan_priv_rx);
 		dev_dbg(&host->pdev->dev, "%s: RX: got channel %p\n", __func__,
 			host->chan_rx);
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 99bf3e66..0990d8a 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -81,10 +81,13 @@ int tmio_core_mmc_resume(void __iomem *cnf, int shift, unsigned long base);
 void tmio_core_mmc_pwr(void __iomem *cnf, int shift, int state);
 void tmio_core_mmc_clk_div(void __iomem *cnf, int shift, int state);
 
+struct dma_chan;
+
 struct tmio_mmc_dma {
 	void *chan_priv_tx;
 	void *chan_priv_rx;
 	int alignment_shift;
+	bool (*filter)(struct dma_chan *chan, void *arg);
 };
 
 struct tmio_mmc_host;
-- 
1.7.2.5

