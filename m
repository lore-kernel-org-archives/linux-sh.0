From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 17 Dec 2015 12:32:36 +0000
Subject: [PATCH] i2c: make i2c_parse_fw_timings() always visible
Message-Id: <1450355556-19875-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-sh@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jim Davis <jim.epost@gmail.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

This function used to be DT only, so it lived inside a CONFIG_OF block.
Now it uses device attributes and must be moved outside of it. No
further code changes.

Reported-by: Jim Davis <jim.epost@gmail.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core.c | 104 ++++++++++++++++++++++++-------------------------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index b34c412bd2c240..90fe315b6360e2 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1439,58 +1439,6 @@ static void of_i2c_register_devices(struct i2c_adapter *adap)
 	}
 }
 
-/**
- * i2c_parse_fw_timings - get I2C related timing parameters from firmware
- * @dev: The device to scan for I2C timing properties
- * @t: the i2c_timings struct to be filled with values
- * @use_defaults: bool to use sane defaults derived from the I2C specification
- * 		  when properties are not found, otherwise use 0
- *
- * Scan the device for the generic I2C properties describing timing parameters
- * for the signal and fill the given struct with the results. If a property was
- * not found and use_defaults was true, then maximum timings are assumed which
- * are derived from the I2C specification. If use_defaults is not used, the
- * results will be 0, so drivers can apply their own defaults later. The latter
- * is mainly intended for avoiding regressions of existing drivers which want
- * to switch to this function. New drivers almost always should use the defaults.
- */
-
-void i2c_parse_fw_timings(struct device *dev, struct i2c_timings *t, bool use_defaults)
-{
-	int ret;
-
-	memset(t, 0, sizeof(*t));
-
-	ret = device_property_read_u32(dev, "clock-frequency", &t->bus_freq_hz);
-	if (ret && use_defaults)
-		t->bus_freq_hz = 100000;
-
-	ret = device_property_read_u32(dev, "i2c-scl-rising-time-ns", &t->scl_rise_ns);
-	if (ret && use_defaults) {
-		if (t->bus_freq_hz <= 100000)
-			t->scl_rise_ns = 1000;
-		else if (t->bus_freq_hz <= 400000)
-			t->scl_rise_ns = 300;
-		else
-			t->scl_rise_ns = 120;
-	}
-
-	ret = device_property_read_u32(dev, "i2c-scl-falling-time-ns", &t->scl_fall_ns);
-	if (ret && use_defaults) {
-		if (t->bus_freq_hz <= 400000)
-			t->scl_fall_ns = 300;
-		else
-			t->scl_fall_ns = 120;
-	}
-
-	device_property_read_u32(dev, "i2c-scl-internal-delay-ns", &t->scl_int_delay_ns);
-
-	ret = device_property_read_u32(dev, "i2c-sda-falling-time-ns", &t->sda_fall_ns);
-	if (ret && use_defaults)
-		t->sda_fall_ns = t->scl_fall_ns;
-}
-EXPORT_SYMBOL_GPL(i2c_parse_fw_timings);
-
 static int of_dev_node_match(struct device *dev, void *data)
 {
 	return dev->of_node = data;
@@ -1892,6 +1840,58 @@ void i2c_del_adapter(struct i2c_adapter *adap)
 }
 EXPORT_SYMBOL(i2c_del_adapter);
 
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
+	int ret;
+
+	memset(t, 0, sizeof(*t));
+
+	ret = device_property_read_u32(dev, "clock-frequency", &t->bus_freq_hz);
+	if (ret && use_defaults)
+		t->bus_freq_hz = 100000;
+
+	ret = device_property_read_u32(dev, "i2c-scl-rising-time-ns", &t->scl_rise_ns);
+	if (ret && use_defaults) {
+		if (t->bus_freq_hz <= 100000)
+			t->scl_rise_ns = 1000;
+		else if (t->bus_freq_hz <= 400000)
+			t->scl_rise_ns = 300;
+		else
+			t->scl_rise_ns = 120;
+	}
+
+	ret = device_property_read_u32(dev, "i2c-scl-falling-time-ns", &t->scl_fall_ns);
+	if (ret && use_defaults) {
+		if (t->bus_freq_hz <= 400000)
+			t->scl_fall_ns = 300;
+		else
+			t->scl_fall_ns = 120;
+	}
+
+	device_property_read_u32(dev, "i2c-scl-internal-delay-ns", &t->scl_int_delay_ns);
+
+	ret = device_property_read_u32(dev, "i2c-sda-falling-time-ns", &t->sda_fall_ns);
+	if (ret && use_defaults)
+		t->sda_fall_ns = t->scl_fall_ns;
+}
+EXPORT_SYMBOL_GPL(i2c_parse_fw_timings);
+
 /* ------------------------------------------------------------------------- */
 
 int i2c_for_each_dev(void *data, int (*fn)(struct device *, void *))
-- 
2.1.4

