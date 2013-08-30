From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Fri, 30 Aug 2013 12:37:42 +0000
Subject: [RFC 08/10] ARM: shmobile: r8a7790: lager: i2c support
Message-Id: <1377866264-21110-9-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Enables the four i2c busses on the Lager board.

Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
---
 arch/arm/mach-shmobile/board-lager.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 4c3e694..c6b5f21 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -20,6 +20,7 @@
 
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
+#include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -171,6 +172,11 @@ static const struct pinctrl_map lager_pinctrl_map[] = {
 				  "du_sync_1", "du"),
 	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7790", "pfc-r8a7790",
 				  "du_clk_out_0", "du"),
+	/* I2C */
+	PIN_MAP_MUX_GROUP_DEFAULT("rcar-i2c.1", "pfc-r8a7790",
+				  "i2c1", "i2c1"),
+	PIN_MAP_MUX_GROUP_DEFAULT("rcar-i2c.2", "pfc-r8a7790",
+				  "i2c2", "i2c2"),
 	/* SCIF0 (CN19: DEBUG SERIAL0) */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.6", "pfc-r8a7790",
 				  "scif0_data", "scif0"),
@@ -193,6 +199,23 @@ static const struct pinctrl_map lager_pinctrl_map[] = {
 				  "intc_irq0", "intc"),
 };
 
+static struct i2c_board_info i2c2_devices[] = {
+	/* ak4643 at 0x12: no driver */
+	{
+		I2C_BOARD_INFO("adv7180", 0x20),
+	},
+	{
+		I2C_BOARD_INFO("adv7511", 0x39),
+	},
+	/* adv7612 at 0x4c: no driver */
+};
+
+/* I2C */
+static struct i2c_rcar_platform_data i2c_pdata = {
+	.bus_speed	= 100000,
+	.flags		= I2C_RCAR_FLAGS_ICCCR_IS_3BIT,
+};
+
 static void __init lager_add_standard_devices(void)
 {
 	r8a7790_clock_init();
@@ -220,6 +243,15 @@ static void __init lager_add_standard_devices(void)
 					  &ether_pdata, sizeof(ether_pdata));
 
 	lager_add_du_device();
+
+	r8a7790_add_i2c_device(0, &i2c_pdata);
+	r8a7790_add_i2c_device(1, &i2c_pdata);
+	r8a7790_add_i2c_device(2, &i2c_pdata);
+	r8a7790_add_i2c_device(3, &i2c_pdata);
+
+	/* I2C channels 0 and 3 are wired to external connectors; channel 1
+	   has only one device (da9063) for which no driver exists. */
+	i2c_register_board_info(2, i2c2_devices, ARRAY_SIZE(i2c2_devices));
 }
 
 static const char * const lager_boards_compat_dt[] __initconst = {
-- 
1.8.1.4

