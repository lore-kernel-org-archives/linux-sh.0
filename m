From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Mon, 28 Sep 2009 08:21:41 +0000
Subject: [PATCH] sh: mach-ecovec24: Add TouchScreen support
Message-Id: <u63b3cwdm.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |   42 ++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 5f9881e..52912a6 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/usb/r8a66597.h>
 #include <linux/i2c.h>
+#include <linux/i2c/tsc2007.h>
 #include <linux/input.h>
 #include <video/sh_mobile_lcdc.h>
 #include <media/sh_mobile_ceu.h>
@@ -376,6 +377,43 @@ static struct platform_device keysc_device = {
 	},
 };
 
+/* TouchScreen */
+#define IRQ0 32
+static int ts_get_pendown_state(void)
+{
+	int val = 0;
+	gpio_free(GPIO_FN_INTC_IRQ0);
+	gpio_request(GPIO_PTZ0, NULL);
+	gpio_direction_input(GPIO_PTZ0);
+
+	val = gpio_get_value(GPIO_PTZ0);
+
+	gpio_free(GPIO_PTZ0);
+	gpio_request(GPIO_FN_INTC_IRQ0, NULL);
+
+	return val ? 0 : 1;
+}
+
+static int ts_init(void)
+{
+	gpio_request(GPIO_FN_INTC_IRQ0, NULL);
+	return 0;
+}
+
+struct tsc2007_platform_data tsc2007_info = {
+	.model			= 2007,
+	.x_plate_ohms		= 180,
+	.get_pendown_state	= ts_get_pendown_state,
+	.init_platform_hw	= ts_init,
+};
+
+static struct i2c_board_info ts_i2c_clients = {
+	I2C_BOARD_INFO("tsc2007", 0x48),
+	.type		= "tsc2007",
+	.platform_data	= &tsc2007_info,
+	.irq		= IRQ0,
+};
+
 static struct platform_device *ecovec_devices[] __initdata = {
 	&heartbeat_device,
 	&nor_flash_device,
@@ -590,6 +628,10 @@ static int __init arch_setup(void)
 		 */
 		gpio_request(GPIO_PTF4, NULL);
 		gpio_direction_output(GPIO_PTF4, 1);
+
+		/* enable TouchScreen */
+		i2c_register_board_info(0, &ts_i2c_clients, 1);
+		set_irq_type(IRQ0, IRQ_TYPE_LEVEL_LOW);
 	}
 
 	/* enable CEU0 */
-- 
1.6.0.4

