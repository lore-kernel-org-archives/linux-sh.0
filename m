From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 14 Apr 2014 10:36:37 +0000
Subject: [PATCH v3 2/7] adv7180: add of match table
Message-Id: <1397471802-27216-3-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add a proper of match id for use when the device is being bound via
device tree, to avoid having to use the i2c old-style binding of the
device.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/media/i2c/adv7180.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/media/i2c/adv7180.c b/drivers/media/i2c/adv7180.c
index 215afa0..687d97b 100644
--- a/drivers/media/i2c/adv7180.c
+++ b/drivers/media/i2c/adv7180.c
@@ -25,6 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include <media/v4l2-ioctl.h>
 #include <linux/videodev2.h>
 #include <media/v4l2-device.h>
@@ -695,11 +696,21 @@ static SIMPLE_DEV_PM_OPS(adv7180_pm_ops, adv7180_suspend, adv7180_resume);
 
 MODULE_DEVICE_TABLE(i2c, adv7180_id);
 
+#ifdef CONFIG_OF
+static const struct of_device_id adv7180_of_id[] = {
+	{ .compatible = "adi,adv7180", },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, adv7180_of_id)
+#endif
+
 static struct i2c_driver adv7180_driver = {
 	.driver = {
 		   .owner = THIS_MODULE,
 		   .name = KBUILD_MODNAME,
 		   .pm = ADV7180_PM_OPS,
+		   .of_match = of_match_ptr(adv7180_of_id),
 		   },
 	.probe = adv7180_probe,
 	.remove = adv7180_remove,
-- 
1.9.1

