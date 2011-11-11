From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 11 Nov 2011 02:47:16 +0000
Subject: [PATCH 18/20] ARM: mach-shmobile: bonito: Add LCDC0 support
Message-Id: <87bosj9xzi.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bonito.c  |  117 ++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7740.c |    6 ++-
 2 files changed, 122 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bonito.c b/arch/arm/mach-shmobile/board-bonito.c
index d78008b..5b01476 100644
--- a/arch/arm/mach-shmobile/board-bonito.c
+++ b/arch/arm/mach-shmobile/board-bonito.c
@@ -33,6 +33,7 @@
 #include <asm/mach/time.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <mach/r8a7740.h>
+#include <video/sh_mobile_lcdc.h>
 
 /*
  * CS	Address		device			note
@@ -65,6 +66,13 @@
  */
 
 /*
+ * LCDC0 (CN3/CN4/CN7)
+ *
+ * S38.1 = OFF
+ * S38.2 = OFF
+ */
+
+/*
  * FPGA
  */
 #define BUSSWMR1	0x0070
@@ -72,6 +80,7 @@
 #define BUSSWMR3	0x0074
 #define BUSSWMR4	0x0076
 
+#define LCDCR		0x10B4
 #define A1MDSR		0x10E0
 #define BVERR		0x1100
 static u16 bonito_fpga_read(u32 offset)
@@ -135,6 +144,63 @@ static int __init pmic_init(void)
 device_initcall(pmic_init);
 
 /*
+ * LCDC0
+ */
+static const struct fb_videomode lcdc0_mode = {
+	.name		= "WVGA Panel",
+	.xres		= 800,
+	.yres		= 480,
+	.left_margin	= 88,
+	.right_margin	= 40,
+	.hsync_len	= 128,
+	.upper_margin	= 20,
+	.lower_margin	= 5,
+	.vsync_len	= 5,
+	.sync		= 0,
+};
+
+static struct sh_mobile_lcdc_info lcdc0_info = {
+	.clock_source	= LCDC_CLK_BUS,
+	.ch[0] = {
+		.chan			= LCDC_CHAN_MAINLCD,
+		.bpp			= 16,
+		.interface_type		= RGB24,
+		.clock_divider		= 5,
+		.flags			= 0,
+		.lcd_cfg		= &lcdc0_mode,
+		.num_cfg		= 1,
+		.lcd_size_cfg = {
+			.width	= 152,
+			.height = 91,
+		},
+	},
+};
+
+static struct resource lcdc0_resources[] = {
+	[0] = {
+		.name	= "LCDC0",
+		.start	= 0xfe940000,
+		.end	= 0xfe943fff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= intcs_evt2irq(0x0580),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device lcdc0_device = {
+	.name		= "sh_mobile_lcdc_fb",
+	.id		= 0,
+	.resource	= lcdc0_resources,
+	.num_resources	= ARRAY_SIZE(lcdc0_resources),
+	.dev	= {
+		.platform_data	= &lcdc0_info,
+		.coherent_dma_mask = ~0,
+	},
+};
+
+/*
  * core board devices
  */
 static struct platform_device *bonito_core_devices[] __initdata = {
@@ -144,6 +210,7 @@ static struct platform_device *bonito_core_devices[] __initdata = {
  * base board devices
  */
 static struct platform_device *bonito_base_devices[] __initdata = {
+	&lcdc0_device,
 };
 
 /*
@@ -199,6 +266,9 @@ static void __init bonito_map_io(void)
 #define BIT_ON(sw, bit)		(sw & (1 << bit))
 #define BIT_OFF(sw, bit)	(!(sw & (1 << bit)))
 
+#define VCCQ1CR		0xE6058140
+#define VCCQ1LCDCR	0xE6058186
+
 static void __init bonito_init(void)
 {
 	u16 val;
@@ -258,6 +328,53 @@ static void __init bonito_init(void)
 			gpio_request(GPIO_FN_SCIFA5_RXD_PORT92,	NULL);
 		}
 
+		/*
+		 * LCDC0 (CN3)
+		 */
+		if (BIT_ON(bsw2, 3) &&	/* S38.1 = OFF */
+		    BIT_ON(bsw2, 2)) {	/* S38.2 = OFF */
+			gpio_request(GPIO_FN_LCDC0_SELECT,	NULL);
+			gpio_request(GPIO_FN_LCD0_D0,		NULL);
+			gpio_request(GPIO_FN_LCD0_D1,		NULL);
+			gpio_request(GPIO_FN_LCD0_D2,		NULL);
+			gpio_request(GPIO_FN_LCD0_D3,		NULL);
+			gpio_request(GPIO_FN_LCD0_D4,		NULL);
+			gpio_request(GPIO_FN_LCD0_D5,		NULL);
+			gpio_request(GPIO_FN_LCD0_D6,		NULL);
+			gpio_request(GPIO_FN_LCD0_D7,		NULL);
+			gpio_request(GPIO_FN_LCD0_D8,		NULL);
+			gpio_request(GPIO_FN_LCD0_D9,		NULL);
+			gpio_request(GPIO_FN_LCD0_D10,		NULL);
+			gpio_request(GPIO_FN_LCD0_D11,		NULL);
+			gpio_request(GPIO_FN_LCD0_D12,		NULL);
+			gpio_request(GPIO_FN_LCD0_D13,		NULL);
+			gpio_request(GPIO_FN_LCD0_D14,		NULL);
+			gpio_request(GPIO_FN_LCD0_D15,		NULL);
+			gpio_request(GPIO_FN_LCD0_D16,		NULL);
+			gpio_request(GPIO_FN_LCD0_D17,		NULL);
+			gpio_request(GPIO_FN_LCD0_D18_PORT163,	NULL);
+			gpio_request(GPIO_FN_LCD0_D19_PORT162,	NULL);
+			gpio_request(GPIO_FN_LCD0_D20_PORT161,	NULL);
+			gpio_request(GPIO_FN_LCD0_D21_PORT158,	NULL);
+			gpio_request(GPIO_FN_LCD0_D22_PORT160,	NULL);
+			gpio_request(GPIO_FN_LCD0_D23_PORT159,	NULL);
+			gpio_request(GPIO_FN_LCD0_DCK,		NULL);
+			gpio_request(GPIO_FN_LCD0_VSYN,		NULL);
+			gpio_request(GPIO_FN_LCD0_HSYN,		NULL);
+			gpio_request(GPIO_FN_LCD0_DISP,		NULL);
+			gpio_request(GPIO_FN_LCD0_LCLK_PORT165,	NULL);
+
+			gpio_request(GPIO_PORT61, NULL); /* LCDDON */
+			gpio_direction_output(GPIO_PORT61, 1);
+
+			/* backlight on */
+			bonito_fpga_write(LCDCR, 1);
+
+			/*  drivability Max */
+			__raw_writew(0x00FF , VCCQ1LCDCR);
+			__raw_writew(0xFFFF , VCCQ1CR);
+		}
+
 		platform_add_devices(bonito_base_devices,
 				     ARRAY_SIZE(bonito_base_devices));
 	}
diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 5bb02f2..3b35b9a 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -251,7 +251,7 @@ static struct clk div6_clks[DIV6_NR] = {
 
 enum {
 	MSTP125,
-	MSTP116, MSTP111,
+	MSTP116, MSTP111, MSTP100, MSTP117,
 
 	MSTP230,
 	MSTP222,
@@ -264,8 +264,10 @@ enum {
 
 static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP125] = SH_CLK_MSTP32(&div6_clks[DIV6_SUB],	SMSTPCR1, 25, 0), /* TMU0 */
+	[MSTP117] = SH_CLK_MSTP32(&div4_clks[DIV4_B],	SMSTPCR1, 17, 0), /* LCDC1 */
 	[MSTP116] = SH_CLK_MSTP32(&div6_clks[DIV6_SUB],	SMSTPCR1, 16, 0), /* IIC0 */
 	[MSTP111] = SH_CLK_MSTP32(&div6_clks[DIV6_SUB],	SMSTPCR1, 11, 0), /* TMU1 */
+	[MSTP100] = SH_CLK_MSTP32(&div4_clks[DIV4_B],	SMSTPCR1,  0, 0), /* LCDC0 */
 
 	[MSTP230] = SH_CLK_MSTP32(&div6_clks[DIV6_SUB],	SMSTPCR2, 30, 0), /* SCIFA6 */
 	[MSTP222] = SH_CLK_MSTP32(&div6_clks[DIV6_SUB],	SMSTPCR2, 22, 0), /* SCIFA7 */
@@ -314,8 +316,10 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("sub_clk",		&div6_clks[DIV6_SUB]),
 
 	/* MSTP32 clocks */
+	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.0",	&mstp_clks[MSTP100]),
 	CLKDEV_DEV_ID("sh_tmu.1",		&mstp_clks[MSTP111]),
 	CLKDEV_DEV_ID("i2c-sh_mobile.0",	&mstp_clks[MSTP116]),
+	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.1",	&mstp_clks[MSTP117]),
 	CLKDEV_DEV_ID("sh_tmu.0",		&mstp_clks[MSTP125]),
 
 	CLKDEV_DEV_ID("sh-sci.4",		&mstp_clks[MSTP200]),
-- 
1.7.5.4

