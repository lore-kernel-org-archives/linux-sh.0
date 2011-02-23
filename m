From: Alexandre Courbot <gnurou@gmail.com>
Date: Wed, 23 Feb 2011 08:36:30 +0000
Subject: [PATCH] fbdev: sh_mobile_lcdcfb: add blanking support
Message-Id: <1298450190-3803-1-git-send-email-gnurou@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add a blanking callback to the LCDC driver in order to support both
FBIOBLANK and TIOCLINUX blanking ioctls. LCDC clocks are also released
if the requested blanking level is superior to FB_BLANK_NORMAL, to allow
runtime PM to disable the clocks if possible.

Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
---
 drivers/video/sh_mobile_lcdcfb.c |   44 ++++++++++++++++++++++++++++++++++++++
 drivers/video/sh_mobile_lcdcfb.h |    1 +
 2 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index bf12e53..994bcc7 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -965,6 +965,49 @@ static int sh_mobile_check_var(struct fb_var_screeninfo *var, struct fb_info *in
 	return 0;
 }
 
+/*
+ * Screen blanking. Behavior is as follows:
+ * FB_BLANK_UNBLANK: screen unblanked, clocks enabled
+ * FB_BLANK_NORMAL: screen blanked, clocks enabled
+ * FB_BLANK_VSYNC,
+ * FB_BLANK_HSYNC,
+ * FB_BLANK_POWEROFF: screen blanked, clocks disabled
+ */
+static int sh_mobile_lcdc_blank(int blank, struct fb_info *info)
+{
+	struct sh_mobile_lcdc_chan *ch = info->par;
+	struct sh_mobile_lcdc_priv *p = ch->lcdc;
+
+	/* blank the screen? */
+	if (blank > FB_BLANK_UNBLANK && ch->blank_status = FB_BLANK_UNBLANK) {
+		struct fb_fillrect rect = {
+			.width = info->var.xres,
+			.height = info->var.yres,
+		};
+		sh_mobile_lcdc_fillrect(info, &rect);
+	}
+	/* turn clocks on? */
+	if (blank <= FB_BLANK_NORMAL && ch->blank_status > FB_BLANK_NORMAL) {
+		sh_mobile_lcdc_clk_on(p);
+	}
+	/* turn clocks off? */
+	if (blank > FB_BLANK_NORMAL && ch->blank_status <= FB_BLANK_NORMAL) {
+		/* make sure the screen is updated with the black fill before
+		 * switching the clocks off. one vsync is not enough since
+		 * blanking may occur in the middle of a refresh. deferred io
+		 * mode will reenable the clocks and update the screen in time,
+		 * so it does not need this. */
+		if (!info->fbdefio) {
+			sh_mobile_wait_for_vsync(info);
+			sh_mobile_wait_for_vsync(info);
+		}
+		sh_mobile_lcdc_clk_off(p);
+	}
+
+	ch->blank_status = blank;
+	return 0;
+}
+
 static struct fb_ops sh_mobile_lcdc_ops = {
 	.owner          = THIS_MODULE,
 	.fb_setcolreg	= sh_mobile_lcdc_setcolreg,
@@ -973,6 +1016,7 @@ static struct fb_ops sh_mobile_lcdc_ops = {
 	.fb_fillrect	= sh_mobile_lcdc_fillrect,
 	.fb_copyarea	= sh_mobile_lcdc_copyarea,
 	.fb_imageblit	= sh_mobile_lcdc_imageblit,
+	.fb_blank	= sh_mobile_lcdc_blank,
 	.fb_pan_display = sh_mobile_fb_pan_display,
 	.fb_ioctl       = sh_mobile_ioctl,
 	.fb_open	= sh_mobile_open,
diff --git a/drivers/video/sh_mobile_lcdcfb.h b/drivers/video/sh_mobile_lcdcfb.h
index 9ecee2f..948dd24 100644
--- a/drivers/video/sh_mobile_lcdcfb.h
+++ b/drivers/video/sh_mobile_lcdcfb.h
@@ -35,6 +35,7 @@ struct sh_mobile_lcdc_chan {
 	struct completion vsync_completion;
 	struct fb_var_screeninfo display_var;
 	int use_count;
+	int blank_status;
 	struct mutex open_lock;		/* protects the use counter */
 };
 
-- 
1.7.4.1

