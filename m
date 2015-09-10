From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 10 Sep 2015 06:36:14 +0000
Subject: [PATCH] misc: add CS2000 Fractional-N driver
Message-Id: <87mvwuokd3.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch adds CS2000 Fractional-N driver as clock provider.
It is useful if it supports runtime clock setting, but it supports
fixed clock rate at this point.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 .../devicetree/bindings/misc/cs2000-cp.txt         |  20 ++
 drivers/misc/Kconfig                               |   6 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/cs2000-cp.c                           | 341 +++++++++++++++++++++
 4 files changed, 368 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/cs2000-cp.txt
 create mode 100644 drivers/misc/cs2000-cp.c

diff --git a/Documentation/devicetree/bindings/misc/cs2000-cp.txt b/Documentation/devicetree/bindings/misc/cs2000-cp.txt
new file mode 100644
index 0000000..e79cf10
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/cs2000-cp.txt
@@ -0,0 +1,20 @@
+CIRRUS LOGIC Fractional-N Clock Synthesizer & Clock Multiplier
+
+Required properties:
+
+- compatible:		"cirrus,cs2000-cp"
+- reg:			The chip select number on the I2C bus
+- clocks:		common clock binding for CLK_IN, XTI/REF_CLK
+- clock-frequency:	clock frequency of CLK_OUT
+
+Example:
+
+&i2c2 {
+	...
+	cs2000: clk_multiplier@0x4f {
+		compatible = "cirrus,cs2000-cp";
+		reg = <0x4f>;
+		clocks = <&rcar_sound 0>, <&x12_clk>;
+		clock-frequency = <24576000>; /* 1/1 divide */
+	};
+};
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index ccccc29..deec03e 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -224,6 +224,12 @@ config SGI_XP
 	  this feature will allow for direct communication between SSIs
 	  based on a network adapter and DMA messaging.
 
+config CS2000_CP
+	tristate "CS2000 Fractional-N Clock Synthesizer & Clock Multiplier"
+	depends on I2C
+	help
+	  If you say yes here you get support for the CS2000 clock multiplier
+
 config CS5535_MFGPT
 	tristate "CS5535/CS5536 Geode Multi-Function General Purpose Timer (MFGPT) support"
 	depends on MFD_CS5535
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 537d7f3b..36491e6 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_ENCLOSURE_SERVICES) += enclosure.o
 obj-$(CONFIG_KGDB_TESTS)	+= kgdbts.o
 obj-$(CONFIG_SGI_XP)		+= sgi-xp/
 obj-$(CONFIG_SGI_GRU)		+= sgi-gru/
+obj-$(CONFIG_CS2000_CP)		+= cs2000-cp.o
 obj-$(CONFIG_CS5535_MFGPT)	+= cs5535-mfgpt.o
 obj-$(CONFIG_HP_ILO)		+= hpilo.o
 obj-$(CONFIG_APDS9802ALS)	+= apds9802als.o
diff --git a/drivers/misc/cs2000-cp.c b/drivers/misc/cs2000-cp.c
new file mode 100644
index 0000000..be639e3
--- /dev/null
+++ b/drivers/misc/cs2000-cp.c
@@ -0,0 +1,341 @@
+/*
+ * CS2000  --  CIRRUS LOGIC Fractional-N Clock Synthesizer & Clock Multiplier
+ *
+ * Copyright (C) 2015 Renesas Electronics Corporation
+ * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/i2c.h>
+#include <linux/of_device.h>
+#include <linux/module.h>
+
+#define CLK_MAIN	0 /* CLK_IN  on datasheet */
+#define CLK_IN		1 /* REF_CLK on datasheet */
+
+#define CH_MAX 4
+
+#define DEVICE_ID	0x1
+#define DEVICE_CTRL	0x2
+#define DEVICE_CFG1	0x3
+#define DEVICE_CFG2	0x4
+#define GLOBAL_CFG	0x5
+#define Ratio_Add(x, nth)	(6 + (x * 4) + (nth))
+#define Ratio_Val(x, nth)	((x >> (24 - (8 * nth))) & 0xFF)
+#define FUNC_CFG1	0x16
+#define FUNC_CFG2	0x17
+
+/* DEVICE_CTRL */
+#define PLL_UNLOCK	(1 << 7)
+
+/* DEVICE_CFG1 */
+#define RSEL(x)		(((x) & 0x3) << 3)
+#define RSEL_MASK	RSEL(0x3)
+#define ENDEV1		(0x1)
+
+/* GLOBAL_CFG */
+#define ENDEV2		(0x1)
+
+
+#define CH_ERR(ch)		((ch < 0) || (ch >= CH_MAX))
+
+struct cs2000_priv {
+	struct clk *clk_main;
+	struct clk *clk_in;
+	struct clk *clk_out;
+};
+
+static const struct of_device_id cs2000_of_match[] = {
+	{ .compatible = "cirrus,cs2000-cp", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, cs2000_of_match);
+
+static const struct i2c_device_id cs2000_id[] = {
+	{ "cs2000-cp", },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, cs2000_id);
+
+#define cs2000_read(c, addr)		i2c_smbus_read_byte_data(c, addr)
+static void cs2000_write(struct i2c_client *client, u8 addr, u8 val)
+{
+	struct device *dev = &client->dev;
+
+	dev_dbg(dev, "0x%02x : 0x%02x\n", addr, val);
+
+	i2c_smbus_write_byte_data(client, addr, val);
+}
+
+static void cs2000_bset(struct i2c_client *client, u8 addr, u8 mask, u8 val)
+{
+	u32 data;
+
+	data = cs2000_read(client, addr);
+
+	data &= ~mask;
+	data |= (val & mask);
+
+	cs2000_write(client, addr, data);
+}
+
+static int cs2000_ratio_set(struct i2c_client *client,
+			    int ch, u32 rate_in, u64 rate_out)
+{
+	u32 val;
+	int i;
+
+	if (CH_ERR(ch))
+		return -EINVAL;
+
+	/*
+	 * ratio = rate_out / rate_in * 2^20
+	 *
+	 * To avoid over flow, rate_out is u64
+	 * The result should be u32
+	 */
+
+	val = rate_out * (1 << 20) / rate_in;
+	for (i = 0; i < 4; i++)
+		cs2000_write(client,
+			     Ratio_Add(ch, i),
+			     Ratio_Val(val, i));
+
+	return 0;
+}
+
+static int cs2000_ratio_select(struct i2c_client *client, int ch)
+{
+	if (CH_ERR(ch))
+		return -EINVAL;
+
+	/*
+	 * FIXME
+	 *
+	 * this driver supports static ratio mode only
+	 * at this point
+	 */
+	cs2000_bset(client, DEVICE_CFG1, RSEL_MASK, RSEL(ch));
+	cs2000_write(client, DEVICE_CFG2, 0x0);
+
+	return 0;
+}
+
+static int cs2000_enable_dev_config(struct i2c_client *client)
+{
+	cs2000_bset(client, DEVICE_CFG1, ENDEV1, ENDEV1);
+	cs2000_bset(client, GLOBAL_CFG,  ENDEV2, ENDEV2);
+
+	return 0;
+}
+
+static int cs2000_get_clk(struct i2c_client *client,
+			  u32 *rate_in, u32 *rate_out)
+{
+	struct cs2000_priv *priv = i2c_get_clientdata(client);
+	struct device *dev = &client->dev;
+	struct device_node *np = dev->of_node;
+	struct clk *clk_main, *clk_in;
+
+	clk_main = of_clk_get(np, CLK_MAIN);
+	/* not yet provided */
+	if (IS_ERR(clk_main))
+		return -EPROBE_DEFER;
+
+	clk_in = of_clk_get(np, CLK_IN);
+	if (IS_ERR(clk_in))
+		return PTR_ERR(clk_in);
+
+	*rate_in = clk_get_rate(clk_in);
+
+	if (of_property_read_u32(np, "clock-frequency", rate_out))
+		return -EINVAL;
+
+	dev_dbg(dev, "%d -> %d\n",
+		*rate_in, *rate_out);
+
+	priv->clk_main	= clk_main;
+	priv->clk_in	= clk_in;
+
+	return 0;
+}
+
+static int cs2000_clk_in_bound_rate(struct i2c_client *client,
+				    u32 rate_in)
+{
+	u32 val;
+
+	if ((32000000 <= rate_in) &&
+	    (56000000 >  rate_in))
+		val = 0x0;
+	else if ((16000000 <= rate_in) &&
+		 (28000000 >  rate_in))
+		val = 0x1;
+	else if ((8000000 <= rate_in) &&
+		 (14000000 > rate_in))
+		val = 0x2;
+	else
+		return -EINVAL;
+
+	cs2000_bset(client, FUNC_CFG1, 0x3 << 3, val << 3);
+
+	return 0;
+}
+
+static int cs2000_wait_pll_lock(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	u32 val;
+	int i;
+
+	for (i = 0; i < 256; i++) {
+		val = cs2000_read(client, DEVICE_CTRL);
+		if (!(val & PLL_UNLOCK))
+			return 0;
+		udelay(1);
+	}
+
+	dev_err(dev, "pll lock failed\n");
+
+	return -EIO;
+}
+
+static int cs2000_enable_clk_out(struct i2c_client *client)
+{
+	/* enable both AUX_OUT, CLK_OUT */
+	cs2000_write(client, DEVICE_CTRL, 0x0);
+
+	return 0;
+}
+
+static int cs2000_register_clock(struct i2c_client *client)
+{
+	struct cs2000_priv *priv = i2c_get_clientdata(client);
+	struct device *dev = &client->dev;
+	struct device_node *np = dev->of_node;
+	struct clk *clk;
+	const char *parent_clk_name = __clk_get_name(priv->clk_in);
+	u32 rate;
+
+	if (of_property_read_u32(np, "clock-frequency", &rate))
+		return -EINVAL;
+
+	/*
+	 * FIXME
+	 *
+	 * register this driver as fixed rate clock
+	 * at this point
+	 */
+	clk = clk_register_fixed_rate(dev, "clk_out", parent_clk_name,
+				      (parent_clk_name) ? 0 : CLK_IS_ROOT,
+				      rate);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	priv->clk_out = clk;
+	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+
+	return 0;
+}
+
+static int cs2000_version_print(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	u32 val = cs2000_read(client, DEVICE_ID);
+	char *revision;
+
+	/* CS2000 should be 0x0 */
+	if (0 != (val >> 3))
+		return -EIO;
+
+	switch (val & 0x7) {
+	case 0x4:
+		revision = "B2 / B3";
+		break;
+	case 0x6:
+		revision = "C1";
+		break;
+	default:
+		return -EIO;
+	}
+
+	dev_info(dev, "revision - %s\n", revision);
+
+	return 0;
+}
+
+static int cs2000_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct cs2000_priv *priv;
+	struct device *dev = &client->dev;
+	u32 rate_in = 0;
+	u32 rate_out = 0;
+	int ret;
+	int ch = 0;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, priv);
+
+	ret = cs2000_get_clk(client, &rate_in, &rate_out);
+	if (ret < 0)
+		return ret;
+
+	ret = cs2000_enable_dev_config(client);
+	if (ret < 0)
+		return ret;
+
+	ret = cs2000_clk_in_bound_rate(client, rate_in);
+	if (ret < 0)
+		return ret;
+
+	ret = cs2000_ratio_set(client, ch, rate_in, rate_out);
+	if (ret < 0)
+		return ret;
+
+	ret = cs2000_ratio_select(client, ch);
+	if (ret < 0)
+		return ret;
+
+	ret = cs2000_wait_pll_lock(client);
+	if (ret < 0)
+		return ret;
+
+	ret = cs2000_enable_clk_out(client);
+	if (ret < 0)
+		return ret;
+
+	ret = cs2000_register_clock(client);
+	if (ret < 0)
+		return ret;
+
+	ret = cs2000_version_print(client);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct i2c_driver cs2000_driver = {
+	.driver = {
+		.name = "cs2000-cp",
+		.owner = THIS_MODULE,
+		.of_match_table = cs2000_of_match,
+	},
+	.probe		= cs2000_probe,
+	.id_table	= cs2000_id,
+};
+
+module_i2c_driver(cs2000_driver);
+
+MODULE_DESCRIPTION("CS2000-CP driver");
+MODULE_AUTHOR("Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

