From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 20 Jun 2015 19:03:22 +0000
Subject: [PATCH 4/4] i2c: sh_mobile: use proper type for timeout
Message-Id: <1434827002-25918-5-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1434827002-25918-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1434827002-25918-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

wait_event_timeout returns long, not int.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 5490bfb58f3e80..47659a925e09cd 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -730,7 +730,8 @@ static int sh_mobile_i2c_xfer(struct i2c_adapter *adapter,
 	struct sh_mobile_i2c_data *pd = i2c_get_adapdata(adapter);
 	struct i2c_msg	*msg;
 	int err = 0;
-	int i, k;
+	int i;
+	long timeout;
 
 	activate_ch(pd);
 
@@ -749,10 +750,10 @@ static int sh_mobile_i2c_xfer(struct i2c_adapter *adapter,
 			i2c_op(pd, OP_START, 0);
 
 		/* The interrupt handler takes care of the rest... */
-		k = wait_event_timeout(pd->wait,
+		timeout = wait_event_timeout(pd->wait,
 				       pd->sr & (ICSR_TACK | SW_DONE),
 				       adapter->timeout);
-		if (!k) {
+		if (!timeout) {
 			dev_err(pd->dev, "Transfer request timed out\n");
 			if (pd->dma_direction != DMA_NONE)
 				sh_mobile_i2c_cleanup_dma(pd);
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
