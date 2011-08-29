From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 29 Aug 2011 03:50:11 +0000
Subject: [PATCH] ARM: mach-shmobile: Kota2 TPU LED support
Message-Id: <20110829035011.28202.37748.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch updates the Kota2 board support code to
use the recently submitted TPU LED driver whenever
possible.

The sh73a0 SoC has 5 TPU hardware blocks each with
4 timer channels which in theory allows a total of
20 LEDs to be controlled by "leds-renesas-tpu"
driver instances. The Kota2 board has 4 LEDs connected
to GPIO pins that also come with TPU pin functions, so
this patch ties up these 4 LEDS and leaves the remaining
3 LEDS for the GPIO based LED driver.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on the "leds-renesas-tpu" driver and the board
 support code for Kota2.

 V2513, V2514, V2514 have been tested on Kota2 hardware
 with values 1000, 100, 10, 1 and 0. KEYLED support is
 half-tested which means the values above seem to work
 OK but we do not know for sure since the actual LED is
 not mounted on the prototype board.

 arch/arm/mach-shmobile/board-kota2.c  |  122 +++++++++++++++++++++++++++++++--
 arch/arm/mach-shmobile/clock-sh73a0.c |   17 ++++
 2 files changed, 135 insertions(+), 4 deletions(-)

--- 0012/arch/arm/mach-shmobile/board-kota2.c
+++ work/arch/arm/mach-shmobile/board-kota2.c	2011-08-29 12:30:02.000000000 +0900
@@ -33,6 +33,7 @@
 #include <linux/input/sh_keysc.h>
 #include <linux/gpio_keys.h>
 #include <linux/leds.h>
+#include <linux/leds-renesas-tpu.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mfd/tmio.h>
@@ -153,10 +154,6 @@ static struct platform_device gpio_keys_
 #define GPIO_LED(n, g) { .name = n, .gpio = g }
 
 static struct gpio_led gpio_leds[] = {
-	GPIO_LED("V2513", GPIO_PORT153), /* PORT153 [TPU1T02] -> V2513 */
-	GPIO_LED("V2514", GPIO_PORT199), /* PORT199 [TPU4TO1] -> V2514 */
-	GPIO_LED("V2515", GPIO_PORT197), /* PORT197 [TPU2TO1] -> V2515 */
-	GPIO_LED("KEYLED", GPIO_PORT163), /* PORT163 [TPU3TO0] -> KEYLED */
 	GPIO_LED("G", GPIO_PORT20), /* PORT20 [GPO0] -> LED7 -> "G" */
 	GPIO_LED("H", GPIO_PORT21), /* PORT21 [GPO1] -> LED8 -> "H" */
 	GPIO_LED("J", GPIO_PORT22), /* PORT22 [GPO2] -> LED9 -> "J" */
@@ -175,6 +172,119 @@ static struct platform_device gpio_leds_
 	},
 };
 
+/* TPU LED */
+static struct led_renesas_tpu_config led_renesas_tpu12_pdata = {
+	.name		= "V2513",
+	.pin_gpio_fn	= GPIO_FN_TPU1TO2,
+	.pin_gpio	= GPIO_PORT153,
+	.channel_offset = 0x90,
+	.timer_bit = 2,
+	.max_brightness = 1000,
+};
+
+static struct resource tpu12_resources[] = {
+	[0] = {
+		.name	= "TPU12",
+		.start	= 0xe6610090,
+		.end	= 0xe66100b5,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device leds_tpu12_device = {
+	.name = "leds-renesas-tpu",
+	.id = 12,
+	.dev = {
+		.platform_data  = &led_renesas_tpu12_pdata,
+	},
+	.num_resources	= ARRAY_SIZE(tpu12_resources),
+	.resource	= tpu12_resources,
+};
+
+static struct led_renesas_tpu_config led_renesas_tpu41_pdata = {
+	.name		= "V2514",
+	.pin_gpio_fn	= GPIO_FN_TPU4TO1,
+	.pin_gpio	= GPIO_PORT199,
+	.channel_offset = 0x50,
+	.timer_bit = 1,
+	.max_brightness = 1000,
+};
+
+static struct resource tpu41_resources[] = {
+	[0] = {
+		.name	= "TPU41",
+		.start	= 0xe6640050,
+		.end	= 0xe6640075,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device leds_tpu41_device = {
+	.name = "leds-renesas-tpu",
+	.id = 41,
+	.dev = {
+		.platform_data  = &led_renesas_tpu41_pdata,
+	},
+	.num_resources	= ARRAY_SIZE(tpu41_resources),
+	.resource	= tpu41_resources,
+};
+
+static struct led_renesas_tpu_config led_renesas_tpu21_pdata = {
+	.name		= "V2515",
+	.pin_gpio_fn	= GPIO_FN_TPU2TO1,
+	.pin_gpio	= GPIO_PORT197,
+	.channel_offset = 0x50,
+	.timer_bit = 1,
+	.max_brightness = 1000,
+};
+
+static struct resource tpu21_resources[] = {
+	[0] = {
+		.name	= "TPU21",
+		.start	= 0xe6620050,
+		.end	= 0xe6620075,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device leds_tpu21_device = {
+	.name = "leds-renesas-tpu",
+	.id = 21,
+	.dev = {
+		.platform_data  = &led_renesas_tpu21_pdata,
+	},
+	.num_resources	= ARRAY_SIZE(tpu21_resources),
+	.resource	= tpu21_resources,
+};
+
+static struct led_renesas_tpu_config led_renesas_tpu30_pdata = {
+	.name		= "KEYLED",
+	.pin_gpio_fn	= GPIO_FN_TPU3TO0,
+	.pin_gpio	= GPIO_PORT163,
+	.channel_offset = 0x10,
+	.timer_bit = 0,
+	.max_brightness = 1000,
+};
+
+static struct resource tpu30_resources[] = {
+	[0] = {
+		.name	= "TPU30",
+		.start	= 0xe6630010,
+		.end	= 0xe6630035,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device leds_tpu30_device = {
+	.name = "leds-renesas-tpu",
+	.id = 30,
+	.dev = {
+		.platform_data  = &led_renesas_tpu30_pdata,
+	},
+	.num_resources	= ARRAY_SIZE(tpu30_resources),
+	.resource	= tpu30_resources,
+};
+
 static struct resource mmcif_resources[] = {
 	[0] = {
 		.name   = "MMCIF",
@@ -284,6 +394,10 @@ static struct platform_device *kota2_dev
 	&keysc_device,
 	&gpio_keys_device,
 	&gpio_leds_device,
+	&leds_tpu12_device,
+	&leds_tpu41_device,
+	&leds_tpu21_device,
+	&leds_tpu30_device,
 	&mmcif_device,
 	&sdhi0_device,
 	&sdhi1_device,
--- 0004/arch/arm/mach-shmobile/clock-sh73a0.c
+++ work/arch/arm/mach-shmobile/clock-sh73a0.c	2011-08-29 12:30:32.000000000 +0900
@@ -113,6 +113,12 @@ static struct clk main_clk = {
 	.ops		= &main_clk_ops,
 };
 
+/* Divide Main clock by two */
+static struct clk main_div2_clk = {
+	.ops		= &div2_clk_ops,
+	.parent		= &main_clk,
+};
+
 /* PLL0, PLL1, PLL2, PLL3 */
 static unsigned long pll_recalc(struct clk *clk)
 {
@@ -181,6 +187,7 @@ static struct clk *main_clks[] = {
 	&extal1_div2_clk,
 	&extal2_div2_clk,
 	&main_clk,
+	&main_div2_clk,
 	&pll0_clk,
 	&pll1_clk,
 	&pll2_clk,
@@ -268,6 +275,7 @@ enum { MSTP001,
 	MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
 	MSTP331, MSTP329, MSTP325, MSTP323, MSTP318,
 	MSTP314, MSTP313, MSTP312, MSTP311,
+	MSTP304, MSTP303, MSTP302, MSTP301, MSTP300,
 	MSTP411, MSTP410, MSTP403,
 	MSTP_NR };
 
@@ -301,6 +309,11 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP313] = MSTP(&div6_clks[DIV6_SDHI1], SMSTPCR3, 13, 0), /* SDHI1 */
 	[MSTP312] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 12, 0), /* MMCIF0 */
 	[MSTP311] = MSTP(&div6_clks[DIV6_SDHI2], SMSTPCR3, 11, 0), /* SDHI2 */
+	[MSTP304] = MSTP(&main_div2_clk, SMSTPCR3, 4, 0), /* TPU0 */
+	[MSTP303] = MSTP(&main_div2_clk, SMSTPCR3, 3, 0), /* TPU1 */
+	[MSTP302] = MSTP(&main_div2_clk, SMSTPCR3, 2, 0), /* TPU2 */
+	[MSTP301] = MSTP(&main_div2_clk, SMSTPCR3, 1, 0), /* TPU3 */
+	[MSTP300] = MSTP(&main_div2_clk, SMSTPCR3, 0, 0), /* TPU4 */
 	[MSTP411] = MSTP(&div4_clks[DIV4_HP], SMSTPCR4, 11, 0), /* IIC3 */
 	[MSTP410] = MSTP(&div4_clks[DIV4_HP], SMSTPCR4, 10, 0), /* IIC4 */
 	[MSTP403] = MSTP(&r_clk, SMSTPCR4, 3, 0), /* KEYSC */
@@ -350,6 +363,10 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP313]), /* SDHI1 */
 	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP312]), /* MMCIF0 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP311]), /* SDHI2 */
+	CLKDEV_DEV_ID("leds-renesas-tpu.12", &mstp_clks[MSTP303]), /* TPU1 */
+	CLKDEV_DEV_ID("leds-renesas-tpu.21", &mstp_clks[MSTP302]), /* TPU2 */
+	CLKDEV_DEV_ID("leds-renesas-tpu.30", &mstp_clks[MSTP301]), /* TPU3 */
+	CLKDEV_DEV_ID("leds-renesas-tpu.41", &mstp_clks[MSTP300]), /* TPU4 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.3", &mstp_clks[MSTP411]), /* I2C3 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.4", &mstp_clks[MSTP410]), /* I2C4 */
 	CLKDEV_DEV_ID("sh_keysc.0", &mstp_clks[MSTP403]), /* KEYSC */
