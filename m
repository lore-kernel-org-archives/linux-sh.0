From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 03 Dec 2019 20:58:52 +0000
Subject: [PATCH v2] drivers: Fix boot problem on SuperH
Message-Id: <20191203205852.15659-1-linux@roeck-us.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Bartosz Golaszewski <brgl@bgdev.pl>

SuperH images crash too eearly to display any console output. Bisect
points to commit 507fd01d5333 ("drivers: move the early platform device
support to arch/sh"). An analysis of that patch suggests that
early_platform_cleanup() is now called at the wrong time. Restoring its
call point fixes the problem.

Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Fixes: 507fd01d5333 ("drivers: move the early platform device support to arch/sh")
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Use __init annotation for early_platform_cleanup()

 arch/sh/drivers/platform_early.c | 11 ++---------
 drivers/base/platform.c          |  4 ++++
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/sh/drivers/platform_early.c b/arch/sh/drivers/platform_early.c
index f6d148451dfc..f3dc3f25b3ff 100644
--- a/arch/sh/drivers/platform_early.c
+++ b/arch/sh/drivers/platform_early.c
@@ -325,9 +325,9 @@ int __init sh_early_platform_driver_probe(char *class_str,
 }
 
 /**
- * sh_early_platform_cleanup - clean up early platform code
+ * early_platform_cleanup - clean up early platform code
  */
-static int __init sh_early_platform_cleanup(void)
+void __init early_platform_cleanup(void)
 {
 	struct platform_device *pd, *pd2;
 
@@ -337,11 +337,4 @@ static int __init sh_early_platform_cleanup(void)
 		list_del(&pd->dev.devres_head);
 		memset(&pd->dev.devres_head, 0, sizeof(pd->dev.devres_head));
 	}
-
-	return 0;
 }
-/*
- * This must happen once after all early devices are probed but before probing
- * real platform devices.
- */
-subsys_initcall(sh_early_platform_cleanup);
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 7c532548b0a6..cf6b6b722e5c 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1325,10 +1325,14 @@ struct device *platform_find_device_by_driver(struct device *start,
 }
 EXPORT_SYMBOL_GPL(platform_find_device_by_driver);
 
+void __weak __init early_platform_cleanup(void) { }
+
 int __init platform_bus_init(void)
 {
 	int error;
 
+	early_platform_cleanup();
+
 	error = device_register(&platform_bus);
 	if (error) {
 		put_device(&platform_bus);
-- 
2.17.1
