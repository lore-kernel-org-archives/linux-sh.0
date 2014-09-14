From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 14 Sep 2014 20:15:46 +0000
Subject: [PATCH v2 2/3] i2c-rcar: make rcar_i2c_prepare_msg() *void*
Message-Id: <3369447.JH8v9DUGDl@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <2245366.q99HVYG3pL@wasted.cogentembedded.com>
In-Reply-To: <2245366.q99HVYG3pL@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org

rcar_i2c_prepare_msg() always returns 0, so we can make this function return
*void* and thus remove the result check in rcar_i2c_master_xfer().

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- resolved reject, refreshed patch.

 drivers/i2c/busses/i2c-rcar.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

Index: linux/drivers/i2c/busses/i2c-rcar.c
=================================--- linux.orig/drivers/i2c/busses/i2c-rcar.c
+++ linux/drivers/i2c/busses/i2c-rcar.c
@@ -245,7 +245,7 @@ scgd_find:
 	return 0;
 }
 
-static int rcar_i2c_prepare_msg(struct rcar_i2c_priv *priv)
+static void rcar_i2c_prepare_msg(struct rcar_i2c_priv *priv)
 {
 	int read = !!rcar_i2c_is_recv(priv);
 
@@ -253,8 +253,6 @@ static int rcar_i2c_prepare_msg(struct r
 	rcar_i2c_write(priv, ICMSR, 0);
 	rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_START);
 	rcar_i2c_write(priv, ICMIER, read ? RCAR_IRQ_RECV : RCAR_IRQ_SEND);
-
-	return 0;
 }
 
 /*
@@ -456,14 +454,11 @@ static int rcar_i2c_master_xfer(struct i
 		if (i = num - 1)
 			rcar_i2c_flags_set(priv, ID_LAST_MSG);
 
-		ret = rcar_i2c_prepare_msg(priv);
+		rcar_i2c_prepare_msg(priv);
 
 		spin_unlock_irqrestore(&priv->lock, flags);
 		/*-------------- spin unlock -----------------*/
 
-		if (ret < 0)
-			break;
-
 		timeout = wait_event_timeout(priv->wait,
 					     rcar_i2c_flags_has(priv, ID_DONE),
 					     5 * HZ);

