From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Sun, 15 Jun 2014 19:56:29 +0000
Subject: [PATCH 4/9] adv7180: add of match table
Message-Id: <1402862194-17743-5-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1402862194-17743-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1402862194-17743-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@lists.codethink.co.uk, linux-sh@vger.kernel.org, linux-media@vger.kernel.org
Cc: robert.jarzmik@free.fr, g.liakhovetski@gmx.de, magnus.damm@opensource.se, horms@verge.net.au, ian.molton@codethink.co.uk, william.towle@codethink.co.uk, Ben Dooks <ben.dooks@codethink.co.uk>

Add a proper of match id for use when the device is being bound via
device tree, to avoid having to use the i2c old-style binding of the
device.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---

Since original submission:
	- Fixed of_match_table typo
---
 drivers/media/i2c/adv7180.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/media/i2c/adv7180.c b/drivers/media/i2c/adv7180.c
index 821178d..46e47a0 100644
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
@@ -710,11 +711,21 @@ static SIMPLE_DEV_PM_OPS(adv7180_pm_ops, adv7180_suspend, adv7180_resume);
 
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
+		   .of_match_table = of_match_ptr(adv7180_of_id),
 		   },
 	.probe = adv7180_probe,
 	.remove = adv7180_remove,
-- 
2.0.0

