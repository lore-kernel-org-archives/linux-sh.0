From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Fri, 08 Aug 2008 05:30:06 +0000
Subject: [PATCH] sh: Add support sh7760fb to sh7763rdp board
Message-Id: <489BD9DE.9080705@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add sh7760fb platform device to sh7763rdp's setup.
---
 arch/sh/boards/mach-sh7763rdp/setup.c |   52 ++++++++++++++++++++++++++++++++-
 1 files changed, 51 insertions(+), 1 deletions(-)

diff --git a/arch/sh/boards/mach-sh7763rdp/setup.c b/arch/sh/boards/mach-sh7763rdp/setup.c
index 49940d1..23850da 100644
--- a/arch/sh/boards/mach-sh7763rdp/setup.c
+++ b/arch/sh/boards/mach-sh7763rdp/setup.c
@@ -15,9 +15,11 @@
 #include <linux/interrupt.h>
 #include <linux/input.h>
 #include <linux/mtd/physmap.h>
+#include <linux/fb.h>
 #include <linux/io.h>
 #include <asm/sh7763rdp.h>
 #include <asm/sh_eth.h>
+#include <asm/sh7760fb.h>

 /* NOR Flash */
 static struct mtd_partition sh7763rdp_nor_flash_partitions[] = {
@@ -88,9 +90,58 @@ static struct platform_device sh7763rdp_eth_device = {
 	},
 };

+/* SH7763 LCDC */
+static struct resource sh7763rdp_fb_resources[] = {
+	{
+		.start  = 0xFFE80000,
+		.end    = 0xFFE80442 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+};
+
+static struct fb_videomode sh7763fb_videomode = {
+	.refresh = 60,
+	.name = "VGA Monitor",
+	.xres = 640,
+	.yres = 480,
+	.pixclock = 10000,
+	.left_margin = 80,
+	.right_margin = 24,
+	.upper_margin = 30,
+	.lower_margin = 1,
+	.hsync_len = 96,
+	.vsync_len = 1,
+	.sync = 0,
+	.vmode = FB_VMODE_NONINTERLACED,
+	.flag = FBINFO_FLAG_DEFAULT,
+};
+
+static struct sh7760fb_platdata sh7763fb_def_pdata = {
+	.def_mode = &sh7763fb_videomode,
+	.ldmtr = (LDMTR_TFT_COLOR_16|LDMTR_MCNT),
+	.lddfr = LDDFR_16BPP_RGB565,
+	.ldpmmr = 0x0000,
+	.ldpspr = 0xFFFF,
+	.ldaclnr = 0x0001,
+	.ldickr = 0x1102,
+	.rotate = 0,
+	.novsync = 0,
+	.blank = NULL,
+};
+
+static struct platform_device sh7763rdp_fb_device = {
+	.name		= "sh7760-lcdc",
+	.resource	= sh7763rdp_fb_resources,
+	.num_resources = ARRAY_SIZE(sh7763rdp_fb_resources),
+	.dev = {
+		.platform_data = &sh7763fb_def_pdata,
+	},
+};
+
 static struct platform_device *sh7763rdp_devices[] __initdata = {
 	&sh7763rdp_nor_flash_device,
 	&sh7763rdp_eth_device,
+	&sh7763rdp_fb_device,
 };

 static int __init sh7763rdp_devices_setup(void)
@@ -98,7 +149,6 @@ static int __init sh7763rdp_devices_setup(void)
 	return platform_add_devices(sh7763rdp_devices,
 				    ARRAY_SIZE(sh7763rdp_devices));
 }
-
 device_initcall(sh7763rdp_devices_setup);

 static void __init sh7763rdp_setup(char **cmdline_p)
-- 
1.5.6.2

