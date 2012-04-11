From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 11 Apr 2012 03:58:45 +0000
Subject: [PATCH 6/6] ARM: mach-shmobile: kzm9g: add ST1232 Touchscreen support
Message-Id: <8762d63oni.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-kzm9g.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 145341d..c846531 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -21,6 +21,7 @@
 #include <linux/gpio.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/i2c.h>
 #include <linux/platform_device.h>
 #include <linux/smsc911x.h>
 #include <linux/usb/r8a66597.h>
@@ -146,6 +147,13 @@ static struct platform_device lcdc_device = {
 	},
 };
 
+static struct i2c_board_info i2c1_devices[] = {
+	{
+		I2C_BOARD_INFO("st1232-ts", 0x55),
+		.irq = intcs_evt2irq(0x300), /* IRQ8 */
+	},
+};
+
 static struct platform_device *kzm_devices[] __initdata = {
 	&smsc_device,
 	&usb_host_device,
@@ -253,11 +261,17 @@ static void __init kzm_init(void)
 	gpio_request(GPIO_PORT222,	NULL);
 	gpio_direction_output(GPIO_PORT222, 1);
 
+	/* Touchscreen */
+	gpio_request(GPIO_PORT223, NULL); /* IRQ8 */
+	gpio_direction_input(GPIO_PORT223);
+
 #ifdef CONFIG_CACHE_L2X0
 	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
 	l2x0_init(IOMEM(0xf0100000), 0x40460000, 0x82000fff);
 #endif
 
+	i2c_register_board_info(1, i2c1_devices, ARRAY_SIZE(i2c1_devices));
+
 	sh73a0_add_standard_devices();
 	platform_add_devices(kzm_devices, ARRAY_SIZE(kzm_devices));
 }
-- 
1.7.5.4

