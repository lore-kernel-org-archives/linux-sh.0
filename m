From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 12 Feb 2013 17:15:31 +0000
Subject: [PATCH 1/3] ARM: shmobile: add AS3711 PMIC platform data on kzm9g
Message-Id: <1360689333-13525-2-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

KZM9G uses an AS3711 PMIC to supply power to the CPU and the LCD backlight.
The PMIC on the board is pre-programmed to supply correct voltages to the
CPU, power supply to the backlight has to be turned on at run-time. The
latter is currently performed by a hard-coded I2C command sequence in the
board file. This patch removes the backlight hack and instead adds an I2C
device to instantiate the AS3711 MFD driver, which will add a regulator
device to dynamically adjust CPU voltages and a backlight device.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-kzm9g.c |  193 ++++++++++++++++++++++++---------
 1 files changed, 140 insertions(+), 53 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 1b6ed86..be622a5 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -29,6 +29,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
+#include <linux/mfd/as3711.h>
 #include <linux/mfd/tmio.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -551,6 +552,140 @@ static struct platform_device fsi_ak4648_device = {
 };
 
 /* I2C */
+
+/* StepDown1 is used to supply 1.315V to the CPU */
+static struct regulator_init_data as3711_sd1 = {
+	.constraints = {
+		.name = "1.315V CPU",
+		.boot_on = 1,
+		.always_on = 1,
+		.min_uV = 1315000,
+		.max_uV = 1335000,
+	},
+};
+
+/* StepDown2 is used to supply 1.8V to the CPU and to the board */
+static struct regulator_init_data as3711_sd2 = {
+	.constraints = {
+		.name = "1.8V",
+		.boot_on = 1,
+		.always_on = 1,
+		.min_uV = 1800000,
+		.max_uV = 1800000,
+	},
+};
+
+/*
+ * StepDown3 is switched in parallel with StepDown2, seems to be off,
+ * according to read-back pre-set register values
+ */
+
+/* StepDown4 is used to supply 1.215V to the CPU and to the board */
+static struct regulator_init_data as3711_sd4 = {
+	.constraints = {
+		.name = "1.215V",
+		.boot_on = 1,
+		.always_on = 1,
+		.min_uV = 1215000,
+		.max_uV = 1235000,
+	},
+};
+
+/* LDO1 is unused and unconnected */
+
+/* LDO2 is used to supply 2.8V to the CPU */
+static struct regulator_init_data as3711_ldo2 = {
+	.constraints = {
+		.name = "2.8V CPU",
+		.boot_on = 1,
+		.always_on = 1,
+		.min_uV = 2800000,
+		.max_uV = 2800000,
+	},
+};
+
+/* LDO3 is used to supply 3.0V to the CPU */
+static struct regulator_init_data as3711_ldo3 = {
+	.constraints = {
+		.name = "3.0V CPU",
+		.boot_on = 1,
+		.always_on = 1,
+		.min_uV = 3000000,
+		.max_uV = 3000000,
+	},
+};
+
+/* LDO4 is used to supply 2.8V to the board */
+static struct regulator_init_data as3711_ldo4 = {
+	.constraints = {
+		.name = "2.8V",
+		.boot_on = 1,
+		.always_on = 1,
+		.min_uV = 2800000,
+		.max_uV = 2800000,
+	},
+};
+
+/* LDO5 is switched parallel to LDO4, also set to 2.8V */
+static struct regulator_init_data as3711_ldo5 = {
+	.constraints = {
+		.name = "2.8V #2",
+		.boot_on = 1,
+		.always_on = 1,
+		.min_uV = 2800000,
+		.max_uV = 2800000,
+	},
+};
+
+/* LDO6 is unused and unconnected */
+
+/* LDO7 is used to supply 1.15V to the CPU */
+static struct regulator_init_data as3711_ldo7 = {
+	.constraints = {
+		.name = "1.15V CPU",
+		.boot_on = 1,
+		.always_on = 1,
+		.min_uV = 1150000,
+		.max_uV = 1150000,
+	},
+};
+
+/* LDO8 is switched parallel to LDO7, also set to 1.15V */
+static struct regulator_init_data as3711_ldo8 = {
+	.constraints = {
+		.name = "1.15V CPU #2",
+		.boot_on = 1,
+		.always_on = 1,
+		.min_uV = 1150000,
+		.max_uV = 1150000,
+	},
+};
+
+static struct as3711_platform_data as3711_pdata = {
+	.regulator	= {
+		.init_data	= {
+			[AS3711_REGULATOR_SD_1] = &as3711_sd1,
+			[AS3711_REGULATOR_SD_2] = &as3711_sd2,
+			[AS3711_REGULATOR_SD_4] = &as3711_sd4,
+			[AS3711_REGULATOR_LDO_2] = &as3711_ldo2,
+			[AS3711_REGULATOR_LDO_3] = &as3711_ldo3,
+			[AS3711_REGULATOR_LDO_4] = &as3711_ldo4,
+			[AS3711_REGULATOR_LDO_5] = &as3711_ldo5,
+			[AS3711_REGULATOR_LDO_7] = &as3711_ldo7,
+			[AS3711_REGULATOR_LDO_8] = &as3711_ldo8,
+		},
+	},
+	.backlight	= {
+		.su2_fb = "sh_mobile_lcdc_fb.0",
+		.su2_max_uA = 36000,
+		.su2_feedback = AS3711_SU2_CURR_AUTO,
+		.su2_fbprot = AS3711_SU2_GPIO4,
+		.su2_auto_curr1 = true,
+		.su2_auto_curr2 = true,
+		.su2_auto_curr3 = true,
+	},
+};
+
 static struct pcf857x_platform_data pcf8575_pdata = {
 	.gpio_base	= GPIO_PCF8575_BASE,
 };
@@ -570,6 +705,11 @@ static struct i2c_board_info i2c0_devices[] = {
 		I2C_BOARD_INFO("adxl34x", 0x1d),
 		.irq = intcs_evt2irq(0x3340), /* IRQ26 */
 	},
+	{
+		I2C_BOARD_INFO("as3711", 0x40),
+		.irq = intcs_evt2irq(0x3300), /* IRQ24 */
+		.platform_data = &as3711_pdata,
+	},
 };
 
 static struct i2c_board_info i2c1_devices[] = {
@@ -600,59 +740,6 @@ static struct platform_device *kzm_devices[] __initdata = {
 	&fsi_ak4648_device,
 };
 
-/*
- * FIXME
- *
- * This is quick hack for enabling LCDC backlight
- */
-static int __init as3711_enable_lcdc_backlight(void)
-{
-	struct i2c_adapter *a = i2c_get_adapter(0);
-	struct i2c_msg msg;
-	int i, ret;
-	__u8 magic[] = {
-		0x40, 0x2a,
-		0x43, 0x3c,
-		0x44, 0x3c,
-		0x45, 0x3c,
-		0x54, 0x03,
-		0x51, 0x00,
-		0x51, 0x01,
-		0xff, 0x00, /* wait */
-		0x43, 0xf0,
-		0x44, 0xf0,
-		0x45, 0xf0,
-	};
-
-	if (!of_machine_is_compatible("renesas,kzm9g"))
-		return 0;
-
-	if (!a)
-		return 0;
-
-	msg.addr	= 0x40;
-	msg.len		= 2;
-	msg.flags	= 0;
-
-	for (i = 0; i < ARRAY_SIZE(magic); i += 2) {
-		msg.buf = magic + i;
-
-		if (0xff = msg.buf[0]) {
-			udelay(500);
-			continue;
-		}
-
-		ret = i2c_transfer(a, &msg, 1);
-		if (ret < 0) {
-			pr_err("i2c transfer fail\n");
-			break;
-		}
-	}
-
-	return 0;
-}
-device_initcall(as3711_enable_lcdc_backlight);
-
 static void __init kzm_init(void)
 {
 	regulator_register_always_on(0, "fixed-1.8V", fixed1v8_power_consumers,
-- 
1.7.2.5

