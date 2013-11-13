From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 13 Nov 2013 16:26:23 +0000
Subject: [PATCH] gpio: rcar: Support both edge trigger with DT
Message-Id: <1384359983-29178-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-gpio@vger.kernel.org, Simon Horman <horms@verge.net.au>

Some versions of the R-Car GPIO controller support triggering on both
edges of the input signal. Whether this capability is supported is
currently specified in platform data. R-Car GPIO devices instantiated
from the device tree have the capability turned off even when the
hardware supports it.

To fix this, add DT match data support to the driver, initialize both
edge trigger support from match data and enable both edge trigger in
r8a7790 and r8a7791 match data.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpio/gpio-rcar.c | 56 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 43 insertions(+), 13 deletions(-)

The patch has been tested on a Lager board. Simon, I've understood that you
need this to add GPIO keys support to the Lager DT. Would you be able to test
that ?

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 6038966..68b0940 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -283,7 +283,34 @@ static struct irq_domain_ops gpio_rcar_irq_domain_ops = {
 	.map	= gpio_rcar_irq_domain_map,
 };
 
-static void gpio_rcar_parse_pdata(struct gpio_rcar_priv *p)
+struct gpio_rcar_info {
+	bool has_both_edge_trigger;
+};
+
+static const struct of_device_id gpio_rcar_of_table[] = {
+	{
+		.compatible = "renesas,gpio-r8a7790",
+		.data = (void *)&(const struct gpio_rcar_info) {
+			.has_both_edge_trigger = true,
+		},
+	}, {
+		.compatible = "renesas,gpio-r8a7791",
+		.data = (void *)&(const struct gpio_rcar_info) {
+			.has_both_edge_trigger = true,
+		},
+	}, {
+		.compatible = "renesas,gpio-rcar",
+		.data = (void *)&(const struct gpio_rcar_info) {
+			.has_both_edge_trigger = false,
+		},
+	}, {
+		/* Terminator */
+	},
+};
+
+MODULE_DEVICE_TABLE(of, gpio_rcar_of_table);
+
+static int gpio_rcar_parse_pdata(struct gpio_rcar_priv *p)
 {
 	struct gpio_rcar_config *pdata = dev_get_platdata(&p->pdev->dev);
 	struct device_node *np = p->pdev->dev.of_node;
@@ -293,11 +320,21 @@ static void gpio_rcar_parse_pdata(struct gpio_rcar_priv *p)
 	if (pdata) {
 		p->config = *pdata;
 	} else if (IS_ENABLED(CONFIG_OF) && np) {
+		const struct of_device_id *match;
+		const struct gpio_rcar_info *info;
+
+		match = of_match_node(gpio_rcar_of_table, np);
+		if (!match)
+			return -EINVAL;
+
+		info = match->data;
+
 		ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0,
 						       &args);
 		p->config.number_of_pins = ret = 0 ? args.args[2]
 					 : RCAR_MAX_GPIO_PER_BANK;
 		p->config.gpio_base = -1;
+		p->config.has_both_edge_trigger = info->has_both_edge_trigger;
 	}
 
 	if (p->config.number_of_pins = 0 ||
@@ -307,6 +344,8 @@ static void gpio_rcar_parse_pdata(struct gpio_rcar_priv *p)
 			 p->config.number_of_pins, RCAR_MAX_GPIO_PER_BANK);
 		p->config.number_of_pins = RCAR_MAX_GPIO_PER_BANK;
 	}
+
+	return 0;
 }
 
 static int gpio_rcar_probe(struct platform_device *pdev)
@@ -329,7 +368,9 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 	spin_lock_init(&p->lock);
 
 	/* Get device configuration from DT node or platform data. */
-	gpio_rcar_parse_pdata(p);
+	ret = gpio_rcar_parse_pdata(p);
+	if (ret < 0)
+		return ret;
 
 	platform_set_drvdata(pdev, p);
 
@@ -434,17 +475,6 @@ static int gpio_rcar_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_OF
-static const struct of_device_id gpio_rcar_of_table[] = {
-	{
-		.compatible = "renesas,gpio-rcar",
-	},
-	{ },
-};
-
-MODULE_DEVICE_TABLE(of, gpio_rcar_of_table);
-#endif
-
 static struct platform_driver gpio_rcar_device_driver = {
 	.probe		= gpio_rcar_probe,
 	.remove		= gpio_rcar_remove,
-- 
Regards,

Laurent Pinchart

