From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 02 Sep 2014 18:02:40 +0000
Subject: [PATCH 2/3] WIP: sketch of an slave-eeprom simulator
Message-Id: <1409680961-12632-3-git-send-email-wsa@the-dreams.de>
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
 drivers/i2c/i2c-slave-eeprom.c | 140 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)
 create mode 100644 drivers/i2c/i2c-slave-eeprom.c

diff --git a/drivers/i2c/i2c-slave-eeprom.c b/drivers/i2c/i2c-slave-eeprom.c
new file mode 100644
index 000000000000..f12edd316ad5
--- /dev/null
+++ b/drivers/i2c/i2c-slave-eeprom.c
@@ -0,0 +1,140 @@
+/*
+ * I2C Slave mode EEPROM simulator
+ *
+ * Copyright (C) 2014 by Wolfram Sang
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/i2c.h>
+#include <linux/i2c-slave.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+
+#define EEPROM_SIZE 256
+
+struct i2c_slave_eeprom_data {
+	struct mutex lock;
+	struct bin_attribute bin;
+	u8 buffer[EEPROM_SIZE];
+	u8 eeprom_ptr;
+	bool first_write_done;
+};
+
+static int at24s_slave_cb(struct i2c_client *client, enum i2c_slave_event event, u8 *val)
+{
+	struct i2c_slave_eeprom_data *at24s = i2c_get_clientdata(client);
+
+	switch (event) {
+	case I2C_SLAVE_REQ_WRITE:
+		if (!at24s->first_write_done)
+			at24s->eeprom_ptr = *val;
+		else
+			at24s->buffer[at24s->eeprom_ptr++] = *val;
+
+		at24s->first_write_done = true;
+		break;
+
+	case I2C_SLAVE_REQ_READ:
+		*val = at24s->buffer[at24s->eeprom_ptr++];
+		break;
+
+	case I2C_SLAVE_STOP:
+		at24s->first_write_done = false;
+		break;
+	}
+
+	return 0;
+}
+
+static ssize_t at24s_bin_read(struct file *filp, struct kobject *kobj,
+		struct bin_attribute *attr, char *buf, loff_t off, size_t count)
+{
+	struct i2c_slave_eeprom_data *at24s;
+
+	at24s = dev_get_drvdata(container_of(kobj, struct device, kobj));
+
+	memcpy(buf, &at24s->buffer[off], count);
+
+	return count;
+}
+
+static ssize_t at24s_bin_write(struct file *filp, struct kobject *kobj,
+		struct bin_attribute *attr, char *buf, loff_t off, size_t count)
+{
+	struct i2c_slave_eeprom_data *at24s;
+
+	if (unlikely(off >= attr->size))
+		return -EFBIG;
+
+	at24s = dev_get_drvdata(container_of(kobj, struct device, kobj));
+
+	memcpy(&at24s->buffer[off], buf, count);
+
+	return count;
+}
+
+static int i2c_slave_eeprom_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	struct i2c_slave_eeprom_data *at24s;
+	int ret;
+
+	at24s = devm_kzalloc(&client->dev, sizeof(struct i2c_slave_eeprom_data), GFP_KERNEL);
+	if (!at24s)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, at24s);
+
+	ret = i2c_slave_register(client, at24s_slave_cb);
+	if (ret)
+		return ret;
+
+	sysfs_bin_attr_init(&at24s->bin);
+	at24s->bin.attr.name = "slave-eeprom";
+	at24s->bin.attr.mode = S_IRUSR | S_IWUSR;
+	at24s->bin.read = at24s_bin_read;
+	at24s->bin.write = at24s_bin_write;
+	at24s->bin.size = EEPROM_SIZE;
+
+	ret = sysfs_create_bin_file(&client->dev.kobj, &at24s->bin);
+	if (ret)
+		return ret;
+
+	return 0;
+};
+
+static int i2c_slave_eeprom_remove(struct i2c_client *client)
+{
+	struct i2c_slave_eeprom_data *at24s;
+
+	at24s = i2c_get_clientdata(client);
+	sysfs_remove_bin_file(&client->dev.kobj, &at24s->bin);
+
+	return i2c_slave_unregister(client);
+}
+
+static const struct i2c_device_id i2c_slave_eeprom_id[] = {
+	{ "i2c-slave-eeprom", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, i2c_slave_eeprom_id);
+
+static struct i2c_driver i2c_slave_eeprom_driver = {
+	.driver = {
+		.name = "i2c-slave-eeprom",
+		.owner = THIS_MODULE,
+	},
+	.probe = i2c_slave_eeprom_probe,
+	.remove = i2c_slave_eeprom_remove,
+	.id_table = i2c_slave_eeprom_id,
+};
+module_i2c_driver(i2c_slave_eeprom_driver);
+
+MODULE_AUTHOR("Wolfram Sang <wsa+renesas@sang-engineering.com>");
+MODULE_DESCRIPTION("I2C Slave mode EEPROM simulator");
+MODULE_LICENSE("GPL v2");
-- 
2.0.0

