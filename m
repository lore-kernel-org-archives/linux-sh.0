From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 28 May 2014 07:44:39 +0000
Subject: [PATCH 04/11] i2c: rcar: refactor irq state machine
Message-Id: <1401263086-13720-5-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1401263086-13720-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1401263086-13720-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Remove the seperate functions and use designated constants. As readable
but less overhead. Actually, this is even more readable since the old
function used a mix of "=" and "|=".

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 39 +++++++--------------------------------
 1 file changed, 7 insertions(+), 32 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index e0cdab488cc5..9757adf33f37 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -83,12 +83,9 @@
 #define RCAR_BUS_PHASE_DATA	(MDBS | MIE)
 #define RCAR_BUS_PHASE_STOP	(MDBS | MIE | FSB)
 
-enum {
-	RCAR_IRQ_CLOSE,
-	RCAR_IRQ_OPEN_FOR_SEND,
-	RCAR_IRQ_OPEN_FOR_RECV,
-	RCAR_IRQ_OPEN_FOR_STOP,
-};
+#define RCAR_IRQ_SEND	(MNRE | MALE | MSTE | MATE | MDEE)
+#define RCAR_IRQ_RECV	(MNRE | MALE | MSTE | MATE | MDRE)
+#define RCAR_IRQ_STOP	(MSTE)
 
 /*
  * flags
@@ -158,28 +155,6 @@ static void rcar_i2c_init(struct rcar_i2c_priv *priv)
 	rcar_i2c_write(priv, ICMAR, 0);
 }
 
-static void rcar_i2c_irq_mask(struct rcar_i2c_priv *priv, int open)
-{
-	u32 val = MNRE | MALE | MSTE | MATE; /* default */
-
-	switch (open) {
-	case RCAR_IRQ_OPEN_FOR_SEND:
-		val |= MDEE; /* default + send */
-		break;
-	case RCAR_IRQ_OPEN_FOR_RECV:
-		val |= MDRE; /* default + read */
-		break;
-	case RCAR_IRQ_OPEN_FOR_STOP:
-		val = MSTE; /* stop irq only */
-		break;
-	case RCAR_IRQ_CLOSE:
-	default:
-		val = 0; /* all close */
-		break;
-	}
-	rcar_i2c_write(priv, ICMIER, val);
-}
-
 static void rcar_i2c_set_addr(struct rcar_i2c_priv *priv, u32 recv)
 {
 	rcar_i2c_write(priv, ICMAR, (priv->msg->addr << 1) | recv);
@@ -312,7 +287,7 @@ static int rcar_i2c_recv(struct rcar_i2c_priv *priv)
 	rcar_i2c_set_addr(priv, 1);
 	rcar_i2c_status_clear(priv);
 	rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_START);
-	rcar_i2c_irq_mask(priv, RCAR_IRQ_OPEN_FOR_RECV);
+	rcar_i2c_write(priv, ICMIER, RCAR_IRQ_RECV);
 
 	return 0;
 }
@@ -331,7 +306,7 @@ static int rcar_i2c_send(struct rcar_i2c_priv *priv)
 	rcar_i2c_set_addr(priv, 0);
 	rcar_i2c_status_clear(priv);
 	rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_START);
-	rcar_i2c_irq_mask(priv, RCAR_IRQ_OPEN_FOR_SEND);
+	rcar_i2c_write(priv, ICMIER, RCAR_IRQ_SEND);
 
 	return 0;
 }
@@ -486,7 +461,7 @@ static irqreturn_t rcar_i2c_irq(int irq, void *ptr)
 
 		/* go to stop phase */
 		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_STOP);
-		rcar_i2c_irq_mask(priv, RCAR_IRQ_OPEN_FOR_STOP);
+		rcar_i2c_write(priv, ICMIER, RCAR_IRQ_STOP);
 		rcar_i2c_flags_set(priv, ID_NACK);
 		goto out;
 	}
@@ -501,7 +476,7 @@ static irqreturn_t rcar_i2c_irq(int irq, void *ptr)
 
 out:
 	if (rcar_i2c_flags_has(priv, ID_DONE)) {
-		rcar_i2c_irq_mask(priv, RCAR_IRQ_CLOSE);
+		rcar_i2c_write(priv, ICMIER, 0);
 		rcar_i2c_status_clear(priv);
 		wake_up(&priv->wait);
 	}
-- 
2.0.0.rc2

