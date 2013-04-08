From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 08 Apr 2013 10:05:32 +0000
Subject: [PATCH v2 3/3] ARM: shmobile: marzen: Use RCAR_GP_PIN macro
Message-Id: <1365415532-24544-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace hardcoded pin numbers with the RCAR_GP_PIN macro to make the
code match the documentation.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-marzen.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 9105285..fac9e0f 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -28,6 +28,7 @@
 #include <linux/leds.h>
 #include <linux/dma-mapping.h>
 #include <linux/pinctrl/machine.h>
+#include <linux/platform_data/gpio-rcar.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/smsc911x.h>
@@ -173,15 +174,15 @@ static struct platform_device usb_phy_device = {
 static struct gpio_led marzen_leds[] = {
 	{
 		.name		= "led2",
-		.gpio		= 157,
+		.gpio		= RCAR_GP_PIN(4, 29),
 		.default_state	= LEDS_GPIO_DEFSTATE_ON,
 	}, {
 		.name		= "led3",
-		.gpio		= 158,
+		.gpio		= RCAR_GP_PIN(4, 30),
 		.default_state	= LEDS_GPIO_DEFSTATE_ON,
 	}, {
 		.name		= "led4",
-		.gpio		= 159,
+		.gpio		= RCAR_GP_PIN(4, 31),
 		.default_state	= LEDS_GPIO_DEFSTATE_ON,
 	},
 };
-- 
1.8.1.5

