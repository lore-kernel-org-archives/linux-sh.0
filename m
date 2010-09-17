From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 17 Sep 2010 10:30:18 +0000
Subject: [PATCH 5/5] ASoC: fix SIU driver breakage, occurred during the
Message-Id: <Pine.LNX.4.64.1009171215470.4988@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1009171129550.4988@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1009171129550.4988@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org
Cc: linux-sh@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>

This patch fixes multiple bugs and a typo, occurred during the multi-
component transition.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 sound/soc/sh/siu.h     |    2 ++
 sound/soc/sh/siu_dai.c |   41 +++++++++++++++++++++++++++++------------
 sound/soc/sh/siu_pcm.c |    2 +-
 3 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/sound/soc/sh/siu.h b/sound/soc/sh/siu.h
index 1c0e1f7..9f4dcb9 100644
--- a/sound/soc/sh/siu.h
+++ b/sound/soc/sh/siu.h
@@ -98,7 +98,9 @@ enum {
 	SIU_CLKB_EXT
 };
 
+struct device;
 struct siu_info {
+	struct device		*dev;
 	int			port_id;
 	u32 __iomem		*pram;
 	u32 __iomem		*xram;
diff --git a/sound/soc/sh/siu_dai.c b/sound/soc/sh/siu_dai.c
index 827940a..af53b64 100644
--- a/sound/soc/sh/siu_dai.c
+++ b/sound/soc/sh/siu_dai.c
@@ -71,8 +71,7 @@ struct port_flag {
 	struct format_flag	capture;
 };
 
-struct siu_info *siu_i2s_data = NULL;
-EXPORT_SYMBOL_GPL(siu_i2s_data);
+struct siu_info *siu_i2s_data;
 
 static struct port_flag siu_flags[SIU_PORT_NUM] = {
 	[SIU_PORT_A] = {
@@ -113,7 +112,7 @@ static void siu_dai_start(struct siu_port *port_info)
 	dev_dbg(port_info->pcm->card->dev, "%s\n", __func__);
 
 	/* Turn on SIU clock */
-	pm_runtime_get_sync(port_info->pcm->card->dev);
+	pm_runtime_get_sync(info->dev);
 
 	/* Issue software reset to siu */
 	siu_write32(base + SIU_SRCTL, 0);
@@ -160,7 +159,7 @@ static void siu_dai_stop(struct siu_port *port_info)
 	siu_write32(base + SIU_SRCTL, 0);
 
 	/* Turn off SIU clock */
-	pm_runtime_put_sync(port_info->pcm->card->dev);
+	pm_runtime_put_sync(info->dev);
 }
 
 static void siu_dai_spbAselect(struct siu_port *port_info)
@@ -675,20 +674,36 @@ static int siu_dai_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	}
 
 	siu_clk = clk_get(dai->dev, siu_name);
-	if (IS_ERR(siu_clk))
+	if (IS_ERR(siu_clk)) {
+		dev_err(dai->dev, "%s: cannot get a SIU clock: %ld\n", __func__,
+			PTR_ERR(siu_clk));
 		return PTR_ERR(siu_clk);
+	}
 
 	parent_clk = clk_get(dai->dev, parent_name);
-	if (!IS_ERR(parent_clk)) {
-		ret = clk_set_parent(siu_clk, parent_clk);
-		if (!ret)
-			clk_set_rate(siu_clk, freq);
-		clk_put(parent_clk);
+	if (IS_ERR(parent_clk)) {
+		ret = PTR_ERR(parent_clk);
+		dev_err(dai->dev, "cannot get a SIU clock parent: %d\n", ret);
+		goto epclkget;
+	}
+
+	ret = clk_set_parent(siu_clk, parent_clk);
+	if (ret < 0) {
+		dev_err(dai->dev, "cannot reparent the SIU clock: %d\n", ret);
+		goto eclksetp;
 	}
 
+	ret = clk_set_rate(siu_clk, freq);
+	if (ret < 0)
+		dev_err(dai->dev, "cannot set SIU clock rate: %d\n", ret);
+
+	/* TODO: when clkdev gets reference counting we'll move these to siu_dai_shutdown() */
+eclksetp:
+	clk_put(parent_clk);
+epclkget:
 	clk_put(siu_clk);
 
-	return 0;
+	return ret;
 }
 
 static struct snd_soc_dai_ops siu_dai_ops = {
@@ -700,7 +715,7 @@ static struct snd_soc_dai_ops siu_dai_ops = {
 };
 
 static struct snd_soc_dai_driver siu_i2s_dai = {
-	.name	= "sui-i2s-dai",
+	.name	= "siu-i2s-dai",
 	.playback = {
 		.channels_min = 2,
 		.channels_max = 2,
@@ -727,6 +742,7 @@ static int __devinit siu_probe(struct platform_device *pdev)
 	if (!info)
 		return -ENOMEM;
 	siu_i2s_data = info;
+	info->dev = &pdev->dev;
 
 	ret = request_firmware(&fw_entry, "siu_spb.bin", &pdev->dev);
 	if (ret)
@@ -828,6 +844,7 @@ static int __devexit siu_remove(struct platform_device *pdev)
 
 static struct platform_driver siu_driver = {
 	.driver 	= {
+		.owner	= THIS_MODULE,
 		.name	= "siu-pcm-audio",
 	},
 	.probe		= siu_probe,
diff --git a/sound/soc/sh/siu_pcm.c b/sound/soc/sh/siu_pcm.c
index d8c6139..ed29c9e 100644
--- a/sound/soc/sh/siu_pcm.c
+++ b/sound/soc/sh/siu_pcm.c
@@ -343,7 +343,7 @@ static int siu_pcm_open(struct snd_pcm_substream *ss)
 {
 	/* Playback / Capture */
 	struct snd_soc_pcm_runtime *rtd = ss->private_data;
-	struct siu_platform *pdata = snd_soc_platform_get_drvdata(rtd->platform);
+	struct siu_platform *pdata = rtd->platform->dev->platform_data;
 	struct siu_info *info = siu_i2s_data;
 	struct siu_port *port_info = siu_port_info(ss);
 	struct siu_stream *siu_stream;
-- 
1.7.1

