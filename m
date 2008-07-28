From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 28 Jul 2008 10:07:04 +0000
Subject: [PATCH] sh: SuperH Mobile LCDC platform data for AP325RXA
Message-Id: <20080728100704.18272.24116.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add LCD panel platform data for the AP325RXA board.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/renesas/ap325rxa/setup.c |   81 ++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

--- 0001/arch/sh/boards/renesas/ap325rxa/setup.c
+++ work/arch/sh/boards/renesas/ap325rxa/setup.c	2008-07-28 18:55:07.000000000 +0900
@@ -16,7 +16,10 @@
 #include <linux/mtd/physmap.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/delay.h>
+#include <asm/sh_mobile_lcdc.h>
 #include <asm/io.h>
+#include <asm/clock.h>
 
 static struct resource smc9118_resources[] = {
 	[0] = {
@@ -79,9 +82,77 @@ static struct platform_device ap325rxa_n
 	},
 };
 
+#define FPGA_LCDREG	0xB4100180
+#define FPGA_BKLREG	0xB4100212
+#define FPGA_LCDREG_VAL	0x0018
+#define PORT_PHCR	0xA405010E
+#define PORT_PLCR	0xA4050114
+#define PORT_PMCR	0xA4050116
+#define PORT_PRCR	0xA405011C
+#define PORT_HIZCRA	0xA4050158
+#define PORT_PSCR	0xA405011E
+#define PORT_PSDR	0xA405013E
+
+static void ap320_wvga_power_on(void *board_data)
+{
+	msleep(100);
+
+	/* ASD AP-320/325 LCD ON */
+	ctrl_outw(FPGA_LCDREG_VAL, FPGA_LCDREG);
+
+	/* backlight */
+	ctrl_outw((ctrl_inw(PORT_PSCR) & ~0x00C0) | 0x40, PORT_PSCR);
+	ctrl_outb(ctrl_inb(PORT_PSDR) & ~0x08, PORT_PSDR);
+	ctrl_outw(0x100, FPGA_BKLREG);
+}
+
+static struct sh_mobile_lcdc_info lcdc_info = {
+	.clock_source = LCDC_CLK_EXTERNAL,
+	.ch[0] = {
+		.chan = LCDC_CHAN_MAINLCD,
+		.bpp = 16,
+		.interface_type = RGB18,
+		.clock_divider = 1,
+		.lcd_cfg = {
+			.name = "LB070WV1",
+			.xres = 800,
+			.yres = 480,
+			.left_margin = 40,
+			.right_margin = 160,
+			.hsync_len = 8,
+			.upper_margin = 63,
+			.lower_margin = 80,
+			.vsync_len = 1,
+			.sync = 0, /* hsync and vsync are active low */
+		},
+		.board_cfg = {
+			.display_on = ap320_wvga_power_on,
+		},
+	}
+};
+
+static struct resource lcdc_resources[] = {
+	[0] = {
+		.name	= "LCDC",
+		.start	= 0xfe940000, /* P4-only space */
+		.end	= 0xfe941fff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device lcdc_device = {
+	.name		= "sh_mobile_lcdc_fb",
+	.num_resources	= ARRAY_SIZE(lcdc_resources),
+	.resource	= lcdc_resources,
+	.dev		= {
+		.platform_data	= &lcdc_info,
+	},
+};
+
 static struct platform_device *ap325rxa_devices[] __initdata = {
 	&smc9118_device,
-	&ap325rxa_nor_flash_device
+	&ap325rxa_nor_flash_device,
+	&lcdc_device,
 };
 
 static struct i2c_board_info __initdata ap325rxa_i2c_devices[] = {
@@ -89,6 +160,8 @@ static struct i2c_board_info __initdata 
 
 static int __init ap325rxa_devices_setup(void)
 {
+	clk_always_enable("mstp200"); /* LCDC */
+
 	i2c_register_board_info(0, ap325rxa_i2c_devices,
 				ARRAY_SIZE(ap325rxa_i2c_devices));
  
@@ -99,6 +172,12 @@ device_initcall(ap325rxa_devices_setup);
 
 static void __init ap325rxa_setup(char **cmdline_p)
 {
+	/* LCDC configuration */
+	ctrl_outw(ctrl_inw(PORT_PHCR) & ~0xffff, PORT_PHCR);
+	ctrl_outw(ctrl_inw(PORT_PLCR) & ~0xffff, PORT_PLCR);
+	ctrl_outw(ctrl_inw(PORT_PMCR) & ~0xffff, PORT_PMCR);
+	ctrl_outw(ctrl_inw(PORT_PRCR) & ~0x03ff, PORT_PRCR);
+	ctrl_outw(ctrl_inw(PORT_HIZCRA) & ~0x01C0, PORT_HIZCRA);
 }
 
 static struct sh_machine_vector mv_ap325rxa __initmv = {
