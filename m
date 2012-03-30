From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 30 Mar 2012 08:44:02 +0000
Subject: [PATCH] i2c: i2c-sh_mobile device tree support
Message-Id: <20120330084402.19597.63655.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: arnd@arndb.de, linux-sh@vger.kernel.org, w.sang@pengutronix.de, rjw@sisk.pl, lethal@linux-sh.org, ben-linux@fluff.org, khali@linux-fr.org, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm@opensource.se>

This patch enables DT support for the IIC driver
used on SH-based SoCs such as sh7722 and sh7724
among others as well as SH-Mobile SoCs such as
sh7367, sh7377, sh7372, sh73a0 and r8a7740.

Tested with out-of-tree DT support code on the
sh7372 Mackerel board.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/i2c/busses/i2c-sh_mobile.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- 0001/drivers/i2c/busses/i2c-sh_mobile.c
+++ work/drivers/i2c/busses/i2c-sh_mobile.c	2012-03-29 14:39:42.000000000 +0900
@@ -27,6 +27,7 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
+#include <linux/of_i2c.h>
 #include <linux/err.h>
 #include <linux/pm_runtime.h>
 #include <linux/clk.h>
@@ -653,6 +654,7 @@ static int sh_mobile_i2c_probe(struct pl
 	adap->dev.parent = &dev->dev;
 	adap->retries = 5;
 	adap->nr = dev->id;
+	adap->dev.of_node = dev->dev.of_node;
 
 	strlcpy(adap->name, dev->name, sizeof(adap->name));
 
@@ -667,6 +669,8 @@ static int sh_mobile_i2c_probe(struct pl
 
 	dev_info(&dev->dev, "I2C adapter %d with bus speed %lu Hz\n",
 		 adap->nr, pd->bus_speed);
+
+	of_i2c_register_devices(adap);
 	return 0;
 
  err_all:
@@ -710,11 +714,18 @@ static const struct dev_pm_ops sh_mobile
 	.runtime_resume = sh_mobile_i2c_runtime_nop,
 };
 
+static const struct of_device_id sh_mobile_i2c_dt_ids[] __devinitconst = {
+	{ .compatible = "renesas,rmobile-iic", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sh_mobile_i2c_dt_ids);
+
 static struct platform_driver sh_mobile_i2c_driver = {
 	.driver		= {
 		.name		= "i2c-sh_mobile",
 		.owner		= THIS_MODULE,
 		.pm		= &sh_mobile_i2c_dev_pm_ops,
+		.of_match_table = sh_mobile_i2c_dt_ids,
 	},
 	.probe		= sh_mobile_i2c_probe,
 	.remove		= sh_mobile_i2c_remove,
