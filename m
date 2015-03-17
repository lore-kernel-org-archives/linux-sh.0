From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 17 Mar 2015 07:15:22 +0000
Subject: [RFC V2 2/4] i2c: mux: add function to reparent a mux
Message-Id: <1426576524-22315-3-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Used for n-to-1 demuxes. Needs discussion.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Changes since RFC V1: none, only rebased

 drivers/i2c/i2c-mux.c   | 8 ++++++++
 include/linux/i2c-mux.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 593f7ca9adc783..c64f3fc9bb3750 100644
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
 struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
 				struct device *mux_dev,
 				void *mux_priv, u32 force_nr, u32 chan_id,
diff --git a/include/linux/i2c-mux.h b/include/linux/i2c-mux.h
index b5f9a007a3abdd..488a7744732853 100644
--- a/include/linux/i2c-mux.h
+++ b/include/linux/i2c-mux.h
@@ -44,6 +44,8 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
 
 void i2c_del_mux_adapter(struct i2c_adapter *adap);
 
+void i2c_mux_reparent(struct i2c_adapter *adap, struct i2c_adapter *new_parent);
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_I2C_MUX_H */
-- 
2.1.4

