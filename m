From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 01 May 2014 11:59:14 +0000
Subject: [RFC] i2c: sh_mobile: WIP! Fix clock calculation for newer SoCs
Message-Id: <1398945555-12928-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Newer SoCs have so fast input clocks that the ICCL/H registers only
count every second clock to have a meaningful 9-bit range. The driver
was already prepared for that happening, but didn't use it so far.

This patch still needs some improvements, but already shows what I am
aiming for.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index ddc9970fd724..d399b9a355b6 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -32,6 +32,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/of_device.h>
 #include <linux/i2c/i2c-sh_mobile.h>
 
 /* Transmit operation:                                                      */
@@ -611,6 +612,14 @@ static struct i2c_algorithm sh_mobile_i2c_algorithm = {
 	.master_xfer	= sh_mobile_i2c_xfer,
 };
 
+static const struct of_device_id sh_mobile_i2c_dt_ids[] = {
+	{ .compatible = "renesas,rmobile-iic", .data = (void *)1 },
+	{ .compatible = "renesas,iic-r8a7790", .data = (void *)2 },
+	{ .compatible = "renesas,iic-r8a7791", .data = (void *)2 },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sh_mobile_i2c_dt_ids);
+
 static int sh_mobile_i2c_hook_irqs(struct platform_device *dev)
 {
 	struct resource *res;
@@ -668,11 +677,18 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 	ret = of_property_read_u32(dev->dev.of_node, "clock-frequency", &bus_speed);
 	pd->bus_speed = ret ? STANDARD_MODE : bus_speed;
 
-	if (pdata && pdata->bus_speed)
-		pd->bus_speed = pdata->bus_speed;
-	pd->clks_per_count = 1;
-	if (pdata && pdata->clks_per_count)
-		pd->clks_per_count = pdata->clks_per_count;
+	if (dev->dev.of_node) {
+		const struct of_device_id *match;
+
+		match = of_match_device(sh_mobile_i2c_dt_ids, &dev->dev);
+		pd->clks_per_count = match->data;
+	} else {
+		if (pdata && pdata->bus_speed)
+			pd->bus_speed = pdata->bus_speed;
+		pd->clks_per_count = 1;
+		if (pdata && pdata->clks_per_count)
+			pd->clks_per_count = pdata->clks_per_count;
+	}
 
 	/* The IIC blocks on SH-Mobile ARM processors
 	 * come with two new bits in ICIC.
@@ -750,12 +766,6 @@ static const struct dev_pm_ops sh_mobile_i2c_dev_pm_ops = {
 	.runtime_resume = sh_mobile_i2c_runtime_nop,
 };
 
-static const struct of_device_id sh_mobile_i2c_dt_ids[] = {
-	{ .compatible = "renesas,rmobile-iic", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, sh_mobile_i2c_dt_ids);
-
 static struct platform_driver sh_mobile_i2c_driver = {
 	.driver		= {
 		.name		= "i2c-sh_mobile",
-- 
1.9.2

