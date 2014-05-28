From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 28 May 2014 07:44:38 +0000
Subject: [PATCH 03/11] i2c: rcar: refactor bus state machine
Message-Id: <1401263086-13720-4-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1401263086-13720-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1401263086-13720-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Remove the seperate functions and use designated constants. As readable
but less overhead.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 37 ++++++++++---------------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 88efbf29a182..e0cdab488cc5 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -79,11 +79,9 @@
 #define MATE	(1 << 0)	/* address sent irq en */
 
 
-enum {
-	RCAR_BUS_PHASE_ADDR,
-	RCAR_BUS_PHASE_DATA,
-	RCAR_BUS_PHASE_STOP,
-};
+#define RCAR_BUS_PHASE_START	(MDBS | MIE | ESG)
+#define RCAR_BUS_PHASE_DATA	(MDBS | MIE)
+#define RCAR_BUS_PHASE_STOP	(MDBS | MIE | FSB)
 
 enum {
 	RCAR_IRQ_CLOSE,
@@ -204,21 +202,6 @@ static int rcar_i2c_bus_barrier(struct rcar_i2c_priv *priv)
 	return -EBUSY;
 }
 
-static void rcar_i2c_bus_phase(struct rcar_i2c_priv *priv, int phase)
-{
-	switch (phase) {
-	case RCAR_BUS_PHASE_ADDR:
-		rcar_i2c_write(priv, ICMCR, MDBS | MIE | ESG);
-		break;
-	case RCAR_BUS_PHASE_DATA:
-		rcar_i2c_write(priv, ICMCR, MDBS | MIE);
-		break;
-	case RCAR_BUS_PHASE_STOP:
-		rcar_i2c_write(priv, ICMCR, MDBS | MIE | FSB);
-		break;
-	}
-}
-
 /*
  *		clock function
  */
@@ -328,7 +311,7 @@ static int rcar_i2c_recv(struct rcar_i2c_priv *priv)
 {
 	rcar_i2c_set_addr(priv, 1);
 	rcar_i2c_status_clear(priv);
-	rcar_i2c_bus_phase(priv, RCAR_BUS_PHASE_ADDR);
+	rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_START);
 	rcar_i2c_irq_mask(priv, RCAR_IRQ_OPEN_FOR_RECV);
 
 	return 0;
@@ -347,7 +330,7 @@ static int rcar_i2c_send(struct rcar_i2c_priv *priv)
 
 	rcar_i2c_set_addr(priv, 0);
 	rcar_i2c_status_clear(priv);
-	rcar_i2c_bus_phase(priv, RCAR_BUS_PHASE_ADDR);
+	rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_START);
 	rcar_i2c_irq_mask(priv, RCAR_IRQ_OPEN_FOR_SEND);
 
 	return 0;
@@ -376,7 +359,7 @@ static int rcar_i2c_irq_send(struct rcar_i2c_priv *priv, u32 msr)
 	 * goto data phase.
 	 */
 	if (msr & MAT)
-		rcar_i2c_bus_phase(priv, RCAR_BUS_PHASE_DATA);
+		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_DATA);
 
 	if (priv->pos < msg->len) {
 		/*
@@ -404,7 +387,7 @@ static int rcar_i2c_irq_send(struct rcar_i2c_priv *priv, u32 msr)
 			 * prepare stop condition here.
 			 * ID_DONE will be set on STOP irq.
 			 */
-			rcar_i2c_bus_phase(priv, RCAR_BUS_PHASE_STOP);
+			rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_STOP);
 		else
 			/*
 			 * If current msg is _NOT_ last msg,
@@ -452,9 +435,9 @@ static int rcar_i2c_irq_recv(struct rcar_i2c_priv *priv, u32 msr)
 	 * otherwise, go to DATA phase.
 	 */
 	if (priv->pos + 1 >= msg->len)
-		rcar_i2c_bus_phase(priv, RCAR_BUS_PHASE_STOP);
+		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_STOP);
 	else
-		rcar_i2c_bus_phase(priv, RCAR_BUS_PHASE_DATA);
+		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_DATA);
 
 	rcar_i2c_recv_restart(priv);
 
@@ -502,7 +485,7 @@ static irqreturn_t rcar_i2c_irq(int irq, void *ptr)
 		dev_dbg(dev, "Nack\n");
 
 		/* go to stop phase */
-		rcar_i2c_bus_phase(priv, RCAR_BUS_PHASE_STOP);
+		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_STOP);
 		rcar_i2c_irq_mask(priv, RCAR_IRQ_OPEN_FOR_STOP);
 		rcar_i2c_flags_set(priv, ID_NACK);
 		goto out;
-- 
2.0.0.rc2

