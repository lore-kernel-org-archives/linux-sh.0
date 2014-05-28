From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 28 May 2014 07:44:41 +0000
Subject: [PATCH 06/11] i2c: rcar: refactor setting up msg
Message-Id: <1401263086-13720-7-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1401263086-13720-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1401263086-13720-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Setting up a read or write message is similar enough to be done in one
function. Also, move a helper function into the new function since it is
only used here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index a97a14955ddf..f7b14d049d5c 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -155,11 +155,6 @@ static void rcar_i2c_init(struct rcar_i2c_priv *priv)
 	rcar_i2c_write(priv, ICMAR, 0);
 }
 
-static void rcar_i2c_set_addr(struct rcar_i2c_priv *priv, u32 recv)
-{
-	rcar_i2c_write(priv, ICMAR, (priv->msg->addr << 1) | recv);
-}
-
 /*
  *		bus control functions
  */
@@ -279,25 +274,14 @@ static void rcar_i2c_status_bit_clear(struct rcar_i2c_priv *priv, u32 bit)
 	rcar_i2c_write(priv, ICMSR, ~bit);
 }
 
-/*
- *		recv/send functions
- */
-static int rcar_i2c_recv(struct rcar_i2c_priv *priv)
+static int rcar_i2c_prepare_msg(struct rcar_i2c_priv *priv)
 {
-	rcar_i2c_set_addr(priv, 1);
-	rcar_i2c_status_clear(priv);
-	rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_START);
-	rcar_i2c_write(priv, ICMIER, RCAR_IRQ_RECV);
-
-	return 0;
-}
+	int read = !!rcar_i2c_is_recv(priv);
 
-static int rcar_i2c_send(struct rcar_i2c_priv *priv)
-{
-	rcar_i2c_set_addr(priv, 0);
+	rcar_i2c_write(priv, ICMAR, (priv->msg->addr << 1) | read);
 	rcar_i2c_status_clear(priv);
 	rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_START);
-	rcar_i2c_write(priv, ICMIER, RCAR_IRQ_SEND);
+	rcar_i2c_write(priv, ICMIER, read ? RCAR_IRQ_RECV : RCAR_IRQ_SEND);
 
 	return 0;
 }
@@ -520,11 +504,7 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 		if (priv->msg = &msgs[num - 1])
 			rcar_i2c_flags_set(priv, ID_LAST_MSG);
 
-		/* start send/recv */
-		if (rcar_i2c_is_recv(priv))
-			ret = rcar_i2c_recv(priv);
-		else
-			ret = rcar_i2c_send(priv);
+		ret = rcar_i2c_prepare_msg(priv);
 
 		spin_unlock_irqrestore(&priv->lock, flags);
 		/*-------------- spin unlock -----------------*/
-- 
2.0.0.rc2

