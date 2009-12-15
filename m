From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 15 Dec 2009 05:37:16 +0000
Subject: [PATCH 1/3] sh: mach-ecovec24: Add tw9910 support
Message-Id: <uocm0vlv7.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |   50 ++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 826e623..8b4d68b 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -24,6 +24,7 @@
 #include <linux/mfd/sh_mobile_sdhi.h>
 #include <video/sh_mobile_lcdc.h>
 #include <media/sh_mobile_ceu.h>
+#include <media/tw9910.h>
 #include <asm/heartbeat.h>
 #include <asm/sh_eth.h>
 #include <asm/clock.h>
@@ -493,6 +494,50 @@ static struct platform_device sdhi1_device = {
 	},
 };
 
+/* I2C Video */
+static struct i2c_board_info i2c_camera[] = {
+	{
+		I2C_BOARD_INFO("tw9910", 0x45),
+	},
+};
+
+/* tw9910 */
+static int tw9910_power(struct device *dev, int mode)
+{
+	int val = mode ? 0 : 1;
+
+	gpio_set_value(GPIO_PTU2, val);
+	if (mode)
+		mdelay(100);
+
+	return 0;
+}
+
+static struct tw9910_video_info tw9910_info = {
+	.buswidth	= SOCAM_DATAWIDTH_8,
+	.mpout		= TW9910_MPO_FIELD,
+};
+
+static struct soc_camera_link tw9910_link = {
+	.i2c_adapter_id	= 0,
+	.bus_id		= 1,
+	.power		= tw9910_power,
+	.board_info	= &i2c_camera[0],
+	.module_name	= "tw9910",
+	.priv		= &tw9910_info,
+};
+
+
+static struct platform_device camera_devices[] = {
+	{
+		.name	= "soc-camera-pdrv",
+		.id	= 0,
+		.dev	= {
+			.platform_data = &tw9910_link,
+		},
+	},
+};
+
 static struct platform_device *ecovec_devices[] __initdata = {
 	&heartbeat_device,
 	&nor_flash_device,
@@ -505,6 +550,7 @@ static struct platform_device *ecovec_devices[] __initdata = {
 	&keysc_device,
 	&sdhi0_device,
 	&sdhi1_device,
+	&camera_devices[0],
 };
 
 #define EEPROM_ADDR 0x50
@@ -800,6 +846,10 @@ static int __init arch_setup(void)
 	/* I/O buffer drive ability is high for SDHI1 */
 	ctrl_outw((ctrl_inw(IODRIVEA) & ~0x3000) | 0x2000 , IODRIVEA);
 
+	/* enable Video */
+	gpio_request(GPIO_PTU2, NULL);
+	gpio_direction_output(GPIO_PTU2, 1);
+
 	/* enable I2C device */
 	i2c_register_board_info(1, i2c1_devices,
 				ARRAY_SIZE(i2c1_devices));
-- 
1.6.3.3

