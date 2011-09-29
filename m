From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 29 Sep 2011 03:06:54 +0000
Subject: [PATCH] ARM: mach-shmobile: bonito: Add LCDC0 support
Message-Id: <87y5x8oxmc.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/configs/bonito_defconfig      |   59 +++++++++++++++-
 arch/arm/mach-shmobile/board-bonito.c  |  117 ++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7740.c |    6 ++-
 3 files changed, 178 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/bonito_defconfig b/arch/arm/configs/bonito_defconfig
index adb4fc3..1cf260d 100644
--- a/arch/arm/configs/bonito_defconfig
+++ b/arch/arm/configs/bonito_defconfig
@@ -396,7 +396,7 @@ CONFIG_ALIGNMENT_TRAP=y
 # CONFIG_USE_OF is not set
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="console=ttySC5,115200 earlyprintk=sh-sci.5,115200 ignore_loglevel"
+CONFIG_CMDLINE="console=tty0, console=ttySC5,115200 earlyprintk=sh-sci.5,115200 ignore_loglevel"
 CONFIG_CMDLINE_FROM_BOOTLOADER=y
 # CONFIG_CMDLINE_EXTEND is not set
 # CONFIG_CMDLINE_FORCE is not set
@@ -795,8 +795,43 @@ CONFIG_BCMA_POSSIBLE=y
 # CONFIG_DRM is not set
 # CONFIG_VGASTATE is not set
 # CONFIG_VIDEO_OUTPUT_CONTROL is not set
-# CONFIG_FB is not set
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+CONFIG_FB=y
+# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_FB_DDC is not set
+# CONFIG_FB_BOOT_VESA_SUPPORT is not set
+# CONFIG_FB_CFB_FILLRECT is not set
+# CONFIG_FB_CFB_COPYAREA is not set
+# CONFIG_FB_CFB_IMAGEBLIT is not set
+# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
+CONFIG_FB_SYS_FILLRECT=y
+CONFIG_FB_SYS_COPYAREA=y
+CONFIG_FB_SYS_IMAGEBLIT=y
+# CONFIG_FB_FOREIGN_ENDIAN is not set
+CONFIG_FB_SYS_FOPS=y
+# CONFIG_FB_WMT_GE_ROPS is not set
+CONFIG_FB_DEFERRED_IO=y
+# CONFIG_FB_SVGALIB is not set
+# CONFIG_FB_MACMODES is not set
+CONFIG_FB_BACKLIGHT=y
+# CONFIG_FB_MODE_HELPERS is not set
+# CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frame buffer hardware drivers
+#
+# CONFIG_FB_S1D13XXX is not set
+CONFIG_FB_SH_MOBILE_LCDC=y
+# CONFIG_FB_SH_MOBILE_HDMI is not set
+# CONFIG_FB_SH_MOBILE_MERAM is not set
+# CONFIG_FB_VIRTUAL is not set
+# CONFIG_FB_METRONOME is not set
+# CONFIG_FB_BROADSHEET is not set
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+# CONFIG_LCD_CLASS_DEVICE is not set
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
+CONFIG_BACKLIGHT_GENERIC=y
+# CONFIG_BACKLIGHT_ADP8860 is not set
+# CONFIG_BACKLIGHT_ADP8870 is not set
 
 #
 # Display device support
@@ -807,6 +842,24 @@ CONFIG_BCMA_POSSIBLE=y
 # Console display driver support
 #
 CONFIG_DUMMY_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
+# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
+CONFIG_FONTS=y
+# CONFIG_FONT_8x8 is not set
+CONFIG_FONT_8x16=y
+# CONFIG_FONT_6x11 is not set
+# CONFIG_FONT_7x14 is not set
+# CONFIG_FONT_PEARL_8x8 is not set
+# CONFIG_FONT_ACORN_8x8 is not set
+# CONFIG_FONT_MINI_4x6 is not set
+# CONFIG_FONT_SUN8x16 is not set
+# CONFIG_FONT_SUN12x22 is not set
+# CONFIG_FONT_10x18 is not set
+CONFIG_LOGO=y
+# CONFIG_LOGO_LINUX_MONO is not set
+CONFIG_LOGO_LINUX_VGA16=y
+# CONFIG_LOGO_LINUX_CLUT224 is not set
 # CONFIG_SOUND is not set
 # CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
diff --git a/arch/arm/mach-shmobile/board-bonito.c b/arch/arm/mach-shmobile/board-bonito.c
index 4b8f7ef..c697f9f 100644
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
 u16 fpga_read(u32 offset)
@@ -139,6 +148,63 @@ static int __init pmic_init(void)
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
+		.start	= gic_spi(177),
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
@@ -148,6 +214,7 @@ static struct platform_device *bonito_core_devices[] __initdata = {
  * base board devices
  */
 static struct platform_device *bonito_base_devices[] __initdata = {
+	&lcdc0_device,
 };
 
 /*
@@ -220,6 +287,9 @@ static void __init bonito_map_io(void)
 #define BIT_ON(sw, bit)		(sw & (1 << bit))
 #define BIT_OFF(sw, bit)	(!(sw & (1 << bit)))
 
+#define VCCQ1CR		0xE6058140
+#define VCCQ1LCDCR	0xE6058186
+
 static void __init bonito_init(void)
 {
 	u16 val;
@@ -279,6 +349,53 @@ static void __init bonito_init(void)
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
+			fpga_write(LCDCR, 1, 1);
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
index 7937800..1e8fee0 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -251,7 +251,7 @@ static struct clk div6_clks[DIV6_NR] = {
 };
 
 enum {	MSTP125,
-	MSTP116, MSTP111,
+	MSTP116, MSTP111, MSTP100, MSTP117,
 
 	MSTP230,
 	MSTP222,
@@ -267,8 +267,10 @@ enum {	MSTP125,
 
 static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP125] = MSTP(&div6_clks[DIV6_SUB],	SMSTPCR1, 25, 0), /* TMU0 */
+	[MSTP117] = MSTP(&div4_clks[DIV4_B],	SMSTPCR1, 17, 0), /* LCDC1 */
 	[MSTP116] = MSTP(&div6_clks[DIV6_SUB],	SMSTPCR1, 16, 0), /* IIC0 */
 	[MSTP111] = MSTP(&div6_clks[DIV6_SUB],	SMSTPCR1, 11, 0), /* TMU1 */
+	[MSTP100] = MSTP(&div4_clks[DIV4_B],	SMSTPCR1,  0, 0), /* LCDC0 */
 
 	[MSTP230] = MSTP(&div6_clks[DIV6_SUB],	SMSTPCR2, 30, 0), /* SCIFA6 */
 	[MSTP222] = MSTP(&div6_clks[DIV6_SUB],	SMSTPCR2, 22, 0), /* SCIFA7 */
@@ -317,8 +319,10 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("sub_clk",		&div6_clks[DIV6_SUB]),
 
 	/* MSTP32 clocks */
+	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.0",	&mstp_clks[MSTP100]),
 	CLKDEV_DEV_ID("sh_tmu.1",		&mstp_clks[MSTP111]),
 	CLKDEV_DEV_ID("i2c-sh_mobile.0",	&mstp_clks[MSTP116]),
+	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.1",	&mstp_clks[MSTP117]),
 	CLKDEV_DEV_ID("sh_tmu.0",		&mstp_clks[MSTP125]),
 
 	CLKDEV_DEV_ID("sh-sci.4",		&mstp_clks[MSTP200]),
-- 
1.7.4.1

