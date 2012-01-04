From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 04 Jan 2012 14:34:17 +0000
Subject: [PATCH 1/2] dma: shdma: fix runtime PM: clear channel buffers on
Message-Id: <Pine.LNX.4.64.1201041532290.30506@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1201041528570.30506@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1201041528570.30506@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Magnus Damm <magnus.damm@gmail.com>

On platforms, supporting power domains, if the domain, containing a DMAC
instance is powered down, the driver fails to resume correctly. On those
platforms DMAC channels have an additional CHCLR register for clearing
channel buffers. Using this register during runtime resume fixes the
problem.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/dma/shdma.c    |   47 +++++++++++++++++++++++++++++++----------------
 include/linux/sh_dma.h |    2 ++
 2 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index 81809c2..e1a2fa6 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -57,6 +57,15 @@ static LIST_HEAD(sh_dmae_devices);
 static unsigned long sh_dmae_slave_used[BITS_TO_LONGS(SH_DMA_SLAVE_NUMBER)];
 
 static void sh_dmae_chan_ld_cleanup(struct sh_dmae_chan *sh_chan, bool all);
+static void sh_chan_xfer_ld_queue(struct sh_dmae_chan *sh_chan);
+
+static void chclr_write(struct sh_dmae_chan *sh_dc, u32 data)
+{
+	struct sh_dmae_device *shdev = to_sh_dev(sh_dc);
+
+	__raw_writel(data, shdev->chan_reg +
+		     shdev->pdata->channel[sh_dc->id].chclr_offset);
+}
 
 static void sh_dmae_writel(struct sh_dmae_chan *sh_dc, u32 data, u32 reg)
 {
@@ -129,6 +138,15 @@ static int sh_dmae_rst(struct sh_dmae_device *shdev)
 
 	dmaor = dmaor_read(shdev) & ~(DMAOR_NMIF | DMAOR_AE | DMAOR_DME);
 
+	if (shdev->pdata->chclr_present) {
+		int i;
+		for (i = 0; i < shdev->pdata->channel_num; i++) {
+			struct sh_dmae_chan *sh_chan = shdev->chan[i];
+			if (sh_chan)
+				chclr_write(sh_chan, 0);
+		}
+	}
+
 	dmaor_write(shdev, dmaor | shdev->pdata->dmaor_init);
 
 	dmaor = dmaor_read(shdev);
@@ -139,6 +157,10 @@ static int sh_dmae_rst(struct sh_dmae_device *shdev)
 		dev_warn(shdev->common.dev, "Can't initialize DMAOR.\n");
 		return -EIO;
 	}
+	if (shdev->pdata->dmaor_init & ~dmaor)
+		dev_warn(shdev->common.dev,
+			 "DMAOR=0x%x hasn't latched the initial value 0x%x.\n",
+			 dmaor, shdev->pdata->dmaor_init);
 	return 0;
 }
 
@@ -259,8 +281,6 @@ static int dmae_set_dmars(struct sh_dmae_chan *sh_chan, u16 val)
 	return 0;
 }
 
-static void sh_chan_xfer_ld_queue(struct sh_dmae_chan *sh_chan);
-
 static dma_cookie_t sh_dmae_tx_submit(struct dma_async_tx_descriptor *tx)
 {
 	struct sh_desc *desc = tx_to_sh_desc(tx), *chunk, *last = desc, *c;
@@ -340,6 +360,8 @@ static dma_cookie_t sh_dmae_tx_submit(struct dma_async_tx_descriptor *tx)
 				sh_chan_xfer_ld_queue(sh_chan);
 			sh_chan->pm_state = DMAE_PM_ESTABLISHED;
 		}
+	} else {
+		sh_chan->pm_state = DMAE_PM_PENDING;
 	}
 
 	spin_unlock_irq(&sh_chan->desc_lock);
@@ -1225,6 +1247,8 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, shdev);
 
+	shdev->common.dev = &pdev->dev;
+
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
@@ -1254,7 +1278,6 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
 	shdev->common.device_prep_slave_sg = sh_dmae_prep_slave_sg;
 	shdev->common.device_control = sh_dmae_control;
 
-	shdev->common.dev = &pdev->dev;
 	/* Default transfer size of 32 bytes requires 32-byte alignment */
 	shdev->common.copy_align = LOG2_DEFAULT_XFER_SIZE;
 
@@ -1435,22 +1458,17 @@ static int sh_dmae_runtime_resume(struct device *dev)
 #ifdef CONFIG_PM
 static int sh_dmae_suspend(struct device *dev)
 {
-	struct sh_dmae_device *shdev = dev_get_drvdata(dev);
-	int i;
-
-	for (i = 0; i < shdev->pdata->channel_num; i++) {
-		struct sh_dmae_chan *sh_chan = shdev->chan[i];
-		if (sh_chan->descs_allocated)
-			sh_chan->pm_error = pm_runtime_put_sync(dev);
-	}
-
 	return 0;
 }
 
 static int sh_dmae_resume(struct device *dev)
 {
 	struct sh_dmae_device *shdev = dev_get_drvdata(dev);
-	int i;
+	int i, ret;
+
+	ret = sh_dmae_rst(shdev);
+	if (ret < 0)
+		dev_err(dev, "Failed to reset!\n");
 
 	for (i = 0; i < shdev->pdata->channel_num; i++) {
 		struct sh_dmae_chan *sh_chan = shdev->chan[i];
@@ -1459,9 +1477,6 @@ static int sh_dmae_resume(struct device *dev)
 		if (!sh_chan->descs_allocated)
 			continue;
 
-		if (!sh_chan->pm_error)
-			pm_runtime_get_sync(dev);
-
 		if (param) {
 			const struct sh_dmae_slave_config *cfg = param->config;
 			dmae_set_dmars(sh_chan, cfg->mid_rid);
diff --git a/include/linux/sh_dma.h b/include/linux/sh_dma.h
index cb2dd11..e11e171 100644
--- a/include/linux/sh_dma.h
+++ b/include/linux/sh_dma.h
@@ -48,6 +48,7 @@ struct sh_dmae_channel {
 	unsigned int	offset;
 	unsigned int	dmars;
 	unsigned int	dmars_bit;
+	unsigned int	chclr_offset;
 };
 
 struct sh_dmae_pdata {
@@ -68,6 +69,7 @@ struct sh_dmae_pdata {
 	unsigned int dmaor_is_32bit:1;
 	unsigned int needs_tend_set:1;
 	unsigned int no_dmars:1;
+	unsigned int chclr_present:1;
 };
 
 /* DMA register */
-- 
1.7.2.5

