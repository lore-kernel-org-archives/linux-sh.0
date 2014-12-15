From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 15 Dec 2014 20:20:17 +0000
Subject: [RFC 4/4] i2c: mux: demux-pinctrl: add driver
Message-Id: <1418674817-12809-5-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

This is the driver which maps n different I2C IP cores to the same bus.
Very experimental, mainly a proof of concept for now.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 .../devicetree/bindings/i2c/i2c-demux-pinctrl.txt  |  65 ++++++++
 drivers/i2c/muxes/Kconfig                          |   6 +
 drivers/i2c/muxes/Makefile                         |   2 +
 drivers/i2c/muxes/i2c-demux-pinctrl.c              | 183 +++++++++++++++++++++
 4 files changed, 256 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt
 create mode 100644 drivers/i2c/muxes/i2c-demux-pinctrl.c

diff --git a/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt b/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt
new file mode 100644
index 000000000000..a03d4c0f8098
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt
@@ -0,0 +1,65 @@
+Pinctrl-based I2C Bus DeMux
+
+This binding describes an I2C bus demultiplexer that uses pin multiplexing to
+route the I2C signals, and represents the pin multiplexing configuration using
+the pinctrl device tree bindings. This may be used to select one I2C IP core at
+runtime which may have a better feature set for a given task than another I2C
+IP core on the SoC.
+
+    +------------------------------+
+    | SoC                          |
+    |                              |   +-----+  +-----+
+    |   +------------+             |   | dev |  | dev |
+    |   |I2C IP Core1|--\          |   +-----+  +-----+
+    |   +------------+   \------+  |      |        |
+    |                    |Pinmux|--|------+--------+
+    |   +------------+   +------+  |
+    |   |I2C IP Core2|--/          |
+    |   +------------+             |
+    |                              |
+    +------------------------------+
+
+Required properties:
+- compatible: i2c-demux-pinctrl
+- i2c-parent: List of phandles of I2C cores to be selected
+
+Also required are:
+
+* Standard pinctrl properties that specify the pin mux state for each child
+  bus. See ../pinctrl/pinctrl-bindings.txt.
+
+* Standard I2C mux properties. See mux.txt in this directory.
+
+* I2C child bus nodes. See mux.txt in this directory.
+
+Note: The child bus nodes must be connected to sub-bus number 0 as shown in the
+example below.
+
+Example:
+
+	i2c-demux {
+
+		compatible = "i2c-demux-pinctrl";
+		i2c-parent = <&iic2>, <&i2c2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			composite-in@20 {
+				compatible = "adi,adv7180";
+				reg = <0x20>;
+				remote = <&vin1>;
+
+				port {
+					adv7180: endpoint {
+						bus-width = <8>;
+						remote-endpoint = <&vin1ep0>;
+					};
+				};
+			};
+		};
+	};
diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
index f6d313e528de..281747d8cf48 100644
--- a/drivers/i2c/muxes/Kconfig
+++ b/drivers/i2c/muxes/Kconfig
@@ -60,4 +60,10 @@ config I2C_MUX_PINCTRL
 	  This driver can also be built as a module. If so, the module will be
 	  called pinctrl-i2cmux.
 
+config I2C_DEMUX_PINCTRL
+	tristate "pinctrl-based I2C demultiplexer"
+	depends on PINCTRL
+	help
+	  PROTOYPE! Understand the docs!
+
 endmenu
diff --git a/drivers/i2c/muxes/Makefile b/drivers/i2c/muxes/Makefile
index 465778b5d5dc..4d14cb88d834 100644
--- a/drivers/i2c/muxes/Makefile
+++ b/drivers/i2c/muxes/Makefile
@@ -3,6 +3,8 @@
 
 obj-$(CONFIG_I2C_ARB_GPIO_CHALLENGE)	+= i2c-arb-gpio-challenge.o
 
+obj-$(CONFIG_I2C_DEMUX_PINCTRL)		+= i2c-demux-pinctrl.o
+
 obj-$(CONFIG_I2C_MUX_GPIO)	+= i2c-mux-gpio.o
 obj-$(CONFIG_I2C_MUX_PCA9541)	+= i2c-mux-pca9541.o
 obj-$(CONFIG_I2C_MUX_PCA954x)	+= i2c-mux-pca954x.o
diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
new file mode 100644
index 000000000000..ed4a25be89ba
--- /dev/null
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -0,0 +1,183 @@
+/*
+ * Pinctrl based I2C DeMultiplexer PROTOTYPE!
+ *
+ * Copyright (C) 2014 by Wolfram Sang, Sang Engineering <wsa@sang-engineering.com>
+ * Copyright (C) 2014 by Renesas Electronics Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; version 2 of the License.
+ *
+ * See the bindings doc for DTS setup.
+ *
+ * For n parents, n+1 new busses are created:
+ *   1st new bus is the demuxed bus with the first parent as the master
+ *   Nth new bus is the demuxed bus with the N-th parent as the master
+ *   N+1st new bus is the demuxed bus using the last active master
+ *   (needed because kernel client drivers need a static bus number for the client)
+ *
+ * Example:
+ *   i2c-0 is native I2C IP core A and first parent of the demuxed bus
+ *   i2c-1 is native I2C IP core B and second parent of the demuxed bus
+ *   i2c-2 accesses the demuxed bus with IP core A
+ *   i2c-3 accesses the demuxed bus with IP core B
+ *   i2c-4 accesses the demuxed bus with the last used IP core
+ *
+ * i2c-0 and i2c-1 should not be used directly. Their pins might not be muxed.
+ * All kernel I2C clients should be attached to i2c-4, so they have static bus number.
+ *
+ * Switching a master currently needs some access to either i2c-2 or i2c-3.
+ * Switching could also be done via sysfs or any other config mechanism.
+ * For this proof-of-concept, extra busses have been used since it simplifies
+ * locking a little.
+ */
+
+#include <linux/i2c.h>
+#include <linux/i2c-mux.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+struct i2c_demux_pinctrl_chan {
+	struct i2c_adapter *parent;
+	struct i2c_adapter *child;
+	struct pinctrl *p;
+	struct pinctrl_state *p_state;
+};
+
+struct i2c_demux_pinctrl_priv {
+	u32 last_chan;
+	int num_chan;
+	struct i2c_demux_pinctrl_chan chan[];
+};
+
+//FIXME: Lock also inacticve adapters
+static int i2c_demux_pinctrl_dummy(struct i2c_adapter *adap, void *data, u32 new_chan)
+{
+	return 0;
+}
+
+static int i2c_demux_pinctrl_select(struct i2c_adapter *adap, void *data, u32 new_chan)
+{
+	struct i2c_demux_pinctrl_priv *priv = data;
+	int err;
+
+	if (new_chan = priv->last_chan)
+		return 0;
+
+	pinctrl_deselect_state(priv->chan[priv->last_chan].p);
+	err = pinctrl_select_state(priv->chan[new_chan].p,
+				   priv->chan[new_chan].p_state);
+	if (!err) {
+		priv->last_chan = new_chan;
+		i2c_mux_reparent(priv->chan[0].child, priv->chan[new_chan].parent);
+	}
+
+	return err;
+}
+
+//FIXME: Proper error paths and correct rollback
+static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
+{
+	struct i2c_demux_pinctrl_priv *priv;
+	struct device_node *np = pdev->dev.of_node;
+	int num_chan, i;
+
+	num_chan = 1 + of_count_phandle_with_args(np, "i2c-parent", NULL);
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv)
+			   + num_chan * sizeof(struct i2c_demux_pinctrl_chan), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->num_chan = num_chan;
+
+	for (i = 1; i < num_chan; i++) {
+		struct device_node *adap_np;
+		struct i2c_adapter *adap;
+
+		adap_np = of_parse_phandle(np, "i2c-parent", i - 1);
+		if (!adap_np) {
+			dev_err(&pdev->dev, "Can't get phandle for bus %d\n", i);
+			return -ENODEV;
+		}
+
+		adap = of_find_i2c_adapter_by_node(adap_np);
+		if (!adap) {
+			dev_err(&pdev->dev, "Cannot find parent bus %d\n", i);
+			return -EPROBE_DEFER;
+		}
+
+		priv->chan[i].p = devm_pinctrl_get(adap->dev.parent);
+		if (IS_ERR(priv->chan[i].p)) {
+			dev_err(&pdev->dev, "no pinctrl handle\n");
+			return -ENODEV;
+		}
+
+		priv->chan[i].p_state = pinctrl_lookup_state(priv->chan[i].p, "active");
+		if (IS_ERR(priv->chan[i].p_state)) {
+			dev_err(&pdev->dev, "no demux pinctrl state\n");
+			return -ENODEV;
+		}
+
+		priv->chan[i].child = i2c_add_mux_adapter(adap, &pdev->dev, priv,
+						0, i, 0, i2c_demux_pinctrl_select, NULL);
+		if (!priv->chan[i].child) {
+			dev_err(&pdev->dev, "Cannot create mux bus %d\n", i);
+			return -ENODEV;
+		}
+
+		priv->chan[i].parent = adap;
+	}
+
+	if (i = 1)
+		return -ENODEV;
+
+	platform_set_drvdata(pdev, priv);
+
+	pinctrl_select_state(priv->chan[1].p, priv->chan[1].p_state);
+	priv->last_chan = 1;
+
+	priv->chan[0].child = i2c_add_mux_adapter(priv->chan[1].child, &pdev->dev, priv,
+					0, 0, 0, i2c_demux_pinctrl_dummy, NULL);
+
+	return 0;
+}
+
+static int i2c_demux_pinctrl_remove(struct platform_device *pdev)
+{
+	struct i2c_demux_pinctrl_priv *priv = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < priv->num_chan; i++) {
+		i2c_del_mux_adapter(priv->chan[i].child);
+		if (i)
+			i2c_put_adapter(priv->chan[i].parent);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id i2c_demux_pinctrl_of_match[] = {
+	{ .compatible = "i2c-demux-pinctrl", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, i2c_demux_pinctrl_of_match);
+
+static struct platform_driver i2c_demux_pinctrl_driver = {
+	.driver	= {
+		.name = "i2c-demux-pinctrl",
+		.of_match_table = i2c_demux_pinctrl_of_match,
+	},
+	.probe	= i2c_demux_pinctrl_probe,
+	.remove	= i2c_demux_pinctrl_remove,
+};
+module_platform_driver(i2c_demux_pinctrl_driver);
+
+MODULE_DESCRIPTION("pinctrl-based I2C demux driver");
+MODULE_AUTHOR("Wolfram Sang <wsa@sang-engineering.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:i2c-demux-pinctrl");
-- 
2.1.3

