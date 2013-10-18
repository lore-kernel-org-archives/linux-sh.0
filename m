From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 18 Oct 2013 00:06:16 +0000
Subject: [PATCH 3/3 v2] rcar-hpbdma: fixup channel busy check for double plane
Message-Id: <87d2n31lze.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The device busy check method is different between
single and double planes.
It will always return "busy" without this patch
if channel was used as double plane.

Reviewed-by: Max Filippov <max.filippov@cogentembedded.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - missing define was added

 drivers/dma/sh/rcar-hpbdma.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rcar-hpbdma.c b/drivers/dma/sh/rcar-hpbdma.c
index 19af32d..3083d90 100644
--- a/drivers/dma/sh/rcar-hpbdma.c
+++ b/drivers/dma/sh/rcar-hpbdma.c
@@ -60,6 +60,7 @@
 #define HPB_DMAE_DSTPR_DMSTP	BIT(0)
 
 /* DMA status register (DSTSR) bits */
+#define HPB_DMAE_DSTSR_DQSTS	BIT(2)
 #define HPB_DMAE_DSTSR_DMSTS	BIT(0)
 
 /* DMA common registers */
@@ -388,7 +389,10 @@ static bool hpb_dmae_channel_busy(struct shdma_chan *schan)
 	struct hpb_dmae_chan *chan = to_chan(schan);
 	u32 dstsr = ch_reg_read(chan, HPB_DMAE_DSTSR);
 
-	return (dstsr & HPB_DMAE_DSTSR_DMSTS) = HPB_DMAE_DSTSR_DMSTS;
+	if (chan->xfer_mode = XFER_DOUBLE)
+		return dstsr & HPB_DMAE_DSTSR_DQSTS;
+	else
+		return dstsr & HPB_DMAE_DSTSR_DMSTS;
 }
 
 static int
-- 
1.7.9.5

