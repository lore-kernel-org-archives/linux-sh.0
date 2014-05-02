From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 02 May 2014 19:15:16 +0000
Subject: [PATCH v2 10/10] i2c: sh_mobile: fix clock calculation for newer SoCs
Message-Id: <1399058116-7721-11-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1399058116-7721-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1399058116-7721-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Newer SoCs have so fast input clocks that the ICCL/H registers only
count every second clock to have a meaningful 9-bit range. The driver
was already prepared for that happening, but didn't use it so far.
Add the proper DT configuration for SoCs that need it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 48 ++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index b1d399e3e5fc..c29be2bba6ea 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -32,6 +32,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/of_device.h>
 #include <linux/i2c/i2c-sh_mobile.h>
 
 /* Transmit operation:                                                      */
@@ -139,6 +140,10 @@ struct sh_mobile_i2c_data {
 	bool send_stop;
 };
 
+struct sh_mobile_dt_config {
+	int clks_per_count;
+};
+
 #define IIC_FLAG_HAS_ICIC67	(1 << 0)
 
 #define STANDARD_MODE		100000
@@ -617,6 +622,22 @@ static struct i2c_algorithm sh_mobile_i2c_algorithm = {
 	.master_xfer	= sh_mobile_i2c_xfer,
 };
 
+static const struct sh_mobile_dt_config default_dt_config = {
+	.clks_per_count = 1,
+};
+
+static const struct sh_mobile_dt_config rcar_gen2_dt_config = {
+	.clks_per_count = 2,
+};
+
+static const struct of_device_id sh_mobile_i2c_dt_ids[] = {
+	{ .compatible = "renesas,rmobile-iic", .data = &default_dt_config },
+	{ .compatible = "renesas,iic-r8a7790", .data = &rcar_gen2_dt_config },
+	{ .compatible = "renesas,iic-r8a7791", .data = &rcar_gen2_dt_config },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sh_mobile_i2c_dt_ids);
+
 static int sh_mobile_i2c_hook_irqs(struct platform_device *dev)
 {
 	struct resource *res;
@@ -674,11 +695,24 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 	ret = of_property_read_u32(dev->dev.of_node, "clock-frequency", &bus_speed);
 	pd->bus_speed = ret ? STANDARD_MODE : bus_speed;
 
-	if (pdata && pdata->bus_speed)
-		pd->bus_speed = pdata->bus_speed;
 	pd->clks_per_count = 1;
-	if (pdata && pdata->clks_per_count)
-		pd->clks_per_count = pdata->clks_per_count;
+
+	if (dev->dev.of_node) {
+		const struct of_device_id *match;
+
+		match = of_match_device(sh_mobile_i2c_dt_ids, &dev->dev);
+		if (match) {
+			const struct sh_mobile_dt_config *config;
+
+			config = match->data;
+			pd->clks_per_count = config->clks_per_count;
+		}
+	} else {
+		if (pdata && pdata->bus_speed)
+			pd->bus_speed = pdata->bus_speed;
+		if (pdata && pdata->clks_per_count)
+			pd->clks_per_count = pdata->clks_per_count;
+	}
 
 	/* The IIC blocks on SH-Mobile ARM processors
 	 * come with two new bits in ICIC.
@@ -758,12 +792,6 @@ static const struct dev_pm_ops sh_mobile_i2c_dev_pm_ops = {
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

