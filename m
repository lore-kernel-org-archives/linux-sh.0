From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 22 Aug 2014 14:23:52 +0000
Subject: [PATCH 2/3] i2c-rcar: make rcar_i2c_prepare_msg() *void*
Message-Id: <4460482.KmaEIVo0yD@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <32018817.zX4x1fdR4T@wasted.cogentembedded.com>
In-Reply-To: <32018817.zX4x1fdR4T-gHKXc3Y1Z8zGSmamagVegGFoWSdPRAKMAL8bYrjMMd8@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

rcar_i2c_prepare_msg() always returns 0, so we can make this function return
*void* and thus remove the result check in rcar_i2c_master_xfer().

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/i2c/busses/i2c-rcar.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

Index: linux/drivers/i2c/busses/i2c-rcar.c
=================================--- linux.orig/drivers/i2c/busses/i2c-rcar.c
+++ linux/drivers/i2c/busses/i2c-rcar.c
@@ -243,7 +243,7 @@ scgd_find:
 	return 0;
 }
 
-static int rcar_i2c_prepare_msg(struct rcar_i2c_priv *priv)
+static void rcar_i2c_prepare_msg(struct rcar_i2c_priv *priv)
 {
 	int read = !!rcar_i2c_is_recv(priv);
 
@@ -251,8 +251,6 @@ static int rcar_i2c_prepare_msg(struct r
 	rcar_i2c_write(priv, ICMSR, 0);
 	rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_START);
 	rcar_i2c_write(priv, ICMIER, read ? RCAR_IRQ_RECV : RCAR_IRQ_SEND);
-
-	return 0;
 }
 
 /*
@@ -435,10 +433,7 @@ static int rcar_i2c_master_xfer(struct i
 		if (i = num - 1)
 			rcar_i2c_flags_set(priv, ID_LAST_MSG);
 
-		ret = rcar_i2c_prepare_msg(priv);
-
-		if (ret < 0)
-			break;
+		rcar_i2c_prepare_msg(priv);
 
 		timeout = wait_event_timeout(priv->wait,
 					     rcar_i2c_flags_has(priv, ID_DONE),

