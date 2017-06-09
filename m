From: <gregkh@linuxfoundation.org>
Date: Fri, 09 Jun 2017 18:08:17 +0000
Subject: patch "sh: superhyway: use dev_groups and not dev_attrs for bus_type" added to driver-core-next
Message-Id: <1497031697142175@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <149699886331247@kroah.com>
In-Reply-To: <149699886331247@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    sh: superhyway: use dev_groups and not dev_attrs for bus_type

to my driver-core git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
in the driver-core-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 9f4ac349bd60ef463450a00aa5e19c67f5ad12e2 Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 6 Jun 2017 14:17:02 +0200
Subject: sh: superhyway: use dev_groups and not dev_attrs for bus_type

The dev_attrs field has long been "depreciated" and is finally being
removed, so move the driver to use the "correct" dev_groups field
instead for struct bus_type.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <linux-sh@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/sh/superhyway/superhyway-sysfs.c | 29 +++++++++++++++++++----------
 drivers/sh/superhyway/superhyway.c       |  2 +-
 include/linux/superhyway.h               |  2 +-
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/sh/superhyway/superhyway-sysfs.c b/drivers/sh/superhyway/superhyway-sysfs.c
index 55434330867b..774f31b564f8 100644
--- a/drivers/sh/superhyway/superhyway-sysfs.c
+++ b/drivers/sh/superhyway/superhyway-sysfs.c
@@ -19,7 +19,8 @@ static ssize_t name##_show(struct device *dev, struct device_attribute *attr, ch
 {									\
 	struct superhyway_device *s = to_superhyway_device(dev);	\
 	return sprintf(buf, fmt, s->field);				\
-}
+}									\
+static DEVICE_ATTR_RO(name);
 
 /* VCR flags */
 superhyway_ro_attr(perr_flags, "0x%02x\n", vcr.perr_flags);
@@ -32,14 +33,22 @@ superhyway_ro_attr(top_mb, "0x%02x\n", vcr.top_mb);
 /* Misc */
 superhyway_ro_attr(resource, "0x%08lx\n", resource[0].start);
 
-struct device_attribute superhyway_dev_attrs[] = {
-	__ATTR_RO(perr_flags),
-	__ATTR_RO(merr_flags),
-	__ATTR_RO(mod_vers),
-	__ATTR_RO(mod_id),
-	__ATTR_RO(bot_mb),
-	__ATTR_RO(top_mb),
-	__ATTR_RO(resource),
-	__ATTR_NULL,
+static struct attribute *superhyway_dev_attrs[] = {
+	&dev_attr_perr_flags.attr,
+	&dev_attr_merr_flags.attr,
+	&dev_attr_mod_vers.attr,
+	&dev_attr_mod_id.attr,
+	&dev_attr_bot_mb.attr,
+	&dev_attr_top_mb.attr,
+	&dev_attr_resource.attr,
+	NULL,
 };
 
+static const struct attribute_group superhyway_dev_group = {
+	.attrs = superhyway_dev_attrs,
+};
+
+const struct attribute_group *superhyway_dev_groups[] = {
+	&superhyway_dev_group,
+	NULL,
+};
diff --git a/drivers/sh/superhyway/superhyway.c b/drivers/sh/superhyway/superhyway.c
index bb1fb7712134..348836b90605 100644
--- a/drivers/sh/superhyway/superhyway.c
+++ b/drivers/sh/superhyway/superhyway.c
@@ -209,7 +209,7 @@ struct bus_type superhyway_bus_type = {
 	.name		= "superhyway",
 	.match		= superhyway_bus_match,
 #ifdef CONFIG_SYSFS
-	.dev_attrs	= superhyway_dev_attrs,
+	.dev_groups	= superhyway_dev_groups,
 #endif
 	.probe		= superhyway_device_probe,
 	.remove		= superhyway_device_remove,
diff --git a/include/linux/superhyway.h b/include/linux/superhyway.h
index 17ea468fa362..8d3376775813 100644
--- a/include/linux/superhyway.h
+++ b/include/linux/superhyway.h
@@ -101,7 +101,7 @@ int superhyway_add_device(unsigned long base, struct superhyway_device *, struct
 int superhyway_add_devices(struct superhyway_bus *bus, struct superhyway_device **devices, int nr_devices);
 
 /* drivers/sh/superhyway/superhyway-sysfs.c */
-extern struct device_attribute superhyway_dev_attrs[];
+extern const struct attribute_group *superhyway_dev_groups[];
 
 #endif /* __LINUX_SUPERHYWAY_H */
 
-- 
2.13.1


