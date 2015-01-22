From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Jan 2015 08:34:03 +0000
Subject: [PATCH 1/5 v6] dmaengine: shdma-base: enable to be non multiplexed DMAEngine driver
Message-Id: <87a91bkyc3.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Current shdma-base driver which was created originally for R-Mobile series
is assuming that it is working as multiplexed DMAEngine.
But, current Renesas SoC (= R-Car series) also uses non-multiplexed
DMAEngine driver (= rcar-dmac). This case, shdma-base and rcar-dmac will
have same ID on each drivers.

Then, dma_request_slave_channel_compat() will call __dma_request_channel(),
and, shdma driver might return channel which was requested as rcar-dma channel if
1) there are rcar-dmac driver user and shdma-base driver user in system
2) user driver requests rcar-dmac side channel
3) system compiles shdma-base driver only
4) user driver uses dma_request_slave_channel_compat()
5) user driver uses shdma_chan_filter in dma_request_slave_channel_compat()

This patch adds shdma_dev :: multiplexed as short term bugfix.
rcar-audmapp will be trouble without this patch.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/dma/sh/rcar-hpbdma.c |    1 +
 drivers/dma/sh/shdma-base.c  |   11 +++++++++++
 drivers/dma/sh/shdmac.c      |    1 +
 include/linux/shdma-base.h   |    1 +
 4 files changed, 14 insertions(+)

diff --git a/drivers/dma/sh/rcar-hpbdma.c b/drivers/dma/sh/rcar-hpbdma.c
index 6fef1b9..dd171e5 100644
--- a/drivers/dma/sh/rcar-hpbdma.c
+++ b/drivers/dma/sh/rcar-hpbdma.c
@@ -602,6 +602,7 @@ static int hpb_dmae_probe(struct platform_device *pdev)
 	dma_dev->directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
 	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 
+	hpbdev->shdma_dev.multiplexed = true;
 	hpbdev->shdma_dev.ops = &hpb_dmae_ops;
 	hpbdev->shdma_dev.desc_size = sizeof(struct hpb_desc);
 	err = shdma_init(&pdev->dev, &hpbdev->shdma_dev, pdata->num_channels);
diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
index 8ee383d..359eaa6 100644
--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -293,6 +293,17 @@ bool shdma_chan_filter(struct dma_chan *chan, void *arg)
 		return false;
 
 	sdev = to_shdma_dev(schan->dma_chan.device);
+
+	/*
+	 * FIXME: this is short term bug fix
+	 * dma_request_slave_channel_compat() will call
+	 * __dma_request_channel() (ex DT case)
+	 * sdhma / shdma_chan_filter doesn't have compatibility
+	 * with non multiplexed DMAC (ex rcar-dmac)
+	 */
+	if (!sdev->multiplexed)
+		return false;
+
 	ret = sdev->ops->set_slave(schan, match, 0, true);
 	if (ret < 0)
 		return false;
diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index aec8a84..d7b6ef8 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -754,6 +754,7 @@ static int sh_dmae_probe(struct platform_device *pdev)
 	/* Default transfer size of 32 bytes requires 32-byte alignment */
 	dma_dev->copy_align = LOG2_DEFAULT_XFER_SIZE;
 
+	shdev->shdma_dev.multiplexed = true;
 	shdev->shdma_dev.ops = &sh_dmae_shdma_ops;
 	shdev->shdma_dev.desc_size = sizeof(struct sh_dmae_desc);
 	err = shdma_init(&pdev->dev, &shdev->shdma_dev,
diff --git a/include/linux/shdma-base.h b/include/linux/shdma-base.h
index abdf1f2..9a9319d 100644
--- a/include/linux/shdma-base.h
+++ b/include/linux/shdma-base.h
@@ -110,6 +110,7 @@ struct shdma_dev {
 	struct shdma_chan **schan;
 	const struct shdma_ops *ops;
 	size_t desc_size;
+	bool multiplexed;
 };
 
 #define shdma_for_each_chan(c, d, i) for (i = 0, c = (d)->schan[0]; \
-- 
1.7.9.5

