From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 19 Nov 2014 12:43:22 +0000
Subject: [PATCH] i2c: sh_mobile: use proper device for mapping DMA memory
Message-Id: <1416401002-18128-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

It should be the DMA device, not the platform device.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 903bb22aa5b4..c2362a4bec25 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -511,6 +511,17 @@ static irqreturn_t sh_mobile_i2c_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void sh_mobile_i2c_dma_unmap(struct sh_mobile_i2c_data *pd)
+{
+	struct dma_chan *chan = pd->dma_direction = DMA_FROM_DEVICE
+				? pd->dma_rx : pd->dma_tx;
+
+	dma_unmap_single(chan->device->dev, sg_dma_address(&pd->sg),
+			 pd->msg->len, pd->dma_direction);
+
+	pd->dma_direction = DMA_NONE;
+}
+
 static void sh_mobile_i2c_cleanup_dma(struct sh_mobile_i2c_data *pd)
 {
 	if (pd->dma_direction = DMA_NONE)
@@ -520,20 +531,14 @@ static void sh_mobile_i2c_cleanup_dma(struct sh_mobile_i2c_data *pd)
 	else if (pd->dma_direction = DMA_TO_DEVICE)
 		dmaengine_terminate_all(pd->dma_tx);
 
-	dma_unmap_single(pd->dev, sg_dma_address(&pd->sg),
-			 pd->msg->len, pd->dma_direction);
-
-	pd->dma_direction = DMA_NONE;
+	sh_mobile_i2c_dma_unmap(pd);
 }
 
 static void sh_mobile_i2c_dma_callback(void *data)
 {
 	struct sh_mobile_i2c_data *pd = data;
 
-	dma_unmap_single(pd->dev, sg_dma_address(&pd->sg),
-			 pd->msg->len, pd->dma_direction);
-
-	pd->dma_direction = DMA_NONE;
+	sh_mobile_i2c_dma_unmap(pd);
 	pd->pos = pd->msg->len;
 
 	iic_set_clr(pd, ICIC, 0, ICIC_TDMAE | ICIC_RDMAE);
@@ -551,7 +556,7 @@ static void sh_mobile_i2c_xfer_dma(struct sh_mobile_i2c_data *pd)
 	if (!chan)
 		return;
 
-	dma_addr = dma_map_single(pd->dev, pd->msg->buf, pd->msg->len, dir);
+	dma_addr = dma_map_single(chan->device->dev, pd->msg->buf, pd->msg->len, dir);
 	if (dma_mapping_error(pd->dev, dma_addr)) {
 		dev_dbg(pd->dev, "dma map failed, using PIO\n");
 		return;
-- 
2.1.1

