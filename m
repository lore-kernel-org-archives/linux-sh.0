From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Sun, 03 Oct 2010 04:24:42 +0000
Subject: [PATCH] sh: fix an ms7724se compile breakage
Message-Id: <Pine.LNX.4.64.1010030622230.15920@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Fix a compile breakage, caused by my own careless copy-paste.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index 3099c36..fe208d6 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -148,14 +148,14 @@ const static struct fb_videomode lcdc_720p_modes[] = {
 	{
 		.name		= "LB070WV1",
 		.sync		= 0, /* hsync and vsync are active low */
-		.xres		= 1280;
-		.yres		= 720;
-		.left_margin	= 220;
-		.right_margin	= 110;
-		.hsync_len	= 40;
-		.upper_margin	= 20;
-		.lower_margin	= 5;
-		.vsync_len	= 5;
+		.xres		= 1280,
+		.yres		= 720,
+		.left_margin	= 220,
+		.right_margin	= 110,
+		.hsync_len	= 40,
+		.upper_margin	= 20,
+		.lower_margin	= 5,
+		.vsync_len	= 5,
 	},
 };
 
@@ -163,14 +163,14 @@ const static struct fb_videomode lcdc_vga_modes[] = {
 	{
 		.name		= "LB070WV1",
 		.sync		= 0, /* hsync and vsync are active low */
-		.xres		= 640;
-		.yres		= 480;
-		.left_margin	= 105;
-		.right_margin	= 50;
-		.hsync_len	= 96;
-		.upper_margin	= 33;
-		.lower_margin	= 10;
-		.vsync_len	= 2;
+		.xres		= 640,
+		.yres		= 480,
+		.left_margin	= 105,
+		.right_margin	= 50,
+		.hsync_len	= 96,
+		.upper_margin	= 33,
+		.lower_margin	= 10,
+		.vsync_len	= 2,
 	},
 };
 
