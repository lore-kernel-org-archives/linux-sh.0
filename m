From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 12 May 2009 15:13:40 +0000
Subject: [PATCH 3/3] SH: convert migor to soc-camera as platform-device
Message-Id: <Pine.LNX.4.64.0905121712430.5087@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0905121649420.5087@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0905121649420.5087@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Media Mailing List <linux-media@vger.kernel.org>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/boards/mach-migor/setup.c |   79 ++++++++++++++++++++++++-------------
 1 files changed, 52 insertions(+), 27 deletions(-)

diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index c4b97e1..785c3e1 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -381,21 +381,6 @@ static struct platform_device migor_ceu_device = {
 	},
 };
 
-static struct ov772x_camera_info ov7725_info = {
-	.buswidth  = SOCAM_DATAWIDTH_8,
-	.link = {
-		.power  = ov7725_power,
-	},
-};
-
-static struct tw9910_video_info tw9910_info = {
-	.buswidth = SOCAM_DATAWIDTH_8,
-	.mpout    = TW9910_MPO_FIELD,
-	.link = {
-		.power  = tw9910_power,
-	}
-};
-
 struct spi_gpio_platform_data sdcard_cn9_platform_data = {
 	.sck = GPIO_PTD0,
 	.mosi = GPIO_PTD1,
@@ -410,16 +395,6 @@ static struct platform_device sdcard_cn9_device = {
 	},
 };
 
-static struct platform_device *migor_devices[] __initdata = {
-	&smc91x_eth_device,
-	&sh_keysc_device,
-	&migor_lcdc_device,
-	&migor_ceu_device,
-	&migor_nor_flash_device,
-	&migor_nand_flash_device,
-	&sdcard_cn9_device,
-};
-
 static struct i2c_board_info migor_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("rs5c372b", 0x32),
@@ -428,16 +403,66 @@ static struct i2c_board_info migor_i2c_devices[] = {
 		I2C_BOARD_INFO("migor_ts", 0x51),
 		.irq = 38, /* IRQ6 */
 	},
+};
+
+static struct i2c_board_info migor_i2c_camera[] = {
 	{
 		I2C_BOARD_INFO("ov772x", 0x21),
-		.platform_data = &ov7725_info.link,
 	},
 	{
 		I2C_BOARD_INFO("tw9910", 0x45),
-		.platform_data = &tw9910_info.link,
 	},
 };
 
+static struct ov772x_camera_info ov7725_info = {
+	.buswidth	= SOCAM_DATAWIDTH_8,
+	.link = {
+		.power		= ov7725_power,
+		.board_info	= &migor_i2c_camera[0],
+		.i2c_adapter_id	= 0,
+		.module_name	= "ov772x",
+	},
+};
+
+static struct tw9910_video_info tw9910_info = {
+	.buswidth	= SOCAM_DATAWIDTH_8,
+	.mpout		= TW9910_MPO_FIELD,
+	.link = {
+		.power		= tw9910_power,
+		.board_info	= &migor_i2c_camera[1],
+		.i2c_adapter_id	= 0,
+		.module_name	= "tw9910",
+	}
+};
+
+static struct platform_device migor_camera[] = {
+	{
+		.name	= "soc-camera-pdrv",
+		.id	= 0,
+		.dev	= {
+			.platform_data = &ov7725_info.link,
+		},
+	}, {
+		.name	= "soc-camera-pdrv",
+		.id	= 1,
+		.dev	= {
+			.platform_data = &tw9910_info.link,
+		},
+	},
+};
+
+static struct platform_device *migor_devices[] __initdata = {
+	&smc91x_eth_device,
+	&sh_keysc_device,
+	&migor_lcdc_device,
+	&migor_ceu_device,
+	&migor_nor_flash_device,
+	&migor_nand_flash_device,
+	&sdcard_cn9_device,
+	&migor_camera[0],
+	&migor_camera[1],
+};
+
 static struct spi_board_info migor_spi_devices[] = {
 	{
 		.modalias = "mmc_spi",
-- 
1.6.2.4

