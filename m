From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 08 Dec 2015 09:37:46 +0000
Subject: [PATCH v2 2/9] i2c: add generic routine to parse DT for timing information
Message-Id: <1449567473-2084-3-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1449567473-2084-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1449567473-2084-1-git-send-email-wsa@the-dreams.de>
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
 drivers/i2c/i2c-core.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c.h    | 18 ++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index ba8eb087f22465..e94d2ca2aab4aa 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -53,6 +53,7 @@
 #include <linux/jump_label.h>
 #include <asm/uaccess.h>
 #include <linux/err.h>
+#include <linux/property.h>
 
 #include "i2c-core.h"
 
@@ -1438,6 +1439,52 @@ static void of_i2c_register_devices(struct i2c_adapter *adap)
 	}
 }
 
+/**
+ * i2c_parse_fw_timings - get I2C related timing parameters from firmware
+ * @dev: The device to scan for I2C timing properties
+ * @t: the i2c_timings struct to be filled with values
+ * @use_defaults: bool to use sane defaults derived from the I2C specification
+ * 		  when properties are not found, otherwise use 0
+ *
+ * Scan the device for the generic I2C properties describing timing parameters
+ * for the signal and fill the given struct with the results. If a property was
+ * not found and use_defaults was true, then maximum timings are assumed which
+ * are derived from the I2C specification. If use_defaults is not used, the
+ * results will be 0, so drivers can apply their own defaults later. The latter
+ * is mainly intended for avoiding regressions of existing drivers which want
+ * to switch to this function. New drivers almost always should use the defaults.
+ */
+
+void i2c_parse_fw_timings(struct device *dev, struct i2c_timings *t, bool use_defaults)
+{
+	memset(t, 0, sizeof(*t));
+
+	if (device_property_read_u32(dev, "clock-frequency", &t->bus_freq_hz) && use_defaults)
+		t->bus_freq_hz = 100000;
+
+	if (device_property_read_u32(dev, "i2c-scl-rising-time-ns", &t->scl_rise_ns) && use_defaults) {
+		if (t->bus_freq_hz <= 100000)
+			t->scl_rise_ns = 1000;
+		else if (t->bus_freq_hz <= 400000)
+			t->scl_rise_ns = 300;
+		else
+			t->scl_rise_ns = 120;
+	}
+
+	if (device_property_read_u32(dev, "i2c-scl-falling-time-ns", &t->scl_fall_ns) && use_defaults) {
+		if (t->bus_freq_hz <= 400000)
+			t->scl_fall_ns = 300;
+		else
+			t->scl_fall_ns = 120;
+	}
+
+	device_property_read_u32(dev, "i2c-scl-internal-delay-ns", &t->scl_int_delay_ns);
+
+	if (device_property_read_u32(dev, "i2c-sda-falling-time-ns", &t->sda_fall_ns) && use_defaults)
+		t->sda_fall_ns = t->scl_fall_ns;
+}
+EXPORT_SYMBOL_GPL(i2c_parse_fw_timings);
+
 static int of_dev_node_match(struct device *dev, void *data)
 {
 	return dev->of_node = data;
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 768063baafbf5e..7c45181f41ab7d 100644
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
@@ -602,6 +618,7 @@ extern void i2c_clients_command(struct i2c_adapter *adap,
 extern struct i2c_adapter *i2c_get_adapter(int nr);
 extern void i2c_put_adapter(struct i2c_adapter *adap);
 
+void i2c_parse_fw_timings(struct device *dev, struct i2c_timings *t, bool use_defaults);
 
 /* Return the functionality mask */
 static inline u32 i2c_get_functionality(struct i2c_adapter *adap)
@@ -644,6 +661,7 @@ extern struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node)
 
 /* must call i2c_put_adapter() when done with returned i2c_adapter device */
 struct i2c_adapter *of_get_i2c_adapter_by_node(struct device_node *node);
+
 #else
 
 static inline struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
-- 
2.1.4

