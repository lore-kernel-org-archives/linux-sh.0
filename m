From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 03 Sep 2015 20:20:07 +0000
Subject: [PATCH 3/9] i2c: rcar: remove spinlock
Message-Id: <1441311613-2681-4-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1441311613-2681-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1441311613-2681-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yoshihiro Kaneko <ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

We make sure to reinit the HW in the timeout case; then we know that
interrupts are always disabled in the sections protected by the
spinlock. Thus, we can simply remove it which is a preparation for
further refactoring. While here, rename the timeout variable to
time_left which is way more readable.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 3594cdab2573b6..e65418b34d868e 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -34,7 +34,6 @@
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
@@ -428,9 +426,6 @@ static irqreturn_t rcar_i2c_irq(int irq, void *ptr)
 	irqreturn_t result = IRQ_HANDLED;
 	u32 msr;
 
-	/*-------------- spin lock -----------------*/
-	spin_lock(&priv->lock);
-
 	if (rcar_i2c_slave_irq(priv))
 		goto exit;
 
@@ -477,9 +472,6 @@ out:
 	}
 
 exit:
-	spin_unlock(&priv->lock);
-	/*-------------- spin unlock -----------------*/
-
 	return result;
 }
 
@@ -489,9 +481,8 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 {
 	struct rcar_i2c_priv *priv = i2c_get_adapdata(adap);
 	struct device *dev = rcar_i2c_priv_to_dev(priv);
-	unsigned long flags;
 	int i, ret;
-	long timeout;
+	long time_left;
 
 	pm_runtime_get_sync(dev);
 
@@ -506,9 +497,6 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 			break;
 		}
 
-		/*-------------- spin lock -----------------*/
-		spin_lock_irqsave(&priv->lock, flags);
-
 		/* init each data */
 		priv->msg	= &msgs[i];
 		priv->pos	= 0;
@@ -518,13 +506,11 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 
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
@@ -658,7 +644,6 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	init_waitqueue_head(&priv->wait);
-	spin_lock_init(&priv->lock);
 
 	adap = &priv->adap;
 	adap->nr = pdev->id;
-- 
2.1.4

