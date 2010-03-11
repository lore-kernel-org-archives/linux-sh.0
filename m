From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 11 Mar 2010 10:42:52 +0000
Subject: [PATCH 2/3] ARM: mach-shmobile: ap4evb: Add TouchScreen support
Message-Id: <upr3bgmvn.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 1c2ec96..b104314 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -26,6 +26,8 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
+#include <linux/i2c.h>
+#include <linux/i2c/tsc2007.h>
 #include <linux/io.h>
 #include <linux/smsc911x.h>
 #include <linux/gpio.h>
@@ -234,6 +236,23 @@ static struct platform_device *ap4evb_devices[] __initdata = {
 	&sdhi0_device,
 };
 
+/* TouchScreen */
+#define IRQ28	396
+struct tsc2007_platform_data tsc2007_info = {
+	.model			= 2007,
+	.x_plate_ohms		= 180,
+};
+
+/* I2C */
+static struct i2c_board_info i2c1_devices[] = {
+	{
+		I2C_BOARD_INFO("tsc2007", 0x48),
+		.type		= "tsc2007",
+		.platform_data	= &tsc2007_info,
+		.irq		= IRQ28,
+	},
+};
+
 static struct map_desc ap4evb_io_desc[] __initdata = {
 	/* create a 1:1 entity map for 0xe6xxxxxx
 	 * used by CPGA, INTC and PFC.
@@ -318,6 +337,13 @@ static void __init ap4evb_init(void)
 	gpio_request(GPIO_FN_SDHID0_1, NULL);
 	gpio_request(GPIO_FN_SDHID0_0, NULL);
 
+	/* enable TouchScreen */
+	gpio_request(GPIO_FN_IRQ28_123, NULL);
+	set_irq_type(IRQ28, IRQ_TYPE_LEVEL_LOW);
+
+	i2c_register_board_info(1, i2c1_devices,
+				ARRAY_SIZE(i2c1_devices));
+
 	sh7372_add_standard_devices();
 
 	platform_add_devices(ap4evb_devices, ARRAY_SIZE(ap4evb_devices));
-- 
1.6.3.3

