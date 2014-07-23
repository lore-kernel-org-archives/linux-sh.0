From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 23 Jul 2014 10:13:27 +0000
Subject: [PATCH] dmaengine: rcar-dmac: Filter out channels from unrelated devices
Message-Id: <1406110407-16858-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Not only does the filter function need to ignore channels from DMA
engines handled by other drivers, it also needs to ignore channels
belonging to unrelated DMACs as DMA DT bindings reference a specific DMA
engine. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/dma/sh/rcar-dmac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

This patch applies to the R-Car Gen2 DMAC driver posted as "[PATCH v2 0/8]
R-Car Gen2 DMA Controller driver". It doesn't depend on the hardware
descriptor list support ("[PATCH/RFC 0/5] R-Car Gen2 DMAC hardware descriptor
list support").

Morimoto-san, I believe this should fix your channel request problem with the
snd_soc_rcar driver.

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index c314a6c..4e7321c 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1444,7 +1444,7 @@ static irqreturn_t rcar_dmac_isr_error(int irq, void *data)
 static bool rcar_dmac_chan_filter(struct dma_chan *chan, void *arg)
 {
 	struct rcar_dmac *dmac = to_rcar_dmac(chan->device);
-	unsigned int id = (unsigned int)arg;
+	struct of_phandle_args *dma_spec = arg;
 
 	/*
 	 * FIXME: Using a filter on OF platforms is a nonsense. The OF xlate
@@ -1453,10 +1453,11 @@ static bool rcar_dmac_chan_filter(struct dma_chan *chan, void *arg)
 	 * Forcing it to call dma_request_channel() and iterate through all
 	 * channels from all controllers is just pointless.
 	 */
-	if (chan->device->device_control != rcar_dmac_control)
+	if (chan->device->device_control != rcar_dmac_control ||
+	    dma_spec->np != chan->device->dev->of_node)
 		return false;
 
-	return !test_and_set_bit(id, dmac->modules);
+	return !test_and_set_bit(dma_spec->args[0], dmac->modules);
 }
 
 static struct dma_chan *rcar_dmac_of_xlate(struct of_phandle_args *dma_spec,
@@ -1473,8 +1474,7 @@ static struct dma_chan *rcar_dmac_of_xlate(struct of_phandle_args *dma_spec,
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	chan = dma_request_channel(mask, rcar_dmac_chan_filter,
-				   (void *)dma_spec->args[0]);
+	chan = dma_request_channel(mask, rcar_dmac_chan_filter, dma_spec);
 	if (!chan)
 		return NULL;
 
-- 
Regards,

Laurent Pinchart

