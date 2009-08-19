From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 19 Aug 2009 11:25:24 +0000
Subject: [PATCH 2/3] Add ak464x codec support
Message-Id: <uk51059ln.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, broonie@opensource.wolfsonmicro.com

This is very simple driver for ALSA
It supprt headphone output and stereo input only

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 sound/soc/codecs/Kconfig  |    4 +
 sound/soc/codecs/Makefile |    2 +
 sound/soc/codecs/ak464x.c |  525 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ak464x.h |   25 +++
 4 files changed, 556 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/ak464x.c
 create mode 100644 sound/soc/codecs/ak464x.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index bbc97fd..f66689c 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -16,6 +16,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_AD73311 if I2C
 	select SND_SOC_AK4104 if SPI_MASTER
 	select SND_SOC_AK4535 if I2C
+	select SND_SOC_AK464X if I2C
 	select SND_SOC_CS4270 if I2C
 	select SND_SOC_PCM3008
 	select SND_SOC_SPDIF
@@ -74,6 +75,9 @@ config SND_SOC_AK4104
 config SND_SOC_AK4535
 	tristate
 
+config SND_SOC_AK464X
+	tristate
+
 # Cirrus Logic CS4270 Codec
 config SND_SOC_CS4270
 	tristate
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 8b75305..4400ad4 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -3,6 +3,7 @@ snd-soc-ad1980-objs := ad1980.o
 snd-soc-ad73311-objs := ad73311.o
 snd-soc-ak4104-objs := ak4104.o
 snd-soc-ak4535-objs := ak4535.o
+snd-soc-ak464x-objs := ak464x.o
 snd-soc-cs4270-objs := cs4270.o
 snd-soc-l3-objs := l3.o
 snd-soc-pcm3008-objs := pcm3008.o
@@ -40,6 +41,7 @@ obj-$(CONFIG_SND_SOC_AD1980)	+= snd-soc-ad1980.o
 obj-$(CONFIG_SND_SOC_AD73311) += snd-soc-ad73311.o
 obj-$(CONFIG_SND_SOC_AK4104)	+= snd-soc-ak4104.o
 obj-$(CONFIG_SND_SOC_AK4535)	+= snd-soc-ak4535.o
+obj-$(CONFIG_SND_SOC_AK464X)	+= snd-soc-ak464x.o
 obj-$(CONFIG_SND_SOC_CS4270)	+= snd-soc-cs4270.o
 obj-$(CONFIG_SND_SOC_L3)	+= snd-soc-l3.o
 obj-$(CONFIG_SND_SOC_PCM3008)	+= snd-soc-pcm3008.o
diff --git a/sound/soc/codecs/ak464x.c b/sound/soc/codecs/ak464x.c
new file mode 100644
index 0000000..d2ef80d
--- /dev/null
+++ b/sound/soc/codecs/ak464x.c
@@ -0,0 +1,525 @@
+/*
+ * ak464x.c  --  AK464x ALSA Soc Audio driver
+ *
+ * Copyright (C) 2009 Renesas Solutions Corp.
+ * Kuninori Morimoto <morimoto.kuninori@renesas.com>
+ *
+ * Based of ak4535.c
+ *
+ * Copyright 2005 Openedhand Ltd.
+ * Author: Richard Purdie <richard@openedhand.com>
+ *
+ * Based on wm8753.c by Liam Girdwood
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/* ** CAUTION **
+ *
+ * This is very simple driver.
+ * It is able to use headphone output
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+
+#include "ak464x.h"
+
+#define AK464X_VERSION "0.0.1"
+
+#define PW_MGMT1	0x00
+#define PW_MGMT2	0x01
+#define SG_SL1		0x02
+#define SG_SL2		0x03
+#define MD_CTL1		0x04
+#define MD_CTL2		0x05
+#define TIMER		0x06
+#define ALC_CTL1	0x07
+#define ALC_CTL2	0x08
+#define L_IVC		0x09
+#define L_DVC		0x0a
+#define ALC_CTL3	0x0b
+#define R_IVC		0x0c
+#define R_DVC		0x0d
+#define MD_CTL3		0x0e
+#define MD_CTL4		0x0f
+#define PW_MGMT3	0x10
+#define DF_S		0x11
+#define FIL3_0		0x12
+#define FIL3_1		0x13
+#define FIL3_2		0x14
+#define FIL3_3		0x15
+#define EQ_0		0x16
+#define EQ_1		0x17
+#define EQ_2		0x18
+#define EQ_3		0x19
+#define EQ_4		0x1a
+#define EQ_5		0x1b
+#define FIL1_0		0x1c
+#define FIL1_1		0x1d
+#define FIL1_2		0x1e
+#define FIL1_3		0x1f
+#define PW_MGMT4	0x20
+#define MD_CTL5		0x21
+#define LO_MS		0x22
+#define HP_MS		0x23
+#define SPK_MS		0x24
+
+#define AK464X_CACHEREGNUM 	0x25
+
+#define DPRINTK(param...) printk(param)
+
+struct snd_soc_codec_device soc_codec_dev_ak464x;
+
+/* codec private data */
+struct ak464x_priv {
+	unsigned int sysclk;
+};
+
+/*
+ * ak464x register cache
+ */
+static const u16 ak464x_reg[AK464X_CACHEREGNUM] = {
+    0x0000, 0x0000, 0x0001, 0x0000,
+    0x0002, 0x0000, 0x0000, 0x0000,
+    0x00e1, 0x00e1, 0x0018, 0x0000,
+    0x00e1, 0x0018, 0x0011, 0x0008,
+    0x0000, 0x0000, 0x0000, 0x0000,
+    0x0000, 0x0000, 0x0000, 0x0000,
+    0x0000, 0x0000, 0x0000, 0x0000,
+    0x0000, 0x0000, 0x0000, 0x0000,
+    0x0000, 0x0000, 0x0000, 0x0000,
+    0x0000,
+};
+
+/*
+ * read ak464x register cache
+ */
+static inline unsigned int ak464x_read_reg_cache(struct snd_soc_codec *codec,
+	unsigned int reg)
+{
+	u16 *cache = codec->reg_cache;
+	if (reg >= AK464X_CACHEREGNUM)
+		return -1;
+	return cache[reg];
+}
+
+static inline unsigned int ak464x_read(struct snd_soc_codec *codec,
+	unsigned int reg)
+{
+	u8 data;
+	data = reg;
+
+	if (codec->hw_write(codec->control_data, &data, 1) != 1)
+		return -EIO;
+
+	if (codec->hw_read(codec->control_data, &data, 1) != 1)
+		return -EIO;
+
+	return data;
+};
+
+/*
+ * write ak464x register cache
+ */
+static inline void ak464x_write_reg_cache(struct snd_soc_codec *codec,
+	u16 reg, unsigned int value)
+{
+	u16 *cache = codec->reg_cache;
+	if (reg >= AK464X_CACHEREGNUM)
+		return;
+
+	cache[reg] = value;
+}
+
+/*
+ * write to the AK464X register space
+ */
+static int ak464x_write(struct snd_soc_codec *codec, unsigned int reg,
+	unsigned int value)
+{
+	u8 data[2];
+
+	/* data is
+	 *   D15..D8 AK464X register
+	 *   D7...D0 register data
+	 */
+	data[0] = reg & 0xff;
+	data[1] = value & 0xff;
+
+	if (codec->hw_write(codec->control_data, data, 2) = 2) {
+		ak464x_write_reg_cache(codec, reg, value);
+		return 0;
+	} else
+		return -EIO;
+}
+
+static int ak464x_sync(struct snd_soc_codec *codec)
+{
+	u16 *cache = codec->reg_cache;
+	int i, r = 0;
+
+	for (i = 0; i < AK464X_CACHEREGNUM; i++)
+		r |= ak464x_write(codec, i, cache[i]);
+
+	return r;
+};
+
+static int ak464x_set_bias_level(struct snd_soc_codec *codec,
+				 enum snd_soc_bias_level level)
+{
+	codec->bias_level = level;
+	return 0;
+}
+
+static int ak464x_dai_startup(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *dai)
+{
+	int is_play = substream->stream = SNDRV_PCM_STREAM_PLAYBACK;
+	struct snd_soc_codec *codec = dai->codec;
+
+	if (is_play) {
+		/* start headphone output */
+		ak464x_write(codec, 0x0f, 0x09);
+		ak464x_write(codec, 0x0e, 0x19);
+		ak464x_write(codec, 0x09, 0x91);
+		ak464x_write(codec, 0x0c, 0x91);
+		ak464x_write(codec, 0x0a, 0x28);
+		ak464x_write(codec, 0x0d, 0x28);
+		ak464x_write(codec, 0x00, 0x64);
+		ak464x_write(codec, 0x01, 0x3b);
+		ak464x_write(codec, 0x01, 0x7b);
+	} else {
+		/* start stereo input */
+		ak464x_write(codec, 0x02, 0x05);
+		ak464x_write(codec, 0x06, 0x3c);
+		ak464x_write(codec, 0x08, 0xe1);
+		ak464x_write(codec, 0x0b, 0x00);
+		ak464x_write(codec, 0x07, 0x21);
+		ak464x_write(codec, 0x00, 0x41);
+		ak464x_write(codec, 0x10, 0x01);
+	}
+
+	return 0;
+}
+
+static void ak464x_dai_shutdown(struct snd_pcm_substream *substream,
+			       struct snd_soc_dai *dai)
+{
+	int is_play = substream->stream = SNDRV_PCM_STREAM_PLAYBACK;
+	struct snd_soc_codec *codec = dai->codec;
+
+	if (is_play) {
+		/* stop headphone output */
+		ak464x_write(codec, 0x01, 0x3b);
+		ak464x_write(codec, 0x01, 0x0b);
+		ak464x_write(codec, 0x00, 0x40);
+		ak464x_write(codec, 0x0e, 0x11);
+		ak464x_write(codec, 0x0f, 0x08);
+	} else {
+		/* stop stereo input */
+		ak464x_write(codec, 0x00, 0x40);
+		ak464x_write(codec, 0x10, 0x00);
+		ak464x_write(codec, 0x07, 0x01);
+	}
+}
+
+static int ak464x_dai_set_sysclk(struct snd_soc_dai *codec_dai,
+	int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct ak464x_priv *ak464x = codec->private_data;
+
+	ak464x->sysclk = freq;
+	return 0;
+}
+
+static struct snd_soc_dai_ops ak464x_dai_ops = {
+	.startup	= ak464x_dai_startup,
+	.shutdown	= ak464x_dai_shutdown,
+	.set_sysclk	= ak464x_dai_set_sysclk,
+};
+
+struct snd_soc_dai ak464x_dai = {
+	.name = "AK464X",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,},
+	.ops = &ak464x_dai_ops,
+};
+EXPORT_SYMBOL_GPL(ak464x_dai);
+
+static int ak464x_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->card->codec;
+
+	ak464x_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	return 0;
+}
+
+static int ak464x_resume(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->card->codec;
+
+	ak464x_sync(codec);
+	ak464x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	ak464x_set_bias_level(codec, codec->suspend_bias_level);
+	return 0;
+}
+
+/*
+ * initialise the AK464X driver
+ * register the mixer and dsp interfaces with the kernel
+ */
+static int ak464x_init(struct snd_soc_device *socdev)
+{
+	struct snd_soc_codec *codec = socdev->card->codec;
+	int ret = 0;
+
+	codec->name		= "AK464X";
+	codec->owner		= THIS_MODULE;
+	codec->read		= ak464x_read_reg_cache;
+	codec->write		= ak464x_write;
+	codec->set_bias_level	= ak464x_set_bias_level;
+	codec->dai		= &ak464x_dai;
+	codec->num_dai		= 1;
+	codec->reg_cache_size	= ARRAY_SIZE(ak464x_reg);
+	codec->reg_cache	= kmemdup(ak464x_reg,
+					  sizeof(ak464x_reg), GFP_KERNEL);
+
+	if (!codec->reg_cache)
+		return -ENOMEM;
+
+	/* register pcms */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		printk(KERN_ERR "ak464x: failed to create pcms\n");
+		goto pcm_err;
+	}
+
+	/* power on device */
+	ak464x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
+	ret = snd_soc_init_card(socdev);
+	if (ret < 0) {
+		printk(KERN_ERR "ak464x: failed to register card\n");
+		goto card_err;
+	}
+
+	/* clock setting */
+	ak464x_write(codec, 0x01, 0x08);
+	ak464x_write(codec, 0x04, 0x4a);
+	ak464x_write(codec, 0x05, 0x27);
+	ak464x_write(codec, 0x00, 0x40);
+	ak464x_write(codec, 0x01, 0x0b);
+
+	return ret;
+
+card_err:
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+pcm_err:
+	kfree(codec->reg_cache);
+
+	return ret;
+}
+
+static struct snd_soc_device *ak464x_socdev;
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+
+static int ak464x_i2c_probe(struct i2c_client *i2c,
+			    const struct i2c_device_id *id)
+{
+	struct snd_soc_device *socdev = ak464x_socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	int ret;
+
+	i2c_set_clientdata(i2c, codec);
+	codec->control_data = i2c;
+
+	ret = ak464x_init(socdev);
+	if (ret < 0)
+		printk(KERN_ERR "failed to initialise AK464X\n");
+
+	return ret;
+}
+
+static int ak464x_i2c_remove(struct i2c_client *client)
+{
+	struct snd_soc_codec *codec = i2c_get_clientdata(client);
+	kfree(codec->reg_cache);
+	return 0;
+}
+
+static const struct i2c_device_id ak464x_i2c_id[] = {
+	{ "ak464x", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ak464x_i2c_id);
+
+static struct i2c_driver ak464x_i2c_driver = {
+	.driver = {
+		.name = "AK464X I2C Codec",
+		.owner = THIS_MODULE,
+	},
+	.probe		= ak464x_i2c_probe,
+	.remove		= ak464x_i2c_remove,
+	.id_table	= ak464x_i2c_id,
+};
+
+static int ak464x_add_i2c_device(struct platform_device *pdev,
+				 const struct ak464x_setup_data *setup)
+{
+	struct i2c_board_info info;
+	struct i2c_adapter *adapter;
+	struct i2c_client *client;
+	int ret;
+
+	ret = i2c_add_driver(&ak464x_i2c_driver);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "can't add i2c driver\n");
+		return ret;
+	}
+
+	memset(&info, 0, sizeof(struct i2c_board_info));
+	info.addr = setup->i2c_address;
+	strlcpy(info.type, "ak464x", I2C_NAME_SIZE);
+
+	adapter = i2c_get_adapter(setup->i2c_bus);
+	if (!adapter) {
+		dev_err(&pdev->dev, "can't get i2c adapter %d\n",
+			setup->i2c_bus);
+		goto err_driver;
+	}
+
+	client = i2c_new_device(adapter, &info);
+	i2c_put_adapter(adapter);
+	if (!client) {
+		dev_err(&pdev->dev, "can't add i2c device at 0x%x\n",
+			(unsigned int)info.addr);
+		goto err_driver;
+	}
+
+	return 0;
+
+err_driver:
+	i2c_del_driver(&ak464x_i2c_driver);
+	return -ENODEV;
+}
+#endif
+
+static int ak464x_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct ak464x_setup_data *setup;
+	struct snd_soc_codec *codec;
+	struct ak464x_priv *ak464x;
+	int ret;
+
+	printk(KERN_INFO "AK464X Audio Codec %s", AK464X_VERSION);
+
+	setup = socdev->codec_data;
+	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
+	if (codec = NULL)
+		return -ENOMEM;
+
+	ak464x = kzalloc(sizeof(struct ak464x_priv), GFP_KERNEL);
+	if (ak464x = NULL) {
+		kfree(codec);
+		return -ENOMEM;
+	}
+
+	codec->private_data = ak464x;
+	socdev->card->codec = codec;
+	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	ak464x_socdev = socdev;
+	ret = -ENODEV;
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	if (setup->i2c_address) {
+		codec->hw_write = (hw_write_t)i2c_master_send;
+		codec->hw_read = (hw_read_t)i2c_master_recv;
+		ret = ak464x_add_i2c_device(pdev, setup);
+	}
+#endif
+
+	if (ret != 0) {
+		kfree(codec->private_data);
+		kfree(codec);
+	}
+
+	return ret;
+}
+
+/* power down chip */
+static int ak464x_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->card->codec;
+
+	if (codec->control_data)
+		ak464x_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	i2c_unregister_device(codec->control_data);
+	i2c_del_driver(&ak464x_i2c_driver);
+#endif
+	kfree(codec->private_data);
+	kfree(codec);
+
+	return 0;
+}
+
+struct snd_soc_codec_device soc_codec_dev_ak464x = {
+	.probe =	ak464x_probe,
+	.remove =	ak464x_remove,
+	.suspend =	ak464x_suspend,
+	.resume =	ak464x_resume,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_ak464x);
+
+static int __init ak464x_modinit(void)
+{
+	return snd_soc_register_dai(&ak464x_dai);
+}
+module_init(ak464x_modinit);
+
+static void __exit ak464x_exit(void)
+{
+	snd_soc_unregister_dai(&ak464x_dai);
+}
+module_exit(ak464x_exit);
+
+MODULE_DESCRIPTION("Soc AK464x driver");
+MODULE_AUTHOR("Kuninori Morimoto <morimoto.kuninori@renesas.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/ak464x.h b/sound/soc/codecs/ak464x.h
new file mode 100644
index 0000000..07cd1bf
--- /dev/null
+++ b/sound/soc/codecs/ak464x.h
@@ -0,0 +1,25 @@
+/*
+ * ak464x.h  --  AK464x Soc Audio driver
+ *
+ * Copyright (C) 2009 Renesas Solutions Corp.
+ * Kuninori Morimoto <morimoto.kuninori@renesas.com>
+ *
+ * Based of ak4535.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _AK464X_H
+#define _AK464X_H
+
+struct ak464x_setup_data {
+	int            i2c_bus;
+	unsigned short i2c_address;
+};
+
+extern struct snd_soc_dai ak464x_dai;
+extern struct snd_soc_codec_device soc_codec_dev_ak464x;
+
+#endif
-- 
1.6.0.4

