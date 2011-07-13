From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 13 Jul 2011 10:55:48 +0000
Subject: [PATCH] ARM: mach-shmobile: AG5EVM LED TPU platform data prototype
Message-Id: <20110713110406.14241.48635.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch adds prototype platform data for the DS2 LED on AG5EVM.

DS2 is hooked up to PORT247 which apart from a regular GPIO
pin also has the pin function TPU3TO1 which means the pin will
generate output from channel 1 of TPU3. Because of this channel 1
of TPU3 is added as platform data to the TPU LED driver and clock
bindings for the MSTP bit of TPU3 is also added.

The PORT247 pin happen to be used to control power to one of the
camera sensors on AG5EVM, so this patch is not upstream material
and should only be seen as an example of TPU LED driver usage.

Not-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-ag5evm.c |   31 +++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-sh73a0.c |    4 +++-
 2 files changed, 34 insertions(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/board-ag5evm.c
+++ work/arch/arm/mach-shmobile/board-ag5evm.c	2011-07-13 19:56:14.000000000 +0900
@@ -37,6 +37,7 @@
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
 #include <linux/sh_clk.h>
+#include <linux/leds-renesas-tpu.h>
 #include <video/sh_mobile_lcdc.h>
 #include <video/sh_mipi_dsi.h>
 #include <sound/sh_fsi.h>
@@ -419,6 +420,35 @@ static struct platform_device sdhi1_devi
 	.resource	= sdhi1_resources,
 };
 
+/* LED test code */
+static struct led_renesas_tpu_config led_renesas_tpu3_1_pdata = {
+	.name		= "tpu3_1",
+	.pin_gpio_fn	= GPIO_FN_TPU3TO1,
+	.pin_gpio	= GPIO_PORT247,
+	.channel_offset	= 0x50,
+	.timer_bit	= 1,
+	.max_brightness	= 100,
+};
+
+static struct resource tpu3_1_resources[] = {
+	[0] = {
+		.name   = "TPU3-1",
+		.start  = 0xe6630050,
+		.end    = 0xe6630077,
+		.flags  = IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device leds_tpu3_1_device = {
+	.name = "leds-renesas-tpu",
+	.id = 0,
+	.dev = {
+		.platform_data  = &led_renesas_tpu3_1_pdata,
+	},
+	.num_resources	= ARRAY_SIZE(tpu3_1_resources),
+	.resource	= tpu3_1_resources,
+};
+
 static struct platform_device *ag5evm_devices[] __initdata = {
 	&eth_device,
 	&keysc_device,
@@ -429,6 +459,7 @@ static struct platform_device *ag5evm_de
 	&mipidsi0_device,
 	&sdhi0_device,
 	&sdhi1_device,
+	&leds_tpu3_1_device,
 };
 
 static struct map_desc ag5evm_io_desc[] __initdata = {
--- 0001/arch/arm/mach-shmobile/clock-sh73a0.c
+++ work/arch/arm/mach-shmobile/clock-sh73a0.c	2011-07-13 19:53:11.000000000 +0900
@@ -267,7 +267,7 @@ enum { MSTP001,
 	MSTP219,
 	MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
 	MSTP331, MSTP329, MSTP325, MSTP323, MSTP318,
-	MSTP314, MSTP313, MSTP312, MSTP311,
+	MSTP314, MSTP313, MSTP312, MSTP311, MSTP301,
 	MSTP411, MSTP410, MSTP403,
 	MSTP_NR };
 
@@ -301,6 +301,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP313] = MSTP(&div6_clks[DIV6_SDHI1], SMSTPCR3, 13, 0), /* SDHI1 */
 	[MSTP312] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 12, 0), /* MMCIF0 */
 	[MSTP311] = MSTP(&div6_clks[DIV6_SDHI2], SMSTPCR3, 11, 0), /* SDHI2 */
+	[MSTP301] = MSTP(&extal1_div2_clk, SMSTPCR3, 1, 0), /* TPU3 */
 	[MSTP411] = MSTP(&div4_clks[DIV4_HP], SMSTPCR4, 11, 0), /* IIC3 */
 	[MSTP410] = MSTP(&div4_clks[DIV4_HP], SMSTPCR4, 10, 0), /* IIC4 */
 	[MSTP403] = MSTP(&r_clk, SMSTPCR4, 3, 0), /* KEYSC */
@@ -354,6 +355,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP313]), /* SDHI1 */
 	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP312]), /* MMCIF0 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP311]), /* SDHI2 */
+	CLKDEV_DEV_ID("leds-renesas-tpu.0", &mstp_clks[MSTP301]), /* TPU3 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.3", &mstp_clks[MSTP411]), /* I2C3 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.4", &mstp_clks[MSTP410]), /* I2C4 */
 	CLKDEV_DEV_ID("sh_keysc.0", &mstp_clks[MSTP403]), /* KEYSC */
