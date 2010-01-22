From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 22 Jan 2010 16:27:53 +0000
Subject: [PATCH 1/4 v2] ASoC: add a WM8978 codec driver
Message-Id: <Pine.LNX.4.64.1001221659410.4652@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1001190839110.4607@axis700.grange>
 <Pine.LNX.4.64.1001190851380.4607@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1001190851380.4607@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org
Cc: linux-sh@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus Damm <damm@opensource.se>

The WM8978 codec from Wolfson Microelectronics is very similar to wm8974, but
is stereo and also has some differences in pin configuration and internal
signal routing. This driver is based on wm8974 and takes the differences into
account.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v1 -> v2:

1. changed HeadPhone to Headphone
2. using global simplified macros from two patches posted earlier
3. removed power-related operations from wm8978_hw_params()
4. register-cache: removed misleading comments, removed "update" bits, 
   they are set now in a dynamically-created copy
5. moved entries from wm8978_enum[] array into individual variables
6. adjusted control names
7. removed unused wm8978_aux_boost_controls[] and 
   wm8978_mic_boost_controls[]
8. moved setting GPIO1 to clock output to OPCLK configuration in 
   wm8978_set_dai_clkdiv()
9. multiple improvements to controls, widgets, audio-map to actually 
   enable automatic hardware configuration by DAPM
10. using SNDRV_PCM_RATE_8000_48000 now
11. removed "if (!codec->card)" tests
12. in wm8978_resume() only copying modified registers, using 
    snd_soc_write() instead of open-codying.

In short - addressed all comments (thanks a lot again!) - except one... I 
still would not like to use symbolic names for register bits. Instead I 
thoroughly commented all multi-bit register manipulations. Reasons:

1. thanks for the header, Mark, but unfortunately it contains errors 
   (duplicate register names, duplicate and wrong bitfield names)
2. the header also uses spaces for indentation, which would have to be 
   manually replaced with TABs
3. I am still not convinced, that macro names like WM8978_WL or 
   WM8978_DLRSWAP or WM8978_MS or... better describe the meaning of the 
   bitfield than respective comment in the source. Here's an example of a 
   comment from this patch:

	/* bit 3: enable bias, bit 2: enable I/O tie off buffer */
	power1 |= 0xc;

   Where bit-field names do make sense, IMHO, is in drivers, where the 
   same bitfields have to be written / evaluated multiple times at 
   different locations. Than indeed giving those bits symbolic names helps 
   finding them. So, I'd like to request a permission to preserve the 
   present style of the driver.

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 62ff26a..0aad72f 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -57,6 +57,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_WM8961 if I2C
 	select SND_SOC_WM8971 if I2C
 	select SND_SOC_WM8974 if I2C
+	select SND_SOC_WM8978 if I2C
 	select SND_SOC_WM8988 if SND_SOC_I2C_AND_SPI
 	select SND_SOC_WM8990 if I2C
 	select SND_SOC_WM8993 if I2C
@@ -230,6 +231,9 @@ config SND_SOC_WM8971
 config SND_SOC_WM8974
 	tristate
 
+config SND_SOC_WM8978
+	tristate
+
 config SND_SOC_WM8988
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index ea98354..fbd290e 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -44,6 +44,7 @@ snd-soc-wm8960-objs := wm8960.o
 snd-soc-wm8961-objs := wm8961.o
 snd-soc-wm8971-objs := wm8971.o
 snd-soc-wm8974-objs := wm8974.o
+snd-soc-wm8978-objs := wm8978.o
 snd-soc-wm8988-objs := wm8988.o
 snd-soc-wm8990-objs := wm8990.o
 snd-soc-wm8993-objs := wm8993.o
@@ -103,6 +104,7 @@ obj-$(CONFIG_SND_SOC_WM8960)	+= snd-soc-wm8960.o
 obj-$(CONFIG_SND_SOC_WM8961)	+= snd-soc-wm8961.o
 obj-$(CONFIG_SND_SOC_WM8971)	+= snd-soc-wm8971.o
 obj-$(CONFIG_SND_SOC_WM8974)	+= snd-soc-wm8974.o
+obj-$(CONFIG_SND_SOC_WM8978)	+= snd-soc-wm8978.o
 obj-$(CONFIG_SND_SOC_WM8988)	+= snd-soc-wm8988.o
 obj-$(CONFIG_SND_SOC_WM8990)	+= snd-soc-wm8990.o
 obj-$(CONFIG_SND_SOC_WM8993)	+= snd-soc-wm8993.o
diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
new file mode 100644
index 0000000..1ca2377
--- /dev/null
+++ b/sound/soc/codecs/wm8978.c
@@ -0,0 +1,988 @@
+/*
+ * wm8978.c  --  WM8978 ALSA SoC Audio Codec driver
+ *
+ * Copyright (C) 2009-2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
+ * Copyright (C) 2007 Carlos Munoz <carlos@kenati.com>
+ * Copyright 2006-2009 Wolfson Microelectronics PLC.
+ * Based on wm8974 and wm8990 by Liam Girdwood <lrg@slimlogic.co.uk>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/kernel.h>
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
+#include <sound/tlv.h>
+#include <asm/div64.h>
+
+#include "wm8978.h"
+
+static struct snd_soc_codec *wm8978_codec;
+
+/* wm8978 register cache. Note that register 0 is not included in the cache. */
+static const u16 wm8978_reg[WM8978_CACHEREGNUM] = {
+	0x0000, 0x0000, 0x0000, 0x0000,	/* 0x00...0x03 */
+	0x0050, 0x0000, 0x0140, 0x0000,	/* 0x04...0x07 */
+	0x0000, 0x0000, 0x0000, 0x00ff,	/* 0x08...0x0b */
+	0x00ff, 0x0000, 0x0100, 0x00ff,	/* 0x0c...0x0f */
+	0x00ff, 0x0000, 0x012c, 0x002c,	/* 0x10...0x13 */
+	0x002c, 0x002c, 0x002c, 0x0000,	/* 0x14...0x17 */
+	0x0032, 0x0000, 0x0000, 0x0000,	/* 0x18...0x1b */
+	0x0000, 0x0000, 0x0000, 0x0000,	/* 0x1c...0x1f */
+	0x0038, 0x000b, 0x0032, 0x0000,	/* 0x20...0x23 */
+	0x0008, 0x000c, 0x0093, 0x00e9,	/* 0x24...0x27 */
+	0x0000, 0x0000, 0x0000, 0x0000,	/* 0x28...0x2b */
+	0x0033, 0x0010, 0x0010, 0x0100,	/* 0x2c...0x2f */
+	0x0100, 0x0002, 0x0001, 0x0001,	/* 0x30...0x33 */
+	0x0039, 0x0039, 0x0039, 0x0039,	/* 0x34...0x37 */
+	0x0001,	0x0001,			/* 0x38...0x3b */
+};
+
+static const int update_reg[] = {
+	0xb, 0xc, 0xf, 0x10, 0x2d, 0x2e, 0x34, 0x35, 0x36, 0x37
+};
+
+/* codec private data */
+struct wm8978_priv {
+	struct snd_soc_codec codec;
+	unsigned int f_pllout;
+	u16 reg_cache[WM8978_CACHEREGNUM];
+};
+
+static const char *wm8978_companding[] = {"Off", "NC", "u-law", "A-law"};
+static const char *wm8978_eqmode[] = {"Capture", "Playback"};
+static const char *wm8978_bw[] = {"Narrow", "Wide"};
+static const char *wm8978_eq1[] = {"80Hz", "105Hz", "135Hz", "175Hz"};
+static const char *wm8978_eq2[] = {"230Hz", "300Hz", "385Hz", "500Hz"};
+static const char *wm8978_eq3[] = {"650Hz", "850Hz", "1.1kHz", "1.4kHz"};
+static const char *wm8978_eq4[] = {"1.8kHz", "2.4kHz", "3.2kHz", "4.1kHz"};
+static const char *wm8978_eq5[] = {"5.3kHz", "6.9kHz", "9kHz", "11.7kHz"};
+static const char *wm8978_alc3[] = {"ALC", "Limiter"};
+static const char *wm8978_alc1[] = {"Off", "Right", "Left", "Both"};
+
+static const SOC_ENUM_SINGLE_DECL(adc_compand, WM8978_COMPANDING_CONTROL, 1, wm8978_companding);
+static const SOC_ENUM_SINGLE_DECL(dac_compand, WM8978_COMPANDING_CONTROL, 3, wm8978_companding);
+static const SOC_ENUM_SINGLE_DECL(eqmode, WM8978_EQ1, 8, wm8978_eqmode);
+static const SOC_ENUM_SINGLE_DECL(eq1, WM8978_EQ1, 5, wm8978_eq1);
+static const SOC_ENUM_SINGLE_DECL(eq2bw, WM8978_EQ2, 8, wm8978_bw);
+static const SOC_ENUM_SINGLE_DECL(eq2, WM8978_EQ2, 5, wm8978_eq2);
+static const SOC_ENUM_SINGLE_DECL(eq3bw, WM8978_EQ3, 8, wm8978_bw);
+static const SOC_ENUM_SINGLE_DECL(eq3, WM8978_EQ3, 5, wm8978_eq3);
+static const SOC_ENUM_SINGLE_DECL(eq4bw, WM8978_EQ4, 8, wm8978_bw);
+static const SOC_ENUM_SINGLE_DECL(eq4, WM8978_EQ4, 5, wm8978_eq4);
+static const SOC_ENUM_SINGLE_DECL(eq5, WM8978_EQ5, 5, wm8978_eq5);
+static const SOC_ENUM_SINGLE_DECL(alc3, WM8978_ALC_CONTROL_3, 8, wm8978_alc3);
+static const SOC_ENUM_SINGLE_DECL(alc1, WM8978_ALC_CONTROL_1, 7, wm8978_alc1);
+
+static const DECLARE_TLV_DB_SCALE(digital_tlv, -12750, 50, 1);
+static const DECLARE_TLV_DB_SCALE(eq_tlv, -1200, 100, 0);
+static const DECLARE_TLV_DB_SCALE(inpga_tlv, -1200, 75, 0);
+static const DECLARE_TLV_DB_SCALE(spk_tlv, -5700, 100, 0);
+static const DECLARE_TLV_DB_SCALE(boost_tlv, -1500, 300, 1);
+
+static const struct snd_kcontrol_new wm8978_snd_controls[] = {
+
+	SOC_SINGLE("Digital Loopback Switch",
+		WM8978_COMPANDING_CONTROL, 0, 1, 0),
+
+	SOC_ENUM("ADC Companding", adc_compand),
+	SOC_ENUM("DAC Companding", dac_compand),
+
+	SOC_SINGLE("DAC Inversion Switch", WM8978_DAC_CONTROL, 0, 1, 0),
+
+	SOC_SINGLE_TLV("Left PCM Volume",
+		WM8978_LEFT_DAC_DIGITAL_VOLUME, 0, 255, 0, digital_tlv),
+	SOC_SINGLE_TLV("Right PCM Volume",
+		WM8978_RIGHT_DAC_DIGITAL_VOLUME, 0, 255, 0, digital_tlv),
+
+	SOC_SINGLE("High Pass Filter Switch", WM8978_ADC_CONTROL, 8, 1, 0),
+	SOC_SINGLE("High Pass Cut Off", WM8978_ADC_CONTROL, 4, 7, 0),
+	SOC_SINGLE("Left ADC Inversion Switch", WM8978_ADC_CONTROL, 0, 1, 0),
+	SOC_SINGLE("Right ADC Inversion Switch", WM8978_ADC_CONTROL, 1, 1, 0),
+
+	SOC_SINGLE_TLV("Left ADC Volume",
+	       WM8978_LEFT_ADC_DIGITAL_VOLUME, 0, 255, 0, digital_tlv),
+	SOC_SINGLE_TLV("Right ADC Volume",
+	       WM8978_RIGHT_ADC_DIGITAL_VOLUME, 0, 255, 0, digital_tlv),
+
+	SOC_ENUM("Equaliser Function", eqmode),
+	SOC_ENUM("EQ1 Cut Off", eq1),
+	SOC_SINGLE_TLV("EQ1 Volume", WM8978_EQ1,  0, 24, 1, eq_tlv),
+
+	SOC_ENUM("Equaliser EQ2 Bandwith", eq2bw),
+	SOC_ENUM("EQ2 Cut Off", eq2),
+	SOC_SINGLE_TLV("EQ2 Volume", WM8978_EQ2,  0, 24, 1, eq_tlv),
+
+	SOC_ENUM("Equaliser EQ3 Bandwith", eq3bw),
+	SOC_ENUM("EQ3 Cut Off", eq3),
+	SOC_SINGLE_TLV("EQ3 Volume", WM8978_EQ3,  0, 24, 1, eq_tlv),
+
+	SOC_ENUM("Equaliser EQ4 Bandwith", eq4bw),
+	SOC_ENUM("EQ4 Cut Off", eq4),
+	SOC_SINGLE_TLV("EQ4 Volume", WM8978_EQ4,  0, 24, 1, eq_tlv),
+
+	SOC_ENUM("EQ5 Cut Off", eq5),
+	SOC_SINGLE_TLV("EQ5 Volume", WM8978_EQ5, 0, 24, 1, eq_tlv),
+
+	SOC_SINGLE("DAC Playback Limiter Switch",
+		WM8978_DAC_LIMITER_1, 8, 1, 0),
+	SOC_SINGLE("DAC Playback Limiter Decay",
+		WM8978_DAC_LIMITER_1, 4, 15, 0),
+	SOC_SINGLE("DAC Playback Limiter Attack",
+		WM8978_DAC_LIMITER_1, 0, 15, 0),
+
+	SOC_SINGLE("DAC Playback Limiter Threshold",
+		WM8978_DAC_LIMITER_2, 4, 7, 0),
+	SOC_SINGLE("DAC Playback Limiter Boost",
+		WM8978_DAC_LIMITER_2, 0, 15, 0),
+
+	SOC_ENUM("ALC Enable Switch", alc1),
+	SOC_SINGLE("ALC Capture Max Gain", WM8978_ALC_CONTROL_1, 3, 7, 0),
+	SOC_SINGLE("ALC Capture Min Gain", WM8978_ALC_CONTROL_1, 0, 7, 0),
+
+	SOC_SINGLE("ALC Capture Hold", WM8978_ALC_CONTROL_2, 4, 7, 0),
+	SOC_SINGLE("ALC Capture Target", WM8978_ALC_CONTROL_2, 0, 15, 0),
+
+	SOC_ENUM("ALC Capture Mode", alc3),
+	SOC_SINGLE("ALC Capture Decay", WM8978_ALC_CONTROL_3, 4, 15, 0),
+	SOC_SINGLE("ALC Capture Attack", WM8978_ALC_CONTROL_3, 0, 15, 0),
+
+	SOC_SINGLE("ALC Capture Noise Gate Switch", WM8978_NOISE_GATE, 3, 1, 0),
+	SOC_SINGLE("ALC Capture Noise Gate Threshold",
+		WM8978_NOISE_GATE, 0, 7, 0),
+
+	SOC_SINGLE("Left Capture PGA ZC Switch",
+		WM8978_LEFT_INP_PGA_CONTROL, 7, 1, 0),
+	SOC_SINGLE("Right Capture PGA ZC Switch",
+		WM8978_RIGHT_INP_PGA_CONTROL, 7, 1, 0),
+
+	/* OUT1 - Headphones */
+	SOC_SINGLE("Left Headphone Playback ZC Switch",
+		WM8978_LOUT1_HP_CONTROL, 7, 1, 0),
+	SOC_SINGLE_TLV("Left Headphone Playback Volume",
+		WM8978_LOUT1_HP_CONTROL, 0, 63, 0, spk_tlv),
+
+	SOC_SINGLE("Right Headphone Playback ZC Switch",
+		WM8978_ROUT1_HP_CONTROL, 7, 1, 0),
+	SOC_SINGLE_TLV("Right Headphone Playback Volume",
+		WM8978_ROUT1_HP_CONTROL, 0, 63, 0, spk_tlv),
+
+	/* OUT2 - Speakers */
+	SOC_SINGLE("Left Speaker Playback ZC Switch",
+		WM8978_LOUT2_SPK_CONTROL, 7, 1, 0),
+	SOC_SINGLE_TLV("Left Speaker Playback Volume",
+		WM8978_LOUT2_SPK_CONTROL, 0, 63, 0, spk_tlv),
+
+	SOC_SINGLE("Right Speaker Playback ZC Switch",
+		WM8978_ROUT2_SPK_CONTROL, 7, 1, 0),
+	SOC_SINGLE_TLV("Right Speaker Playback Volume",
+		WM8978_ROUT2_SPK_CONTROL, 0, 63, 0, spk_tlv),
+
+	/* OUT3/4 - Line Output */
+	SOC_SINGLE("Left Line Playback Switch",
+		WM8978_OUT3_MIXER_CONTROL, 6, 1, 1),
+	SOC_SINGLE("Right Line Playback Switch",
+		WM8978_OUT4_MIXER_CONTROL, 6, 1, 1),
+};
+
+/* Mixer #1: Output (OUT1, OUT2) Mixer: mix AUX, Input mixer output and DAC */
+static const struct snd_kcontrol_new wm8978_left_out_mixer[] = {
+	SOC_DAPM_SINGLE("Line Bypass Switch", WM8978_LEFT_MIXER_CONTROL, 1, 1, 0),
+	SOC_DAPM_SINGLE("Aux Playback Switch", WM8978_LEFT_MIXER_CONTROL, 5, 1, 0),
+	SOC_DAPM_SINGLE("PCM Playback Switch", WM8978_LEFT_MIXER_CONTROL, 0, 1, 0),
+};
+
+static const struct snd_kcontrol_new wm8978_right_out_mixer[] = {
+	SOC_DAPM_SINGLE("Line Bypass Switch", WM8978_RIGHT_MIXER_CONTROL, 1, 1, 0),
+	SOC_DAPM_SINGLE("Aux Playback Switch", WM8978_RIGHT_MIXER_CONTROL, 5, 1, 0),
+	SOC_DAPM_SINGLE("PCM Playback Switch", WM8978_RIGHT_MIXER_CONTROL, 0, 1, 0),
+};
+
+/* OUT3/OUT4 Mixer not implemented */
+
+/* Mixer #2: Input PGA Mute */
+static const struct snd_kcontrol_new wm8978_left_input_pga[] = {
+	SOC_DAPM_SINGLE("L2 Switch", WM8978_INPUT_CONTROL, 2, 1, 0),
+	SOC_DAPM_SINGLE("MicN Switch", WM8978_INPUT_CONTROL, 1, 1, 0),
+	SOC_DAPM_SINGLE("MicP Switch", WM8978_INPUT_CONTROL, 0, 1, 0),
+};
+static const struct snd_kcontrol_new wm8978_right_input_pga[] = {
+	SOC_DAPM_SINGLE("R2 Switch", WM8978_INPUT_CONTROL, 6, 1, 0),
+	SOC_DAPM_SINGLE("MicN Switch", WM8978_INPUT_CONTROL, 5, 1, 0),
+	SOC_DAPM_SINGLE("MicP Switch", WM8978_INPUT_CONTROL, 4, 1, 0),
+};
+
+/* Mixer #3: Boost (Input) mixer */
+static const struct snd_kcontrol_new wm8978_left_boost_mixer[] = {
+
+	SOC_DAPM_SINGLE("PGA Boost (+20dB)",
+		WM8978_LEFT_ADC_BOOST_CONTROL, 8, 1, 0),
+	SOC_DAPM_SINGLE_TLV("L2 Boost Volume",
+		WM8978_LEFT_ADC_BOOST_CONTROL, 4, 7, 0, boost_tlv),
+	SOC_DAPM_SINGLE_TLV("Aux Boost Volume",
+		WM8978_LEFT_ADC_BOOST_CONTROL, 0, 7, 0, boost_tlv),
+};
+static const struct snd_kcontrol_new wm8978_right_boost_mixer[] = {
+
+	SOC_DAPM_SINGLE("PGA Boost (+20dB)",
+		WM8978_RIGHT_ADC_BOOST_CONTROL, 8, 1, 0),
+	SOC_DAPM_SINGLE_TLV("R2 Boost Volume",
+		WM8978_RIGHT_ADC_BOOST_CONTROL, 4, 7, 0, boost_tlv),
+	SOC_DAPM_SINGLE_TLV("Aux Boost Volume",
+		WM8978_RIGHT_ADC_BOOST_CONTROL, 0, 7, 0, boost_tlv),
+};
+
+/* Input PGA volume */
+static const struct snd_kcontrol_new wm8978_left_input_pga_volume[] = {
+	SOC_DAPM_SINGLE_TLV("Volume",
+		WM8978_LEFT_INP_PGA_CONTROL, 0, 63, 0, inpga_tlv),
+};
+static const struct snd_kcontrol_new wm8978_right_input_pga_volume[] = {
+	SOC_DAPM_SINGLE_TLV("Volume",
+		WM8978_RIGHT_INP_PGA_CONTROL, 0, 63, 0, inpga_tlv),
+};
+
+/* Headphone */
+static const struct snd_kcontrol_new wm8978_left_hp_mute[] = {
+	SOC_DAPM_SINGLE("Mute Switch", WM8978_LOUT1_HP_CONTROL, 6, 1, 1),
+};
+static const struct snd_kcontrol_new wm8978_right_hp_mute[] = {
+	SOC_DAPM_SINGLE("Mute Switch", WM8978_ROUT1_HP_CONTROL, 6, 1, 1),
+};
+
+/* Speaker */
+static const struct snd_kcontrol_new wm8978_left_speaker_mute[] = {
+	SOC_DAPM_SINGLE("Mute Switch", WM8978_LOUT2_SPK_CONTROL, 6, 1, 1),
+};
+static const struct snd_kcontrol_new wm8978_right_speaker_mute[] = {
+	SOC_DAPM_SINGLE("Mute Switch", WM8978_ROUT2_SPK_CONTROL, 6, 1, 1),
+};
+
+static const struct snd_soc_dapm_widget wm8978_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC("Left DAC", "Left HiFi Playback",
+		WM8978_POWER_MANAGEMENT_3, 0, 0),
+	SND_SOC_DAPM_DAC("Right DAC", "Right HiFi Playback",
+		WM8978_POWER_MANAGEMENT_3, 1, 0),
+	SND_SOC_DAPM_ADC("Left ADC", "Left HiFi Capture",
+		WM8978_POWER_MANAGEMENT_2, 0, 0),
+	SND_SOC_DAPM_ADC("Right ADC", "Right HiFi Capture",
+		WM8978_POWER_MANAGEMENT_2, 1, 0),
+
+	/* Mixer #1: OUT1,2 */
+	SOC_MIXER_ARRAY("Left Output Mixer", WM8978_POWER_MANAGEMENT_3, 2, 0,
+		   wm8978_left_out_mixer),
+	SOC_MIXER_ARRAY("Right Output Mixer", WM8978_POWER_MANAGEMENT_3, 3, 0,
+		   wm8978_right_out_mixer),
+
+	SOC_MIXER_ARRAY("Left Input PGA", WM8978_POWER_MANAGEMENT_2, 2, 0,
+		   wm8978_left_input_pga),
+	SOC_MIXER_ARRAY("Right Input PGA", WM8978_POWER_MANAGEMENT_2, 3, 0,
+		   wm8978_right_input_pga),
+
+	SOC_MIXER_ARRAY("Left Boost Mixer", WM8978_POWER_MANAGEMENT_2, 4, 0,
+		   wm8978_left_boost_mixer),
+	SOC_MIXER_ARRAY("Right Boost Mixer", WM8978_POWER_MANAGEMENT_2, 5, 0,
+		   wm8978_right_boost_mixer),
+
+	SND_SOC_DAPM_SWITCH("Left Capture PGA", WM8978_LEFT_INP_PGA_CONTROL, 6, 1,
+		   wm8978_left_input_pga_volume),
+	SND_SOC_DAPM_SWITCH("Right Capture PGA", WM8978_RIGHT_INP_PGA_CONTROL, 6, 1,
+		   wm8978_right_input_pga_volume),
+
+	SND_SOC_DAPM_SWITCH("Left Headphone Out", WM8978_POWER_MANAGEMENT_2, 7, 0,
+		   wm8978_left_hp_mute),
+	SND_SOC_DAPM_SWITCH("Right Headphone Out", WM8978_POWER_MANAGEMENT_2, 8, 0,
+		   wm8978_right_hp_mute),
+
+	SND_SOC_DAPM_SWITCH("Left Speaker Out", WM8978_POWER_MANAGEMENT_3, 6, 0,
+		   wm8978_left_speaker_mute),
+	SND_SOC_DAPM_SWITCH("Right Speaker Out", WM8978_POWER_MANAGEMENT_3, 5, 0,
+		   wm8978_right_speaker_mute),
+
+	SND_SOC_DAPM_MIXER("OUT4 VMID", WM8978_POWER_MANAGEMENT_3,
+			   8, 0, NULL, 0),
+
+	SND_SOC_DAPM_MICBIAS("Mic Bias", WM8978_POWER_MANAGEMENT_1, 4, 0),
+
+	SND_SOC_DAPM_INPUT("LMICN"),
+	SND_SOC_DAPM_INPUT("LMICP"),
+	SND_SOC_DAPM_INPUT("RMICN"),
+	SND_SOC_DAPM_INPUT("RMICP"),
+	SND_SOC_DAPM_INPUT("LAUX"),
+	SND_SOC_DAPM_INPUT("RAUX"),
+	SND_SOC_DAPM_INPUT("L2"),
+	SND_SOC_DAPM_INPUT("R2"),
+	SND_SOC_DAPM_OUTPUT("LHP"),
+	SND_SOC_DAPM_OUTPUT("RHP"),
+	SND_SOC_DAPM_OUTPUT("LSPK"),
+	SND_SOC_DAPM_OUTPUT("RSPK"),
+};
+
+static const struct snd_soc_dapm_route audio_map[] = {
+	/* Output mixer */
+	{"Right Output Mixer", "PCM Playback Switch", "Right DAC"},
+	{"Right Output Mixer", "Aux Playback Switch", "RAUX"},
+	{"Right Output Mixer", "Line Bypass Switch", "Right Boost Mixer"},
+
+	{"Left Output Mixer", "PCM Playback Switch", "Left DAC"},
+	{"Left Output Mixer", "Aux Playback Switch", "LAUX"},
+	{"Left Output Mixer", "Line Bypass Switch", "Left Boost Mixer"},
+
+	/* Outputs */
+	{"Right Headphone Out", "Mute Switch", "Right Output Mixer"},
+	{"RHP", NULL, "Right Headphone Out"},
+
+	{"Left Headphone Out", "Mute Switch", "Left Output Mixer"},
+	{"LHP", NULL, "Left Headphone Out"},
+
+	{"Right Speaker Out", "Mute Switch", "Right Output Mixer"},
+	{"RSPK", NULL, "Right Speaker Out"},
+
+	{"Left Speaker Out", "Mute Switch", "Left Output Mixer"},
+	{"LSPK", NULL, "Left Speaker Out"},
+
+	/* Boost Mixer */
+	{"Right ADC", NULL, "Right Boost Mixer"},
+
+	{"Right Boost Mixer", "Aux Boost Volume", "RAUX"},
+	{"Right Boost Mixer", "PGA Boost (+20dB)", "Right Capture PGA"},
+	{"Right Boost Mixer", "R2 Boost Volume", "R2"},
+
+	{"Left ADC", NULL, "Left Boost Mixer"},
+
+	{"Left Boost Mixer", "Aux Boost Volume", "LAUX"},
+	{"Left Boost Mixer", "PGA Boost (+20dB)", "Left Capture PGA"},
+	{"Left Boost Mixer", "L2 Boost Volume", "L2"},
+
+	/* Input PGA */
+	{"Right Capture PGA", "Volume", "Right Input PGA"},
+	{"Left Capture PGA", "Volume", "Left Input PGA"},
+
+	{"Right Input PGA", "R2 Switch", "R2"},
+	{"Right Input PGA", "MicN Switch", "RMICN"},
+	{"Right Input PGA", "MicP Switch", "RMICP"},
+
+	{"Left Input PGA", "L2 Switch", "L2"},
+	{"Left Input PGA", "MicN Switch", "LMICN"},
+	{"Left Input PGA", "MicP Switch", "LMICP"},
+};
+
+static int wm8978_add_widgets(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_new_controls(codec, wm8978_dapm_widgets,
+				  ARRAY_SIZE(wm8978_dapm_widgets));
+
+	/* set up the WM8978 audio map */
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+
+	return 0;
+}
+
+/* PLL divisors */
+struct wm8978_pll_div {
+	u32 k;
+	u8 n;
+	u8 div2;
+};
+
+#define FIXED_PLL_SIZE (1 << 24)
+
+static void pll_factors(struct wm8978_pll_div *pll_div, unsigned int target,
+			unsigned int source)
+{
+	u64 k_part;
+	unsigned int k, n_div, n_mod;
+
+	n_div = target / source;
+	if (n_div < 6) {
+		source >>= 1;
+		pll_div->div2 = 1;
+		n_div = target / source;
+	} else {
+		pll_div->div2 = 0;
+	}
+
+	if (n_div < 6 || n_div > 12)
+		dev_warn(wm8978_codec->dev,
+			 "WM8978 N value exceeds recommended range! N = %u\n",
+			 n_div);
+
+	pll_div->n = n_div;
+	n_mod = target - source * n_div;
+	k_part = FIXED_PLL_SIZE * (long long)n_mod + source / 2;
+
+	do_div(k_part, source);
+
+	k = k_part & 0xFFFFFFFF;
+
+	pll_div->k = k;
+}
+
+static int wm8978_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
+		int source, unsigned int freq_in, unsigned int freq_out)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct wm8978_priv *wm8978 = codec->private_data;
+	struct wm8978_pll_div pll_div;
+	unsigned int f2, opclk_div;
+	u16 reg;
+
+	if (freq_in = 0 || freq_out = 0) {
+		/* Clock CODEC directly from MCLK */
+		reg = snd_soc_read(codec, WM8978_CLOCKING);
+		snd_soc_write(codec, WM8978_CLOCKING, reg & ~0x100);
+
+		/* Turn off PLL */
+		reg = snd_soc_read(codec, WM8978_POWER_MANAGEMENT_1);
+		snd_soc_write(codec, WM8978_POWER_MANAGEMENT_1, reg & ~0x20);
+		return 0;
+	}
+
+	opclk_div = ((snd_soc_read(codec, WM8978_GPIO_CONTROL) & 0x30) >> 4) + 1;
+
+	wm8978->f_pllout = freq_out * opclk_div;
+
+	f2 = wm8978->f_pllout * 4;
+
+	pll_factors(&pll_div, f2, freq_in);
+
+	dev_dbg(codec->dev, "%s: calculated PLL N=0x%x, K=0x%x, div2=%d\n",
+		__func__, pll_div.n, pll_div.k, pll_div.div2);
+
+	snd_soc_write(codec, WM8978_PLL_N, (pll_div.div2 << 4) | pll_div.n);
+	snd_soc_write(codec, WM8978_PLL_K1, pll_div.k >> 18);
+	snd_soc_write(codec, WM8978_PLL_K2, (pll_div.k >> 9) & 0x1ff);
+	snd_soc_write(codec, WM8978_PLL_K3, pll_div.k & 0x1ff);
+	/* Turn PLL on */
+	reg = snd_soc_read(codec, WM8978_POWER_MANAGEMENT_1);
+	snd_soc_write(codec, WM8978_POWER_MANAGEMENT_1, reg | 0x020);
+
+	/* Run CODEC from PLL instead of MCLK */
+	reg = snd_soc_read(codec, WM8978_CLOCKING);
+	snd_soc_write(codec, WM8978_CLOCKING, reg | 0x100);
+
+	return 0;
+}
+
+/*
+ * Configure WM8978 clock dividers.
+ */
+static int wm8978_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
+				 int div_id, int div)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	u16 reg;
+
+	switch (div_id) {
+	case WM8978_OPCLKDIV:
+		if (div & ~0x30)
+			return -EINVAL;
+		reg = snd_soc_read(codec, WM8978_GPIO_CONTROL) & ~0x30;
+		snd_soc_write(codec, WM8978_GPIO_CONTROL, reg | div);
+		/* Output PLL (OPCLK) to GPIO1 */
+		snd_soc_write(codec, WM8978_GPIO_CONTROL,
+			      snd_soc_read(codec, WM8978_GPIO_CONTROL) | 0x4);
+		break;
+	case WM8978_MCLKDIV:
+		if (div & ~0xe0)
+			return -EINVAL;
+		reg = snd_soc_read(codec, WM8978_CLOCKING) & ~0xe0;
+		snd_soc_write(codec, WM8978_CLOCKING, reg | div);
+		break;
+	case WM8978_ADCCLK:
+		if (div & ~8)
+			return -EINVAL;
+		reg = snd_soc_read(codec, WM8978_ADC_CONTROL) & ~8;
+		snd_soc_write(codec, WM8978_ADC_CONTROL, reg | div);
+		break;
+	case WM8978_DACCLK:
+		if (div & ~8)
+			return -EINVAL;
+		reg = snd_soc_read(codec, WM8978_DAC_CONTROL) & ~8;
+		snd_soc_write(codec, WM8978_DAC_CONTROL, reg | div);
+		break;
+	case WM8978_BCLKDIV:
+		if (div & ~0x1c)
+			return -EINVAL;
+		reg = snd_soc_read(codec, WM8978_CLOCKING) & ~0x1c;
+		snd_soc_write(codec, WM8978_CLOCKING, reg | div);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	dev_dbg(codec->dev, "%s: ID %d, value 0x%x\n",
+		__func__, div_id, reg | div);
+
+	return 0;
+}
+
+/*
+ * Set ADC and Voice DAC format.
+ */
+static int wm8978_set_dai_fmt(struct snd_soc_dai *codec_dai,
+			      unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	/*
+	 * BCLK polarity mask = 0x100, LRC clock polarity mask = 0x80,
+	 * Data Format mask = 0x18: all will be calculated anew
+	 */
+	u16 iface = snd_soc_read(codec, WM8978_AUDIO_INTERFACE) & ~0x198;
+	u16 clk = snd_soc_read(codec, WM8978_CLOCKING);
+
+	/* set master/slave audio interface */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		clk |= 1;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		clk &= ~1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* interface format */
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		iface |= 0x10;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		iface |= 0x8;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		iface |= 0x18;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* clock inversion */
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		iface |= 0x180;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		iface |= 0x100;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		iface |= 0x80;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	snd_soc_write(codec, WM8978_AUDIO_INTERFACE, iface);
+	snd_soc_write(codec, WM8978_CLOCKING, clk);
+
+	return 0;
+}
+
+/* MCLK dividers */
+static const int mclk_numerator[]	= {1, 3, 2, 3, 4, 6, 8, 12};
+static const int mclk_denominator[]	= {1, 2, 1, 1, 1, 1, 1, 1};
+
+/*
+ * Set PCM DAI bit size and sample rate.
+ */
+static int wm8978_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->card->codec;
+	struct wm8978_priv *wm8978 = codec->private_data;
+	/* Word length mask = 0x60 */
+	u16 iface_ctl = snd_soc_read(codec, WM8978_AUDIO_INTERFACE) & ~0x60;
+	/* Sampling rate mask = 0xe (for filters) */
+	u16 add_ctl = snd_soc_read(codec, WM8978_ADDITIONAL_CONTROL) & ~0xe;
+	unsigned int f_sys;
+	int i;
+
+	/* bit size */
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		iface_ctl |= 0x20;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		iface_ctl |= 0x40;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		iface_ctl |= 0x60;
+		break;
+	}
+
+	/* filter coefficient */
+	switch (params_rate(params)) {
+	case 8000:
+		add_ctl |= 0x5 << 1;
+		break;
+	case 11025:
+		add_ctl |= 0x4 << 1;
+		break;
+	case 16000:
+		add_ctl |= 0x3 << 1;
+		break;
+	case 22050:
+		add_ctl |= 0x2 << 1;
+		break;
+	case 32000:
+		add_ctl |= 0x1 << 1;
+		break;
+	case 44100:
+	case 48000:
+		break;
+	}
+
+	/*
+	 * Calculate internal frequencies and dividers, according to Figure 40
+	 * "PLL and Clock Select Circuit" in WM8978 datasheet Rev. 2.6
+	 */
+	f_sys = params_rate(params) * 256;
+	if (f_sys > wm8978->f_pllout)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(mclk_numerator); i++)
+		if (wm8978->f_pllout * mclk_denominator[i] =
+		    mclk_numerator[i] * f_sys)
+			break;
+
+	if (i = ARRAY_SIZE(mclk_numerator))
+		return -EINVAL;
+
+	dev_dbg(codec->dev, "%s: fmt %d, rate %u, MCLK divisor #%d\n", __func__,
+		params_format(params), params_rate(params), i);
+
+	/* MCLK divisor mask = 0xe0 */
+	snd_soc_update_bits(codec, WM8978_CLOCKING, 0xe0, i << 5);
+	snd_soc_write(codec, WM8978_AUDIO_INTERFACE, iface_ctl);
+	snd_soc_write(codec, WM8978_ADDITIONAL_CONTROL, add_ctl);
+
+	return 0;
+}
+
+static int wm8978_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	u16 val = snd_soc_read(codec, WM8978_DAC_CONTROL);
+
+	dev_dbg(codec->dev, "%s: %d\n", __func__, mute);
+
+	if (mute)
+		snd_soc_write(codec, WM8978_DAC_CONTROL, val | 0x40);
+	else
+		snd_soc_write(codec, WM8978_DAC_CONTROL, val & ~0x40);
+
+	return 0;
+}
+
+static int wm8978_set_bias_level(struct snd_soc_codec *codec,
+				 enum snd_soc_bias_level level)
+{
+	u16 power1 = snd_soc_read(codec, WM8978_POWER_MANAGEMENT_1) & ~3;
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+	case SND_SOC_BIAS_PREPARE:
+		power1 |= 1;  /* VMID 75k */
+		snd_soc_write(codec, WM8978_POWER_MANAGEMENT_1, power1);
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		/* bit 3: enable bias, bit 2: enable I/O tie off buffer */
+		power1 |= 0xc;
+
+		if (codec->bias_level = SND_SOC_BIAS_OFF) {
+			/* Initial cap charge at VMID 5k */
+			snd_soc_write(codec, WM8978_POWER_MANAGEMENT_1,
+				      power1 | 0x3);
+			mdelay(100);
+		}
+
+		power1 |= 0x2;  /* VMID 500k */
+		snd_soc_write(codec, WM8978_POWER_MANAGEMENT_1, power1);
+		break;
+	case SND_SOC_BIAS_OFF:
+		snd_soc_write(codec, WM8978_POWER_MANAGEMENT_1, 0);
+		snd_soc_write(codec, WM8978_POWER_MANAGEMENT_2, 0);
+		snd_soc_write(codec, WM8978_POWER_MANAGEMENT_3, 0);
+		break;
+	}
+
+	dev_dbg(codec->dev, "%s: %d, %u\n", __func__, level, power1);
+
+	codec->bias_level = level;
+	return 0;
+}
+
+#define WM8978_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
+	SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_ops wm8978_dai_ops = {
+	.hw_params	= wm8978_hw_params,
+	.digital_mute	= wm8978_mute,
+	.set_fmt	= wm8978_set_dai_fmt,
+	.set_clkdiv	= wm8978_set_dai_clkdiv,
+	.set_pll	= wm8978_set_dai_pll,
+};
+
+/* Also supports 12kHz */
+struct snd_soc_dai wm8978_dai = {
+	.name = "WM8978 HiFi",
+	.id = 1,
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_48000,
+		.formats = WM8978_FORMATS,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_48000,
+		.formats = WM8978_FORMATS,
+	},
+	.ops = &wm8978_dai_ops,
+};
+EXPORT_SYMBOL_GPL(wm8978_dai);
+
+static int wm8978_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->card->codec;
+
+	wm8978_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	return 0;
+}
+
+static int wm8978_resume(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->card->codec;
+	int i;
+	u16 *cache = codec->reg_cache;
+
+	/* Sync reg_cache with the hardware */
+	for (i = 0; i < ARRAY_SIZE(wm8978_reg); i++) {
+		if (i = WM8978_RESET)
+			continue;
+		if (cache[i] != wm8978_reg[i])
+			snd_soc_write(codec, i, cache[i]);
+	}
+
+	wm8978_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	return 0;
+}
+
+static int wm8978_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec;
+	int ret = 0;
+
+	if (wm8978_codec = NULL) {
+		dev_err(&pdev->dev, "Codec device not registered\n");
+		return -ENODEV;
+	}
+
+	socdev->card->codec = wm8978_codec;
+	codec = wm8978_codec;
+
+	/* register pcms */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		dev_err(codec->dev, "failed to create pcms: %d\n", ret);
+		goto pcm_err;
+	}
+
+	snd_soc_add_controls(codec, wm8978_snd_controls,
+			     ARRAY_SIZE(wm8978_snd_controls));
+	wm8978_add_widgets(codec);
+
+pcm_err:
+	return ret;
+}
+
+/* power down chip */
+static int wm8978_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+
+	return 0;
+}
+
+struct snd_soc_codec_device soc_codec_dev_wm8978 = {
+	.probe		= wm8978_probe,
+	.remove		= wm8978_remove,
+	.suspend	= wm8978_suspend,
+	.resume		= wm8978_resume,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_wm8978);
+
+static __devinit int wm8978_register(struct wm8978_priv *wm8978)
+{
+	int ret, i;
+	struct snd_soc_codec *codec = &wm8978->codec;
+
+	if (wm8978_codec) {
+		dev_err(codec->dev, "Another WM8978 is registered\n");
+		return -EINVAL;
+	}
+
+	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	codec->private_data = wm8978;
+	codec->name = "WM8978";
+	codec->owner = THIS_MODULE;
+	codec->bias_level = SND_SOC_BIAS_OFF;
+	codec->set_bias_level = wm8978_set_bias_level;
+	codec->dai = &wm8978_dai;
+	codec->num_dai = 1;
+	codec->reg_cache_size = WM8978_CACHEREGNUM;
+	codec->reg_cache = &wm8978->reg_cache;
+
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_I2C);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		goto err;
+	}
+
+	memcpy(codec->reg_cache, wm8978_reg, sizeof(wm8978_reg));
+
+	/*
+	 * Set the update bit in all registers, that have one. This way all
+	 * writes to those registers will also cause the update bit to be
+	 * written.
+	 */
+	for (i = 0; i < ARRAY_SIZE(update_reg); i++)
+		((u16 *)codec->reg_cache)[update_reg[i]] |= 0x100;
+
+	/* Reset the codec */
+	ret = snd_soc_write(codec, WM8978_RESET, 0);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to issue reset\n");
+		goto err;
+	}
+
+	wm8978_dai.dev = codec->dev;
+
+	wm8978_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
+	wm8978_codec = codec;
+
+	ret = snd_soc_register_codec(codec);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
+		goto err;
+	}
+
+	ret = snd_soc_register_dai(&wm8978_dai);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
+		goto err_codec;
+	}
+
+	return 0;
+
+err_codec:
+	snd_soc_unregister_codec(codec);
+err:
+	kfree(wm8978);
+	return ret;
+}
+
+static __devexit void wm8978_unregister(struct wm8978_priv *wm8978)
+{
+	wm8978_set_bias_level(&wm8978->codec, SND_SOC_BIAS_OFF);
+	snd_soc_unregister_dai(&wm8978_dai);
+	snd_soc_unregister_codec(&wm8978->codec);
+	kfree(wm8978);
+	wm8978_codec = NULL;
+}
+
+static __devinit int wm8978_i2c_probe(struct i2c_client *i2c,
+				      const struct i2c_device_id *id)
+{
+	struct wm8978_priv *wm8978;
+	struct snd_soc_codec *codec;
+
+	wm8978 = kzalloc(sizeof(struct wm8978_priv), GFP_KERNEL);
+	if (wm8978 = NULL)
+		return -ENOMEM;
+
+	codec = &wm8978->codec;
+	codec->hw_write = (hw_write_t)i2c_master_send;
+
+	i2c_set_clientdata(i2c, wm8978);
+	codec->control_data = i2c;
+
+	codec->dev = &i2c->dev;
+
+	return wm8978_register(wm8978);
+}
+
+static __devexit int wm8978_i2c_remove(struct i2c_client *client)
+{
+	struct wm8978_priv *wm8978 = i2c_get_clientdata(client);
+	wm8978_unregister(wm8978);
+	return 0;
+}
+
+static const struct i2c_device_id wm8978_i2c_id[] = {
+	{ "wm8978", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, wm8978_i2c_id);
+
+static struct i2c_driver wm8978_i2c_driver = {
+	.driver = {
+		.name = "WM8978",
+		.owner = THIS_MODULE,
+	},
+	.probe =    wm8978_i2c_probe,
+	.remove =   __devexit_p(wm8978_i2c_remove),
+	.id_table = wm8978_i2c_id,
+};
+
+static int __init wm8978_modinit(void)
+{
+	return i2c_add_driver(&wm8978_i2c_driver);
+}
+module_init(wm8978_modinit);
+
+static void __exit wm8978_exit(void)
+{
+	i2c_del_driver(&wm8978_i2c_driver);
+}
+module_exit(wm8978_exit);
+
+MODULE_DESCRIPTION("ASoC WM8978 codec driver");
+MODULE_AUTHOR("Guennadi Liakhovetski <g.liakhovetski@gmx.de>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/wm8978.h b/sound/soc/codecs/wm8978.h
new file mode 100644
index 0000000..61e39c0
--- /dev/null
+++ b/sound/soc/codecs/wm8978.h
@@ -0,0 +1,84 @@
+/*
+ * wm8978.h		--  codec driver for WM8978
+ *
+ * Copyright 2009 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __WM8978_H__
+#define __WM8978_H__
+
+/*
+ * Register values.
+ */
+#define WM8978_RESET				0x00
+#define WM8978_POWER_MANAGEMENT_1		0x01
+#define WM8978_POWER_MANAGEMENT_2		0x02
+#define WM8978_POWER_MANAGEMENT_3		0x03
+#define WM8978_AUDIO_INTERFACE			0x04
+#define WM8978_COMPANDING_CONTROL		0x05
+#define WM8978_CLOCKING				0x06
+#define WM8978_ADDITIONAL_CONTROL		0x07
+#define WM8978_GPIO_CONTROL			0x08
+#define WM8978_JACK_DETECT_CONTROL_1		0x09
+#define WM8978_DAC_CONTROL			0x0A
+#define WM8978_LEFT_DAC_DIGITAL_VOLUME		0x0B
+#define WM8978_RIGHT_DAC_DIGITAL_VOLUME		0x0C
+#define WM8978_JACK_DETECT_CONTROL_2		0x0D
+#define WM8978_ADC_CONTROL			0x0E
+#define WM8978_LEFT_ADC_DIGITAL_VOLUME		0x0F
+#define WM8978_RIGHT_ADC_DIGITAL_VOLUME		0x10
+#define WM8978_EQ1				0x12
+#define WM8978_EQ2				0x13
+#define WM8978_EQ3				0x14
+#define WM8978_EQ4				0x15
+#define WM8978_EQ5				0x16
+#define WM8978_DAC_LIMITER_1			0x18
+#define WM8978_DAC_LIMITER_2			0x19
+#define WM8978_NOTCH_FILTER_1			0x1b
+#define WM8978_NOTCH_FILTER_2			0x1c
+#define WM8978_NOTCH_FILTER_3			0x1d
+#define WM8978_NOTCH_FILTER_4			0x1e
+#define WM8978_ALC_CONTROL_1			0x20
+#define WM8978_ALC_CONTROL_2			0x21
+#define WM8978_ALC_CONTROL_3			0x22
+#define WM8978_NOISE_GATE			0x23
+#define WM8978_PLL_N				0x24
+#define WM8978_PLL_K1				0x25
+#define WM8978_PLL_K2				0x26
+#define WM8978_PLL_K3				0x27
+#define WM8978_3D_CONTROL			0x29
+#define WM8978_BEEP_CONTROL			0x2b
+#define WM8978_INPUT_CONTROL			0x2c
+#define WM8978_LEFT_INP_PGA_CONTROL		0x2d
+#define WM8978_RIGHT_INP_PGA_CONTROL		0x2e
+#define WM8978_LEFT_ADC_BOOST_CONTROL		0x2f
+#define WM8978_RIGHT_ADC_BOOST_CONTROL		0x30
+#define WM8978_OUTPUT_CONTROL			0x31
+#define WM8978_LEFT_MIXER_CONTROL		0x32
+#define WM8978_RIGHT_MIXER_CONTROL		0x33
+#define WM8978_LOUT1_HP_CONTROL			0x34
+#define WM8978_ROUT1_HP_CONTROL			0x35
+#define WM8978_LOUT2_SPK_CONTROL		0x36
+#define WM8978_ROUT2_SPK_CONTROL		0x37
+#define WM8978_OUT3_MIXER_CONTROL		0x38
+#define WM8978_OUT4_MIXER_CONTROL		0x39
+
+#define WM8978_CACHEREGNUM			58
+
+/* Clock divider Id's */
+enum wm8978_clk_id {
+	WM8978_OPCLKDIV,
+	WM8978_MCLKDIV,
+	WM8978_ADCCLK,
+	WM8978_DACCLK,
+	WM8978_BCLKDIV,
+};
+
+extern struct snd_soc_dai wm8978_dai;
+extern struct snd_soc_codec_device soc_codec_dev_wm8978;
+
+#endif	/* __WM8978_H__ */
