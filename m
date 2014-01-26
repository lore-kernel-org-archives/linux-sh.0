From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Sun, 26 Jan 2014 16:05:37 +0000
Subject: [PATCH 6/6] i2c: rcar: fix NACK error code
Message-Id: <1390752337-22386-7-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1390752337-22386-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1390752337-22386-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@lists.codethink.co.uk
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Wolfram Sang <wsa@the-dreams.de>, Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <damm@opensource.se>, linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org

The response to a bus NACK is to return -ENXIO instead of the
-EREMOTEIO being currently returned by the driver.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Magnus Damm <damm@opensource.se>
Cc: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org
---
 drivers/i2c/busses/i2c-rcar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index dc8c224..fa16adf 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -599,7 +599,7 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 		 * error handling
 		 */
 		if (rcar_i2c_flags_has(priv, ID_NACK)) {
-			ret = -EREMOTEIO;
+			ret = -ENXIO;
 			break;
 		}
 
@@ -618,7 +618,7 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 
 	pm_runtime_put(dev);
 
-	if (ret < 0 && ret != -EREMOTEIO)
+	if (ret < 0 && ret != -ENXIO)
 		dev_err(dev, "error %d : %x\n", ret, priv->flags);
 
 	return ret;
-- 
1.8.5.2

