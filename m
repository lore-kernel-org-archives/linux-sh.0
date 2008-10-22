From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 22 Oct 2008 09:27:57 +0000
Subject: [PATCH] sh: ap325rxa MMC support using spi_gpio and mmc_spi
Message-Id: <20081022092757.1075.26284.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds CN3 MMC support for ap325rxa using the mmc_spi driver on
top of the bitbanging spi_gpio driver.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/board-ap325rxa.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

--- 0001/arch/sh/boards/board-ap325rxa.c
+++ work/arch/sh/boards/board-ap325rxa.c	2008-10-22 17:41:50.000000000 +0900
@@ -20,6 +20,8 @@
 #include <linux/i2c.h>
 #include <linux/smc911x.h>
 #include <linux/gpio.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_gpio.h>
 #include <media/soc_camera_platform.h>
 #include <media/sh_mobile_ceu.h>
 #include <video/sh_mobile_lcdc.h>
@@ -310,6 +312,20 @@ static struct platform_device ceu_device
 	},
 };
 
+struct spi_gpio_platform_data sdcard_cn3_platform_data = {
+	.sck = GPIO_PTD0,
+	.mosi = GPIO_PTD1,
+	.miso = GPIO_PTD2,
+	.num_chipselect = 1,
+};
+
+static struct platform_device sdcard_cn3_device = {
+	.name		= "spi_gpio",
+	.dev	= {
+		.platform_data	= &sdcard_cn3_platform_data,
+	},
+};
+
 static struct platform_device *ap325rxa_devices[] __initdata = {
 	&smc9118_device,
 	&ap325rxa_nor_flash_device,
@@ -319,6 +335,7 @@ static struct platform_device *ap325rxa_
 	&camera_device,
 #endif
 	&nand_flash_device,
+	&sdcard_cn3_device,
 };
 
 static struct i2c_board_info __initdata ap325rxa_i2c_devices[] = {
@@ -327,6 +344,15 @@ static struct i2c_board_info __initdata 
 	},
 };
 
+static struct spi_board_info ap325rxa_spi_devices[] = {
+	{
+		.modalias = "mmc_spi",
+		.max_speed_hz = 5000000,
+		.chip_select = 0,
+		.controller_data = (void *) GPIO_PTD5,
+	},
+};
+
 static int __init ap325rxa_devices_setup(void)
 {
 	/* LD3 and LD4 LEDs */
@@ -426,6 +452,9 @@ static int __init ap325rxa_devices_setup
 	i2c_register_board_info(0, ap325rxa_i2c_devices,
 				ARRAY_SIZE(ap325rxa_i2c_devices));
 
+	spi_register_board_info(ap325rxa_spi_devices,
+				ARRAY_SIZE(ap325rxa_spi_devices));
+
 	return platform_add_devices(ap325rxa_devices,
 				ARRAY_SIZE(ap325rxa_devices));
 }
