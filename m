From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 23 May 2011 05:10:36 +0000
Subject: [PATCH] ARM: mach-shmobile: Add SDHI support for AG5EVM and sh73a0
Message-Id: <20110523051036.26281.36243.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add SDHI0 and SDHI1 support to the AG5EVM board
including platform data, pinmux configuration
and clock bindings.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Has run-time dependencies on SDHI patches in -next
 especially "mmc: sdhi: support up to 3 interrupt sources"

 arch/arm/mach-shmobile/board-ag5evm.c |  103 +++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-sh73a0.c |   16 ++++-
 2 files changed, 118 insertions(+), 1 deletion(-)

--- 0007/arch/arm/mach-shmobile/board-ag5evm.c
+++ work/arch/arm/mach-shmobile/board-ag5evm.c	2011-05-23 13:59:36.000000000 +0900
@@ -34,6 +34,8 @@
 #include <linux/input/sh_keysc.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mmcif.h>
+#include <linux/mmc/sh_mobile_sdhi.h>
+#include <linux/mfd/tmio.h>
 #include <linux/sh_clk.h>
 #include <video/sh_mobile_lcdc.h>
 #include <video/sh_mipi_dsi.h>
@@ -327,6 +329,85 @@ static struct platform_device mipidsi0_d
 	},
 };
 
+static struct sh_mobile_sdhi_info sdhi0_info = {
+	.tmio_caps	= MMC_CAP_SD_HIGHSPEED,
+	.tmio_ocr_mask	= MMC_VDD_27_28 | MMC_VDD_28_29,
+};
+
+static struct resource sdhi0_resources[] = {
+	[0] = {
+		.name	= "SDHI0",
+		.start	= 0xee100000,
+		.end	= 0xee1000ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= gic_spi(83),
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= gic_spi(84),
+		.flags	= IORESOURCE_IRQ,
+	},
+	[3] = {
+		.start	= gic_spi(85),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sdhi0_device = {
+	.name		= "sh_mobile_sdhi",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(sdhi0_resources),
+	.resource	= sdhi0_resources,
+	.dev	= {
+		.platform_data	= &sdhi0_info,
+	},
+};
+
+void ag5evm_sdhi1_set_pwr(struct platform_device *pdev, int state)
+{
+	gpio_set_value(GPIO_PORT114, state);
+}
+
+static struct sh_mobile_sdhi_info sh_sdhi1_platdata = {
+	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE,
+	.tmio_caps	= MMC_CAP_NONREMOVABLE,
+	.tmio_ocr_mask	= MMC_VDD_32_33 | MMC_VDD_33_34,
+	.set_pwr	= ag5evm_sdhi1_set_pwr,
+};
+
+static struct resource sdhi1_resources[] = {
+	[0] = {
+		.name	= "SDHI1",
+		.start	= 0xee120000,
+		.end	= 0xee1200ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= gic_spi(87),
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= gic_spi(88),
+		.flags	= IORESOURCE_IRQ,
+	},
+	[3] = {
+		.start	= gic_spi(89),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sdhi1_device = {
+	.name		= "sh_mobile_sdhi",
+	.id		= 1,
+	.dev		= {
+		.platform_data	= &sh_sdhi1_platdata,
+	},
+	.num_resources	= ARRAY_SIZE(sdhi1_resources),
+	.resource	= sdhi1_resources,
+};
+
 static struct platform_device *ag5evm_devices[] __initdata = {
 	&eth_device,
 	&keysc_device,
@@ -335,6 +416,8 @@ static struct platform_device *ag5evm_de
 	&irda_device,
 	&lcdc0_device,
 	&mipidsi0_device,
+	&sdhi0_device,
+	&sdhi1_device,
 };
 
 static struct map_desc ag5evm_io_desc[] __initdata = {
@@ -456,6 +539,26 @@ static void __init ag5evm_init(void)
 	/* MIPI-DSI clock setup */
 	__raw_writel(0x2a809010, DSI0PHYCR);
 
+	/* enable SDHI0 on CN15 [SD I/F] */
+	gpio_request(GPIO_FN_SDHICD0, NULL);
+	gpio_request(GPIO_FN_SDHIWP0, NULL);
+	gpio_request(GPIO_FN_SDHICMD0, NULL);
+	gpio_request(GPIO_FN_SDHICLK0, NULL);
+	gpio_request(GPIO_FN_SDHID0_3, NULL);
+	gpio_request(GPIO_FN_SDHID0_2, NULL);
+	gpio_request(GPIO_FN_SDHID0_1, NULL);
+	gpio_request(GPIO_FN_SDHID0_0, NULL);
+
+	/* enable SDHI1 on CN4 [WLAN I/F] */
+	gpio_request(GPIO_FN_SDHICLK1, NULL);
+	gpio_request(GPIO_FN_SDHICMD1_PU, NULL);
+	gpio_request(GPIO_FN_SDHID1_3_PU, NULL);
+	gpio_request(GPIO_FN_SDHID1_2_PU, NULL);
+	gpio_request(GPIO_FN_SDHID1_1_PU, NULL);
+	gpio_request(GPIO_FN_SDHID1_0_PU, NULL);
+	gpio_request(GPIO_PORT114, "sdhi1_power");
+	gpio_direction_output(GPIO_PORT114, 0);
+
 #ifdef CONFIG_CACHE_L2X0
 	/* Shared attribute override enable, 64K*8way */
 	l2x0_init(__io(0xf0100000), 0x00460000, 0xc2000fff);
--- 0001/arch/arm/mach-shmobile/clock-sh73a0.c
+++ work/arch/arm/mach-shmobile/clock-sh73a0.c	2011-05-23 13:58:58.000000000 +0900
@@ -266,7 +266,7 @@ enum { MSTP001,
 	MSTP129, MSTP128, MSTP127, MSTP126, MSTP125, MSTP118, MSTP116, MSTP100,
 	MSTP219,
 	MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
-	MSTP331, MSTP329, MSTP325, MSTP323, MSTP312,
+	MSTP331, MSTP329, MSTP325, MSTP323, MSTP314, MSTP313, MSTP312, MSTP311,
 	MSTP411, MSTP410, MSTP403,
 	MSTP_NR };
 
@@ -295,7 +295,10 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP329] = MSTP(&r_clk, SMSTPCR3, 29, 0), /* CMT10 */
 	[MSTP325] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR3, 25, 0), /* IrDA */
 	[MSTP323] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 23, 0), /* IIC1 */
+	[MSTP314] = MSTP(&div6_clks[DIV6_SDHI0], SMSTPCR3, 14, 0), /* SDHI0 */
+	[MSTP313] = MSTP(&div6_clks[DIV6_SDHI1], SMSTPCR3, 13, 0), /* SDHI1 */
 	[MSTP312] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 12, 0), /* MMCIF0 */
+	[MSTP311] = MSTP(&div6_clks[DIV6_SDHI2], SMSTPCR3, 11, 0), /* SDHI2 */
 	[MSTP411] = MSTP(&div4_clks[DIV4_HP], SMSTPCR4, 11, 0), /* IIC3 */
 	[MSTP410] = MSTP(&div4_clks[DIV4_HP], SMSTPCR4, 10, 0), /* IIC4 */
 	[MSTP403] = MSTP(&r_clk, SMSTPCR4, 3, 0), /* KEYSC */
@@ -313,6 +316,9 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("vck1_clk", &div6_clks[DIV6_VCK1]),
 	CLKDEV_CON_ID("vck2_clk", &div6_clks[DIV6_VCK2]),
 	CLKDEV_CON_ID("vck3_clk", &div6_clks[DIV6_VCK3]),
+	CLKDEV_CON_ID("sdhi0_clk", &div6_clks[DIV6_SDHI0]),
+	CLKDEV_CON_ID("sdhi1_clk", &div6_clks[DIV6_SDHI1]),
+	CLKDEV_CON_ID("sdhi2_clk", &div6_clks[DIV6_SDHI2]),
 	CLKDEV_ICK_ID("dsit_clk", "sh-mipi-dsi.0", &div6_clks[DIV6_DSIT]),
 	CLKDEV_ICK_ID("dsit_clk", "sh-mipi-dsi.1", &div6_clks[DIV6_DSIT]),
 	CLKDEV_ICK_ID("dsi0p_clk", "sh-mipi-dsi.0", &div6_clks[DIV6_DSI0P]),
@@ -341,7 +347,10 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_cmt.10", &mstp_clks[MSTP329]), /* CMT10 */
 	CLKDEV_DEV_ID("sh_irda.0", &mstp_clks[MSTP325]), /* IrDA */
 	CLKDEV_DEV_ID("i2c-sh_mobile.1", &mstp_clks[MSTP323]), /* I2C1 */
+	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP314]), /* SDHI0 */
+	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP313]), /* SDHI1 */
 	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP312]), /* MMCIF0 */
+	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP311]), /* SDHI2 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.3", &mstp_clks[MSTP411]), /* I2C3 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.4", &mstp_clks[MSTP410]), /* I2C4 */
 	CLKDEV_DEV_ID("sh_keysc.0", &mstp_clks[MSTP403]), /* KEYSC */
@@ -351,6 +360,11 @@ void __init sh73a0_clock_init(void)
 {
 	int k, ret = 0;
 
+	/* Set SDHI clocks to a known state */
+	__raw_writel(0x108, SD0CKCR);
+	__raw_writel(0x108, SD1CKCR);
+	__raw_writel(0x108, SD2CKCR);
+
 	/* detect main clock parent */
 	switch ((__raw_readl(CKSCR) >> 24) & 0x03) {
 	case 0:
