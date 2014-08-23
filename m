From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 23 Aug 2014 20:42:52 +0000
Subject: [PATCH] Revert "i2c-rcar: remove spinlock"
Message-Id: <5687273.SAZk4lxXAk@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org

This reverts commit 150b8be3cda54412ad7b54f5392b513b25c0aaa7.

The I2C core's per-adapter locks can't protect from IRQs, so the driver still
needs a spinlock to protect the register accesses.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: stable@vger.kernel.org # 3.16+

---
The patch is against Wolfram Sang's 'linux.git' repo.

 drivers/i2c/busses/i2c-rcar.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

Index: linux/drivers/i2c/busses/i2c-rcar.c
=================================--- linux.orig/drivers/i2c/busses/i2c-rcar.c
+++ linux/drivers/i2c/busses/i2c-rcar.c
@@ -34,6 +34,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 
 /* register offsets */
 #define ICSCR	0x00	/* slave ctrl */
@@ -95,6 +96,7 @@ struct rcar_i2c_priv {
 	struct i2c_msg	*msg;
 	struct clk *clk;
 
+	spinlock_t lock;
 	wait_queue_head_t wait;
 
 	int pos;
@@ -365,6 +367,9 @@ static irqreturn_t rcar_i2c_irq(int irq,
 	struct rcar_i2c_priv *priv = ptr;
 	u32 msr;
 
+	/*-------------- spin lock -----------------*/
+	spin_lock(&priv->lock);
+
 	msr = rcar_i2c_read(priv, ICMSR);
 
 	/* Arbitration lost */
@@ -400,6 +405,9 @@ out:
 		wake_up(&priv->wait);
 	}
 
+	spin_unlock(&priv->lock);
+	/*-------------- spin unlock -----------------*/
+
 	return IRQ_HANDLED;
 }
 
@@ -409,14 +417,21 @@ static int rcar_i2c_master_xfer(struct i
 {
 	struct rcar_i2c_priv *priv = i2c_get_adapdata(adap);
 	struct device *dev = rcar_i2c_priv_to_dev(priv);
+	unsigned long flags;
 	int i, ret, timeout;
 
 	pm_runtime_get_sync(dev);
 
+	/*-------------- spin lock -----------------*/
+	spin_lock_irqsave(&priv->lock, flags);
+
 	rcar_i2c_init(priv);
 	/* start clock */
 	rcar_i2c_write(priv, ICCCR, priv->icccr);
 
+	spin_unlock_irqrestore(&priv->lock, flags);
+	/*-------------- spin unlock -----------------*/
+
 	ret = rcar_i2c_bus_barrier(priv);
 	if (ret < 0)
 		goto out;
@@ -428,6 +443,9 @@ static int rcar_i2c_master_xfer(struct i
 			break;
 		}
 
+		/*-------------- spin lock -----------------*/
+		spin_lock_irqsave(&priv->lock, flags);
+
 		/* init each data */
 		priv->msg	= &msgs[i];
 		priv->pos	= 0;
@@ -437,6 +455,9 @@ static int rcar_i2c_master_xfer(struct i
 
 		ret = rcar_i2c_prepare_msg(priv);
 
+		spin_unlock_irqrestore(&priv->lock, flags);
+		/*-------------- spin unlock -----------------*/
+
 		if (ret < 0)
 			break;
 
@@ -540,6 +561,7 @@ static int rcar_i2c_probe(struct platfor
 
 	irq = platform_get_irq(pdev, 0);
 	init_waitqueue_head(&priv->wait);
+	spin_lock_init(&priv->lock);
 
 	adap = &priv->adap;
 	adap->nr = pdev->id;

