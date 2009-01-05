From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Mon, 05 Jan 2009 07:25:16 +0000
Subject: [PATCH] Add support tw9910 driver setting for Migo-R
Message-Id: <ubpum6uuu.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-migor/setup.c |   37 +++++++++++++++++++++++++++++++++++--
 1 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index 6df933d..53537fe 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -20,6 +20,7 @@
 #include <linux/gpio.h>
 #include <media/sh_mobile_ceu.h>
 #include <media/ov772x.h>
+#include <media/tw9910.h>
 #include <video/sh_mobile_lcdc.h>
 #include <asm/clock.h>
 #include <asm/machvec.h>
@@ -292,9 +293,12 @@ static struct platform_device migor_lcdc_device = {
 };
 
 static struct clk *camera_clk;
+static DEFINE_MUTEX(camera_lock);
 
-static void camera_power_on(void)
+static void camera_power_on(int is_tw)
 {
+	mutex_lock(&camera_lock);
+
 	/* Use 10 MHz VIO_CKO instead of 24 MHz to work
 	 * around signal quality issues on Panel Board V2.1.
 	 */
@@ -304,6 +308,12 @@ static void camera_power_on(void)
 
 	/* use VIO_RST to take camera out of reset */
 	mdelay(10);
+	if (is_tw) {
+		gpio_set_value(GPIO_PTT2, 0);
+		gpio_set_value(GPIO_PTT0, 0);
+	} else {
+		gpio_set_value(GPIO_PTT0, 1);
+	}
 	gpio_set_value(GPIO_PTT3, 0);
 	mdelay(10);
 	gpio_set_value(GPIO_PTT3, 1);
@@ -316,12 +326,23 @@ static void camera_power_off(void)
 	clk_put(camera_clk);
 
 	gpio_set_value(GPIO_PTT3, 0);
+	mutex_unlock(&camera_lock);
 }
 
 static int ov7725_power(struct device *dev, int mode)
 {
 	if (mode)
-		camera_power_on();
+		camera_power_on(0);
+	else
+		camera_power_off();
+
+	return 0;
+}
+
+static int tw9910_power(struct device *dev, int mode)
+{
+	if (mode)
+		camera_power_on(1);
 	else
 		camera_power_off();
 
@@ -366,6 +387,14 @@ static struct ov772x_camera_info ov7725_info = {
 	},
 };
 
+static struct tw9910_video_info tw9910_info = {
+	.buswidth = SOCAM_DATAWIDTH_8,
+	.mpout    = TW9910_MPO_FIELD,
+	.link = {
+		.power  = tw9910_power,
+	}
+};
+
 static struct platform_device *migor_devices[] __initdata = {
 	&smc91x_eth_device,
 	&sh_keysc_device,
@@ -387,6 +416,10 @@ static struct i2c_board_info migor_i2c_devices[] = {
 		I2C_BOARD_INFO("ov772x", 0x21),
 		.platform_data = &ov7725_info,
 	},
+	{
+		I2C_BOARD_INFO("tw9910", 0x45),
+		.platform_data = &tw9910_info,
+	},
 };
 
 static int __init migor_devices_setup(void)
-- 
1.5.6.3

