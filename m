From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 23 Dec 2015 16:56:34 +0000
Subject: [PATCH 3/3] i2c: rcar: disable PM in multi-master mode
Message-Id: <1450889794-9509-4-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1450889794-9509-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1450889794-9509-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Geert Uytterhoeven <geert+renesas@glider.be>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

In multi master mode, the IP core needs to be always active for
arbitration reasons. Get the config from DT and set up PM depending on
the config.

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index fab841899e65f2..1abeadc8ab7959 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -96,6 +96,9 @@
 #define ID_DONE		(1 << 2)
 #define ID_ARBLOST	(1 << 3)
 #define ID_NACK		(1 << 4)
+/* persistent flags */
+#define ID_P_PM_BLOCKED	(1 << 31)
+#define ID_P_MASK	ID_P_PM_BLOCKED
 
 enum rcar_i2c_type {
 	I2C_RCAR_GEN1,
@@ -277,7 +280,7 @@ static void rcar_i2c_next_msg(struct rcar_i2c_priv *priv)
 {
 	priv->msg++;
 	priv->msgs_left--;
-	priv->flags = 0;
+	priv->flags &= ID_P_MASK;
 	rcar_i2c_prepare_msg(priv);
 }
 
@@ -495,7 +498,7 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 	/* init first message */
 	priv->msg = msgs;
 	priv->msgs_left = num;
-	priv->flags = ID_FIRST_MSG;
+	priv->flags = (priv->flags & ID_P_MASK) | ID_FIRST_MSG;
 	rcar_i2c_prepare_msg(priv);
 
 	time_left = wait_event_timeout(priv->wait, priv->flags & ID_DONE,
@@ -630,7 +633,13 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 		goto out_pm_put;
 
 	rcar_i2c_init(priv);
-	pm_runtime_put(dev);
+
+	/* Don't suspend when multi-master to keep arbitration working */
+	if (of_property_read_bool(dev->of_node, "multi-master"))
+		priv->flags |= ID_P_PM_BLOCKED;
+	else
+		pm_runtime_put(dev);
+
 
 	irq = platform_get_irq(pdev, 0);
 	ret = devm_request_irq(dev, irq, rcar_i2c_irq, 0, dev_name(dev), priv);
@@ -664,6 +673,8 @@ static int rcar_i2c_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 
 	i2c_del_adapter(&priv->adap);
+	if (priv->flags & ID_P_PM_BLOCKED)
+		pm_runtime_put(dev);
 	pm_runtime_disable(dev);
 
 	return 0;
-- 
2.1.4

