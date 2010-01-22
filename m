From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 22 Jan 2010 18:17:09 +0000
Subject: [PATCH 2b/4 v2] ASoC: add support for the sh7722 Migo-R board
Message-Id: <Pine.LNX.4.64.1001221909050.4652@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1001190839110.4607@axis700.grange>
	<Pine.LNX.4.64.1001190902000.4607@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1001190902000.4607@axis700.grange>
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

v1 -> v2:

1. separated from core SIU patch
2. now selecting SND_SOC_SH4_SIU instead of depending on it
3. moved most of clocking calculations / configuration into the codec 
   driver, also removed confusing comments
4. refactored calculations, based on input frequency and output frequency 
   requirement, instead of internal codec knowledge
5. added datasheet revision - now in the actual codec driver
6. removed reconfiguring codec PLL in migor_hw_free() and consequently 
   removed migor_hw_free() altogether
7. removed hard-coded pin-enabling, now managed by DAPM
8. added widgets and an audio map to supportautomatic routing 
   configuration and other DAPM functions

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
@@ -6,7 +6,9 @@ obj-$(CONFIG_SND_SOC_PCM_SH7760)	+= snd-soc-dma-sh7760.o
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
index 0000000..cae832d
--- /dev/null
+++ b/sound/soc/sh/migor.c
@@ -0,0 +1,227 @@
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
+	unsigned int opclk_div;
+	int ret;
+	unsigned int rate = params_rate(params);
+
+	/* Configure f_out = rate * 512 */
+	switch (rate) {
+	case 48000:
+		opclk_div = 0;
+		break;
+	case 44100:
+		opclk_div = 0;
+		break;
+	case 32000:
+		opclk_div = 0x010;
+		break;
+	case 24000:
+		opclk_div = 0x010;
+		break;
+	case 22050:
+		opclk_div = 0x010;
+		break;
+	case 16000:
+		opclk_div = 0x020;
+		break;
+	case 11025:
+		opclk_div = 0x010;
+		break;
+	default:
+	case 8000:
+		opclk_div = 0x020;
+		break;
+	}
+
+	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8978_OPCLKDIV, opclk_div);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8978_DACCLK, 8);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_pll(codec_dai, 0, 0, 13000000, rate * 512);
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
+	snd_soc_dai_set_sysclk(rtd->dai->cpu_dai, SIU_CLKB_EXT, codec_freq / 2,
+			       SND_SOC_CLOCK_IN);
+
+	return ret;
+}
+
+static struct snd_soc_ops migor_dai_ops = {
+	.hw_params = migor_hw_params,
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
