From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 21 Oct 2008 12:32:31 +0000
Subject: [PATCH] sh: Migo-R MMC support using spi_gpio and mmc_spi
Message-Id: <20081021123231.27894.26150.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds CN9 MMC support for MigoR using the mmc_spi driver on
top of the bitbanging spi_gpio driver.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Needs the header from the not-yet-merged spi_gpio driver.

 arch/sh/boards/mach-migor/setup.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

--- 0002/arch/sh/boards/mach-migor/setup.c
+++ work/arch/sh/boards/mach-migor/setup.c	2008-10-21 20:03:36.000000000 +0900
@@ -18,6 +18,8 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/gpio.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_gpio.h>
 #include <media/soc_camera_platform.h>
 #include <media/sh_mobile_ceu.h>
 #include <video/sh_mobile_lcdc.h>
@@ -436,6 +438,20 @@ static struct platform_device migor_ceu_
 	},
 };
 
+struct spi_gpio_platform_data sdcard_cn9_platform_data = {
+	.sck = GPIO_PTD0,
+	.mosi = GPIO_PTD1,
+	.miso = GPIO_PTD2,
+	.num_chipselect = 1,
+};
+
+static struct platform_device sdcard_cn9_device = {
+	.name		= "spi_gpio",
+	.dev	= {
+		.platform_data	= &sdcard_cn9_platform_data,
+	},
+};
+
 static struct platform_device *migor_devices[] __initdata = {
 	&smc91x_eth_device,
 	&sh_keysc_device,
@@ -446,6 +462,7 @@ static struct platform_device *migor_dev
 #endif
 	&migor_nor_flash_device,
 	&migor_nand_flash_device,
+	&sdcard_cn9_device,
 };
 
 static struct i2c_board_info migor_i2c_devices[] = {
@@ -458,6 +475,15 @@ static struct i2c_board_info migor_i2c_d
 	},
 };
 
+static struct spi_board_info migor_spi_devices[] = {
+	{
+		.modalias = "mmc_spi",
+		.max_speed_hz = 5000000,
+		.chip_select = 0,
+		.controller_data = (void *) GPIO_PTD5,
+	},
+};
+
 static int __init migor_devices_setup(void)
 {
 	/* Lit D11 LED */
@@ -583,6 +609,9 @@ static int __init migor_devices_setup(vo
 	i2c_register_board_info(0, migor_i2c_devices,
 				ARRAY_SIZE(migor_i2c_devices));
 
+	spi_register_board_info(migor_spi_devices,
+				ARRAY_SIZE(migor_spi_devices));
+
 	return platform_add_devices(migor_devices, ARRAY_SIZE(migor_devices));
 }
 __initcall(migor_devices_setup);
