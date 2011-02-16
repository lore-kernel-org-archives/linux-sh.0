From: Alexandre Courbot <gnurou@gmail.com>
Date: Wed, 16 Feb 2011 03:49:03 +0000
Subject: [PATCH v2 3/3] sh: mach-ap325rxa: move backlight control code
Message-Id: <1297828143-11798-4-git-send-email-gnurou@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Move the backlight control code into the appropriate hooks for the LCDC
driver.

Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
---
 arch/sh/boards/mach-ap325rxa/setup.c |   32 ++++++++++++++++++++++++--------
 1 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
index 3e5fc3b..d695e43 100644
--- a/arch/sh/boards/mach-ap325rxa/setup.c
+++ b/arch/sh/boards/mach-ap325rxa/setup.c
@@ -156,24 +156,34 @@ static struct platform_device nand_flash_device = {
 #define PORT_DRVCRA	0xA405018A
 #define PORT_DRVCRB	0xA405018C
 
+static int ap320_wvga_set_brightness(void *board_data, int brightness)
+{
+	if (brightness) {
+		gpio_set_value(GPIO_PTS3, 0);
+		__raw_writew(0x100, FPGA_BKLREG);
+	} else {
+		__raw_writew(0, FPGA_BKLREG);
+		gpio_set_value(GPIO_PTS3, 1);
+	}
+	
+	return 0;
+}
+
+static int ap320_wvga_get_brightness(void *board_data)
+{
+	return gpio_get_value(GPIO_PTS3);
+}
+
 static void ap320_wvga_power_on(void *board_data, struct fb_info *info)
 {
 	msleep(100);
 
 	/* ASD AP-320/325 LCD ON */
 	__raw_writew(FPGA_LCDREG_VAL, FPGA_LCDREG);
-
-	/* backlight */
-	gpio_set_value(GPIO_PTS3, 0);
-	__raw_writew(0x100, FPGA_BKLREG);
 }
 
 static void ap320_wvga_power_off(void *board_data)
 {
-	/* backlight */
-	__raw_writew(0, FPGA_BKLREG);
-	gpio_set_value(GPIO_PTS3, 1);
-
 	/* ASD AP-320/325 LCD OFF */
 	__raw_writew(0, FPGA_LCDREG);
 }
@@ -209,6 +219,12 @@ static struct sh_mobile_lcdc_info lcdc_info = {
 		.board_cfg = {
 			.display_on = ap320_wvga_power_on,
 			.display_off = ap320_wvga_power_off,
+			.set_brightness = ap320_wvga_set_brightness,
+			.get_brightness = ap320_wvga_get_brightness,
+		},
+		.bl_info = {
+			.name = "sh_mobile_lcdc_bl",
+			.max_brightness = 1,
 		},
 	}
 };
-- 
1.7.4.1

