From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 20 Jun 2015 19:03:21 +0000
Subject: [PATCH 3/4] i2c: sh_mobile: use adapter default for timeout
Message-Id: <1434827002-25918-4-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1434827002-25918-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1434827002-25918-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

5 seconds is a very large timeout, and it is hardcoded. Use the default
timeout from 'struct adapter' which is 1 second. It can also be modified
from userspace for specific workloads via i2c-dev.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 7193bcfdd94013..5490bfb58f3e80 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -751,7 +751,7 @@ static int sh_mobile_i2c_xfer(struct i2c_adapter *adapter,
 		/* The interrupt handler takes care of the rest... */
 		k = wait_event_timeout(pd->wait,
 				       pd->sr & (ICSR_TACK | SW_DONE),
-				       5 * HZ);
+				       adapter->timeout);
 		if (!k) {
 			dev_err(pd->dev, "Transfer request timed out\n");
 			if (pd->dma_direction != DMA_NONE)
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
