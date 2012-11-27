From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 27 Nov 2012 00:03:13 +0000
Subject: [PATCH v2 74/77] ARM: shmobile: armadillo: Populate platform devices from device tree
Message-Id: <1353974596-30033-75-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Call of_platform_populate() at machine initialization time to populate
platform devices. Remove the explicit pinmux initialization as the PFC
device will be instantiated from the device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 3cc8b1c..ba81519 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -25,6 +25,7 @@
 #include <linux/kernel.h>
 #include <linux/input.h>
 #include <linux/irq.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
@@ -985,7 +986,8 @@ static void __init eva_init(void)
 	regulator_register_always_on(0, "fixed-3.3V", fixed3v3_power_consumers,
 				     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
 
-	r8a7740_pinmux_init();
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+
 	r8a7740_meram_workaround();
 
 	/* SCIFA1 */
-- 
1.7.8.6

