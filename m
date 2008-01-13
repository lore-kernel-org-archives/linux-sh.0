From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 13 Jan 2008 13:27:30 +0000
Subject: [PATCH] sh: r2d - add lcd planel timings to sm501 platform data
Message-Id: <20080113132730.28928.26659.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh: r2d - add lcd planel timings to sm501 platform data

This patch adds timings to drive a Sharp LQ104V1DG21 lcd panel that can be
hooked up to R2D-1 or R2D-PLUS. The sm501fb driver should leave the pins
FPEN and VBIASEN alone, and this patch instructs the driver to do so by not
setting flags flags for these pins.

This patch works best together with the patch posted to the linux-fbdev-devel
list "sm501fb: control panel pin usage with platform data flags", but this
patch can be merged independently.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/renesas/rts7751r2d/setup.c |   45 +++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

--- 0001/arch/sh/boards/renesas/rts7751r2d/setup.c
+++ work/arch/sh/boards/renesas/rts7751r2d/setup.c	2008-01-13 21:52:42.000000000 +0900
@@ -14,6 +14,7 @@
 #include <linux/serial_8250.h>
 #include <linux/sm501.h>
 #include <linux/pm.h>
+#include <linux/fb.h>
 #include <asm/machvec.h>
 #include <asm/rts7751r2d.h>
 #include <asm/voyagergx.h>
@@ -129,9 +130,53 @@ static struct resource sm501_resources[]
 	},
 };
 
+static struct fb_videomode sm501_default_mode = {
+	.pixclock	= 35714,
+	.xres		= 640,
+	.yres		= 480,
+	.left_margin	= 105,
+	.right_margin	= 50,
+	.upper_margin	= 35,
+	.lower_margin	= 0,
+	.hsync_len	= 96,
+	.vsync_len	= 2,
+	.sync = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+};
+
+static struct sm501_platdata_fbsub sm501_pdata_fbsub_pnl = {
+	.def_bpp	= 16,
+	.def_mode	= &sm501_default_mode,
+	.flags		= SM501FB_FLAG_USE_INIT_MODE |
+			  SM501FB_FLAG_USE_HWCURSOR |
+			  SM501FB_FLAG_USE_HWACCEL |
+			  SM501FB_FLAG_DISABLE_AT_EXIT,
+};
+
+static struct sm501_platdata_fbsub sm501_pdata_fbsub_crt = {
+	.flags		= (SM501FB_FLAG_USE_INIT_MODE |
+			   SM501FB_FLAG_USE_HWCURSOR |
+			   SM501FB_FLAG_USE_HWACCEL |
+			   SM501FB_FLAG_DISABLE_AT_EXIT),
+
+};
+
+static struct sm501_platdata_fb sm501_fb_pdata = {
+	.fb_route	= SM501_FB_OWN,
+	.fb_crt		= &sm501_pdata_fbsub_crt,
+	.fb_pnl		= &sm501_pdata_fbsub_pnl,
+	.flags		= SM501_FBPD_SWAP_FB_ENDIAN,
+};
+
+static struct sm501_platdata sm501_platform_data = {
+	.fb		= &sm501_fb_pdata,
+};
+
 static struct platform_device sm501_device = {
 	.name		= "sm501",
 	.id		= -1,
+	.dev		= {
+		.platform_data	= &sm501_platform_data,
+	},
 	.num_resources	= ARRAY_SIZE(sm501_resources),
 	.resource	= sm501_resources,
 };
