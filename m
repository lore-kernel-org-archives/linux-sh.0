From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 28 Apr 2011 04:25:36 +0000
Subject: [PATCH] i2c: i2c-sh_mobile bus speed platform data V2
Message-Id: <20110428042536.2877.12805.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
References: <20110421132254.3725.84300.sendpatchset@t400s>
In-Reply-To: <20110421132254.3725.84300.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, lethal@linux-sh.org, simon@horms.net, ben-linux@fluff.org, khali@linux-fr.org, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm@opensource.se>

Add support to the i2c-sh_mobile driver for setting
the I2C bus speed using platform data.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Changes since V1:
 - Moved header file from include/linux/ to include/linux/i2c/

 drivers/i2c/busses/i2c-sh_mobile.c |   13 +++++++++++--
 include/linux/i2c/i2c-sh_mobile.h  |   10 ++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

--- 0003/drivers/i2c/busses/i2c-sh_mobile.c
+++ work/drivers/i2c/busses/i2c-sh_mobile.c	2011-04-28 13:21:51.000000000 +0900
@@ -32,6 +32,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/i2c/i2c-sh_mobile.h>
 
 /* Transmit operation:                                                      */
 /*                                                                          */
@@ -117,7 +118,7 @@ struct sh_mobile_i2c_data {
 	struct device *dev;
 	void __iomem *reg;
 	struct i2c_adapter adap;
-
+	unsigned long bus_speed;
 	struct clk *clk;
 	u_int8_t icic;
 	u_int8_t iccl;
@@ -205,7 +206,7 @@ static void activate_ch(struct sh_mobile
 	 * We also round off the result.
 	 */
 	num = i2c_clk * 5;
-	denom = NORMAL_SPEED * 9;
+	denom = pd->bus_speed * 9;
 	tmp = num * 10 / denom;
 	if (tmp % 10 >= 5)
 		pd->iccl = (u_int8_t)((num/denom) + 1);
@@ -574,6 +575,7 @@ static int sh_mobile_i2c_hook_irqs(struc
 
 static int sh_mobile_i2c_probe(struct platform_device *dev)
 {
+	struct i2c_sh_mobile_platform_data *pdata = dev->dev.platform_data;
 	struct sh_mobile_i2c_data *pd;
 	struct i2c_adapter *adap;
 	struct resource *res;
@@ -618,6 +620,11 @@ static int sh_mobile_i2c_probe(struct pl
 		goto err_irq;
 	}
 
+	/* Use platformd data bus speed or NORMAL_SPEED */
+	pd->bus_speed = NORMAL_SPEED;
+	if (pdata && pdata->bus_speed)
+		pd->bus_speed = pdata->bus_speed;
+
 	/* The IIC blocks on SH-Mobile ARM processors
 	 * come with two new bits in ICIC.
 	 */
@@ -658,6 +665,8 @@ static int sh_mobile_i2c_probe(struct pl
 		goto err_all;
 	}
 
+	dev_info(&dev->dev, "I2C adapter %d with bus speed %lu Hz\n",
+		 adap->nr, pd->bus_speed);
 	return 0;
 
  err_all:
--- /dev/null
+++ work/include/linux/i2c/i2c-sh_mobile.h	2011-04-28 12:21:45.000000000 +0900
@@ -0,0 +1,10 @@
+#ifndef __I2C_SH_MOBILE_H__
+#define __I2C_SH_MOBILE_H__
+
+#include <linux/platform_device.h>
+
+struct i2c_sh_mobile_platform_data {
+	unsigned long bus_speed;
+};
+
+#endif /* __I2C_SH_MOBILE_H__ */
