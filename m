From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 22 Jan 2009 00:38:31 +0000
Subject: [PATCH 2/2] Add support ov772x driver setting to ap325
Message-Id: <uhc3skvqd.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch add ov772x camera settings to ap325,
Old camera is still supported. And it will be 2nd camera
if you select ov772x and soc_camera_platform in same time.

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Signed-off-by: Magnus Damm <damm@igel.co.jp>
---
 arch/sh/boards/board-ap325rxa.c |   53 ++++++++++++++++++++++++++++++++++++--
 1 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/arch/sh/boards/board-ap325rxa.c b/arch/sh/boards/board-ap325rxa.c
index 72da416..7c35787 100644
--- a/arch/sh/boards/board-ap325rxa.c
+++ b/arch/sh/boards/board-ap325rxa.c
@@ -22,6 +22,7 @@
 #include <linux/gpio.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_gpio.h>
+#include <media/ov772x.h>
 #include <media/soc_camera_platform.h>
 #include <media/sh_mobile_ceu.h>
 #include <video/sh_mobile_lcdc.h>
@@ -223,6 +224,7 @@ static void camera_power(int val)
 }
 
 #ifdef CONFIG_I2C
+/* support for the old ncm03j camera */
 static unsigned char camera_ncm03j_magic[]  {
 	0x87, 0x00, 0x88, 0x08, 0x89, 0x01, 0x8A, 0xE8,
@@ -243,6 +245,23 @@ static unsigned char camera_ncm03j_magic[]  	0x63, 0xD4, 0x64, 0xEA, 0xD6, 0x0F,
 };
 
+static int camera_probe(void)
+{
+	struct i2c_adapter *a = i2c_get_adapter(0);
+	struct i2c_msg msg;
+	int ret;
+
+	camera_power(1);
+	msg.addr = 0x6e;
+	msg.buf = camera_ncm03j_magic;
+	msg.len = 2;
+	msg.flags = 0;
+	ret = i2c_transfer(a, &msg, 1);
+	camera_power(0);
+
+	return ret;
+}
+
 static int camera_set_capture(struct soc_camera_platform_info *info,
 			      int enable)
 {
@@ -294,8 +313,35 @@ static struct platform_device camera_device = {
 		.platform_data	= &camera_info,
 	},
 };
+
+static int __init camera_setup(void)
+{
+	if (camera_probe() > 0)
+		platform_device_register(&camera_device);
+
+	return 0;
+}
+late_initcall(camera_setup);
+
 #endif /* CONFIG_I2C */
 
+static int ov7725_power(struct device *dev, int mode)
+{
+	camera_power(0);
+	if (mode)
+		camera_power(1);
+
+	return 0;
+}
+
+static struct ov772x_camera_info ov7725_info = {
+	.buswidth  = SOCAM_DATAWIDTH_8,
+	.flags = OV772X_FLAG_VFLIP | OV772X_FLAG_HFLIP,
+	.link = {
+		.power  = ov7725_power,
+	},
+};
+
 static struct sh_mobile_ceu_info sh_mobile_ceu_info = {
 	.flags = SOCAM_PCLK_SAMPLE_RISING | SOCAM_HSYNC_ACTIVE_HIGH |
 	SOCAM_VSYNC_ACTIVE_HIGH | SOCAM_MASTER | SOCAM_DATAWIDTH_8,
@@ -346,9 +392,6 @@ static struct platform_device *ap325rxa_devices[] __initdata = {
 	&ap325rxa_nor_flash_device,
 	&lcdc_device,
 	&ceu_device,
-#ifdef CONFIG_I2C
-	&camera_device,
-#endif
 	&nand_flash_device,
 	&sdcard_cn3_device,
 };
@@ -357,6 +400,10 @@ static struct i2c_board_info __initdata ap325rxa_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("pcf8563", 0x51),
 	},
+	{
+		I2C_BOARD_INFO("ov772x", 0x21),
+		.platform_data = &ov7725_info,
+	},
 };
 
 static struct spi_board_info ap325rxa_spi_devices[] = {
-- 
1.5.6.3

