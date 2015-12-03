From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 03 Dec 2015 15:51:32 +0000
Subject: [PATCH 2/9] i2c: add generic routine to parse DT for timing information
Message-Id: <1449157899-6572-3-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1449157899-6572-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1449157899-6572-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-rockchip@lists.infradead.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Inspired from the i2c-rk3x driver (thanks guys!) but refactored and
extended. See built-in docs for further information.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c.h    | 22 ++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index ba8eb087f22465..5c269dd51b2de7 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1438,6 +1438,56 @@ static void of_i2c_register_devices(struct i2c_adapter *adap)
 	}
 }
 
+/**
+ * of_i2c_parse_timings - get I2C related timing parameters from DT
+ * @node: The DT node to scan for I2C timing properties
+ * @t: the i2c_timings struct to be filled with values
+ * @use_defaults: bool to use sane defaults derived from the I2C specification
+ * 		  when properties are not found, otherwise use 0
+ *
+ * Scan the node pointer for the generic I2C DT properties describing timing
+ * parameters for the signal and fill the given struct with the results. If a
+ * property was not found and use_defaults was true, then maximum timings are
+ * assumed which are derived from the I2C specification. If use_defaults is not
+ * used, the result will be 0, so drivers can apply their own defaults later.
+ * The latter is mainly intended for avoiding regressions of existing drivers
+ * which want to switch to this function. New drivers almost always should use
+ * the defaults.
+ */
+void of_i2c_parse_timings(struct device_node *node, struct i2c_timings *t, bool use_defaults)
+{
+	memset(t, 0, sizeof(*t));
+
+	if (of_property_read_u32(node, "clock-frequency", &t->bus_freq_hz) && use_defaults)
+		t->bus_freq_hz = 100000;
+
+	/*
+	 * Read rise and fall time from device tree. If not available, use
+	 * the default maximum timing from the specification.
+	 */
+	if (of_property_read_u32(node, "i2c-scl-rising-time-ns", &t->scl_rise_ns) && use_defaults) {
+		if (t->bus_freq_hz <= 100000)
+			t->scl_rise_ns = 1000;
+		else if (t->bus_freq_hz <= 400000)
+			t->scl_rise_ns = 300;
+		else
+			t->scl_rise_ns = 120;
+	}
+
+	if (of_property_read_u32(node, "i2c-scl-falling-time-ns", &t->scl_fall_ns) && use_defaults) {
+		if (t->bus_freq_hz <= 400000)
+			t->scl_fall_ns = 300;
+		else
+			t->scl_fall_ns = 120;
+	}
+
+	of_property_read_u32(node, "i2c-scl-internal-delay-ns", &t->scl_int_delay_ns);
+
+	if (of_property_read_u32(node, "i2c-sda-falling-time-ns", &t->sda_fall_ns) && use_defaults)
+		t->sda_fall_ns = t->scl_fall_ns;
+}
+EXPORT_SYMBOL_GPL(of_i2c_parse_timings);
+
 static int of_dev_node_match(struct device *dev, void *data)
 {
 	return dev->of_node = data;
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 768063baafbf5e..c3f53666df117e 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -414,6 +414,22 @@ struct i2c_algorithm {
 };
 
 /**
+ * struct i2c_timings - I2C timing information
+ * @bus_freq_hz: the bus frequency in Hz
+ * @scl_rise_ns: time SCL signal takes to rise in ns; t(r) in the I2C specification
+ * @scl_fall_ns: time SCL signal takes to fall in ns; t(f) in the I2C specification
+ * @scl_int_delay_ns: time IP core additionally needs to setup SCL in ns
+ * @sda_fall_ns: time SDA signal takes to fall in ns; t(f) in the I2C specification
+ */
+struct i2c_timings {
+	u32 bus_freq_hz;
+	u32 scl_rise_ns;
+	u32 scl_fall_ns;
+	u32 scl_int_delay_ns;
+	u32 sda_fall_ns;
+};
+
+/**
  * struct i2c_bus_recovery_info - I2C bus recovery information
  * @recover_bus: Recover routine. Either pass driver's recover_bus() routine, or
  *	i2c_generic_scl_recovery() or i2c_generic_gpio_recovery().
@@ -644,6 +660,8 @@ extern struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node)
 
 /* must call i2c_put_adapter() when done with returned i2c_adapter device */
 struct i2c_adapter *of_get_i2c_adapter_by_node(struct device_node *node);
+
+void of_i2c_parse_timings(struct device_node *node, struct i2c_timings *t, bool use_defaults);
 #else
 
 static inline struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
@@ -660,6 +678,10 @@ static inline struct i2c_adapter *of_get_i2c_adapter_by_node(struct device_node
 {
 	return NULL;
 }
+
+static inline void of_i2c_parse_timings(struct device_node *node, struct i2c_timings *t, bool use_defaults)
+{
+}
 #endif /* CONFIG_OF */
 
 #endif /* _LINUX_I2C_H */
-- 
2.1.4

