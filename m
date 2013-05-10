From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 10 May 2013 14:48:37 +0000
Subject: [RFC/PATCH 2/2] gpio-rcar: Add DT support
Message-Id: <1368197317-13169-3-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1368197317-13169-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1368197317-13169-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <damm@opensource.se>

Add DT bindings for the gpio-rcar driver and read the device
configuration from the DT node at probe time if available.

Cc: devicetree-discuss@lists.ozlabs.org
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 .../devicetree/bindings/gpio/renesas,gpio-rcar.txt | 48 +++++++++++++++++
 drivers/gpio/gpio-rcar.c                           | 63 ++++++++++++++++++----
 2 files changed, 101 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt

diff --git a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
new file mode 100644
index 0000000..a2f4cd1
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
@@ -0,0 +1,48 @@
+* Renesas R-Car GPIO Controller
+
+Required Properties:
+
+  - compatible: should be one of the following.
+    - "renesas,gpio-r8a7778": for R8A7778 (R-Mobile M1) compatible GPIO controller.
+    - "renesas,gpio-r8a7779": for R8A7779 (R-Car H1) compatible GPIO controller.
+    - "renesas,gpio-r8a7790": for R8A7790 (R-Car H2) compatible GPIO controller.
+    - "renesas,gpio-rcar": for generic R-Car GPIO controller.
+
+  - reg: Base address and length of each memory resource used by the GPIO
+    controller hardware module.
+
+  - interrupt-parent: phandle of the parent interrupt controller.
+  - interrupts: Interrupt specifier for the controllers interrupt.
+
+  - gpio-controller: Marks the device node as a gpio controller.
+  - #gpio-cells: Should be 2. The first cell is the GPIO number and the second
+    cell is used to specify optional parameters as bit flags. Only the GPIO
+    active low flag (bit 0) is currently supported.
+
+Optional Properties:
+
+  - #gpio-lines: Number of GPIOs handled by this controller (defaults to 32).
+
+Please refer to gpio.txt in this directory for details of the common GPIO
+bindings used by client devices.
+
+Example: R8A7779 (R-Car H1) GPIO controller nodes
+
+	gpio0: gpio@ffc40000 {
+		compatible = "renesas,gpio-r8a7779", "renesas,gpio-rcar";
+		reg = <0xffc40000 0x2c>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 141 0x4>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+	...
+	gpio6: gpio@ffc46000 {
+		compatible = "renesas,gpio-r8a7779", "renesas,gpio-rcar";
+		reg = <0xffc46000 0x2c>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 147 0x4>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		#gpio-lines = <9>;
+	};
diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 0f3d647..a499ea6 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -50,6 +50,8 @@ struct gpio_rcar_priv {
 #define EDGLEVEL 0x24
 #define FILONOFF 0x28
 
+#define RCAR_MAX_GPIO_PER_BANK		32
+
 static inline u32 gpio_rcar_read(struct gpio_rcar_priv *p, int offs)
 {
 	return ioread32(p->base + offs);
@@ -258,9 +260,37 @@ static struct irq_domain_ops gpio_rcar_irq_domain_ops = {
 	.map	= gpio_rcar_irq_domain_map,
 };
 
+static void gpio_rcar_parse_pdata(struct gpio_rcar_priv *p)
+{
+	struct gpio_rcar_config *pdata = p->pdev->dev.platform_data;
+#ifdef CONFIG_OF
+	struct device_node *np = p->pdev->dev.of_node;
+	u32 gpio_lines;
+	int ret;
+#endif
+
+	if (pdata)
+		p->config = *pdata;
+#ifdef CONFIG_OF
+	else if (np) {
+		ret = of_property_read_u32(np, "#gpio-lines", &gpio_lines);
+		p->config.number_of_pins = ret = 0 ? gpio_lines
+					 : RCAR_MAX_GPIO_PER_BANK;
+		p->config.gpio_base = -1;
+	}
+#endif
+
+	if (p->config.number_of_pins = 0 ||
+	    p->config.number_of_pins > RCAR_MAX_GPIO_PER_BANK) {
+		dev_warn(&p->pdev->dev,
+			 "Invalid number of gpio lines %u, using %u\n",
+			 p->config.number_of_pins, RCAR_MAX_GPIO_PER_BANK);
+		p->config.number_of_pins = RCAR_MAX_GPIO_PER_BANK;
+	}
+}
+
 static int gpio_rcar_probe(struct platform_device *pdev)
 {
-	struct gpio_rcar_config *pdata = pdev->dev.platform_data;
 	struct gpio_rcar_priv *p;
 	struct resource *io, *irq;
 	struct gpio_chip *gpio_chip;
@@ -275,14 +305,14 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
-	/* deal with driver instance configuration */
-	if (pdata)
-		p->config = *pdata;
-
 	p->pdev = pdev;
-	platform_set_drvdata(pdev, p);
 	spin_lock_init(&p->lock);
 
+	/* Get device configuration from DT node or platform data. */
+	gpio_rcar_parse_pdata(p);
+
+	platform_set_drvdata(pdev, p);
+
 	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 
@@ -355,10 +385,12 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 				 p->config.irq_base, ret);
 	}
 
-	ret = gpiochip_add_pin_range(gpio_chip, p->config.pctl_name, 0,
-				     gpio_chip->base, gpio_chip->ngpio);
-	if (ret < 0)
-		dev_warn(&pdev->dev, "failed to add pin range\n");
+	if (p->config.pctl_name) {
+		ret = gpiochip_add_pin_range(gpio_chip, p->config.pctl_name, 0,
+					     gpio_chip->base, gpio_chip->ngpio);
+		if (ret < 0)
+			dev_warn(&pdev->dev, "failed to add pin range\n");
+	}
 
 	return 0;
 
@@ -381,11 +413,22 @@ static int gpio_rcar_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id gpio_rcar_of_table[] = {
+	{
+		.compatible = "renesas,gpio-rcar",
+	},
+};
+
+MODULE_DEVICE_TABLE(of, gpio_rcar_of_table);
+#endif
+
 static struct platform_driver gpio_rcar_device_driver = {
 	.probe		= gpio_rcar_probe,
 	.remove		= gpio_rcar_remove,
 	.driver		= {
 		.name	= "gpio_rcar",
+		.of_match_table = of_match_ptr(gpio_rcar_of_table),
 	}
 };
 
-- 
1.8.1.5

