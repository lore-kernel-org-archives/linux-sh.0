From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 29 Jan 2015 17:33:16 +0000
Subject: [PATCH] i2c: sh_mobile: terminate DMA reads properly
Message-Id: <1422552796-11315-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

DMA read requests could miss proper termination, so two more bytes would
have been read via PIO overwriting the end of the buffer with wrong
data. Make DMA stop handling more readable while we are here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 440d5dbc8b5f..007818b3e174 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -139,6 +139,7 @@ struct sh_mobile_i2c_data {
 	int pos;
 	int sr;
 	bool send_stop;
+	bool stop_after_dma;
 
 	struct resource *res;
 	struct dma_chan *dma_tx;
@@ -407,7 +408,7 @@ static int sh_mobile_i2c_isr_tx(struct sh_mobile_i2c_data *pd)
 
 	if (pd->pos = pd->msg->len) {
 		/* Send stop if we haven't yet (DMA case) */
-		if (pd->send_stop && (iic_rd(pd, ICCR) & ICCR_BBSY))
+		if (pd->send_stop && pd->stop_after_dma)
 			i2c_op(pd, OP_TX_STOP, 0);
 		return 1;
 	}
@@ -449,6 +450,13 @@ static int sh_mobile_i2c_isr_rx(struct sh_mobile_i2c_data *pd)
 		real_pos = pd->pos - 2;
 
 		if (pd->pos = pd->msg->len) {
+			if (pd->stop_after_dma) {
+				/* Simulate PIO end condition after DMA transfer */
+				i2c_op(pd, OP_RX_STOP, 0);
+				pd->pos++;
+				break;
+			}
+
 			if (real_pos < 0) {
 				i2c_op(pd, OP_RX_STOP, 0);
 				break;
@@ -536,6 +544,7 @@ static void sh_mobile_i2c_dma_callback(void *data)
 
 	sh_mobile_i2c_dma_unmap(pd);
 	pd->pos = pd->msg->len;
+	pd->stop_after_dma = true;
 
 	iic_set_clr(pd, ICIC, 0, ICIC_TDMAE | ICIC_RDMAE);
 }
@@ -726,6 +735,7 @@ static int sh_mobile_i2c_xfer(struct i2c_adapter *adapter,
 		bool do_start = pd->send_stop || !i;
 		msg = &msgs[i];
 		pd->send_stop = i = num - 1 || msg->flags & I2C_M_STOP;
+		pd->stop_after_dma = false;
 
 		err = start_ch(pd, msg, do_start);
 		if (err)
-- 
2.1.4

