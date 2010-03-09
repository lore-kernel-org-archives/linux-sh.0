From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 09 Mar 2010 06:57:53 +0000
Subject: [PATCH] driver core: Early dev_name() support.
Message-Id: <20100309065753.GA8287@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Magnus Damm <damm@opensource.se>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

Presently early platform devices suffer from the fact they are unable to
use dev_xxx() calls early on due to dev_name() and others being
unavailable at the time ->probe() is called.

This implements early init_name construction from the matched name/id
pair following the semantics of the late device/driver match. As a
result, matched IDs (inclusive of requested ones) are preserved when the
handoff from the early platform code happens at kobject initialization
time.

Since we still require kmalloc slabs to be available at this point, using
kstrdup() for establishing the init_name works fine. This subsequently
needs to be tested from dev_name() prior to the init_name being cleared
by the driver core. We don't kfree() since others will already have a
handle on the string long before the kobject initialization takes place.

This is also needed to permit drivers to use the clock framework early,
without having to manually construct their own device IDs from the match
id/name pair locally (needed by the early console and timer code on sh
and arm).

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 drivers/base/platform.c |   19 +++++++++++++++++++
 include/linux/device.h  |    4 ++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 58efaf2..bc38f63 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1181,6 +1181,25 @@ static int __init early_platform_driver_probe_id(char *class_str,
 		}
 
 		if (match) {
+			/*
+			 * Set up a sensible init_name to enable
+			 * dev_name() and others to be used before the
+			 * rest of the driver core is initialized.
+			 */
+			if (!match->dev.init_name) {
+				char buf[32];
+
+				if (match->id != -1)
+					snprintf(buf, sizeof(buf), "%s.%d",
+						 match->name, match->id);
+				else
+					snprintf(buf, sizeof(buf), "%s",
+						 match->name);
+
+				match->dev.init_name = kstrdup(buf, GFP_KERNEL);
+				if (!match->dev.init_name)
+					return -ENOMEM;
+			}
 			if (epdrv->pdrv->probe(match))
 				pr_warning("%s: unable to probe %s early.\n",
 					   class_str, match->name);
diff --git a/include/linux/device.h b/include/linux/device.h
index b30527d..3af5bce 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -432,6 +432,10 @@ struct device {
 
 static inline const char *dev_name(const struct device *dev)
 {
+	/* Use the init name until the kobject becomes available */
+	if (dev->init_name)
+		return dev->init_name;
+
 	return kobject_name(&dev->kobj);
 }
 
