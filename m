From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 31 Aug 2010 05:46:41 +0000
Subject: [PATCH 1/4 v2] fbdev: sh-mobile: Add HDMI sound type selection
Message-Id: <w3p1v9f72rk.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p39tv72sx.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p39tv72sx.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2
 no change

 drivers/video/sh_mobile_hdmi.c |   21 ++++++++++++++++++++-
 include/video/sh_mobile_hdmi.h |   16 ++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index afebe80..d25e348 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -318,6 +318,9 @@ static void sh_hdmi_video_config(struct sh_hdmi *hdmi)
  */
 static void sh_hdmi_audio_config(struct sh_hdmi *hdmi)
 {
+	u8 data;
+	struct sh_mobile_hdmi_info *pdata = hdmi->dev->platform_data;
+
 	/*
 	 * [7:4] L/R data swap control
 	 * [3:0] appropriate N[19:16]
@@ -335,7 +338,23 @@ static void sh_hdmi_audio_config(struct sh_hdmi *hdmi)
 	 * [6:5] set required down sampling rate if required
 	 * [4:3] set required audio source
 	 */
-	hdmi_write(hdmi, 0x00, HDMI_AUDIO_SETTING_1);
+	switch (pdata->flags & HDMI_SRC_MASK) {
+	default:
+		/* FALL THROUGH */
+	case HDMI_SRC_I2S:
+		data = (0x0 << 3);
+		break;
+	case HDMI_SRC_SPDIF:
+		data = (0x1 << 3);
+		break;
+	case HDMI_SRC_DSD:
+		data = (0x2 << 3);
+		break;
+	case HDMI_SRC_HBR:
+		data = (0x3 << 3);
+		break;
+	}
+	hdmi_write(hdmi, data, HDMI_AUDIO_SETTING_1);
 
 	/* [3:0] set sending channel number for channel status */
 	hdmi_write(hdmi, 0x40, HDMI_AUDIO_SETTING_2);
diff --git a/include/video/sh_mobile_hdmi.h b/include/video/sh_mobile_hdmi.h
index 577cf18..929c2d3 100644
--- a/include/video/sh_mobile_hdmi.h
+++ b/include/video/sh_mobile_hdmi.h
@@ -14,9 +14,25 @@
 struct sh_mobile_lcdc_chan_cfg;
 struct device;
 
+/*
+ * flags format
+ *
+ * 0x0000000A
+ *
+ * A: Audio source select
+ */
+
+/* Audio source select */
+#define HDMI_SRC_MASK		(0xF << 0)
+#define HDMI_SRC_I2S		(0 << 0) /* default */
+#define HDMI_SRC_SPDIF		(1 << 0)
+#define HDMI_SRC_DSD		(2 << 0)
+#define HDMI_SRC_HBR		(3 << 0)
+
 struct sh_mobile_hdmi_info {
 	struct sh_mobile_lcdc_chan_cfg	*lcd_chan;
 	struct device			*lcd_dev;
+	unsigned int			 flags;
 };
 
 #endif
-- 
1.7.0.4

