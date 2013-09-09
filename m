From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 09 Sep 2013 15:55:18 +0000
Subject: [PATCH 3/5] i2c: rcar: add Device Tree support
Message-Id: <1378742120-11135-4-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1378742120-11135-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1378742120-11135-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

This patch adds Device Tree support to the i2c-rcar driver and respective
documentation.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt |   22 ++++++++++++++++++++
 drivers/i2c/busses/i2c-rcar.c                      |   20 ++++++++++++++++-
 2 files changed, 40 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-rcar.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
new file mode 100644
index 0000000..b3c030b
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
@@ -0,0 +1,22 @@
+I2C for R-Car platforms
+
+Required properties:
+- compatible: Must be one of
+	"renesas,i2c-rcar"
+	"renesas,i2c-rcar-h1"
+	"renesas,i2c-rcar-h2"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: interrupt specifier.
+
+Optional properties:
+- clock-frequency: desired I2C bus clock frequency in Hz. The absence of this
+  propoerty indicates the default frequency 100 kHz.
+
+Examples :
+
+i2c0: i2c@e6500000 {
+	compatible = "renesas,i2c-rcar-h2";
+	reg = <0 0xe6500000 0 0x428>;
+	interrupts = <0 174 0x4>;
+};
diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 9325db4..be801b9 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -33,6 +33,7 @@
 #include <linux/i2c/i2c-rcar.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
@@ -638,6 +639,14 @@ static const struct i2c_algorithm rcar_i2c_algo = {
 	.functionality	= rcar_i2c_func,
 };
 
+static const struct of_device_id rcar_i2c_dt_ids[] = {
+	{ .compatible = "renesas,i2c-rcar", .data = (void *)I2C_RCAR_H1 },
+	{ .compatible = "renesas,i2c-rcar-h1", .data = (void *)I2C_RCAR_H1 },
+	{ .compatible = "renesas,i2c-rcar-h2", .data = (void *)I2C_RCAR_H2 },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rcar_i2c_dt_ids);
+
 static int rcar_i2c_probe(struct platform_device *pdev)
 {
 	struct i2c_rcar_platform_data *pdata = dev_get_platdata(&pdev->dev);
@@ -655,10 +664,15 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	}
 
 	bus_speed = 100000; /* default 100 kHz */
-	if (pdata && pdata->bus_speed)
+	ret = of_property_read_u32(dev->of_node, "clock-frequency", &bus_speed);
+	if (ret < 0 && pdata && pdata->bus_speed)
 		bus_speed = pdata->bus_speed;
 
-	priv->devtype = platform_get_device_id(pdev)->driver_data;
+	if (pdev->dev.of_node)
+		priv->devtype = (long)of_match_device(rcar_i2c_dt_ids,
+						      dev)->data;
+	else
+		priv->devtype = platform_get_device_id(pdev)->driver_data;
 
 	ret = rcar_i2c_clock_calculate(priv, bus_speed, dev);
 	if (ret < 0)
@@ -679,6 +693,7 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	adap->class		= I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	adap->retries		= 3;
 	adap->dev.parent	= dev;
+	adap->dev.of_node	= dev->of_node;
 	i2c_set_adapdata(adap, priv);
 	strlcpy(adap->name, pdev->name, sizeof(adap->name));
 
@@ -726,6 +741,7 @@ static struct platform_driver rcar_i2c_driver = {
 	.driver	= {
 		.name	= "i2c-rcar",
 		.owner	= THIS_MODULE,
+		.of_match_table = rcar_i2c_dt_ids,
 	},
 	.probe		= rcar_i2c_probe,
 	.remove		= rcar_i2c_remove,
-- 
1.7.2.5

