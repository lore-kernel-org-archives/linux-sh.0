From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 12 Nov 2015 17:36:29 +0000
Subject: [PATCH] i2c: rcar: handle difference in setting up non-first message
Message-Id: <1447349789-24252-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-rcar.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index ef963d195a4eb9..b1aea21755f84d 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -92,6 +92,7 @@
 #define RCAR_IRQ_ACK_RECV	(~(MAT | MDR) & 0xFF)
 
 #define ID_LAST_MSG	(1 << 0)
+#define ID_FIRST_MSG	(1 << 1)
 #define ID_DONE		(1 << 2)
 #define ID_ARBLOST	(1 << 3)
 #define ID_NACK		(1 << 4)
@@ -254,13 +255,22 @@ static void rcar_i2c_prepare_msg(struct rcar_i2c_priv *priv)
 	int read = !!rcar_i2c_is_recv(priv);
 
 	priv->pos = 0;
-	priv->flags = 0;
 	if (priv->msgs_left = 1)
 		rcar_i2c_flags_set(priv, ID_LAST_MSG);
 
 	rcar_i2c_write(priv, ICMAR, (priv->msg->addr << 1) | read);
-	rcar_i2c_write(priv, ICMSR, 0);
-	rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_START);
+	/*
+	 * We don't have a testcase but the HW engineers say that the write order
+	 * of ICMSR and ICMCR depends on whether we issue START or REP_START. Since
+	 * it didn't cause a drawback for me, let's rather be safe than sorry.
+	 */
+	if (rcar_i2c_flags_has(priv, ID_FIRST_MSG)) {
+		rcar_i2c_write(priv, ICMSR, 0);
+		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_START);
+	} else {
+		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_START);
+		rcar_i2c_write(priv, ICMSR, 0);
+	}
 	rcar_i2c_write(priv, ICMIER, read ? RCAR_IRQ_RECV : RCAR_IRQ_SEND);
 }
 
@@ -268,6 +278,7 @@ static void rcar_i2c_next_msg(struct rcar_i2c_priv *priv)
 {
 	priv->msg++;
 	priv->msgs_left--;
+	priv->flags = 0;
 	rcar_i2c_prepare_msg(priv);
 }
 
@@ -486,10 +497,10 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 		}
 	}
 
-	/* init data */
+	/* init first message */
 	priv->msg = msgs;
 	priv->msgs_left = num;
-
+	priv->flags = ID_FIRST_MSG;
 	rcar_i2c_prepare_msg(priv);
 
 	time_left = wait_event_timeout(priv->wait,
-- 
2.1.4

