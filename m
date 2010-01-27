From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 27 Jan 2010 11:15:00 +0000
Subject: [PATCH 2b/4 v2] ASoC: add support for the sh7722 Migo-R board
Message-Id: <Pine.LNX.4.64.1001271211420.5073@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1001221909050.4652@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1001221909050.4652@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, Magnus Damm <damm@opensource.se>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-sh@vger.kernel.org

Add support for audio on sh7722-based Migo-R boards, using SIU and wm8978 
codec, recording via external microphone and playback via headphones are 
implemented.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v2 -> v3:

1. adjusted to the new wm8978 clocking scheme
2. added .hw_free() to switch off PLL

diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index 8072a6d..a86696b 100644
--- a/sound/soc/sh/Kconfig
+++ b/sound/soc/sh/Kconfig
@@ -55,4 +61,12 @@ config SND_FSI_DA7210
 	  This option enables generic sound support for the
 	  FSI - DA7210 unit
 
+config SND_SIU_MIGOR
+	tristate "SIU sound support on Migo-R"
+	depends on SH_MIGOR
+	select SND_SOC_SH4_SIU
+	select SND_SOC_WM8978
+	help
+	  This option enables sound support for the SH7722 Migo-R board
+
 endmenu
diff --git a/sound/soc/sh/Makefile b/sound/soc/sh/Makefile
index 1d0ec0a..8a5a192 100644
--- a/sound/soc/sh/Makefile
+++ b/sound/soc/sh/Makefile
@@ -16,7 +16,9 @@ obj-$(CONFIG_SND_SOC_PCM_SH7760)	+= snd-soc-dma-sh7760.o
 snd-soc-sh7760-ac97-objs	:= sh7760-ac97.o
 snd-soc-fsi-ak4642-objs		:= fsi-ak4642.o
 snd-soc-fsi-da7210-objs		:= fsi-da7210.o
+snd-soc-migor-objs		:= migor.o
 
 obj-$(CONFIG_SND_SH7760_AC97)	+= snd-soc-sh7760-ac97.o
 obj-$(CONFIG_SND_FSI_AK4642)	+= snd-soc-fsi-ak4642.o
 obj-$(CONFIG_SND_FSI_DA7210)	+= snd-soc-fsi-da7210.o
+obj-$(CONFIG_SND_SIU_MIGOR)	+= snd-soc-migor.o
diff --git a/sound/soc/sh/migor.c b/sound/soc/sh/migor.c
new file mode 100644
index 0000000..3ccd9b3
--- /dev/null
+++ b/sound/soc/sh/migor.c
@@ -0,0 +1,222 @@
+/*
+ * ALSA SoC driver for Migo-R
+ *
+ * Copyright (C) 2009-2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/device.h>
+#include <linux/firmware.h>
+#include <linux/module.h>
+
+#include <asm/clock.h>
+
+#include <cpu/sh7722.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include "../codecs/wm8978.h"
+#include "siu.h"
+
+/* Default 8000Hz sampling frequency */
+static unsigned long codec_freq = 8000 * 512;
+
+static unsigned int use_count;
+
+/* External clock, sourced from the codec at the SIUMCKB pin */
+static unsigned long siumckb_recalc(struct clk *clk)
+{
+	return codec_freq;
+}
+
+static struct clk_ops siumckb_clk_ops = {
+	.recalc = siumckb_recalc,
+};
+
+static struct clk siumckb_clk = {
+	.name		= "siumckb_clk",
+	.id		= -1,
+	.ops		= &siumckb_clk_ops,
+	.rate		= 0, /* initialised at run-time */
+};
+
+static int migor_hw_params(struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	int ret;
+	unsigned int rate = params_rate(params);
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8978_PLL, 13000000,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8978_DACCLK, 8);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8978_OPCLKRATE, rate * 512);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_NB_IF |
+				  SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_fmt(rtd->dai->cpu_dai, SND_SOC_DAIFMT_NB_IF |
+				  SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	codec_freq = rate * 512;
+	/*
+	 * This propagates the parent frequency change to children and
+	 * recalculates the frequency table
+	 */
+	clk_set_rate(&siumckb_clk, codec_freq);
+	dev_dbg(codec_dai->dev, "%s: configure %luHz\n", __func__, codec_freq);
+
+	ret = snd_soc_dai_set_sysclk(rtd->dai->cpu_dai, SIU_CLKB_EXT,
+				     codec_freq / 2, SND_SOC_CLOCK_IN);
+
+	if (!ret)
+		use_count++;
+
+	return ret;
+}
+
+static int migor_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+
+	if (use_count) {
+		use_count--;
+
+		if (!use_count)
+			snd_soc_dai_set_sysclk(codec_dai, WM8978_PLL, 0,
+					       SND_SOC_CLOCK_IN);
+	} else {
+		dev_dbg(codec_dai->dev, "Unbalanced hw_free!\n");
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops migor_dai_ops = {
+	.hw_params = migor_hw_params,
+	.hw_free = migor_hw_free,
+};
+
+static const struct snd_soc_dapm_widget migor_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_MIC("Onboard Microphone", NULL),
+	SND_SOC_DAPM_MIC("External Microphone", NULL),
+};
+
+static const struct snd_soc_dapm_route audio_map[] = {
+	/* Headphone output connected to LHP/RHP, enable OUT4 for VMID */
+	{ "Headphone", NULL,  "OUT4 VMID" },
+	{ "OUT4 VMID", NULL,  "LHP" },
+	{ "OUT4 VMID", NULL,  "RHP" },
+
+	/* On-board microphone */
+	{ "RMICN", NULL, "Mic Bias" },
+	{ "RMICP", NULL, "Mic Bias" },
+	{ "Mic Bias", NULL, "Onboard Microphone" },
+
+	/* External microphone */
+	{ "LMICN", NULL, "Mic Bias" },
+	{ "LMICP", NULL, "Mic Bias" },
+	{ "Mic Bias", NULL, "External Microphone" },
+};
+
+static int migor_dai_init(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_new_controls(codec, migor_dapm_widgets,
+				  ARRAY_SIZE(migor_dapm_widgets));
+
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+
+	return 0;
+}
+
+/* migor digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link migor_dai = {
+	.name = "wm8978",
+	.stream_name = "WM8978",
+	.cpu_dai = &siu_i2s_dai,
+	.codec_dai = &wm8978_dai,
+	.ops = &migor_dai_ops,
+	.init = migor_dai_init,
+};
+
+/* migor audio machine driver */
+static struct snd_soc_card snd_soc_migor = {
+	.name = "Migo-R",
+	.platform = &siu_platform,
+	.dai_link = &migor_dai,
+	.num_links = 1,
+};
+
+/* migor audio subsystem */
+static struct snd_soc_device migor_snd_devdata = {
+	.card = &snd_soc_migor,
+	.codec_dev = &soc_codec_dev_wm8978,
+};
+
+static struct platform_device *migor_snd_device;
+
+static int __init migor_init(void)
+{
+	int ret;
+
+	ret = clk_register(&siumckb_clk);
+	if (ret < 0)
+		return ret;
+
+	/* Port number used on this machine: port B */
+	migor_snd_device = platform_device_alloc("soc-audio", 1);
+	if (!migor_snd_device) {
+		ret = -ENOMEM;
+		goto epdevalloc;
+	}
+
+	platform_set_drvdata(migor_snd_device, &migor_snd_devdata);
+
+	migor_snd_devdata.dev = &migor_snd_device->dev;
+
+	ret = platform_device_add(migor_snd_device);
+	if (ret)
+		goto epdevadd;
+
+	return 0;
+
+epdevadd:
+	platform_device_put(migor_snd_device);
+epdevalloc:
+	clk_unregister(&siumckb_clk);
+	return ret;
+}
+
+static void __exit migor_exit(void)
+{
+	clk_unregister(&siumckb_clk);
+	platform_device_unregister(migor_snd_device);
+}
+
+module_init(migor_init);
+module_exit(migor_exit);
+
+MODULE_AUTHOR("Guennadi Liakhovetski <g.liakhovetski@gmx.de>");
+MODULE_DESCRIPTION("ALSA SoC Migor");
+MODULE_LICENSE("GPL v2");
