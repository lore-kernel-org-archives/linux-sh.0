From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 10 Dec 2014 13:13:01 +0000
Subject: [PATCH] i2c: sh_mobile: remove unneeded DMA mask
Message-Id: <1418217181-25647-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

We don't need the mask since we obtain the channels via DT.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 429778280b6d..b9c8cf2aac2c 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -752,14 +752,11 @@ MODULE_DEVICE_TABLE(of, sh_mobile_i2c_dt_ids);
 static int sh_mobile_i2c_request_dma_chan(struct device *dev, enum dma_transfer_direction dir,
 					  dma_addr_t port_addr, struct dma_chan **chan_ptr)
 {
-	dma_cap_mask_t mask;
 	struct dma_chan *chan;
 	struct dma_slave_config cfg;
 	char *chan_name = dir = DMA_MEM_TO_DEV ? "tx" : "rx";
 	int ret;
 
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
 	*chan_ptr = NULL;
 
 	chan = dma_request_slave_channel_reason(dev, chan_name);
-- 
2.1.3

