From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 05 Jun 2013 08:26:05 +0000
Subject: [PATCH 074/130] ARM: shmobile: bonito: Remove empty core devices array
Message-Id: <1370420821-28420-75-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The core devices array is empty, passing it to platform_add_devices() is
a no-op. Remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
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
1.8.2.1

