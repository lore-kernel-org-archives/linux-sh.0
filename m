From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 10 Dec 2014 13:21:49 +0000
Subject: [RFC 2/2] i2c: sh_mobile: rework deferred probing
Message-Id: <1418217709-26392-3-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1418217709-26392-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1418217709-26392-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

DMA is opt-in for this driver. So, we can't use deferred probing in
probe, because our driver would get endlessly deferred if DMA support is
compiled in but only the DMA driver is missing. Because we can't know
when the DMA driver might show up, we always try again when a DMA
transfer would be possible. The downside is that there is more overhead
for setting up every DMA transfer.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 98 +++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 50 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 636f2297143a..ea7b99212fa6 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -144,6 +144,7 @@ struct sh_mobile_i2c_data {
 	int sr;
 	bool send_stop;
 
+	struct resource *res;
 	struct dma_chan *dma_tx;
 	struct dma_chan *dma_rx;
 	struct scatterlist sg;
@@ -543,6 +544,41 @@ static void sh_mobile_i2c_dma_callback(void *data)
 	iic_set_clr(pd, ICIC, 0, ICIC_TDMAE | ICIC_RDMAE);
 }
 
+static struct dma_chan *sh_mobile_i2c_request_dma_chan(struct device *dev,
+				enum dma_transfer_direction dir, dma_addr_t port_addr)
+{
+	struct dma_chan *chan;
+	struct dma_slave_config cfg;
+	char *chan_name = dir = DMA_MEM_TO_DEV ? "tx" : "rx";
+	int ret;
+
+	chan = dma_request_slave_channel_reason(dev, chan_name);
+	if (IS_ERR(chan)) {
+		dev_dbg(dev, "request_channel failed for %s (%d)\n", chan_name, ret);
+		return chan;
+	}
+
+	memset(&cfg, 0, sizeof(cfg));
+	cfg.direction = dir;
+	if (dir = DMA_MEM_TO_DEV) {
+		cfg.dst_addr = port_addr;
+		cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	} else {
+		cfg.src_addr = port_addr;
+		cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	}
+
+	ret = dmaengine_slave_config(chan, &cfg);
+	if (ret) {
+		dev_dbg(dev, "slave_config failed for %s (%d)\n", chan_name, ret);
+		dma_release_channel(chan);
+		return ERR_PTR(ret);
+	}
+
+	dev_dbg(dev, "got DMA channel for %s\n", chan_name);
+	return chan;
+}
+
 static void sh_mobile_i2c_xfer_dma(struct sh_mobile_i2c_data *pd)
 {
 	bool read = pd->msg->flags & I2C_M_RD;
@@ -552,6 +588,15 @@ static void sh_mobile_i2c_xfer_dma(struct sh_mobile_i2c_data *pd)
 	dma_addr_t dma_addr;
 	dma_cookie_t cookie;
 
+	if (PTR_ERR(chan) = -EPROBE_DEFER) {
+		if (read)
+			chan = pd->dma_rx = sh_mobile_i2c_request_dma_chan(pd->dev, DMA_DEV_TO_MEM,
+							     pd->res->start + ICDR);
+		else
+			chan = pd->dma_tx = sh_mobile_i2c_request_dma_chan(pd->dev, DMA_MEM_TO_DEV,
+							     pd->res->start + ICDR);
+	}
+
 	if (IS_ERR(chan))
 		return;
 
@@ -749,41 +794,6 @@ static const struct of_device_id sh_mobile_i2c_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, sh_mobile_i2c_dt_ids);
 
-static struct dma_chan *sh_mobile_i2c_request_dma_chan(struct device *dev,
-				enum dma_transfer_direction dir, dma_addr_t port_addr)
-{
-	struct dma_chan *chan;
-	struct dma_slave_config cfg;
-	char *chan_name = dir = DMA_MEM_TO_DEV ? "tx" : "rx";
-	int ret;
-
-	chan = dma_request_slave_channel_reason(dev, chan_name);
-	if (IS_ERR(chan)) {
-		dev_dbg(dev, "request_channel failed for %s (%d)\n", chan_name, ret);
-		return chan;
-	}
-
-	memset(&cfg, 0, sizeof(cfg));
-	cfg.direction = dir;
-	if (dir = DMA_MEM_TO_DEV) {
-		cfg.dst_addr = port_addr;
-		cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
-	} else {
-		cfg.src_addr = port_addr;
-		cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
-	}
-
-	ret = dmaengine_slave_config(chan, &cfg);
-	if (ret) {
-		dev_dbg(dev, "slave_config failed for %s (%d)\n", chan_name, ret);
-		dma_release_channel(chan);
-		return ERR_PTR(ret);
-	}
-
-	dev_dbg(dev, "got DMA channel for %s\n", chan_name);
-	return chan;
-}
-
 static void sh_mobile_i2c_release_dma(struct sh_mobile_i2c_data *pd)
 {
 	if (!IS_ERR(pd->dma_tx)) {
@@ -846,6 +856,7 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 
 	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
 
+	pd->res = res;
 	pd->reg = devm_ioremap_resource(&dev->dev, res);
 	if (IS_ERR(pd->reg))
 		return PTR_ERR(pd->reg);
@@ -886,19 +897,7 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 	/* Init DMA */
 	sg_init_table(&pd->sg, 1);
 	pd->dma_direction = DMA_NONE;
-	pd->dma_rx = sh_mobile_i2c_request_dma_chan(pd->dev, DMA_DEV_TO_MEM,
-					     res->start + ICDR);
-	ret = PTR_ERR(pd->dma_rx);
-	if (ret = -EPROBE_DEFER)
-		return ret;
-
-	pd->dma_tx = sh_mobile_i2c_request_dma_chan(pd->dev, DMA_MEM_TO_DEV,
-					     res->start + ICDR);
-	ret = PTR_ERR(pd->dma_tx);
-	if (ret = -EPROBE_DEFER) {
-		sh_mobile_i2c_release_dma(pd);
-		return ret;
-	}
+	pd->dma_rx = pd->dma_tx = ERR_PTR(-EPROBE_DEFER);
 
 	/* Enable Runtime PM for this device.
 	 *
@@ -936,8 +935,7 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 		return ret;
 	}
 
-	dev_info(&dev->dev, "I2C adapter %d, bus speed %lu Hz, DMA=%c\n",
-		 adap->nr, pd->bus_speed, (pd->dma_rx || pd->dma_tx) ? 'y' : 'n');
+	dev_info(&dev->dev, "I2C adapter %d, bus speed %lu Hz\n", adap->nr, pd->bus_speed);
 
 	return 0;
 }
-- 
2.1.3

