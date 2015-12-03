From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 03 Dec 2015 15:51:34 +0000
Subject: [PATCH 4/9] i2c: rcar: switch to i2c generic dt parsing
Message-Id: <1449157899-6572-5-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1449157899-6572-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1449157899-6572-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-rockchip@lists.infradead.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Switch to the new generic functions. Plain convert, no functionality
added yet.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index d4322a9096786f..05274fda57eb08 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -162,12 +162,15 @@ static int rcar_i2c_bus_barrier(struct rcar_i2c_priv *priv)
 	return -EBUSY;
 }
 
-static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv, u32 bus_speed)
+static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv, struct i2c_timings *t)
 {
 	u32 scgd, cdf, round, ick, scl, cdf_width;
 	unsigned long rate;
 	struct device *dev = rcar_i2c_priv_to_dev(priv);
 
+	/* Fall back to previously used values if not supplied */
+	t->bus_freq_hz = t->bus_freq_hz ?: 100000;
+
 	switch (priv->devtype) {
 	case I2C_RCAR_GEN1:
 		cdf_width = 2;
@@ -230,7 +233,7 @@ static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv, u32 bus_speed)
 	 */
 	for (scgd = 0; scgd < 0x40; scgd++) {
 		scl = ick / (20 + (scgd * 8) + round);
-		if (scl <= bus_speed)
+		if (scl <= t->bus_freq_hz)
 			goto scgd_find;
 	}
 	dev_err(dev, "it is impossible to calculate best SCL\n");
@@ -238,7 +241,7 @@ static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv, u32 bus_speed)
 
 scgd_find:
 	dev_dbg(dev, "clk %d/%d(%lu), round %u, CDF:0x%x, SCGD: 0x%x\n",
-		scl, bus_speed, clk_get_rate(priv->clk), round, cdf, scgd);
+		scl, t->bus_freq_hz, clk_get_rate(priv->clk), round, cdf, scgd);
 
 	/* keep icccr value */
 	priv->icccr = scgd << cdf_width | cdf;
@@ -588,7 +591,7 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	struct i2c_adapter *adap;
 	struct resource *res;
 	struct device *dev = &pdev->dev;
-	u32 bus_speed;
+	struct i2c_timings i2c_t;
 	int irq, ret;
 
 	priv = devm_kzalloc(dev, sizeof(struct rcar_i2c_priv), GFP_KERNEL);
@@ -619,12 +622,11 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	i2c_set_adapdata(adap, priv);
 	strlcpy(adap->name, pdev->name, sizeof(adap->name));
 
-	bus_speed = 100000; /* default 100 kHz */
-	of_property_read_u32(dev->of_node, "clock-frequency", &bus_speed);
+	of_i2c_parse_timings(dev->of_node, &i2c_t, false);
 
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
-	ret = rcar_i2c_clock_calculate(priv, bus_speed);
+	ret = rcar_i2c_clock_calculate(priv, &i2c_t);
 	if (ret < 0)
 		goto out_pm_put;
 
-- 
2.1.4

