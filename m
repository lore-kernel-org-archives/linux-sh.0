From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 26 Nov 2015 22:59:10 +0000
Subject: [RFC 2/9] i2c: add generic routine to parse DT timing information
Message-Id: <1448578757-12613-3-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1448578757-12613-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1448578757-12613-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Inspired from the i2c-rk3x driver, thanks guys!

FIXME: add documentation

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/i2c.h    | 15 +++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 040af5cc8143f1..7543fec4f65b61 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1438,6 +1438,40 @@ static void of_i2c_register_devices(struct i2c_adapter *adap)
 	}
 }
 
+void of_i2c_parse_timings(struct device_node *node, struct i2c_timings *t, bool use_defaults)
+{
+	memset(t, 0, sizeof(*t));
+
+	if (of_property_read_u32(node, "clock-frequency", &t->bus_freq) && use_defaults)
+		t->bus_freq = 100000;
+
+	/*
+	 * Read rise and fall time from device tree. If not available, use
+	 * the default maximum timing from the specification.
+	 */
+	if (of_property_read_u32(node, "i2c-scl-rising-time-ns", &t->scl_rise_ns) && use_defaults) {
+		if (t->bus_freq <= 100000)
+			t->scl_rise_ns = 1000;
+		else if (t->bus_freq <= 400000)
+			t->scl_rise_ns = 300;
+		else
+			t->scl_rise_ns = 120;
+	}
+
+	if (of_property_read_u32(node, "i2c-scl-falling-time-ns", &t->scl_fall_ns) && use_defaults) {
+		if (t->bus_freq <= 400000)
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
index 768063baafbf5e..ca28c104ac5fb6 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -413,6 +413,15 @@ struct i2c_algorithm {
 #endif
 };
 
+/* FIXME: Add docs */
+struct i2c_timings {
+	u32 bus_freq;
+	u32 scl_rise_ns;
+	u32 scl_fall_ns;
+	u32 scl_int_delay_ns;
+	u32 sda_fall_ns;
+};
+
 /**
  * struct i2c_bus_recovery_info - I2C bus recovery information
  * @recover_bus: Recover routine. Either pass driver's recover_bus() routine, or
@@ -644,6 +653,8 @@ extern struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node)
 
 /* must call i2c_put_adapter() when done with returned i2c_adapter device */
 struct i2c_adapter *of_get_i2c_adapter_by_node(struct device_node *node);
+
+void of_i2c_parse_timings(struct device_node *node, struct i2c_timings *t, bool use_defaults);
 #else
 
 static inline struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
@@ -660,6 +671,10 @@ static inline struct i2c_adapter *of_get_i2c_adapter_by_node(struct device_node
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

