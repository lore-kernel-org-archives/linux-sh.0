From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 07 Apr 2014 06:33:51 +0000
Subject: [PATCH 01/05] gpio: rcar: Per-controller gpios property prototype
Message-Id: <20140407063351.26152.25813.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Hack up the R-Car GPIO driver to install a "gpios" property
per GPIO controller during run time. This allows drivers
and board code to look up GPIOs from C code using functions
such as of_get_gpio().

Not for upstream merge.

Not-yet-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/gpio/gpio-rcar.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

--- 0001/drivers/gpio/gpio-rcar.c
+++ work/drivers/gpio/gpio-rcar.c	2014-04-07 12:13:13.000000000 +0900
@@ -30,6 +30,10 @@
 #include <linux/slab.h>
 
 struct gpio_rcar_priv {
+	/* per-gpio-device "gpios" for use with of_get_named_gpiod_flags() */
+	struct property gpios_property;
+	__be32 gpios_phandle_value[32 * 3]; /*  #gpio-cells assumed to be 2 */
+
 	void __iomem *base;
 	spinlock_t lock;
 	struct gpio_rcar_config config;
@@ -317,6 +321,7 @@ static int gpio_rcar_parse_pdata(struct
 	struct gpio_rcar_config *pdata = dev_get_platdata(&p->pdev->dev);
 	struct device_node *np = p->pdev->dev.of_node;
 	struct of_phandle_args args;
+	unsigned int k;
 	int ret;
 
 	if (pdata) {
@@ -337,6 +342,18 @@ static int gpio_rcar_parse_pdata(struct
 					 : RCAR_MAX_GPIO_PER_BANK;
 		p->config.gpio_base = -1;
 		p->config.has_both_edge_trigger = info->has_both_edge_trigger;
+
+		/* initialize "gpios" property for this GPIO controller */
+		for (k = 0; k < RCAR_MAX_GPIO_PER_BANK; k++) {
+			p->gpios_phandle_value[k*3] = cpu_to_be32(np->phandle);
+			p->gpios_phandle_value[(k*3) + 1] = cpu_to_be32(k);
+			p->gpios_phandle_value[(k*3) + 2] = cpu_to_be32(0);
+		}
+
+		p->gpios_property.name = "gpios";
+		p->gpios_property.length = sizeof(p->gpios_phandle_value);
+		p->gpios_property.value = p->gpios_phandle_value;
+		of_add_property(np, &p->gpios_property);
 	}
 
 	if (p->config.number_of_pins = 0 ||
@@ -466,6 +483,8 @@ err0:
 static int gpio_rcar_remove(struct platform_device *pdev)
 {
 	struct gpio_rcar_priv *p = platform_get_drvdata(pdev);
+	struct gpio_rcar_config *pdata = dev_get_platdata(&p->pdev->dev);
+	struct device_node *np = p->pdev->dev.of_node;
 	int ret;
 
 	ret = gpiochip_remove(&p->gpio_chip);
@@ -473,6 +492,10 @@ static int gpio_rcar_remove(struct platf
 		return ret;
 
 	irq_domain_remove(p->irq_domain);
+
+	if (!pdata && IS_ENABLED(CONFIG_OF) && np)
+		of_remove_property(np, &p->gpios_property);
+
 	return 0;
 }
 
