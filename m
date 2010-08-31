From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 31 Aug 2010 05:47:07 +0000
Subject: [PATCH 2/4 v2] ASoC: Add sh_mobile_hdmi sound support
Message-Id: <w3pwrr75o6d.wl%kuninori.morimoto.gx@renesas.com>
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

o based on Mark's latest "for-2.6.37"

 drivers/video/sh_mobile_hdmi.c |   65 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index d25e348..f14c58a 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -22,6 +22,8 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
 
 #include <video/sh_mobile_hdmi.h>
 #include <video/sh_mobile_lcdc.h>
@@ -222,6 +224,62 @@ static u8 hdmi_read(struct sh_hdmi *hdmi, u8 reg)
 	return ioread8(hdmi->base + reg);
 }
 
+/************************************************************************
+
+
+			HDMI sound
+
+
+************************************************************************/
+static unsigned int sh_hdmi_snd_read(struct snd_soc_codec *codec,
+				     unsigned int reg)
+{
+	struct sh_hdmi *hdmi = snd_soc_codec_get_drvdata(codec);
+
+	return hdmi_read(hdmi, reg);
+}
+
+static int sh_hdmi_snd_write(struct snd_soc_codec *codec,
+			     unsigned int reg,
+			     unsigned int value)
+{
+	struct sh_hdmi *hdmi = snd_soc_codec_get_drvdata(codec);
+
+	hdmi_write(hdmi, value, reg);
+	return 0;
+}
+
+static struct snd_soc_dai_driver sh_hdmi_dai = {
+	.name = "sh_mobile_hdmi-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
+	},
+};
+
+static int sh_hdmi_snd_probe(struct snd_soc_codec *codec)
+{
+	dev_info(codec->dev, "SH Mobile HDMI Audio Codec");
+
+	return 0;
+}
+
+static struct snd_soc_codec_driver soc_codec_dev_sh_hdmi = {
+	.probe		= sh_hdmi_snd_probe,
+	.read		= sh_hdmi_snd_read,
+	.write		= sh_hdmi_snd_write,
+};
+
+/************************************************************************
+
+
+			HDMI video
+
+
+************************************************************************/
 /* External video parameter settings */
 static void hdmi_external_video_param(struct sh_hdmi *hdmi)
 {
@@ -804,6 +862,11 @@ static int __init sh_hdmi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	ret =  snd_soc_register_codec(&pdev->dev,
+			&soc_codec_dev_sh_hdmi, &sh_hdmi_dai, 1);
+	if (ret < 0)
+		goto egetclk;
+
 	hdmi->dev = &pdev->dev;
 
 	hdmi->hdmi_clk = clk_get(&pdev->dev, "ick");
@@ -901,6 +964,8 @@ static int __exit sh_hdmi_remove(struct platform_device *pdev)
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	int irq = platform_get_irq(pdev, 0);
 
+	snd_soc_unregister_codec(&pdev->dev);
+
 	pdata->lcd_chan->board_cfg.display_on = NULL;
 	pdata->lcd_chan->board_cfg.display_off = NULL;
 	pdata->lcd_chan->board_cfg.board_data = NULL;
-- 
1.7.0.4

