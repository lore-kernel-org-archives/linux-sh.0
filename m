From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Tue, 10 Sep 2013 11:39:53 +0000
Subject: [PATCH 2/3] i2c: rcar: support R-Car H2 in i2c bus driver
Message-Id: <1378813194-19493-3-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Nguyen Viet Dung <nv-dung@jinso.co.jp>

This patch modifies the I2C bus driver to be usable on both R-Car H1 and H2.

Signed-off-by: Nguyen Viet Dung <nv-dung@jinso.co.jp>
---
 drivers/i2c/busses/i2c-rcar.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 0fc5858..883897f 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -101,6 +101,11 @@ enum {
 #define ID_ARBLOST	(1 << 3)
 #define ID_NACK		(1 << 4)
 
+enum rcar_i2c_type {
+	I2C_RCAR_H1,
+	I2C_RCAR_H2,
+};
+
 struct rcar_i2c_priv {
 	void __iomem *io;
 	struct i2c_adapter adap;
@@ -113,6 +118,7 @@ struct rcar_i2c_priv {
 	int irq;
 	u32 icccr;
 	u32 flags;
+	enum rcar_i2c_type	devtype;
 };
 
 #define rcar_i2c_priv_to_dev(p)		((p)->adap.dev.parent)
@@ -224,12 +230,25 @@ static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv,
 	u32 scgd, cdf;
 	u32 round, ick;
 	u32 scl;
+	u32 cdf_width;
 
 	if (!clkp) {
 		dev_err(dev, "there is no peripheral_clk\n");
 		return -EIO;
 	}
 
+	switch (priv->devtype) {
+	case I2C_RCAR_H1:
+		cdf_width = 2;
+		break;
+	case I2C_RCAR_H2:
+		cdf_width = 3;
+		break;
+	default:
+		dev_err(dev, "device type error\n");
+		return -EIO;
+	}
+
 	/*
 	 * calculate SCL clock
 	 * see
@@ -245,7 +264,7 @@ static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv,
 	 * clkp : peripheral_clk
 	 * F[]  : integer up-valuation
 	 */
-	for (cdf = 0; cdf < 4; cdf++) {
+	for (cdf = 0; cdf < (1 << cdf_width); cdf++) {
 		ick = clk_get_rate(clkp) / (1 + cdf);
 		if (ick < 20000000)
 			goto ick_find;
@@ -287,7 +306,7 @@ scgd_find:
 	/*
 	 * keep icccr value
 	 */
-	priv->icccr = (scgd << 2 | cdf);
+	priv->icccr = (scgd << cdf_width) | cdf;
 
 	return 0;
 }
@@ -632,6 +651,9 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	bus_speed = 100000; /* default 100 kHz */
 	if (pdata && pdata->bus_speed)
 		bus_speed = pdata->bus_speed;
+
+	priv->devtype = platform_get_device_id(pdev)->driver_data;
+
 	ret = rcar_i2c_clock_calculate(priv, bus_speed, dev);
 	if (ret < 0)
 		return ret;
@@ -686,6 +708,14 @@ static int rcar_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static struct platform_device_id rcar_i2c_id_table[] = {
+	{ "i2c-rcar",		I2C_RCAR_H1 },
+	{ "i2c-rcar_h1",	I2C_RCAR_H1 },
+	{ "i2c-rcar_h2",	I2C_RCAR_H2 },
+	{},
+};
+MODULE_DEVICE_TABLE(platform, rcar_i2c_id_table);
+
 static struct platform_driver rcar_i2c_driver = {
 	.driver	= {
 		.name	= "i2c-rcar",
@@ -693,6 +723,7 @@ static struct platform_driver rcar_i2c_driver = {
 	},
 	.probe		= rcar_i2c_probe,
 	.remove		= rcar_i2c_remove,
+	.id_table	= rcar_i2c_id_table,
 };
 
 module_platform_driver(rcar_i2c_driver);
-- 
1.8.1.4

