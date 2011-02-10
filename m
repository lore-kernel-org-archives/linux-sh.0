From: Alexandre Courbot <gnurou@gmail.com>
Date: Thu, 10 Feb 2011 15:22:45 +0000
Subject: [PATCH 1/2] fbdev: sh_mobile_lcdcfb: add backlight support
Message-Id: <1297351366-7374-2-git-send-email-gnurou@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Support for LCD backlight devices controlled through a GPIO to the LCDC
driver. Backlights can be defined per-channel and follow fbdev
directives to switch off as the LCD blanks.

Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
---
 drivers/video/Kconfig            |    1 +
 drivers/video/sh_mobile_lcdcfb.c |   73 ++++++++++++++++++++++++++++++++++++++
 drivers/video/sh_mobile_lcdcfb.h |    2 +
 include/video/sh_mobile_lcdc.h   |    7 ++++
 4 files changed, 83 insertions(+), 0 deletions(-)

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
index bf12e53..5240406 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -21,8 +21,10 @@
 #include <linux/ioctl.h>
 #include <linux/slab.h>
 #include <linux/console.h>
+#include <linux/backlight.h>
 #include <video/sh_mobile_lcdc.h>
 #include <asm/atomic.h>
+#include <linux/gpio.h>
 
 #include "sh_mobile_lcdcfb.h"
 
@@ -980,6 +982,65 @@ static struct fb_ops sh_mobile_lcdc_ops = {
 	.fb_check_var	= sh_mobile_check_var,
 };
 
+static int sh_mobile_lcdc_update_bl(struct backlight_device *bdev)
+{
+	struct sh_mobile_lcdc_bl_info *bi = dev_get_drvdata(&bdev->dev);
+	int brightness = bdev->props.brightness;
+
+	if (bdev->props.power != FB_BLANK_UNBLANK ||
+	    bdev->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
+		brightness = 0;
+
+	gpio_set_value(bi->gpio, brightness);
+
+	return 0;
+}
+
+static int sh_mobile_lcdc_get_brightness(struct backlight_device *bdev)
+{
+	struct sh_mobile_lcdc_bl_info *bi = dev_get_drvdata(&bdev->dev);
+
+	return gpio_get_value(bi->gpio);
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
+static struct backlight_device *sh_mobile_lcdc_bl_probe(struct device *dev,
+				       struct sh_mobile_lcdc_bl_info *info)
+{
+	struct backlight_device *bl;
+
+	bl = backlight_device_register(info->name, dev, info,
+				       &sh_mobile_lcdc_bl_ops, NULL);
+	if (!bl) {
+		dev_err(dev, "unable to register backlight device\n");
+		return NULL;
+	}
+
+	/* brightness is set through gpio, thus binary */
+	bl->props.max_brightness = 1;
+	bl->props.power = FB_BLANK_UNBLANK;
+	bl->props.brightness = sh_mobile_lcdc_get_brightness(bl);
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
@@ -1198,6 +1259,11 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 		init_completion(&ch->vsync_completion);
 		ch->pan_offset = 0;
 
+		if (ch->cfg.bl_info) {
+			ch->bl = sh_mobile_lcdc_bl_probe(&pdev->dev,
+							 ch->cfg.bl_info);
+		}
+
 		switch (pdata->ch[i].chan) {
 		case LCDC_CHAN_MAINLCD:
 			ch->enabled = 1 << 1;
@@ -1345,6 +1411,8 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 			}
 		}
 
+		info->bl_dev = ch->bl;
+
 		error = register_framebuffer(info);
 		if (error < 0)
 			goto err1;
@@ -1404,6 +1472,11 @@ static int sh_mobile_lcdc_remove(struct platform_device *pdev)
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
index 9ecee2f..1057495 100644
--- a/drivers/video/sh_mobile_lcdcfb.h
+++ b/drivers/video/sh_mobile_lcdcfb.h
@@ -17,6 +17,7 @@ enum { LDDCKPAT1R, LDDCKPAT2R, LDMT1R, LDMT2R, LDMT3R, LDDFR, LDSM1R,
 struct sh_mobile_lcdc_priv;
 struct fb_info;
 
+struct backlight_device;
 struct sh_mobile_lcdc_chan {
 	struct sh_mobile_lcdc_priv *lcdc;
 	unsigned long *reg_offs;
@@ -26,6 +27,7 @@ struct sh_mobile_lcdc_chan {
 	u32 pseudo_palette[PALETTE_NR];
 	unsigned long saved_ch_regs[NR_CH_REGS];
 	struct fb_info *info;
+	struct backlight_device *bl;
 	dma_addr_t dma_handle;
 	struct fb_deferred_io defio;
 	struct scatterlist *sglist;
diff --git a/include/video/sh_mobile_lcdc.h b/include/video/sh_mobile_lcdc.h
index daabae5..da0d971 100644
--- a/include/video/sh_mobile_lcdc.h
+++ b/include/video/sh_mobile_lcdc.h
@@ -66,6 +66,12 @@ struct sh_mobile_lcdc_lcd_size_cfg { /* width and height of panel in mm */
 	unsigned long height;
 };
 
+/* backlight info */
+struct sh_mobile_lcdc_bl_info {
+	const char *name;
+	int gpio;
+};
+
 struct sh_mobile_lcdc_chan_cfg {
 	int chan;
 	int bpp;
@@ -73,6 +79,7 @@ struct sh_mobile_lcdc_chan_cfg {
 	int clock_divider;
 	unsigned long flags; /* LCDC_FLAGS_... */
 	const struct fb_videomode *lcd_cfg;
+	struct sh_mobile_lcdc_bl_info *bl_info;
 	int num_cfg;
 	struct sh_mobile_lcdc_lcd_size_cfg lcd_size_cfg;
 	struct sh_mobile_lcdc_board_cfg board_cfg;
-- 
1.7.4

