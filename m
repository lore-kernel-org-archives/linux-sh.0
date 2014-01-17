From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Fri, 17 Jan 2014 18:11:38 +0000
Subject: [PATCH 4/4] i2c: rcar: use devm_clk_get to ensure clock is properly ref-counted
Message-Id: <1389982298-23143-5-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1389982298-23143-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1389982298-23143-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@lists.codethink.co.uk
Cc: linux-sh@vger.kernel.org, horms+renesas@verge.net.au, Ben Dooks <ben.dooks@codethink.co.uk>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

The current i2c-rcar driver does clk_get() without a corresponding
clk_put(). Add the clk to the driver private data and then get it
with the devm functions so that it is released when the driver is
unbound.

Note, we do not call clk_prepare_enable() at this point due to the
very possible magic that is being done by the pm_runtime system
underneath the driver.

Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/i2c/busses/i2c-rcar.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 0d25104..6fd716e 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -111,6 +111,7 @@ struct rcar_i2c_priv {
 	void __iomem *io;
 	struct i2c_adapter adap;
 	struct i2c_msg	*msg;
+	struct clk *clk;
 
 	spinlock_t lock;
 	wait_queue_head_t wait;
@@ -227,18 +228,12 @@ static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv,
 				    u32 bus_speed,
 				    struct device *dev)
 {
-	struct clk *clkp = clk_get(dev, NULL);
 	u32 scgd, cdf;
 	u32 round, ick;
 	u32 scl;
 	u32 cdf_width;
 	unsigned long rate;
 
-	if (IS_ERR(clkp)) {
-		dev_err(dev, "couldn't get clock\n");
-		return PTR_ERR(clkp);
-	}
-
 	switch (priv->devtype) {
 	case I2C_RCAR_GEN1:
 		cdf_width = 2;
@@ -266,7 +261,7 @@ static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv,
 	 * clkp : peripheral_clk
 	 * F[]  : integer up-valuation
 	 */
-	rate = clk_get_rate(clkp);
+	rate = clk_get_rate(priv->clk);
 	cdf = rate / 20000000;
 	if (cdf >= 1 << cdf_width) {
 		dev_err(dev, "Input clock %lu too high\n", rate);
@@ -308,7 +303,7 @@ static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv,
 
 scgd_find:
 	dev_dbg(dev, "clk %d/%d(%lu), round %u, CDF:0x%x, SCGD: 0x%x\n",
-		scl, bus_speed, clk_get_rate(clkp), round, cdf, scgd);
+		scl, bus_speed, clk_get_rate(priv->clk), round, cdf, scgd);
 
 	/*
 	 * keep icccr value
@@ -664,6 +659,12 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		dev_err(dev, "cannot get clock\n");
+		return -ENOENT;
+	}
+
 	bus_speed = 100000; /* default 100 kHz */
 	ret = of_property_read_u32(dev->of_node, "clock-frequency", &bus_speed);
 	if (ret < 0 && pdata && pdata->bus_speed)
-- 
1.8.5.2

