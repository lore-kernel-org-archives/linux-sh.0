From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 05 Jul 2012 10:29:38 +0000
Subject: [PATCH 2/7 v2] ASoC: siu: don't use DMA device for channel filtering
Message-Id: <1341484183-10757-3-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1341484183-10757-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1341484183-10757-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

DMA channels are filtered based on slave IDs, no need to additionally filter
on DMA device.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/sh/siu_pcm.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/siu_pcm.c b/sound/soc/sh/siu_pcm.c
index 3fdc801..488f9be 100644
--- a/sound/soc/sh/siu_pcm.c
+++ b/sound/soc/sh/siu_pcm.c
@@ -332,9 +332,6 @@ static bool filter(struct dma_chan *chan, void *slave)
 
 	pr_debug("%s: slave ID %d\n", __func__, param->shdma_slave.slave_id);
 
-	if (unlikely(param->dma_dev != chan->device->dev))
-		return false;
-
 	chan->private = &param->shdma_slave;
 	return true;
 }
@@ -369,7 +366,6 @@ static int siu_pcm_open(struct snd_pcm_substream *ss)
 			pdata->dma_slave_rx_a;
 	}
 
-	param->dma_dev = pdata->dma_dev;
 	/* Get DMA channel */
 	siu_stream->chan = dma_request_channel(mask, filter, param);
 	if (!siu_stream->chan) {
-- 
1.7.2.5

