From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 29 Apr 2015 20:46:42 +0000
Subject: [PATCH v3 3/3] i2c: mux: demux-pinctrl: add driver
Message-Id: <1430340402-21586-4-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

This is the second approach of a driver which maps n different I2C IP
cores to the same bus. Very experimental, mainly a proof of concept for
now. Not for upstream!

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 .../devicetree/bindings/i2c/i2c-demux-pinctrl.txt  |  39 ++++
 drivers/i2c/muxes/Kconfig                          |   7 +
 drivers/i2c/muxes/Makefile                         |   2 +
 drivers/i2c/muxes/i2c-demux-pinctrl.c              | 224 +++++++++++++++++++++
 4 files changed, 272 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt
 create mode 100644 drivers/i2c/muxes/i2c-demux-pinctrl.c

diff --git a/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt b/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt
new file mode 100644
index 00000000000000..65f2f73a6aee50
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt
@@ -0,0 +1,39 @@
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
+- compatible: "i2c-demux-pinctrl"
+- i2c-parent: List of phandles of I2C cores to be selected
+
+Also I2C mux properties and child nodes. See mux.txt in this directory.
+
+Also required:
+
+FIXME (do we keep it like this?):
+- pinctrl properties for the parent I2C controllers need their pinctrl state
+  for actually driving the bus named "active", not "default"!
+
+FIXME: add example
+
+HACK: Currently, the created mux-device will have a file "cur_master" in its
+sysfs-entry. Write 0 there for the first master listed in the "i2c-parent"
+property, 1 for the second etc... This interface is merely for
+proof-of-concept.
diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
index f6d313e528de34..93885537c24ec6 100644
--- a/drivers/i2c/muxes/Kconfig
+++ b/drivers/i2c/muxes/Kconfig
@@ -60,4 +60,11 @@ config I2C_MUX_PINCTRL
 	  This driver can also be built as a module. If so, the module will be
 	  called pinctrl-i2cmux.
 
+config I2C_DEMUX_PINCTRL
+	tristate "pinctrl-based I2C demultiplexer"
+	depends on PINCTRL
+	select OF_DYNAMIC
+	help
+	  PROTOYPE! Understand the docs!
+
 endmenu
diff --git a/drivers/i2c/muxes/Makefile b/drivers/i2c/muxes/Makefile
index 465778b5d5dc86..4d14cb88d83438 100644
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
index 00000000000000..58e3c90762d567
--- /dev/null
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -0,0 +1,224 @@
+/*
+ * Pinctrl based I2C DeMultiplexer V2 PROTOTYPE!
+ *
+ * Copyright (C) 2015 by Wolfram Sang, Sang Engineering <wsa@sang-engineering.com>
+ * Copyright (C) 2015 by Renesas Electronics Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; version 2 of the License.
+ *
+ * See the bindings doc for DTS setup.
+ */
+
+#include <linux/i2c.h>
+#include <linux/i2c-mux.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+
+struct i2c_demux_pinctrl_chan {
+	struct device_node *parent_np;
+	struct i2c_adapter *parent_adap;
+	struct of_changeset chgset;
+};
+
+struct i2c_demux_pinctrl_priv {
+	u32 cur_chan;
+	int num_chan;
+	struct device *dev;
+	const char *node_name;
+	struct i2c_adapter *cur_adap;
+	struct i2c_demux_pinctrl_chan chan[];
+};
+
+static struct property status_okay = { .name = "status", .length = 3, .value = "ok" };
+
+static int i2c_demux_dummy(struct i2c_adapter *adap, void *data, u32 new_chan)
+{
+	return 0;
+}
+
+static int i2c_demux_activate_master(struct i2c_demux_pinctrl_priv *priv, u32 new_chan)
+{
+	struct i2c_adapter *adap;
+	struct pinctrl *p;
+	int ret;
+
+	mutex_lock(&of_mutex);
+	ret = of_changeset_apply(&priv->chan[new_chan].chgset);
+	mutex_unlock(&of_mutex);
+	if (ret)
+		return ret;
+
+	adap = of_find_i2c_adapter_by_node(priv->chan[new_chan].parent_np);
+	if (!adap)
+		return -EPROBE_DEFER;
+
+	p = devm_pinctrl_get_select(adap->dev.parent, priv->node_name);
+	if (IS_ERR(p)) {
+		put_device(&adap->dev);
+		return PTR_ERR(p);
+	}
+
+	priv->chan[new_chan].parent_adap = adap;
+	priv->cur_adap = i2c_add_mux_adapter(adap, priv->dev, priv,
+					0, 0, 0, i2c_demux_dummy, NULL);
+	if (!priv->cur_adap) {
+		put_device(&adap->dev);
+		dev_err(priv->dev, "cannot create mux bus\n");
+		return -ENXIO;
+	}
+
+	priv->cur_chan = new_chan;
+
+	return 0;
+}
+
+static int i2c_demux_deactivate_master(struct i2c_demux_pinctrl_priv *priv)
+{
+	int ret;
+
+	i2c_del_mux_adapter(priv->cur_adap);
+	put_device(&priv->chan[priv->cur_chan].parent_adap->dev);
+
+	mutex_lock(&of_mutex);
+	ret = of_changeset_revert(&priv->chan[priv->cur_chan].chgset);
+	mutex_unlock(&of_mutex);
+
+	return ret;
+}
+
+static int i2c_demux_change_master(struct i2c_demux_pinctrl_priv *priv, u32 new_chan)
+{
+	int ret;
+
+	if (new_chan = priv->cur_chan)
+		return 0;
+
+	ret = i2c_demux_deactivate_master(priv);
+	if (ret)
+		return ret;
+
+	ret = i2c_demux_activate_master(priv, new_chan);
+	return ret;
+}
+
+static ssize_t cur_master_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct i2c_demux_pinctrl_priv *priv = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", priv->cur_chan);
+}
+
+static ssize_t cur_master_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct i2c_demux_pinctrl_priv *priv = dev_get_drvdata(dev);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_demux_change_master(priv, val);
+
+	return ret < 0 ? ret : count;
+}
+static DEVICE_ATTR_RW(cur_master);
+
+static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct i2c_demux_pinctrl_priv *priv;
+	int num_chan, i, j, err;
+
+	num_chan = of_count_phandle_with_args(np, "i2c-parent", NULL);
+	if (num_chan < 2) {
+		dev_err(&pdev->dev, "Need at least two I2C masters to switch\n");
+		return -EINVAL;
+	}
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv)
+			   + num_chan * sizeof(struct i2c_demux_pinctrl_chan), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	for (i = 0; i < num_chan; i++) {
+		struct device_node *adap_np;
+
+		adap_np = of_parse_phandle(np, "i2c-parent", i);
+		if (!adap_np) {
+			dev_err(&pdev->dev, "can't get phandle for parent %d\n", i);
+			err = -ENOENT;
+			goto err_rollback;
+		}
+		priv->chan[i].parent_np = adap_np;
+
+		of_changeset_init(&priv->chan[i].chgset);
+		of_changeset_update_property(&priv->chan[i].chgset, adap_np, &status_okay);
+	}
+
+	priv->num_chan = num_chan;
+	priv->dev = &pdev->dev;
+	priv->node_name = "active"; //FIXME: something like of_node_full_name(np)?
+
+	platform_set_drvdata(pdev, priv);
+
+	/* switch to first parent as active master */
+	i2c_demux_activate_master(priv, 0);
+
+	//FIXME: error check & rollback
+	device_create_file(&pdev->dev, &dev_attr_cur_master);
+
+	return 0;
+
+err_rollback:
+	for (j = 1; j < i; j++) {
+		of_node_put(priv->chan[j].parent_np);
+		of_changeset_destroy(&priv->chan[j].chgset);
+	}
+
+	return err;
+}
+
+static int i2c_demux_pinctrl_remove(struct platform_device *pdev)
+{
+	struct i2c_demux_pinctrl_priv *priv = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < priv->num_chan; i++) {
+		of_node_put(priv->chan[i].parent_np);
+		of_changeset_destroy(&priv->chan[i].chgset);
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
2.1.4

