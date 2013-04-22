From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 22:59:57 +0000
Subject: [PATCH 16/37] ARM: shmobile: bonito: Remove empty core devices array
Message-Id: <1366671618-8796-17-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The core devices array is empty, passing it to platform_add_devices() is
a no-op. Remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-bonito.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bonito.c b/arch/arm/mach-shmobile/board-bonito.c
index 70d992c..b111c13 100644
--- a/arch/arm/mach-shmobile/board-bonito.c
+++ b/arch/arm/mach-shmobile/board-bonito.c
@@ -331,12 +331,6 @@ static struct platform_device smsc_device = {
 };
 
 /*
- * core board devices
- */
-static struct platform_device *bonito_core_devices[] __initdata = {
-};
-
-/*
  * base board devices
  */
 static struct platform_device *bonito_base_devices[] __initdata = {
@@ -397,9 +391,6 @@ static void __init bonito_init(void)
 
 	r8a7740_add_standard_devices();
 
-	platform_add_devices(bonito_core_devices,
-			     ARRAY_SIZE(bonito_core_devices));
-
 	/*
 	 * base board settings
 	 */
-- 
1.8.1.5

