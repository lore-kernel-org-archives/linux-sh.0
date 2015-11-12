From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 12 Nov 2015 14:31:51 +0000
Subject: [PATCH v2 06/10] i2c: rcar: init new messages in irq
Message-Id: <1447338715-9955-7-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1447338715-9955-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1447338715-9955-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Setting up new messages was done in process context while handling a
message was in interrupt context. Because of the HW design, this IP core
is sensitive to timing, so the context switches were too expensive. Move
this setup to interrupt context as well.

In my test setup, this fixed the occasional 'data byte sent twice' issue
which a number of people have seen. It also fixes to send REP_START
after a read message which was wrongly send as a STOP + START sequence
before.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 74 +++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 4bd3099865b485..316de40fa4dc69 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -267,6 +267,13 @@ static void rcar_i2c_prepare_msg(struct rcar_i2c_priv *priv)
 	rcar_i2c_write(priv, ICMIER, read ? RCAR_IRQ_RECV : RCAR_IRQ_SEND);
 }
 
+static void rcar_i2c_next_msg(struct rcar_i2c_priv *priv)
+{
+	priv->msg++;
+	priv->msgs_left--;
+	rcar_i2c_prepare_msg(priv);
+}
+
 /*
  *		interrupt functions
  */
@@ -309,21 +316,17 @@ static int rcar_i2c_irq_send(struct rcar_i2c_priv *priv, u32 msr)
 		 * [ICRXTX] -> [SHIFT] -> [I2C bus]
 		 */
 
-		if (priv->flags & ID_LAST_MSG)
+		if (priv->flags & ID_LAST_MSG) {
 			/*
 			 * If current msg is the _LAST_ msg,
 			 * prepare stop condition here.
 			 * ID_DONE will be set on STOP irq.
 			 */
 			rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_STOP);
-		else
-			/*
-			 * If current msg is _NOT_ last msg,
-			 * it doesn't call stop phase.
-			 * thus, there is no STOP irq.
-			 * return ID_DONE here.
-			 */
-			return ID_DONE;
+		} else {
+			rcar_i2c_next_msg(priv);
+			return 0;
+		}
 	}
 
 	rcar_i2c_write(priv, ICMSR, RCAR_IRQ_ACK_SEND);
@@ -367,7 +370,10 @@ static int rcar_i2c_irq_recv(struct rcar_i2c_priv *priv, u32 msr)
 	else
 		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_DATA);
 
-	rcar_i2c_write(priv, ICMSR, RCAR_IRQ_ACK_RECV);
+	if (priv->pos = msg->len && !(priv->flags & ID_LAST_MSG))
+		rcar_i2c_next_msg(priv);
+	else
+		rcar_i2c_write(priv, ICMSR, RCAR_IRQ_ACK_RECV);
 
 	return 0;
 }
@@ -462,6 +468,7 @@ static irqreturn_t rcar_i2c_irq(int irq, void *ptr)
 
 	/* Stop */
 	if (msr & MST) {
+		priv->msgs_left--; /* The last message also made it */
 		rcar_i2c_flags_set(priv, ID_DONE);
 		goto out;
 	}
@@ -501,35 +508,28 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 		/* This HW can't send STOP after address phase */
 		if (msgs[i].len = 0) {
 			ret = -EOPNOTSUPP;
-			break;
-		}
-
-		/* init each data */
-		priv->msg = &msgs[i];
-		priv->msgs_left = num - i;
-
-		rcar_i2c_prepare_msg(priv);
-
-		time_left = wait_event_timeout(priv->wait,
-					     rcar_i2c_flags_has(priv, ID_DONE),
-					     adap->timeout);
-		if (!time_left) {
-			rcar_i2c_init(priv);
-			ret = -ETIMEDOUT;
-			break;
-		}
-
-		if (rcar_i2c_flags_has(priv, ID_NACK)) {
-			ret = -ENXIO;
-			break;
-		}
-
-		if (rcar_i2c_flags_has(priv, ID_ARBLOST)) {
-			ret = -EAGAIN;
-			break;
+			goto out;
 		}
+	}
 
-		ret = i + 1; /* The number of transfer */
+	/* init data */
+	priv->msg = msgs;
+	priv->msgs_left = num;
+
+	rcar_i2c_prepare_msg(priv);
+
+	time_left = wait_event_timeout(priv->wait,
+				     rcar_i2c_flags_has(priv, ID_DONE),
+				     num * adap->timeout);
+	if (!time_left) {
+		rcar_i2c_init(priv);
+		ret = -ETIMEDOUT;
+	} else if (rcar_i2c_flags_has(priv, ID_NACK)) {
+		ret = -ENXIO;
+	} else if (rcar_i2c_flags_has(priv, ID_ARBLOST)) {
+		ret = -EAGAIN;
+	} else {
+		ret = num - priv->msgs_left; /* The number of transfer */
 	}
 out:
 	pm_runtime_put(dev);
-- 
2.1.4

