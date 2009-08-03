From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Mon, 03 Aug 2009 04:52:03 +0000
Subject: [PATCH] ms7724se: add 1280x720 lcdc output support
Message-Id: <u8wi1ts7g.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

There was no big meaning in the support of SVGA,
but 720p support is necessary for ms7724se board.
So, this patch support 720p instead of SVGA.

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-se/7724/setup.c |   28 ++++++++++++++++++----------
 1 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index 7f506b1..52ea80e 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -41,7 +41,15 @@
  * SW41 : abxx xxxx  -> a = 0 : Analog  monitor
  *                          1 : Digital monitor
  *                      b = 0 : VGA
- *                          1 : SVGA
+ *                          1 : 720p
+ */
+
+/*
+ * about 720p
+ *
+ * When you use 1280 x 720 lcdc output,
+ * you should change OSC6 lcdc clock from 25.175MHz to 74.25MHz,
+ * and change SW41 to use 720p
  */
 
 /* Heartbeat */
@@ -637,15 +645,15 @@ static int __init devices_setup(void)
 	sh_eth_init();
 
 	if (sw & SW41_B) {
-		/* SVGA */
-		lcdc_info.ch[0].lcd_cfg.xres         = 800;
-		lcdc_info.ch[0].lcd_cfg.yres         = 600;
-		lcdc_info.ch[0].lcd_cfg.left_margin  = 142;
-		lcdc_info.ch[0].lcd_cfg.right_margin = 52;
-		lcdc_info.ch[0].lcd_cfg.hsync_len    = 96;
-		lcdc_info.ch[0].lcd_cfg.upper_margin = 24;
-		lcdc_info.ch[0].lcd_cfg.lower_margin = 2;
-		lcdc_info.ch[0].lcd_cfg.vsync_len    = 2;
+		/* 720p */
+		lcdc_info.ch[0].lcd_cfg.xres         = 1280;
+		lcdc_info.ch[0].lcd_cfg.yres         = 720;
+		lcdc_info.ch[0].lcd_cfg.left_margin  = 220;
+		lcdc_info.ch[0].lcd_cfg.right_margin = 110;
+		lcdc_info.ch[0].lcd_cfg.hsync_len    = 40;
+		lcdc_info.ch[0].lcd_cfg.upper_margin = 20;
+		lcdc_info.ch[0].lcd_cfg.lower_margin = 5;
+		lcdc_info.ch[0].lcd_cfg.vsync_len    = 5;
 	} else {
 		/* VGA */
 		lcdc_info.ch[0].lcd_cfg.xres         = 640;
-- 
1.6.0.4

