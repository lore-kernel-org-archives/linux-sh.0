From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Fri, 17 Jan 2014 18:11:37 +0000
Subject: [PATCH 3/4] i2c: rcar: do not print error if device nacks transfer
Message-Id: <1389982298-23143-4-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1389982298-23143-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1389982298-23143-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@lists.codethink.co.uk
Cc: linux-sh@vger.kernel.org, horms+renesas@verge.net.au, Ben Dooks <ben.dooks@codethink.co.uk>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

The i2c-rcar driver currently prints an error message if the master_xfer
callback fails. However if the bus is being probed then lots of NAKs
will be generated, causing the output of a number of errors printed.

To solve this, disable the print if the error is not -EREMOTEIO.

An example of running i2cdetect:

10: i2c-rcar e6530000.i2c: error -121 : 15
-- i2c-rcar e6530000.i2c: error -121 : 15
-- 12 i2c-rcar e6530000.i2c: error -121 : 15
-- i2c-rcar e6530000.i2c: error -121 : 15
-- i2c-rcar e6530000.i2c: error -121 : 15
-- i2c-rcar e6530000.i2c: error -121 : 15
-- i2c-rcar e6530000.i2c: error -121 : 15
-- i2c-rcar e6530000.i2c: error -121 : 15

Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/i2c/busses/i2c-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 2c2fd7c..0d25104 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -623,7 +623,7 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 
 	pm_runtime_put(dev);
 
-	if (ret < 0)
+	if (ret < 0 && ret != -EREMOTEIO)
 		dev_err(dev, "error %d : %x\n", ret, priv->flags);
 
 	return ret;
-- 
1.8.5.2

