From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 10 Dec 2014 13:21:48 +0000
Subject: [RFC 1/2] i2c: sh_mobile: refactor DMA setup
Message-Id: <1418217709-26392-2-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1418217709-26392-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1418217709-26392-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Refactor DMA setup to keep the errno so we can implement better
deferred probe support in the next step.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index b9c8cf2aac2c..636f2297143a 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -552,7 +552,7 @@ static void sh_mobile_i2c_xfer_dma(struct sh_mobile_i2c_data *pd)
 	dma_addr_t dma_addr;
 	dma_cookie_t cookie;
 
-	if (!chan)
+	if (IS_ERR(chan))
 		return;
 
 	dma_addr = dma_map_single(chan->device->dev, pd->msg->buf, pd->msg->len, dir);
@@ -749,21 +749,18 @@ static const struct of_device_id sh_mobile_i2c_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, sh_mobile_i2c_dt_ids);
 
-static int sh_mobile_i2c_request_dma_chan(struct device *dev, enum dma_transfer_direction dir,
-					  dma_addr_t port_addr, struct dma_chan **chan_ptr)
+static struct dma_chan *sh_mobile_i2c_request_dma_chan(struct device *dev,
+				enum dma_transfer_direction dir, dma_addr_t port_addr)
 {
 	struct dma_chan *chan;
 	struct dma_slave_config cfg;
 	char *chan_name = dir = DMA_MEM_TO_DEV ? "tx" : "rx";
 	int ret;
 
-	*chan_ptr = NULL;
-
 	chan = dma_request_slave_channel_reason(dev, chan_name);
 	if (IS_ERR(chan)) {
-		ret = PTR_ERR(chan);
 		dev_dbg(dev, "request_channel failed for %s (%d)\n", chan_name, ret);
-		return ret;
+		return chan;
 	}
 
 	memset(&cfg, 0, sizeof(cfg));
@@ -780,25 +777,23 @@ static int sh_mobile_i2c_request_dma_chan(struct device *dev, enum dma_transfer_
 	if (ret) {
 		dev_dbg(dev, "slave_config failed for %s (%d)\n", chan_name, ret);
 		dma_release_channel(chan);
-		return ret;
+		return ERR_PTR(ret);
 	}
 
-	*chan_ptr = chan;
-
 	dev_dbg(dev, "got DMA channel for %s\n", chan_name);
-	return 0;
+	return chan;
 }
 
 static void sh_mobile_i2c_release_dma(struct sh_mobile_i2c_data *pd)
 {
-	if (pd->dma_tx) {
+	if (!IS_ERR(pd->dma_tx)) {
 		dma_release_channel(pd->dma_tx);
-		pd->dma_tx = NULL;
+		pd->dma_tx = ERR_PTR(-EPROBE_DEFER);
 	}
 
-	if (pd->dma_rx) {
+	if (!IS_ERR(pd->dma_rx)) {
 		dma_release_channel(pd->dma_rx);
-		pd->dma_rx = NULL;
+		pd->dma_rx = ERR_PTR(-EPROBE_DEFER);
 	}
 }
 
@@ -891,13 +886,15 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 	/* Init DMA */
 	sg_init_table(&pd->sg, 1);
 	pd->dma_direction = DMA_NONE;
-	ret = sh_mobile_i2c_request_dma_chan(pd->dev, DMA_DEV_TO_MEM,
-					     res->start + ICDR, &pd->dma_rx);
+	pd->dma_rx = sh_mobile_i2c_request_dma_chan(pd->dev, DMA_DEV_TO_MEM,
+					     res->start + ICDR);
+	ret = PTR_ERR(pd->dma_rx);
 	if (ret = -EPROBE_DEFER)
 		return ret;
 
-	ret = sh_mobile_i2c_request_dma_chan(pd->dev, DMA_MEM_TO_DEV,
-					     res->start + ICDR, &pd->dma_tx);
+	pd->dma_tx = sh_mobile_i2c_request_dma_chan(pd->dev, DMA_MEM_TO_DEV,
+					     res->start + ICDR);
+	ret = PTR_ERR(pd->dma_tx);
 	if (ret = -EPROBE_DEFER) {
 		sh_mobile_i2c_release_dma(pd);
 		return ret;
-- 
2.1.3

