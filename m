From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 21 Mar 2011 07:49:45 +0000
Subject: [PATCH] ARM: mach-shmobile: Dynamic backlight control for Mackerel
Message-Id: <20110321074945.3855.4211.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Use GPIO_PORT31 to control the backlight on the Mackerel board.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-mackerel.c |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/board-mackerel.c
+++ work/arch/arm/mach-shmobile/board-mackerel.c	2011-03-21 15:00:04.000000000 +0900
@@ -295,6 +295,18 @@ static struct fb_videomode mackerel_lcdc
 	},
 };
 
+static int mackerel_set_brightness(void *board_data, int brightness)
+{
+	gpio_set_value(GPIO_PORT31, brightness);
+
+	return 0;
+}
+
+static int mackerel_get_brightness(void *board_data)
+{
+	return gpio_get_value(GPIO_PORT31);
+}
+
 static struct sh_mobile_lcdc_info lcdc_info = {
 	.clock_source = LCDC_CLK_BUS,
 	.ch[0] = {
@@ -307,6 +319,14 @@ static struct sh_mobile_lcdc_info lcdc_i
 		.flags			= 0,
 		.lcd_size_cfg.width	= 152,
 		.lcd_size_cfg.height	= 91,
+		.board_cfg = {
+			.set_brightness = mackerel_set_brightness,
+			.get_brightness = mackerel_get_brightness,
+		},
+		.bl_info = {
+			.name = "sh_mobile_lcdc_bl",
+			.max_brightness = 1,
+		},
 	}
 };
 
@@ -1059,7 +1079,7 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_LCDDCK,   NULL);
 
 	gpio_request(GPIO_PORT31, NULL); /* backlight */
-	gpio_direction_output(GPIO_PORT31, 1);
+	gpio_direction_output(GPIO_PORT31, 0); /* off by default */
 
 	gpio_request(GPIO_PORT151, NULL); /* LCDDON */
 	gpio_direction_output(GPIO_PORT151, 1);
