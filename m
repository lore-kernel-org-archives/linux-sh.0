From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 09 Sep 2013 15:55:17 +0000
Subject: [PATCH 2/5] i2c: rcar: get clock rate only once and simplify calculation
Message-Id: <1378742120-11135-3-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1378742120-11135-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1378742120-11135-1-git-send-email-g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

There is no need to repeatedly query clock frequency, where it is not
expected to change. The complete loop can also trivially be replaced with
a simple division. A further loop below the one, being simplified, could
also be replaced, but that would get more complicated.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 drivers/i2c/busses/i2c-rcar.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 15eef94..9325db4 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -231,6 +231,7 @@ static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv,
 	u32 round, ick;
 	u32 scl;
 	u32 cdf_width;
+	unsigned long rate;
 
 	if (!clkp) {
 		dev_err(dev, "there is no peripheral_clk\n");
@@ -264,15 +265,14 @@ static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv,
 	 * clkp : peripheral_clk
 	 * F[]  : integer up-valuation
 	 */
-	for (cdf = 0; cdf < (1 << cdf_width); cdf++) {
-		ick = clk_get_rate(clkp) / (1 + cdf);
-		if (ick < 20000000)
-			goto ick_find;
+	rate = clk_get_rate(clkp);
+	cdf = rate / 20000000;
+	if (cdf >= 1 << cdf_width) {
+		dev_err(dev, "Input clock %lu too high\n", rate);
+		return -EIO;
 	}
-	dev_err(dev, "there is no best CDF\n");
-	return -EIO;
+	ick = rate / (cdf + 1);
 
-ick_find:
 	/*
 	 * it is impossible to calculate large scale
 	 * number on u32. separate it
@@ -290,6 +290,12 @@ ick_find:
 	 *
 	 * Calculation result (= SCL) should be less than
 	 * bus_speed for hardware safety
+	 *
+	 * We could use something along the lines of
+	 *	div = ick / (bus_speed + 1) + 1;
+	 *	scgd = (div - 20 - round + 7) / 8;
+	 *	scl = ick / (20 + (scgd * 8) + round);
+	 * (not fully verified) but that would get pretty involved
 	 */
 	for (scgd = 0; scgd < 0x40; scgd++) {
 		scl = ick / (20 + (scgd * 8) + round);
-- 
1.7.2.5

