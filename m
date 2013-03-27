From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 27 Mar 2013 19:07:33 +0000
Subject: [PATCH 3/3] ARM: shmobile: marzen: Use GP_PIN macro
Message-Id: <1364411253-12170-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace hardcoded pin numbers with the GP_PIN macro to make the code
match the documentation.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-marzen.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 9105285..cea6a3f 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -173,15 +173,15 @@ static struct platform_device usb_phy_device = {
 static struct gpio_led marzen_leds[] = {
 	{
 		.name		= "led2",
-		.gpio		= 157,
+		.gpio		= GP_PIN(4, 29),
 		.default_state	= LEDS_GPIO_DEFSTATE_ON,
 	}, {
 		.name		= "led3",
-		.gpio		= 158,
+		.gpio		= GP_PIN(4, 30),
 		.default_state	= LEDS_GPIO_DEFSTATE_ON,
 	}, {
 		.name		= "led4",
-		.gpio		= 159,
+		.gpio		= GP_PIN(4, 31),
 		.default_state	= LEDS_GPIO_DEFSTATE_ON,
 	},
 };
-- 
1.8.1.5

