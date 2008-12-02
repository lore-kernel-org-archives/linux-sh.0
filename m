From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 02 Dec 2008 07:38:34 +0000
Subject: [PATCH 1/2] Add support ov772x driver setting for Migo-R
Message-Id: <u3ah7m2kz.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
this patch is for linux 2.6.29
V4L2 maintainer said ov772x driver will be added to linux 2.6.29

 arch/sh/boards/mach-migor/setup.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index 03d2dea..4b348d8 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -20,6 +20,7 @@
 #include <linux/gpio.h>
 #include <media/soc_camera_platform.h>
 #include <media/sh_mobile_ceu.h>
+#include <media/ov772x.h>
 #include <video/sh_mobile_lcdc.h>
 #include <asm/clock.h>
 #include <asm/machvec.h>
@@ -319,6 +320,16 @@ static void camera_power(int mode)
 		camera_power_off();
 }
 
+static int ov7725_power(struct device *dev, int mode)
+{
+	if (mode)
+		camera_power_on();
+	else
+		camera_power_off();
+
+	return 0;
+}
+
 #ifdef CONFIG_I2C
 static unsigned char camera_ov772x_magic[]  {
@@ -441,6 +452,13 @@ static struct platform_device migor_ceu_device = {
 	},
 };
 
+struct ov772x_camera_info ov7725_info = {
+	.buswidth  = SOCAM_DATAWIDTH_8,
+	.link = {
+		.power  = ov7725_power,
+	},
+};
+
 static struct platform_device *migor_devices[] __initdata = {
 	&smc91x_eth_device,
 	&sh_keysc_device,
@@ -461,6 +479,10 @@ static struct i2c_board_info migor_i2c_devices[] = {
 		I2C_BOARD_INFO("migor_ts", 0x51),
 		.irq = 38, /* IRQ6 */
 	},
+	{
+		I2C_BOARD_INFO("ov772x", 0x21),
+		.platform_data = &ov7725_info,
+	},
 };
 
 static int __init migor_devices_setup(void)
-- 
1.5.6.3

