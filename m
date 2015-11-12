From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 12 Nov 2015 14:31:49 +0000
Subject: [PATCH v2 04/10] i2c: rcar: remove spinlock
Message-Id: <1447338715-9955-5-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1447338715-9955-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1447338715-9955-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

After making sure to reinit the HW and clear interrupts in the timeout
case, we know that interrupts are always disabled in the sections
protected by the spinlock. Thus, we can simply remove it which is a
preparation for further refactoring. While here, rename the timeout
variable to time_left which is way more readable.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 746406923a5825..0f2dc74ab8bcc1 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -33,7 +33,6 @@
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
@@ -429,9 +427,6 @@ static irqreturn_t rcar_i2c_irq(int irq, void *ptr)
 	irqreturn_t result = IRQ_HANDLED;
 	u32 msr;
 
-	/*-------------- spin lock -----------------*/
-	spin_lock(&priv->lock);
-
 	if (rcar_i2c_slave_irq(priv))
 		goto exit;
 
@@ -478,9 +473,6 @@ out:
 	}
 
 exit:
-	spin_unlock(&priv->lock);
-	/*-------------- spin unlock -----------------*/
-
 	return result;
 }
 
@@ -490,9 +482,8 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 {
 	struct rcar_i2c_priv *priv = i2c_get_adapdata(adap);
 	struct device *dev = rcar_i2c_priv_to_dev(priv);
-	unsigned long flags;
 	int i, ret;
-	long timeout;
+	long time_left;
 
 	pm_runtime_get_sync(dev);
 
@@ -507,9 +498,6 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 			break;
 		}
 
-		/*-------------- spin lock -----------------*/
-		spin_lock_irqsave(&priv->lock, flags);
-
 		/* init each data */
 		priv->msg	= &msgs[i];
 		priv->pos	= 0;
@@ -519,13 +507,11 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 
 		rcar_i2c_prepare_msg(priv);
 
-		spin_unlock_irqrestore(&priv->lock, flags);
-		/*-------------- spin unlock -----------------*/
-
-		timeout = wait_event_timeout(priv->wait,
+		time_left = wait_event_timeout(priv->wait,
 					     rcar_i2c_flags_has(priv, ID_DONE),
 					     adap->timeout);
-		if (!timeout) {
+		if (!time_left) {
+			rcar_i2c_init(priv);
 			ret = -ETIMEDOUT;
 			break;
 		}
@@ -656,7 +642,6 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	init_waitqueue_head(&priv->wait);
-	spin_lock_init(&priv->lock);
 
 	adap = &priv->adap;
 	adap->nr = pdev->id;
-- 
2.1.4

