From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Tue, 18 Aug 2015 15:20:06 +0000
Subject: [PATCH repost] i2c: rcar: Fix order of restart and clear status
Message-Id: <1439911206-8736-1-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: Ryo Kataoka <ryo.kataoka.wt@renesas.com>

In case of repeated START condition, the restart has to be kicked
before clear status (MSR register). If it is kicked after clear status,
R-Car I2C may transfer data (TXD register) or receive data (RXD register)
instead of transferring slave address (MAR register).

Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on i2c/for-next branch of Wolfram Sang's linux tree.

 drivers/i2c/busses/i2c-rcar.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index d8361da..8cc7bd7 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -2,6 +2,7 @@
  * Driver for the Renesas RCar I2C unit
  *
  * Copyright (C) 2014 Wolfram Sang <wsa@sang-engineering.com>
+ * Copyright (C) 2013-2014 Renesas Electronics Corporation
  *
  * Copyright (C) 2012-14 Renesas Solutions Corp.
  * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
@@ -99,6 +100,7 @@
 #define ID_DONE		(1 << 2)
 #define ID_ARBLOST	(1 << 3)
 #define ID_NACK		(1 << 4)
+#define ID_FIRST_MSG	(1 << 5)
 
 enum rcar_i2c_type {
 	I2C_RCAR_GEN1,
@@ -125,6 +127,7 @@ struct rcar_i2c_priv {
 #define rcar_i2c_is_recv(p)		((p)->msg->flags & I2C_M_RD)
 
 #define rcar_i2c_flags_set(p, f)	((p)->flags |= (f))
+#define rcar_i2c_flags_clr(p, f)	((p)->flags &= ~(f))
 #define rcar_i2c_flags_has(p, f)	((p)->flags & (f))
 
 #define LOOP_TIMEOUT	1024
@@ -257,8 +260,14 @@ static void rcar_i2c_prepare_msg(struct rcar_i2c_priv *priv)
 	int read = !!rcar_i2c_is_recv(priv);
 
 	rcar_i2c_write(priv, ICMAR, (priv->msg->addr << 1) | read);
-	rcar_i2c_write(priv, ICMSR, 0);
-	rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_START);
+	if (rcar_i2c_flags_has(priv, ID_FIRST_MSG)) {	/* start */
+		rcar_i2c_write(priv, ICMSR, 0);
+		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_START);
+		rcar_i2c_flags_clr(priv, ID_FIRST_MSG);
+	} else {	/* restart */
+		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_START);
+		rcar_i2c_write(priv, ICMSR, 0);
+	}
 	rcar_i2c_write(priv, ICMIER, read ? RCAR_IRQ_RECV : RCAR_IRQ_SEND);
 }
 
@@ -523,6 +532,8 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 		priv->msg	= &msgs[i];
 		priv->pos	= 0;
 		priv->flags	= 0;
+		if (i = 0)
+			rcar_i2c_flags_set(priv, ID_FIRST_MSG);
 		if (i = num - 1)
 			rcar_i2c_flags_set(priv, ID_LAST_MSG);
 
-- 
1.9.1

