From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 15 Dec 2009 05:37:26 +0000
Subject: [PATCH 2/3] sh: mach-ecovec24: Add mt9t112 camera support
Message-Id: <umy1kvlux.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |   79 +++++++++++++++++++++++++++++++++-
 1 files changed, 78 insertions(+), 1 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 8b4d68b..459501c 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -25,6 +25,7 @@
 #include <video/sh_mobile_lcdc.h>
 #include <media/sh_mobile_ceu.h>
 #include <media/tw9910.h>
+#include <media/mt9t112.h>
 #include <asm/heartbeat.h>
 #include <asm/sh_eth.h>
 #include <asm/clock.h>
@@ -494,11 +495,19 @@ static struct platform_device sdhi1_device = {
 	},
 };
 
-/* I2C Video */
+/* I2C Video/Camera */
 static struct i2c_board_info i2c_camera[] = {
 	{
 		I2C_BOARD_INFO("tw9910", 0x45),
 	},
+	{
+		/* 1st camera */
+		I2C_BOARD_INFO("mt9t112", 0x3c),
+	},
+	{
+		/* 2nd camera */
+		I2C_BOARD_INFO("mt9t112", 0x3c),
+	},
 };
 
 /* tw9910 */
@@ -527,6 +536,52 @@ static struct soc_camera_link tw9910_link = {
 	.priv		= &tw9910_info,
 };
 
+/* mt9t112 */
+static int mt9t112_power1(struct device *dev, int mode)
+{
+	gpio_set_value(GPIO_PTA3, mode);
+	if (mode)
+		mdelay(100);
+
+	return 0;
+}
+
+static struct mt9t112_camera_info mt9t112_info1 = {
+	.flags = MT9T112_FLAG_PCLK_RISING_EDGE | MT9T112_FLAG_DATAWIDTH_8,
+	.divider = { 0x49, 0x6, 0, 6, 0, 9, 9, 6, 0 }, /* for 24MHz */
+};
+
+static struct soc_camera_link mt9t112_link1 = {
+	.i2c_adapter_id	= 0,
+	.power		= mt9t112_power1,
+	.bus_id		= 0,
+	.board_info	= &i2c_camera[1],
+	.module_name	= "mt9t112",
+	.priv		= &mt9t112_info1,
+};
+
+static int mt9t112_power2(struct device *dev, int mode)
+{
+	gpio_set_value(GPIO_PTA4, mode);
+	if (mode)
+		mdelay(100);
+
+	return 0;
+}
+
+static struct mt9t112_camera_info mt9t112_info2 = {
+	.flags = MT9T112_FLAG_PCLK_RISING_EDGE | MT9T112_FLAG_DATAWIDTH_8,
+	.divider = { 0x49, 0x6, 0, 6, 0, 9, 9, 6, 0 }, /* for 24MHz */
+};
+
+static struct soc_camera_link mt9t112_link2 = {
+	.i2c_adapter_id	= 1,
+	.power		= mt9t112_power2,
+	.bus_id		= 1,
+	.board_info	= &i2c_camera[2],
+	.module_name	= "mt9t112",
+	.priv		= &mt9t112_info2,
+};
 
 static struct platform_device camera_devices[] = {
 	{
@@ -536,6 +591,20 @@ static struct platform_device camera_devices[] = {
 			.platform_data = &tw9910_link,
 		},
 	},
+	{
+		.name	= "soc-camera-pdrv",
+		.id	= 1,
+		.dev	= {
+			.platform_data = &mt9t112_link1,
+		},
+	},
+	{
+		.name	= "soc-camera-pdrv",
+		.id	= 2,
+		.dev	= {
+			.platform_data = &mt9t112_link2,
+		},
+	},
 };
 
 static struct platform_device *ecovec_devices[] __initdata = {
@@ -551,6 +620,8 @@ static struct platform_device *ecovec_devices[] __initdata = {
 	&sdhi0_device,
 	&sdhi1_device,
 	&camera_devices[0],
+	&camera_devices[1],
+	&camera_devices[2],
 };
 
 #define EEPROM_ADDR 0x50
@@ -850,6 +921,12 @@ static int __init arch_setup(void)
 	gpio_request(GPIO_PTU2, NULL);
 	gpio_direction_output(GPIO_PTU2, 1);
 
+	/* enable Camera */
+	gpio_request(GPIO_PTA3, NULL);
+	gpio_request(GPIO_PTA4, NULL);
+	gpio_direction_output(GPIO_PTA3, 0);
+	gpio_direction_output(GPIO_PTA4, 0);
+
 	/* enable I2C device */
 	i2c_register_board_info(1, i2c1_devices,
 				ARRAY_SIZE(i2c1_devices));
-- 
1.6.3.3

