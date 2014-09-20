From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 20 Sep 2014 10:07:37 +0000
Subject: [PATCH] i2c: rcar: remove sign-compare flaw
Message-Id: <1411207657-23707-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

gcc rightfully says:

drivers/i2c/busses/i2c-rcar.c:198:10: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 4c6fa78063fb..1eed463662c4 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -195,7 +195,7 @@ static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv,
 	 */
 	rate = clk_get_rate(priv->clk);
 	cdf = rate / 20000000;
-	if (cdf >= 1 << cdf_width) {
+	if (cdf >= 1U << cdf_width) {
 		dev_err(dev, "Input clock %lu too high\n", rate);
 		return -EIO;
 	}
-- 
2.0.0

