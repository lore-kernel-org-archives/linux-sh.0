From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 16 Jun 2011 05:08:09 +0000
Subject: [PATCH 1/3 v2] dmaengine: shdma: add to_sh_dev define
Message-Id: <w3pboxyicsm.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds "to_sh_dev" macro, and clean up codes.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/dma/shdma.c |   13 ++++---------
 drivers/dma/shdma.h |    2 ++
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index 2a638f9..d2fb16d 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -130,8 +130,7 @@ static bool dmae_is_busy(struct sh_dmae_chan *sh_chan)
 
 static unsigned int calc_xmit_shift(struct sh_dmae_chan *sh_chan, u32 chcr)
 {
-	struct sh_dmae_device *shdev = container_of(sh_chan->common.device,
-						struct sh_dmae_device, common);
+	struct sh_dmae_device *shdev = to_sh_dev(sh_chan);
 	struct sh_dmae_pdata *pdata = shdev->pdata;
 	int cnt = ((chcr & pdata->ts_low_mask) >> pdata->ts_low_shift) |
 		((chcr & pdata->ts_high_mask) >> pdata->ts_high_shift);
@@ -144,8 +143,7 @@ static unsigned int calc_xmit_shift(struct sh_dmae_chan *sh_chan, u32 chcr)
 
 static u32 log2size_to_chcr(struct sh_dmae_chan *sh_chan, int l2size)
 {
-	struct sh_dmae_device *shdev = container_of(sh_chan->common.device,
-						struct sh_dmae_device, common);
+	struct sh_dmae_device *shdev = to_sh_dev(sh_chan);
 	struct sh_dmae_pdata *pdata = shdev->pdata;
 	int i;
 
@@ -209,8 +207,7 @@ static int dmae_set_chcr(struct sh_dmae_chan *sh_chan, u32 val)
 
 static int dmae_set_dmars(struct sh_dmae_chan *sh_chan, u16 val)
 {
-	struct sh_dmae_device *shdev = container_of(sh_chan->common.device,
-						struct sh_dmae_device, common);
+	struct sh_dmae_device *shdev = to_sh_dev(sh_chan);
 	struct sh_dmae_pdata *pdata = shdev->pdata;
 	const struct sh_dmae_channel *chan_pdata = &pdata->channel[sh_chan->id];
 	u16 __iomem *addr = shdev->dmars;
@@ -296,9 +293,7 @@ static struct sh_desc *sh_dmae_get_desc(struct sh_dmae_chan *sh_chan)
 static const struct sh_dmae_slave_config *sh_dmae_find_slave(
 	struct sh_dmae_chan *sh_chan, struct sh_dmae_slave *param)
 {
-	struct dma_device *dma_dev = sh_chan->common.device;
-	struct sh_dmae_device *shdev = container_of(dma_dev,
-					struct sh_dmae_device, common);
+	struct sh_dmae_device *shdev = to_sh_dev(sh_chan);
 	struct sh_dmae_pdata *pdata = shdev->pdata;
 	int i;
 
diff --git a/drivers/dma/shdma.h b/drivers/dma/shdma.h
index 5ae9fc5..6c73b65 100644
--- a/drivers/dma/shdma.h
+++ b/drivers/dma/shdma.h
@@ -52,5 +52,7 @@ struct sh_dmae_device {
 #define to_sh_chan(chan) container_of(chan, struct sh_dmae_chan, common)
 #define to_sh_desc(lh) container_of(lh, struct sh_desc, node)
 #define tx_to_sh_desc(tx) container_of(tx, struct sh_desc, async_tx)
+#define to_sh_dev(chan) container_of(chan->common.device,\
+				     struct sh_dmae_device, common)
 
 #endif	/* __DMA_SHDMA_H */
-- 
1.7.4.1

