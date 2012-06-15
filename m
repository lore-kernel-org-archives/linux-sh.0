From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 15 Jun 2012 15:17:06 +0000
Subject: [PATCH 5/6] ARM: mach-shmobile: Kota2: Use leds-pwm + rmob-tpu-pwm
Message-Id: <1339773427-29508-6-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Instead of using the LED-specific TPU PWM driver, switch to the generic
TPU PWM driver with leds-pwm.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-kota2.c  |  173 +++++++++++++++++++--------------
 arch/arm/mach-shmobile/clock-sh73a0.c |    8 +-
 2 files changed, 104 insertions(+), 77 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kota2.c b/arch/arm/mach-shmobile/board-kota2.c
index 200dcd4..aa179cc0 100644
--- a/arch/arm/mach-shmobile/board-kota2.c
+++ b/arch/arm/mach-shmobile/board-kota2.c
@@ -33,7 +33,8 @@
 #include <linux/input/sh_keysc.h>
 #include <linux/gpio_keys.h>
 #include <linux/leds.h>
-#include <linux/platform_data/leds-renesas-tpu.h>
+#include <linux/leds_pwm.h>
+#include <linux/platform_data/rmob-tpu-pwm.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mfd/tmio.h>
@@ -176,116 +177,141 @@ static struct platform_device gpio_leds_device = {
 };
 
 /* TPU LED */
-static struct led_renesas_tpu_config led_renesas_tpu12_pdata = {
-	.name		= "V2513",
-	.pin_gpio_fn	= GPIO_FN_TPU1TO2,
-	.pin_gpio	= GPIO_PORT153,
-	.channel_offset = 0x90,
-	.timer_bit = 2,
-	.max_brightness = 1000,
+static struct rmob_tpu_pwm_platform_data tpu1_pwm_pdata = {
+	.channels[2] = {
+		.polarity	= 1,
+		.pin_gpio	= GPIO_PORT153,
+		.pin_gpio_fn	= GPIO_FN_TPU1TO2,
+	},
 };
 
-static struct resource tpu12_resources[] = {
+static struct resource tpu1_pwm_resources[] = {
 	[0] = {
-		.name	= "TPU12",
-		.start	= 0xe6610090,
-		.end	= 0xe66100b5,
+		.start	= 0xe6610000,
+		.end	= 0xe66100ff,
 		.flags	= IORESOURCE_MEM,
 	},
 };
 
-static struct platform_device leds_tpu12_device = {
-	.name = "leds-renesas-tpu",
-	.id = 12,
+static struct platform_device tpu1_pwm_device = {
+	.name = "rmob_tpu_pwm",
+	.id = 1,
 	.dev = {
-		.platform_data  = &led_renesas_tpu12_pdata,
+		.platform_data  = &tpu1_pwm_pdata,
 	},
-	.num_resources	= ARRAY_SIZE(tpu12_resources),
-	.resource	= tpu12_resources,
+	.num_resources	= ARRAY_SIZE(tpu1_pwm_resources),
+	.resource	= tpu1_pwm_resources,
 };
 
-static struct led_renesas_tpu_config led_renesas_tpu41_pdata = {
-	.name		= "V2514",
-	.pin_gpio_fn	= GPIO_FN_TPU4TO1,
-	.pin_gpio	= GPIO_PORT199,
-	.channel_offset = 0x50,
-	.timer_bit = 1,
-	.max_brightness = 1000,
+static struct rmob_tpu_pwm_platform_data tpu2_pwm_pdata = {
+	.channels[1] = {
+		.polarity	= 1,
+		.pin_gpio	= GPIO_PORT197,
+		.pin_gpio_fn	= GPIO_FN_TPU2TO1,
+	},
 };
 
-static struct resource tpu41_resources[] = {
+static struct resource tpu2_pwm_resources[] = {
 	[0] = {
-		.name	= "TPU41",
-		.start	= 0xe6640050,
-		.end	= 0xe6640075,
+		.start	= 0xe6620000,
+		.end	= 0xe66200ff,
 		.flags	= IORESOURCE_MEM,
 	},
 };
 
-static struct platform_device leds_tpu41_device = {
-	.name = "leds-renesas-tpu",
-	.id = 41,
+static struct platform_device tpu2_pwm_device = {
+	.name = "rmob_tpu_pwm",
+	.id = 2,
 	.dev = {
-		.platform_data  = &led_renesas_tpu41_pdata,
+		.platform_data  = &tpu2_pwm_pdata,
 	},
-	.num_resources	= ARRAY_SIZE(tpu41_resources),
-	.resource	= tpu41_resources,
+	.num_resources	= ARRAY_SIZE(tpu2_pwm_resources),
+	.resource	= tpu2_pwm_resources,
 };
 
-static struct led_renesas_tpu_config led_renesas_tpu21_pdata = {
-	.name		= "V2515",
-	.pin_gpio_fn	= GPIO_FN_TPU2TO1,
-	.pin_gpio	= GPIO_PORT197,
-	.channel_offset = 0x50,
-	.timer_bit = 1,
-	.max_brightness = 1000,
+static struct rmob_tpu_pwm_platform_data tpu3_pwm_pdata = {
+	.channels[0] = {
+		.polarity	= 1,
+		.pin_gpio	= GPIO_PORT163,
+		.pin_gpio_fn	= GPIO_FN_TPU3TO0,
+	},
 };
 
-static struct resource tpu21_resources[] = {
+static struct resource tpu3_pwm_resources[] = {
 	[0] = {
-		.name	= "TPU21",
-		.start	= 0xe6620050,
-		.end	= 0xe6620075,
+		.start	= 0xe6630000,
+		.end	= 0xe66300ff,
 		.flags	= IORESOURCE_MEM,
 	},
 };
 
-static struct platform_device leds_tpu21_device = {
-	.name = "leds-renesas-tpu",
-	.id = 21,
+static struct platform_device tpu3_pwm_device = {
+	.name = "rmob_tpu_pwm",
+	.id = 3,
 	.dev = {
-		.platform_data  = &led_renesas_tpu21_pdata,
+		.platform_data  = &tpu3_pwm_pdata,
 	},
-	.num_resources	= ARRAY_SIZE(tpu21_resources),
-	.resource	= tpu21_resources,
+	.num_resources	= ARRAY_SIZE(tpu3_pwm_resources),
+	.resource	= tpu3_pwm_resources,
 };
 
-static struct led_renesas_tpu_config led_renesas_tpu30_pdata = {
-	.name		= "KEYLED",
-	.pin_gpio_fn	= GPIO_FN_TPU3TO0,
-	.pin_gpio	= GPIO_PORT163,
-	.channel_offset = 0x10,
-	.timer_bit = 0,
-	.max_brightness = 1000,
+static struct rmob_tpu_pwm_platform_data tpu4_pwm_pdata = {
+	.channels[1] = {
+		.polarity	= 1,
+		.pin_gpio	= GPIO_PORT199,
+		.pin_gpio_fn	= GPIO_FN_TPU4TO1,
+	},
 };
 
-static struct resource tpu30_resources[] = {
+static struct resource tpu4_pwm_resources[] = {
 	[0] = {
-		.name	= "TPU30",
-		.start	= 0xe6630010,
-		.end	= 0xe6630035,
+		.start	= 0xe6640000,
+		.end	= 0xe66400ff,
 		.flags	= IORESOURCE_MEM,
 	},
 };
 
-static struct platform_device leds_tpu30_device = {
-	.name = "leds-renesas-tpu",
-	.id = 30,
+static struct platform_device tpu4_pwm_device = {
+	.name = "rmob_tpu_pwm",
+	.id = 4,
+	.dev = {
+		.platform_data  = &tpu4_pwm_pdata,
+	},
+	.num_resources	= ARRAY_SIZE(tpu4_pwm_resources),
+	.resource	= tpu4_pwm_resources,
+};
+
+static struct led_pwm tpu_pwm_leds[] = {
+	{
+		.name		= "V2513",
+		.pwm_id		= 6,
+		.max_brightness	= 1000,
+	}, {
+		.name		= "V2515",
+		.pwm_id		= 9,
+		.max_brightness	= 1000,
+	}, {
+		.name		= "KEYLED",
+		.pwm_id		= 12,
+		.max_brightness	= 1000,
+	}, {
+		.name		= "V2514",
+		.pwm_id		= 17,
+		.max_brightness	= 1000,
+	},
+};
+
+static struct led_pwm_platform_data leds_pwm_pdata = {
+	.num_leds = ARRAY_SIZE(tpu_pwm_leds),
+	.leds = tpu_pwm_leds,
+};
+
+static struct platform_device leds_pwm_device = {
+	.name = "leds-pwm",
+	.id = 0,
 	.dev = {
-		.platform_data  = &led_renesas_tpu30_pdata,
+		.platform_data = &leds_pwm_pdata,
 	},
-	.num_resources	= ARRAY_SIZE(tpu30_resources),
-	.resource	= tpu30_resources,
 };
 
 /* MMCIF */
@@ -400,10 +426,11 @@ static struct platform_device *kota2_devices[] __initdata = {
 	&keysc_device,
 	&gpio_keys_device,
 	&gpio_leds_device,
-	&leds_tpu12_device,
-	&leds_tpu41_device,
-	&leds_tpu21_device,
-	&leds_tpu30_device,
+	&tpu1_pwm_device,
+	&tpu2_pwm_device,
+	&tpu3_pwm_device,
+	&tpu4_pwm_device,
+	&leds_pwm_device,
 	&mmcif_device,
 	&sdhi0_device,
 	&sdhi1_device,
diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index 472d1f5..4f6d55b 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -568,10 +568,10 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP313]), /* SDHI1 */
 	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP312]), /* MMCIF0 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP311]), /* SDHI2 */
-	CLKDEV_DEV_ID("leds-renesas-tpu.12", &mstp_clks[MSTP303]), /* TPU1 */
-	CLKDEV_DEV_ID("leds-renesas-tpu.21", &mstp_clks[MSTP302]), /* TPU2 */
-	CLKDEV_DEV_ID("leds-renesas-tpu.30", &mstp_clks[MSTP301]), /* TPU3 */
-	CLKDEV_DEV_ID("leds-renesas-tpu.41", &mstp_clks[MSTP300]), /* TPU4 */
+	CLKDEV_DEV_ID("rmob_tpu_pwm.1", &mstp_clks[MSTP303]), /* TPU1 */
+	CLKDEV_DEV_ID("rmob_tpu_pwm.2", &mstp_clks[MSTP302]), /* TPU2 */
+	CLKDEV_DEV_ID("rmob_tpu_pwm.3", &mstp_clks[MSTP301]), /* TPU3 */
+	CLKDEV_DEV_ID("rmob_tpu_pwm.4", &mstp_clks[MSTP300]), /* TPU4 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.3", &mstp_clks[MSTP411]), /* I2C3 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.4", &mstp_clks[MSTP410]), /* I2C4 */
 	CLKDEV_DEV_ID("sh_keysc.0", &mstp_clks[MSTP403]), /* KEYSC */
-- 
1.7.3.4

