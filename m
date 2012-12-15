From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sat, 15 Dec 2012 22:50:54 +0000
Subject: [PATCH v3 20/81] sh-pfc: Split platform device and platform driver registration
Message-Id: <1355611915-25060-21-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Move platform driver registration to a static postcore initcall. This
prepares the move of platform device registration to arch code.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Paul Mundt <lethal@linux-sh.org>
---
 drivers/sh/pfc/core.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/sh/pfc/core.c b/drivers/sh/pfc/core.c
index 1bb38e8..cd8f09d 100644
--- a/drivers/sh/pfc/core.c
+++ b/drivers/sh/pfc/core.c
@@ -573,19 +573,16 @@ static struct platform_device sh_pfc_device = {
 
 int __init register_sh_pfc(struct sh_pfc_platform_data *pdata)
 {
-	int rc;
-
 	sh_pfc_device.dev.platform_data = pdata;
 
-	rc = platform_driver_register(&sh_pfc_driver);
-	if (likely(!rc)) {
-		rc = platform_device_register(&sh_pfc_device);
-		if (unlikely(rc))
-			platform_driver_unregister(&sh_pfc_driver);
-	}
+	return platform_device_register(&sh_pfc_device);
+}
 
-	return rc;
+static int __init sh_pfc_init(void)
+{
+	return platform_driver_register(&sh_pfc_driver);
 }
+postcore_initcall(sh_pfc_init);
 
 static void __exit sh_pfc_exit(void)
 {
-- 
1.7.8.6

