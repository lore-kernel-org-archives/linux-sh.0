From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Tue, 10 Sep 2013 11:39:52 +0000
Subject: [PATCH 1/3] ARM: shmobile: r8a7790: lager: i2c support
Message-Id: <1378813194-19493-2-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Enables the four i2c busses on the Lager board.

Signed-off-by: Nguyen Viet Dung <nv-dung@jinso.co.jp>
Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
---
 arch/arm/mach-shmobile/board-lager.c | 60 ++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index bb39d5f..097af8e 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -20,6 +20,8 @@
 
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
+#include <linux/i2c.h>
+#include <linux/i2c/i2c-rcar.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -171,6 +173,11 @@ static const struct pinctrl_map lager_pinctrl_map[] = {
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
@@ -193,6 +200,48 @@ static const struct pinctrl_map lager_pinctrl_map[] = {
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
+};
+
+static struct resource rcar_i2c_res[] __initdata = {
+	/* I2C0 */
+	DEFINE_RES_MEM(0xe6508000, 0x10000),
+	DEFINE_RES_IRQ(gic_spi(287)),
+	/* I2C1 */
+	DEFINE_RES_MEM(0xe6518000, 0x10000),
+	DEFINE_RES_IRQ(gic_spi(288)),
+	/* I2C2 */
+	DEFINE_RES_MEM(0xe6530000, 0x10000),
+	DEFINE_RES_IRQ(gic_spi(286)),
+	/* I2C3 */
+	DEFINE_RES_MEM(0xe6540000, 0x10000),
+	DEFINE_RES_IRQ(gic_spi(290)),
+};
+
+static void __init lager_add_i2c_device(int idx,
+				   struct i2c_rcar_platform_data *pdata)
+{
+	BUG_ON(idx < 0 || idx > 3);
+
+	platform_device_register_resndata(
+			&platform_bus, "i2c-rcar_h2", idx,
+			rcar_i2c_res + (2*idx), 2,
+			pdata, sizeof(*pdata));
+}
+
 static void __init lager_add_standard_devices(void)
 {
 	r8a7790_clock_init();
@@ -220,6 +269,17 @@ static void __init lager_add_standard_devices(void)
 					  &ether_pdata, sizeof(ether_pdata));
 
 	lager_add_du_device();
+
+	lager_add_i2c_device(0, &i2c_pdata);
+	lager_add_i2c_device(1, &i2c_pdata);
+	lager_add_i2c_device(2, &i2c_pdata);
+	lager_add_i2c_device(3, &i2c_pdata);
+
+	/*
+	 * I2C channels 0 and 3 are wired to external connectors; channel 1
+	 * has only one device (da9063) for which no driver exists.
+	 */
+	i2c_register_board_info(2, i2c2_devices, ARRAY_SIZE(i2c2_devices));
 }
 
 static const char * const lager_boards_compat_dt[] __initconst = {
-- 
1.8.1.4

