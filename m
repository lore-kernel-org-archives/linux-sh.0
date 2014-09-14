From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 14 Sep 2014 20:20:19 +0000
Subject: [PATCH] i2c-rcar: check for no IRQ in rcar_i2c_irq()
Message-Id: <3921243.2t7X6eKC2i@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Check if the ICMSR register (masked with the ICMIER register) evaluates to 0  in
the driver's interrupt handler and return IRQ_NONE in that case, like many other
drivers do.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against Wolfram Sang's 'linux.git' repo's 'i2c/for-next' branch
plus 3 cleanup patches just re-posted.

 drivers/i2c/busses/i2c-rcar.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: renesas/drivers/i2c/busses/i2c-rcar.c
=================================--- renesas.orig/drivers/i2c/busses/i2c-rcar.c
+++ renesas/drivers/i2c/busses/i2c-rcar.c
@@ -361,6 +361,7 @@ static void rcar_i2c_irq_recv(struct rca
 static irqreturn_t rcar_i2c_irq(int irq, void *ptr)
 {
 	struct rcar_i2c_priv *priv = ptr;
+	irqreturn_t result = IRQ_HANDLED;
 	u32 msr;
 
 	/*-------------- spin lock -----------------*/
@@ -370,6 +371,10 @@ static irqreturn_t rcar_i2c_irq(int irq,
 
 	/* Only handle interrupts that are currently enabled */
 	msr &= rcar_i2c_read(priv, ICMIER);
+	if (!msr) {
+		result = IRQ_NONE;
+		goto exit;
+	}
 
 	/* Arbitration lost */
 	if (msr & MAL) {
@@ -404,10 +409,11 @@ out:
 		wake_up(&priv->wait);
 	}
 
+exit:
 	spin_unlock(&priv->lock);
 	/*-------------- spin unlock -----------------*/
 
-	return IRQ_HANDLED;
+	return result;
 }
 
 static int rcar_i2c_master_xfer(struct i2c_adapter *adap,

