From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 07 Oct 2015 08:16:31 +0000
Subject: [PATCH] i2c: rcar: Remove obsolete platform data support
Message-Id: <1444205791-25480-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Since commit 4baadb9e05c68962 ("ARM: shmobile: r8a7778: remove obsolete
setup code"), Renesas R-Car SoCs are only supported in generic DT-only
ARM multi-platform builds.  The driver doesn't need to use platform data
anymore, hence remove platform data configuration.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Commit 4baadb9e05c68962 is now in arm-soc/for-next.
---
 drivers/i2c/busses/i2c-rcar.c | 19 +------------------
 include/linux/i2c/i2c-rcar.h  | 10 ----------
 2 files changed, 1 insertion(+), 28 deletions(-)
 delete mode 100644 include/linux/i2c/i2c-rcar.h

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 3e125654bb28..cd38406db074 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -27,7 +27,6 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/i2c.h>
-#include <linux/i2c/i2c-rcar.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
@@ -634,7 +633,6 @@ MODULE_DEVICE_TABLE(of, rcar_i2c_dt_ids);
 
 static int rcar_i2c_probe(struct platform_device *pdev)
 {
-	struct i2c_rcar_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct rcar_i2c_priv *priv;
 	struct i2c_adapter *adap;
 	struct resource *res;
@@ -654,14 +652,8 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 
 	bus_speed = 100000; /* default 100 kHz */
 	ret = of_property_read_u32(dev->of_node, "clock-frequency", &bus_speed);
-	if (ret < 0 && pdata && pdata->bus_speed)
-		bus_speed = pdata->bus_speed;
 
-	if (pdev->dev.of_node)
-		priv->devtype = (long)of_match_device(rcar_i2c_dt_ids,
-						      dev)->data;
-	else
-		priv->devtype = platform_get_device_id(pdev)->driver_data;
+	priv->devtype = (long)of_match_device(rcar_i2c_dt_ids, dev)->data;
 
 	ret = rcar_i2c_clock_calculate(priv, bus_speed, dev);
 	if (ret < 0)
@@ -718,14 +710,6 @@ static int rcar_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct platform_device_id rcar_i2c_id_table[] = {
-	{ "i2c-rcar",		I2C_RCAR_GEN1 },
-	{ "i2c-rcar_gen1",	I2C_RCAR_GEN1 },
-	{ "i2c-rcar_gen2",	I2C_RCAR_GEN2 },
-	{},
-};
-MODULE_DEVICE_TABLE(platform, rcar_i2c_id_table);
-
 static struct platform_driver rcar_i2c_driver = {
 	.driver	= {
 		.name	= "i2c-rcar",
@@ -733,7 +717,6 @@ static struct platform_driver rcar_i2c_driver = {
 	},
 	.probe		= rcar_i2c_probe,
 	.remove		= rcar_i2c_remove,
-	.id_table	= rcar_i2c_id_table,
 };
 
 module_platform_driver(rcar_i2c_driver);
diff --git a/include/linux/i2c/i2c-rcar.h b/include/linux/i2c/i2c-rcar.h
deleted file mode 100644
index 496f5c2b23c9..000000000000
--- a/include/linux/i2c/i2c-rcar.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef __I2C_R_CAR_H__
-#define __I2C_R_CAR_H__
-
-#include <linux/platform_device.h>
-
-struct i2c_rcar_platform_data {
-	u32 bus_speed;
-};
-
-#endif /* __I2C_R_CAR_H__ */
-- 
1.9.1

