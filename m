From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 03 Sep 2015 20:20:08 +0000
Subject: [PATCH 4/9] i2c: rcar: refactor setup of a msg
Message-Id: <1441311613-2681-5-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1441311613-2681-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1441311613-2681-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yoshihiro Kaneko <ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

We want to reuse this function later.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index e65418b34d868e..6e459a338ccc75 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -106,7 +106,8 @@ enum rcar_i2c_type {
 struct rcar_i2c_priv {
 	void __iomem *io;
 	struct i2c_adapter adap;
-	struct i2c_msg	*msg;
+	struct i2c_msg *msg;
+	int msgs_left;
 	struct clk *clk;
 
 	wait_queue_head_t wait;
@@ -254,6 +255,11 @@ static void rcar_i2c_prepare_msg(struct rcar_i2c_priv *priv)
 {
 	int read = !!rcar_i2c_is_recv(priv);
 
+	priv->pos = 0;
+	priv->flags = 0;
+	if (priv->msgs_left = 1)
+		rcar_i2c_flags_set(priv, ID_LAST_MSG);
+
 	rcar_i2c_write(priv, ICMAR, (priv->msg->addr << 1) | read);
 	rcar_i2c_write(priv, ICMSR, 0);
 	rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_START);
@@ -498,11 +504,8 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 		}
 
 		/* init each data */
-		priv->msg	= &msgs[i];
-		priv->pos	= 0;
-		priv->flags	= 0;
-		if (i = num - 1)
-			rcar_i2c_flags_set(priv, ID_LAST_MSG);
+		priv->msg = &msgs[i];
+		priv->msgs_left = num - i;
 
 		rcar_i2c_prepare_msg(priv);
 
-- 
2.1.4

