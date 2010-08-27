From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 27 Aug 2010 09:49:30 +0000
Subject: [PATCH] sh: ecovec24: modify tsc2007 platform settings
Message-Id: <w3pmxs8idw5.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch modify x_plate_ohms to correct value for tsc2007 panel,
and removed un-necessary ts_get_pendown_state()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |   26 ++------------------------
 1 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 1d7b495..db7a7c0 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -400,32 +400,9 @@ static struct platform_device keysc_device = {
 
 /* TouchScreen */
 #define IRQ0 32
-static int ts_get_pendown_state(void)
-{
-	int val = 0;
-	gpio_free(GPIO_FN_INTC_IRQ0);
-	gpio_request(GPIO_PTZ0, NULL);
-	gpio_direction_input(GPIO_PTZ0);
-
-	val = gpio_get_value(GPIO_PTZ0);
-
-	gpio_free(GPIO_PTZ0);
-	gpio_request(GPIO_FN_INTC_IRQ0, NULL);
-
-	return val ? 0 : 1;
-}
-
-static int ts_init(void)
-{
-	gpio_request(GPIO_FN_INTC_IRQ0, NULL);
-	return 0;
-}
-
 static struct tsc2007_platform_data tsc2007_info = {
 	.model			= 2007,
-	.x_plate_ohms		= 180,
-	.get_pendown_state	= ts_get_pendown_state,
-	.init_platform_hw	= ts_init,
+	.x_plate_ohms		= 1000,
 };
 
 static struct i2c_board_info ts_i2c_clients = {
@@ -1119,6 +1096,7 @@ static int __init arch_setup(void)
 		gpio_direction_output(GPIO_PTF4, 1);
 
 		/* enable TouchScreen */
+		gpio_request(GPIO_FN_INTC_IRQ0, NULL);
 		i2c_register_board_info(0, &ts_i2c_clients, 1);
 		set_irq_type(IRQ0, IRQ_TYPE_LEVEL_LOW);
 	}
-- 
1.7.0.4

