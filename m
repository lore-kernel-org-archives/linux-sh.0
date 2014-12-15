From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 15 Dec 2014 20:20:15 +0000
Subject: [RFC 2/4] i2c: mux: add function to reparent a mux
Message-Id: <1418674817-12809-3-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Used for n-to-1 demuxes. Needs discussion.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-mux.c   | 8 ++++++++
 include/linux/i2c-mux.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 2a0207e9645a..1c2db2e10671 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -100,6 +100,14 @@ static unsigned int i2c_mux_parent_classes(struct i2c_adapter *parent)
 	return class;
 }
 
+void i2c_mux_reparent(struct i2c_adapter *adap, struct i2c_adapter *new_parent)
+{
+	struct i2c_mux_priv *priv = adap->algo_data;
+
+	priv->parent = new_parent;
+}
+EXPORT_SYMBOL_GPL(i2c_mux_reparent);
+
 /* Simple consistent prefix for i2c_add_mux_adapter */
 #define i2c_mux_msg(fmt, ...) "%s-%u: " fmt, dev_name(mux_dev), chan_id, ##__VA_ARGS__
 
diff --git a/include/linux/i2c-mux.h b/include/linux/i2c-mux.h
index b5f9a007a3ab..488a77447328 100644
--- a/include/linux/i2c-mux.h
+++ b/include/linux/i2c-mux.h
@@ -44,6 +44,8 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
 
 void i2c_del_mux_adapter(struct i2c_adapter *adap);
 
+void i2c_mux_reparent(struct i2c_adapter *adap, struct i2c_adapter *new_parent);
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_I2C_MUX_H */
-- 
2.1.3

