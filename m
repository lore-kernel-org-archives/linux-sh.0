From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 17 Jan 2013 09:45:55 +0000
Subject: [PATCH 2/4] i2c: sh_mobile: fix timeout error handling
Message-Id: <1358415957-8371-3-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1358415957-8371-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1358415957-8371-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>

In a timeout case return an error immediately from the driver's
.master_xfer() method, instead of continuing and letting higher layers
fail.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/i2c/busses/i2c-sh_mobile.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 3b08b4e..69a1fbe 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -521,8 +521,11 @@ static int sh_mobile_i2c_xfer(struct i2c_adapter *adapter,
 		k = wait_event_timeout(pd->wait,
 				       pd->sr & (ICSR_TACK | SW_DONE),
 				       5 * HZ);
-		if (!k)
+		if (!k) {
 			dev_err(pd->dev, "Transfer request timed out\n");
+			err = -ETIMEDOUT;
+			break;
+		}
 
 		retry_count = 1000;
 again:
-- 
1.7.2.5

