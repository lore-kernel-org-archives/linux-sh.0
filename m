From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 11 Dec 2013 02:48:16 +0000
Subject: [PATCH 2/4] ARM: shmobile: armadillo: Set backlight enable GPIO
Message-Id: <1386730098-26641-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The Armadillo 800 EVA panel module has a backlight enable signal
connected to GPIO 61. Instead of requesting the GPIO in board code and
setting it to a high level unconditionally, pass the GPIO number to the
PWM backlight driver as the backlight enable GPIO.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index d0835a2..fbcbabe 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -423,7 +423,7 @@ static struct platform_pwm_backlight_data pwm_backlight_data = {
 	.max_brightness = 255,
 	.dft_brightness = 255,
 	.pwm_period_ns = 33333, /* 30kHz */
-	.enable_gpio = -1,
+	.enable_gpio = 61,
 };
 
 static struct platform_device pwm_backlight_device = {
@@ -1210,9 +1210,6 @@ static void __init eva_init(void)
 	r8a7740_pinmux_init();
 	r8a7740_meram_workaround();
 
-	/* LCDC0 */
-	gpio_request_one(61, GPIOF_OUT_INIT_HIGH, NULL); /* LCDDON */
-
 	/* GETHER */
 	gpio_request_one(18, GPIOF_OUT_INIT_HIGH, NULL); /* PHY_RST */
 
-- 
1.8.3.2

