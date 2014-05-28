From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 28 May 2014 07:44:43 +0000
Subject: [PATCH 08/11] i2c: rcar: remove spinlock
Message-Id: <1401263086-13720-9-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1401263086-13720-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1401263086-13720-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

The i2c core has per-adapter locks, so no need to protect again.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index e82d64b5acef..4b088e67f2fd 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -36,7 +36,6 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
-#include <linux/spinlock.h>
 
 /* register offsets */
 #define ICSCR	0x00	/* slave ctrl */
@@ -110,7 +109,6 @@ struct rcar_i2c_priv {
 	struct i2c_msg	*msg;
 	struct clk *clk;
 
-	spinlock_t lock;
 	wait_queue_head_t wait;
 
 	int pos;
@@ -394,9 +392,6 @@ static irqreturn_t rcar_i2c_irq(int irq, void *ptr)
 	struct device *dev = rcar_i2c_priv_to_dev(priv);
 	u32 msr;
 
-	/*-------------- spin lock -----------------*/
-	spin_lock(&priv->lock);
-
 	msr = rcar_i2c_read(priv, ICMSR);
 
 	/*
@@ -450,9 +445,6 @@ out:
 		wake_up(&priv->wait);
 	}
 
-	spin_unlock(&priv->lock);
-	/*-------------- spin unlock -----------------*/
-
 	return IRQ_HANDLED;
 }
 
@@ -462,21 +454,14 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 {
 	struct rcar_i2c_priv *priv = i2c_get_adapdata(adap);
 	struct device *dev = rcar_i2c_priv_to_dev(priv);
-	unsigned long flags;
 	int i, ret, timeout;
 
 	pm_runtime_get_sync(dev);
 
-	/*-------------- spin lock -----------------*/
-	spin_lock_irqsave(&priv->lock, flags);
-
 	rcar_i2c_init(priv);
 	/* start clock */
 	rcar_i2c_write(priv, ICCCR, priv->icccr);
 
-	spin_unlock_irqrestore(&priv->lock, flags);
-	/*-------------- spin unlock -----------------*/
-
 	ret = rcar_i2c_bus_barrier(priv);
 	if (ret < 0)
 		goto out;
@@ -488,9 +473,6 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 			break;
 		}
 
-		/*-------------- spin lock -----------------*/
-		spin_lock_irqsave(&priv->lock, flags);
-
 		/* init each data */
 		priv->msg	= &msgs[i];
 		priv->pos	= 0;
@@ -500,9 +482,6 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 
 		ret = rcar_i2c_prepare_msg(priv);
 
-		spin_unlock_irqrestore(&priv->lock, flags);
-		/*-------------- spin unlock -----------------*/
-
 		if (ret < 0)
 			break;
 
@@ -611,7 +590,6 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	init_waitqueue_head(&priv->wait);
-	spin_lock_init(&priv->lock);
 
 	adap			= &priv->adap;
 	adap->nr		= pdev->id;
-- 
2.0.0.rc2

