From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 04 Oct 2013 06:36:52 +0000
Subject: [PATCH] i2c: rcar: fixup rcar type naming
Message-Id: <87ob75zgn2.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Linux-I2C <linux-i2c@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

b720423a2627f045133bec39a31fe2bc0dab86f3
(i2c: rcar: add rcar-H2 support)
added R-Car H2 support on i2c-rcar.
But the added i2c type naming was H1/H2,
instead of Gen1/Gen2 (Generation 1/2)
Gen1/Gen2 is better naming on this driver.

This patch exchanges rcar_i2c_id_table[],
but it still can keep compatible, since still there is no user
for i2c-rcar_h1/h2 at this point.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/i2c/busses/i2c-rcar.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 8603f5e..2c2fd7c 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -103,8 +103,8 @@ enum {
 #define ID_NACK		(1 << 4)
 
 enum rcar_i2c_type {
-	I2C_RCAR_H1,
-	I2C_RCAR_H2,
+	I2C_RCAR_GEN1,
+	I2C_RCAR_GEN2,
 };
 
 struct rcar_i2c_priv {
@@ -240,10 +240,10 @@ static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv,
 	}
 
 	switch (priv->devtype) {
-	case I2C_RCAR_H1:
+	case I2C_RCAR_GEN1:
 		cdf_width = 2;
 		break;
-	case I2C_RCAR_H2:
+	case I2C_RCAR_GEN2:
 		cdf_width = 3;
 		break;
 	default:
@@ -640,10 +640,10 @@ static const struct i2c_algorithm rcar_i2c_algo = {
 };
 
 static const struct of_device_id rcar_i2c_dt_ids[] = {
-	{ .compatible = "renesas,i2c-rcar", .data = (void *)I2C_RCAR_H1 },
-	{ .compatible = "renesas,i2c-r8a7778", .data = (void *)I2C_RCAR_H1 },
-	{ .compatible = "renesas,i2c-r8a7779", .data = (void *)I2C_RCAR_H1 },
-	{ .compatible = "renesas,i2c-r8a7790", .data = (void *)I2C_RCAR_H2 },
+	{ .compatible = "renesas,i2c-rcar", .data = (void *)I2C_RCAR_GEN1 },
+	{ .compatible = "renesas,i2c-r8a7778", .data = (void *)I2C_RCAR_GEN1 },
+	{ .compatible = "renesas,i2c-r8a7779", .data = (void *)I2C_RCAR_GEN1 },
+	{ .compatible = "renesas,i2c-r8a7790", .data = (void *)I2C_RCAR_GEN2 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rcar_i2c_dt_ids);
@@ -731,9 +731,9 @@ static int rcar_i2c_remove(struct platform_device *pdev)
 }
 
 static struct platform_device_id rcar_i2c_id_table[] = {
-	{ "i2c-rcar",		I2C_RCAR_H1 },
-	{ "i2c-rcar_h1",	I2C_RCAR_H1 },
-	{ "i2c-rcar_h2",	I2C_RCAR_H2 },
+	{ "i2c-rcar",		I2C_RCAR_GEN1 },
+	{ "i2c-rcar_gen1",	I2C_RCAR_GEN1 },
+	{ "i2c-rcar_gen2",	I2C_RCAR_GEN2 },
 	{},
 };
 MODULE_DEVICE_TABLE(platform, rcar_i2c_id_table);
-- 
1.7.9.5

