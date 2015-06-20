From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 20 Jun 2015 18:48:23 +0000
Subject: [PATCH 1/2] i2c: rcar: use adapter default for timeout
Message-Id: <1434826104-16346-2-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1434826104-16346-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1434826104-16346-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

5 seconds is a very large timeout, and it is hardcoded. Use the default
timeout from 'struct adapter' which is 1 second. It can also be modified
from userspace for specific workloads.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 9eef46254369b3..e57e520b4756a9 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -532,7 +532,7 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 
 		timeout = wait_event_timeout(priv->wait,
 					     rcar_i2c_flags_has(priv, ID_DONE),
-					     5 * HZ);
+					     adap->timeout);
 		if (!timeout) {
 			ret = -ETIMEDOUT;
 			break;
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
