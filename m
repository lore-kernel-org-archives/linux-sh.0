From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Fri, 22 Apr 2016 18:07:04 +0000
Subject: [PATCH 4/4] sh: make heartbeat driver explicitly non-modular
Message-Id: <1461348424-3896-5-git-send-email-paul.gortmaker@windriver.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1461348424-3896-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1461348424-3896-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

The Kconfig for this driver is currently:

config HEARTBEAT
        bool "Heartbeat LED"

...meaning that it currently is not being built as a module by anyone.
Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/sh/drivers/heartbeat.c | 32 +++-----------------------------
 1 file changed, 3 insertions(+), 29 deletions(-)

diff --git a/arch/sh/drivers/heartbeat.c b/arch/sh/drivers/heartbeat.c
index 7efc9c354fc7..49bace446a1a 100644
--- a/arch/sh/drivers/heartbeat.c
+++ b/arch/sh/drivers/heartbeat.c
@@ -19,7 +19,6 @@
  * for more details.
  */
 #include <linux/init.h>
-#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/timer.h>
@@ -139,26 +138,11 @@ static int heartbeat_drv_probe(struct platform_device *pdev)
 	return mod_timer(&hd->timer, jiffies + 1);
 }
 
-static int heartbeat_drv_remove(struct platform_device *pdev)
-{
-	struct heartbeat_data *hd = platform_get_drvdata(pdev);
-
-	del_timer_sync(&hd->timer);
-	iounmap(hd->base);
-
-	platform_set_drvdata(pdev, NULL);
-
-	if (!pdev->dev.platform_data)
-		kfree(hd);
-
-	return 0;
-}
-
 static struct platform_driver heartbeat_driver = {
 	.probe		= heartbeat_drv_probe,
-	.remove		= heartbeat_drv_remove,
 	.driver		= {
-		.name	= DRV_NAME,
+		.name			= DRV_NAME,
+		.suppress_bind_attrs	= true,
 	},
 };
 
@@ -167,14 +151,4 @@ static int __init heartbeat_init(void)
 	printk(KERN_NOTICE DRV_NAME ": version %s loaded\n", DRV_VERSION);
 	return platform_driver_register(&heartbeat_driver);
 }
-
-static void __exit heartbeat_exit(void)
-{
-	platform_driver_unregister(&heartbeat_driver);
-}
-module_init(heartbeat_init);
-module_exit(heartbeat_exit);
-
-MODULE_VERSION(DRV_VERSION);
-MODULE_AUTHOR("Paul Mundt");
-MODULE_LICENSE("GPL v2");
+device_initcall(heartbeat_init);
-- 
2.8.0

