From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 28 May 2014 07:44:40 +0000
Subject: [PATCH 05/11] i2c: rcar: check bus free before first message
Message-Id: <1401263086-13720-6-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1401263086-13720-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1401263086-13720-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

We should always check if the bus is free, independently if it is a read
or write. It should be done before the first message, though. After
that, we ourselves keep the bus busy. Remove a 'ret' assignment which
only silenced a build warning.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 9757adf33f37..a97a14955ddf 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -294,15 +294,6 @@ static int rcar_i2c_recv(struct rcar_i2c_priv *priv)
 
 static int rcar_i2c_send(struct rcar_i2c_priv *priv)
 {
-	int ret;
-
-	/*
-	 * It should check bus status when send case
-	 */
-	ret = rcar_i2c_bus_barrier(priv);
-	if (ret < 0)
-		return ret;
-
 	rcar_i2c_set_addr(priv, 0);
 	rcar_i2c_status_clear(priv);
 	rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_START);
@@ -508,7 +499,10 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 	spin_unlock_irqrestore(&priv->lock, flags);
 	/*-------------- spin unlock -----------------*/
 
-	ret = -EINVAL;
+	ret = rcar_i2c_bus_barrier(priv);
+	if (ret < 0)
+		goto out;
+
 	for (i = 0; i < num; i++) {
 		/* This HW can't send STOP after address phase */
 		if (msgs[i].len = 0) {
@@ -569,7 +563,7 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 
 		ret = i + 1; /* The number of transfer */
 	}
-
+out:
 	pm_runtime_put(dev);
 
 	if (ret < 0 && ret != -ENXIO)
-- 
2.0.0.rc2

