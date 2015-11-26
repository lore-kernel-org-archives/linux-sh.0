From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 26 Nov 2015 22:59:13 +0000
Subject: [RFC 5/9] i2c: rcar: honor additional i2c timings from DT
Message-Id: <1448578757-12613-6-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1448578757-12613-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1448578757-12613-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt |  4 ++++
 drivers/i2c/busses/i2c-rcar.c                      | 21 ++++++++++++---------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
index ea406eb20fa5ad..95e97223a71c83 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
@@ -20,6 +20,10 @@ Optional properties:
   propoerty indicates the default frequency 100 kHz.
 - clocks: clock specifier.
 
+- i2c-scl-falling-time-ns: see i2c.txt
+- i2c-scl-internal-delay-ns: see i2c.txt
+- i2c-scl-rising-time-ns: see i2c.txt
+
 Examples :
 
 i2c0: i2c@e6508000 {
diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 453ce10132025d..9465a23bcc91a5 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -164,12 +164,15 @@ static int rcar_i2c_bus_barrier(struct rcar_i2c_priv *priv)
 
 static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv, struct i2c_timings *t)
 {
-	u32 scgd, cdf, round, ick, scl, cdf_width;
+	u32 scgd, cdf, round, ick, sum, scl, cdf_width;
 	unsigned long rate;
 	struct device *dev = rcar_i2c_priv_to_dev(priv);
 
 	/* Fall back to previously used values if not supplied */
 	t->bus_freq = t->bus_freq ?: 100000;
+	t->scl_fall_ns = t->scl_fall_ns ?: 35;
+	t->scl_rise_ns = t->scl_rise_ns ?: 200;
+	t->scl_int_delay_ns = t->scl_int_delay_ns ?: 50;
 
 	switch (priv->devtype) {
 	case I2C_RCAR_GEN1:
@@ -193,9 +196,9 @@ static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv, struct i2c_timin
 	 * SCL	= ick / (20 + SCGD * 8 + F[(ticf + tr + intd) * ick])
 	 *
 	 * ick  : I2C internal clock < 20 MHz
-	 * ticf : I2C SCL falling time  =  35 ns here
-	 * tr   : I2C SCL rising  time  = 200 ns here
-	 * intd : LSI internal delay    =  50 ns here
+	 * ticf : I2C SCL falling time
+	 * tr   : I2C SCL rising  time
+	 * intd : LSI internal delay
 	 * clkp : peripheral_clk
 	 * F[]  : integer up-valuation
 	 */
@@ -211,12 +214,12 @@ static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv, struct i2c_timin
 	 * it is impossible to calculate large scale
 	 * number on u32. separate it
 	 *
-	 * F[(ticf + tr + intd) * ick]
-	 *  = F[(35 + 200 + 50)ns * ick]
-	 *  = F[285 * ick / 1000000000]
-	 *  = F[(ick / 1000000) * 285 / 1000]
+	 * F[(ticf + tr + intd) * ick] with sum = (ticf + tr + intd)
+	 *  = F[sum * ick / 1000000000]
+	 *  = F[(ick / 1000000) * sum / 1000]
 	 */
-	round = (ick + 500000) / 1000000 * 285;
+	sum = t->scl_fall_ns + t->scl_rise_ns + t->scl_int_delay_ns;
+	round = (ick + 500000) / 1000000 * sum;
 	round = (round + 500) / 1000;
 
 	/*
-- 
2.1.4

