From: Alexandre Courbot <gnurou@gmail.com>
Date: Wed, 16 Feb 2011 03:49:01 +0000
Subject: [PATCH v2 1/3] fbdev: sh_mobile_lcdcfb: add backlight support
Message-Id: <1297828143-11798-2-git-send-email-gnurou@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Support for backlight devices controlled through board-specific
routines. Backlights can be defined per-channel and follow fbdev
directives to switch off as the LCD blanks or is turned on/off.

Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
---
 drivers/video/Kconfig            |    1 +
 drivers/video/sh_mobile_lcdcfb.c |   81 ++++++++++++++++++++++++++++++++++++++
 drivers/video/sh_mobile_lcdcfb.h |    2 +
 include/video/sh_mobile_lcdc.h   |    9 ++++
 4 files changed, 93 insertions(+), 0 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 6bafb51b..a222d65 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2005,6 +2005,7 @@ config FB_SH_MOBILE_LCDC
 	select FB_SYS_IMAGEBLIT
 	select FB_SYS_FOPS
 	select FB_DEFERRED_IO
+	select FB_BACKLIGHT
 	select SH_MIPI_DSI if SH_LCD_MIPI_DSI
 	---help---
 	  Frame buffer driver for the on-chip SH-Mobile LCD controller.
diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index bf12e53..e040e46 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -21,6 +21,8 @@
 #include <linux/ioctl.h>
 #include <linux/slab.h>
 #include <linux/console.h>
+#include <linux/backlight.h>
+#include <linux/gpio.h>
 #include <video/sh_mobile_lcdc.h>
 #include <asm/atomic.h>
 
@@ -618,6 +620,11 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 			board_cfg->display_on(board_cfg->board_data, ch->info);
 			module_put(board_cfg->owner);
 		}
+
+		if (ch->bl) {
+			ch->bl->props.power = FB_BLANK_UNBLANK;
+			backlight_update_status(ch->bl);
+		}
 	}
 
 	return 0;
@@ -648,6 +655,11 @@ static void sh_mobile_lcdc_stop(struct sh_mobile_lcdc_priv *priv)
 			sh_mobile_lcdc_clk_on(priv);
 		}
 
+		if (ch->bl) {
+			ch->bl->props.power = FB_BLANK_POWERDOWN;
+			backlight_update_status(ch->bl);
+		}
+
 		board_cfg = &ch->cfg.board_cfg;
 		if (try_module_get(board_cfg->owner) && board_cfg->display_off) {
 			board_cfg->display_off(board_cfg->board_data);
@@ -980,6 +992,64 @@ static struct fb_ops sh_mobile_lcdc_ops = {
 	.fb_check_var	= sh_mobile_check_var,
 };
 
+static int sh_mobile_lcdc_update_bl(struct backlight_device *bdev)
+{
+	struct sh_mobile_lcdc_chan *ch = bl_get_data(bdev);
+	struct sh_mobile_lcdc_board_cfg *cfg = &ch->cfg.board_cfg;
+	int brightness = bdev->props.brightness;
+
+	if (bdev->props.power != FB_BLANK_UNBLANK ||
+	    bdev->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
+		brightness = 0;
+
+	return cfg->set_brightness(cfg->board_data, brightness);
+}
+
+static int sh_mobile_lcdc_get_brightness(struct backlight_device *bdev)
+{
+	struct sh_mobile_lcdc_chan *ch = bl_get_data(bdev);
+	struct sh_mobile_lcdc_board_cfg *cfg = &ch->cfg.board_cfg;
+
+	return cfg->get_brightness(cfg->board_data);
+}
+
+static int sh_mobile_lcdc_check_fb(struct backlight_device *bdev,
+				   struct fb_info *info)
+{
+	return (info->bl_dev = bdev);
+}
+
+static struct backlight_ops sh_mobile_lcdc_bl_ops = {
+	.options	= BL_CORE_SUSPENDRESUME,
+	.update_status	= sh_mobile_lcdc_update_bl,
+	.get_brightness	= sh_mobile_lcdc_get_brightness,
+	.check_fb	= sh_mobile_lcdc_check_fb,
+};
+
+static struct backlight_device *sh_mobile_lcdc_bl_probe(struct device *parent,
+					       struct sh_mobile_lcdc_chan *ch)
+{
+	struct backlight_device *bl;
+
+	bl = backlight_device_register(ch->cfg.bl_info.name, parent, ch,
+				       &sh_mobile_lcdc_bl_ops, NULL);
+	if (!bl) {
+		dev_err(parent, "unable to register backlight device\n");
+		return NULL;
+	}
+
+	bl->props.max_brightness = ch->cfg.bl_info.max_brightness;
+	bl->props.brightness = bl->props.max_brightness;
+	backlight_update_status(bl);
+
+	return bl;
+}
+
+static void sh_mobile_lcdc_bl_remove(struct backlight_device *bdev)
+{
+	backlight_device_unregister(bdev);
+}
+
 static int sh_mobile_lcdc_set_bpp(struct fb_var_screeninfo *var, int bpp)
 {
 	switch (bpp) {
@@ -1198,6 +1268,10 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 		init_completion(&ch->vsync_completion);
 		ch->pan_offset = 0;
 
+		/* probe the backlight is there is one defined */
+		if (ch->cfg.bl_info.max_brightness)
+			ch->bl = sh_mobile_lcdc_bl_probe(&pdev->dev, ch);
+
 		switch (pdata->ch[i].chan) {
 		case LCDC_CHAN_MAINLCD:
 			ch->enabled = 1 << 1;
@@ -1345,6 +1419,8 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 			}
 		}
 
+		info->bl_dev = ch->bl;
+
 		error = register_framebuffer(info);
 		if (error < 0)
 			goto err1;
@@ -1404,6 +1480,11 @@ static int sh_mobile_lcdc_remove(struct platform_device *pdev)
 		framebuffer_release(info);
 	}
 
+	for (i = 0; i < ARRAY_SIZE(priv->ch); i++) {
+		if (priv->ch[i].bl)
+			sh_mobile_lcdc_bl_remove(priv->ch[i].bl);
+	}
+
 	if (priv->dot_clk)
 		clk_put(priv->dot_clk);
 
diff --git a/drivers/video/sh_mobile_lcdcfb.h b/drivers/video/sh_mobile_lcdcfb.h
index 9ecee2f..03a22dc 100644
--- a/drivers/video/sh_mobile_lcdcfb.h
+++ b/drivers/video/sh_mobile_lcdcfb.h
@@ -16,6 +16,7 @@ enum { LDDCKPAT1R, LDDCKPAT2R, LDMT1R, LDMT2R, LDMT3R, LDDFR, LDSM1R,
 
 struct sh_mobile_lcdc_priv;
 struct fb_info;
+struct backlight_device;
 
 struct sh_mobile_lcdc_chan {
 	struct sh_mobile_lcdc_priv *lcdc;
@@ -26,6 +27,7 @@ struct sh_mobile_lcdc_chan {
 	u32 pseudo_palette[PALETTE_NR];
 	unsigned long saved_ch_regs[NR_CH_REGS];
 	struct fb_info *info;
+	struct backlight_device *bl;
 	dma_addr_t dma_handle;
 	struct fb_deferred_io defio;
 	struct scatterlist *sglist;
diff --git a/include/video/sh_mobile_lcdc.h b/include/video/sh_mobile_lcdc.h
index daabae5..f2e6ab8 100644
--- a/include/video/sh_mobile_lcdc.h
+++ b/include/video/sh_mobile_lcdc.h
@@ -59,6 +59,8 @@ struct sh_mobile_lcdc_board_cfg {
 			       struct sh_mobile_lcdc_sys_bus_ops *sys_ops);
 	void (*display_on)(void *board_data, struct fb_info *info);
 	void (*display_off)(void *board_data);
+	int (*set_brightness)(void *board_data, int brightness);
+	int (*get_brightness)(void *board_data);
 };
 
 struct sh_mobile_lcdc_lcd_size_cfg { /* width and height of panel in mm */
@@ -66,6 +68,12 @@ struct sh_mobile_lcdc_lcd_size_cfg { /* width and height of panel in mm */
 	unsigned long height;
 };
 
+/* backlight info */
+struct sh_mobile_lcdc_bl_info {
+	const char *name;
+	int max_brightness;
+};
+
 struct sh_mobile_lcdc_chan_cfg {
 	int chan;
 	int bpp;
@@ -76,6 +84,7 @@ struct sh_mobile_lcdc_chan_cfg {
 	int num_cfg;
 	struct sh_mobile_lcdc_lcd_size_cfg lcd_size_cfg;
 	struct sh_mobile_lcdc_board_cfg board_cfg;
+	struct sh_mobile_lcdc_bl_info bl_info;
 	struct sh_mobile_lcdc_sys_bus_cfg sys_bus_cfg; /* only for SYSn I/F */
 };
 
-- 
1.7.4.1

