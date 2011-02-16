From: Alexandre Courbot <gnurou@gmail.com>
Date: Wed, 16 Feb 2011 03:49:02 +0000
Subject: [PATCH v2 2/3] sh: mach-ecovec24: support for main lcd backlight
Message-Id: <1297828143-11798-3-git-send-email-gnurou@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add support for the main LCD backlight that is controlled through the
PTR1 GPIO.

Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 701667a..a2c0622 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -261,6 +261,18 @@ const static struct fb_videomode ecovec_dvi_modes[] = {
 	},
 };
 
+static int ecovec24_set_brightness(void *board_data, int brightness)
+{
+	gpio_set_value(GPIO_PTR1, brightness);
+
+	return 0;
+}
+
+static int ecovec24_get_brightness(void *board_data)
+{
+	return gpio_get_value(GPIO_PTR1);
+}
+
 static struct sh_mobile_lcdc_info lcdc_info = {
 	.ch[0] = {
 		.interface_type = RGB18,
@@ -271,6 +283,12 @@ static struct sh_mobile_lcdc_info lcdc_info = {
 			.height = 91,
 		},
 		.board_cfg = {
+			.set_brightness = ecovec24_set_brightness,
+			.get_brightness = ecovec24_get_brightness,
+		},
+		.bl_info = {
+			.name = "sh_mobile_lcdc_bl",
+			.max_brightness = 1,
 		},
 	}
 };
-- 
1.7.4.1

