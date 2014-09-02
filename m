From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 02 Sep 2014 18:02:39 +0000
Subject: [PATCH 1/3] WIP: i2c core changes for slave support
Message-Id: <1409680961-12632-2-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1409680961-12632-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1409680961-12632-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Not for upstream yet.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core.c    | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c-slave.h | 28 ++++++++++++++++++++++++++++
 include/linux/i2c.h       |  5 +++++
 3 files changed, 75 insertions(+)
 create mode 100644 include/linux/i2c-slave.h

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 632057a44615..63ea70e5c274 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -2536,6 +2536,48 @@ trace:
 }
 EXPORT_SYMBOL(i2c_smbus_xfer);
 
+int i2c_slave_register(struct i2c_client *client,
+		       int (*slave_cb)(struct i2c_client *, enum i2c_slave_event, u8 *))
+{
+	u16 addr = client->addr;
+	int ret;
+
+	if (!slave_cb)
+		return -EINVAL;
+
+	ret = i2c_check_addr_validity(addr);
+	if (ret)
+		return ret;
+
+	if (!client->adapter->algo->reg_slave)
+		return -EOPNOTSUPP;
+
+	client->slave_cb = slave_cb;
+
+	ret = client->adapter->algo->reg_slave(client);
+	if (ret)
+		client->slave_cb = NULL;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i2c_slave_register);
+
+int i2c_slave_unregister(struct i2c_client *client)
+{
+	int ret;
+
+	if (!client->adapter->algo->unreg_slave)
+		return -EOPNOTSUPP;
+
+	ret = client->adapter->algo->unreg_slave(client);
+
+	if (ret = 0)
+		client->slave_cb = NULL;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i2c_slave_unregister);
+
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus main module");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/i2c-slave.h b/include/linux/i2c-slave.h
new file mode 100644
index 000000000000..ddc9493cb5e7
--- /dev/null
+++ b/include/linux/i2c-slave.h
@@ -0,0 +1,28 @@
+/*
+ * i2c-slave.h - Linux I2C slave support
+ *
+ * Copyright (C) 2014 by Wolfram Sang
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/i2c.h>
+
+#ifndef _LINUX_I2C_SLAVE_H
+#define _LINUX_I2C_SLAVE_H
+
+enum i2c_slave_event {
+	I2C_SLAVE_REQ_READ,
+	I2C_SLAVE_REQ_WRITE,
+	I2C_SLAVE_STOP,
+};
+
+extern int i2c_slave_register(struct i2c_client *client, int (*slave_cb)(struct i2c_client *, enum i2c_slave_event, u8 *));
+extern int i2c_slave_unregister(struct i2c_client *client);
+
+#define i2c_slave_event(__client, __event, __value) \
+	client->slave_cb(__client, __event, __value)
+
+#endif
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index a95efeb53a8b..8541aa6b0178 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -46,6 +46,7 @@ struct i2c_client;
 struct i2c_driver;
 union i2c_smbus_data;
 struct i2c_board_info;
+enum i2c_slave_event;
 
 struct module;
 
@@ -224,6 +225,7 @@ struct i2c_client {
 	struct device dev;		/* the device structure		*/
 	int irq;			/* irq issued by device		*/
 	struct list_head detected;
+	int (*slave_cb)(struct i2c_client *, enum i2c_slave_event, u8 *);
 };
 #define to_i2c_client(d) container_of(d, struct i2c_client, dev)
 
@@ -377,6 +379,9 @@ struct i2c_algorithm {
 
 	/* To determine what the adapter supports */
 	u32 (*functionality) (struct i2c_adapter *);
+
+	int (*reg_slave)(struct i2c_client *client);
+	int (*unreg_slave)(struct i2c_client *client);
 };
 
 /**
-- 
2.0.0

