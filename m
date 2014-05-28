From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 28 May 2014 07:44:45 +0000
Subject: [PATCH 10/11] i2c: rcar: janitorial cleanup after refactoring
Message-Id: <1401263086-13720-11-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1401263086-13720-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1401263086-13720-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Remove some obvious comments, remove some superfluous debug output (the
error code carries the same information), some white space fixing...

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 50 +++++--------------------------------------
 1 file changed, 5 insertions(+), 45 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index d489d54ebc6f..b4cbbc412ca9 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -80,9 +80,6 @@
 #define RCAR_IRQ_ACK_SEND	(~(MAT | MDE))
 #define RCAR_IRQ_ACK_RECV	(~(MAT | MDR))
 
-/*
- * flags
- */
 #define ID_LAST_MSG	(1 << 0)
 #define ID_IOERROR	(1 << 1)
 #define ID_DONE		(1 << 2)
@@ -105,7 +102,7 @@ struct rcar_i2c_priv {
 	int pos;
 	u32 icccr;
 	u32 flags;
-	enum rcar_i2c_type	devtype;
+	enum rcar_i2c_type devtype;
 };
 
 #define rcar_i2c_priv_to_dev(p)		((p)->adap.dev.parent)
@@ -116,9 +113,7 @@ struct rcar_i2c_priv {
 
 #define LOOP_TIMEOUT	1024
 
-/*
- *		basic functions
- */
+
 static void rcar_i2c_write(struct rcar_i2c_priv *priv, int reg, u32 val)
 {
 	writel(val, priv->io + reg);
@@ -147,9 +142,6 @@ static void rcar_i2c_init(struct rcar_i2c_priv *priv)
 	rcar_i2c_write(priv, ICMAR, 0);
 }
 
-/*
- *		bus control functions
- */
 static int rcar_i2c_bus_barrier(struct rcar_i2c_priv *priv)
 {
 	int i;
@@ -164,9 +156,6 @@ static int rcar_i2c_bus_barrier(struct rcar_i2c_priv *priv)
 	return -EBUSY;
 }
 
-/*
- *		clock function
- */
 static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv,
 				    u32 bus_speed,
 				    struct device *dev)
@@ -256,10 +245,6 @@ scgd_find:
 	return 0;
 }
 
-/*
- *		status functions
- */
-
 static int rcar_i2c_prepare_msg(struct rcar_i2c_priv *priv)
 {
 	int read = !!rcar_i2c_is_recv(priv);
@@ -380,40 +365,24 @@ static int rcar_i2c_irq_recv(struct rcar_i2c_priv *priv, u32 msr)
 static irqreturn_t rcar_i2c_irq(int irq, void *ptr)
 {
 	struct rcar_i2c_priv *priv = ptr;
-	struct device *dev = rcar_i2c_priv_to_dev(priv);
 	u32 msr;
 
 	msr = rcar_i2c_read(priv, ICMSR);
 
-	/*
-	 * Arbitration lost
-	 */
+	/* Arbitration lost */
 	if (msr & MAL) {
-		/*
-		 * CAUTION
-		 *
-		 * When arbitration lost, device become _slave_ mode.
-		 */
-		dev_dbg(dev, "Arbitration Lost\n");
 		rcar_i2c_flags_set(priv, (ID_DONE | ID_ARBLOST));
 		goto out;
 	}
 
-	/*
-	 * Stop
-	 */
+	/* Stop */
 	if (msr & MST) {
-		dev_dbg(dev, "Stop\n");
 		rcar_i2c_flags_set(priv, ID_DONE);
 		goto out;
 	}
 
-	/*
-	 * Nack
-	 */
+	/* Nack */
 	if (msr & MNR) {
-		dev_dbg(dev, "Nack\n");
-
 		/* go to stop phase */
 		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_STOP);
 		rcar_i2c_write(priv, ICMIER, RCAR_IRQ_STOP);
@@ -421,9 +390,6 @@ static irqreturn_t rcar_i2c_irq(int irq, void *ptr)
 		goto out;
 	}
 
-	/*
-	 * recv/send
-	 */
 	if (rcar_i2c_is_recv(priv))
 		rcar_i2c_flags_set(priv, rcar_i2c_irq_recv(priv, msr));
 	else
@@ -476,9 +442,6 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 		if (ret < 0)
 			break;
 
-		/*
-		 * wait result
-		 */
 		timeout = wait_event_timeout(priv->wait,
 					     rcar_i2c_flags_has(priv, ID_DONE),
 					     5 * HZ);
@@ -487,9 +450,6 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 			break;
 		}
 
-		/*
-		 * error handling
-		 */
 		if (rcar_i2c_flags_has(priv, ID_NACK)) {
 			ret = -ENXIO;
 			break;
-- 
2.0.0.rc2

