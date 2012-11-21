From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 21 Nov 2012 02:53:25 +0000
Subject: [PATCH 09/42] sh-pfc: Split platform device and platform driver registration
Message-Id: <1353466438-10929-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Move platform driver registration to a static postcore initcall. This
prepares the move of platform device registration to arch code.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/sh/pfc/core.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/sh/pfc/core.c b/drivers/sh/pfc/core.c
index f1a0c85..9736e3d 100644
--- a/drivers/sh/pfc/core.c
+++ b/drivers/sh/pfc/core.c
@@ -597,19 +597,16 @@ static struct platform_device sh_pfc_device = {
 
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

