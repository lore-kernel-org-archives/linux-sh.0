From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 17 Sep 2015 04:23:17 +0000
Subject: [PATCH 06/20 v2] ASoC: ak4613: add Digital Playback Volume support
Message-Id: <87mvwl7k5k.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

For L/ROUT1 to L/ROUT6

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - not yet posted

 sound/soc/codecs/ak4613.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index fd96a8f..07a2664 100644
--- a/sound/soc/codecs/ak4613.c
+++ b/sound/soc/codecs/ak4613.c
@@ -22,6 +22,7 @@
 #include <linux/regmap.h>
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
+#include <sound/tlv.h>
 
 #define PW_MGMT1	0x00 /* Power Management 1 */
 #define PW_MGMT2	0x01 /* Power Management 2 */
@@ -91,6 +92,31 @@ struct ak4613_interface {
 	struct ak4613_formats playback;
 };
 
+/*
+ * Playback Volume
+ *
+ * max : 0x00 : 0 dB
+ *       ( 0.5 dB step )
+ * min : 0xFE : -127.0 dB
+ * mute: 0xFF
+ */
+static const DECLARE_TLV_DB_SCALE(out_tlv, -12750, 50, 1);
+
+static const struct snd_kcontrol_new ak4613_snd_controls[] = {
+	SOC_DOUBLE_R_TLV("Digital Playback Volume1", LOUT1, ROUT1,
+			 0, 0xFF, 1, out_tlv),
+	SOC_DOUBLE_R_TLV("Digital Playback Volume2", LOUT2, ROUT2,
+			 0, 0xFF, 1, out_tlv),
+	SOC_DOUBLE_R_TLV("Digital Playback Volume3", LOUT3, ROUT3,
+			 0, 0xFF, 1, out_tlv),
+	SOC_DOUBLE_R_TLV("Digital Playback Volume4", LOUT4, ROUT4,
+			 0, 0xFF, 1, out_tlv),
+	SOC_DOUBLE_R_TLV("Digital Playback Volume5", LOUT5, ROUT5,
+			 0, 0xFF, 1, out_tlv),
+	SOC_DOUBLE_R_TLV("Digital Playback Volume6", LOUT6, ROUT6,
+			 0, 0xFF, 1, out_tlv),
+};
+
 static const struct reg_default ak4613_reg[] = {
 	{ 0x0,  0x0f }, { 0x1,  0x07 }, { 0x2,  0x3f }, { 0x3,  0x20 },
 	{ 0x4,  0x20 }, { 0x5,  0x55 }, { 0x6,  0x05 }, { 0x7,  0x07 },
@@ -397,6 +423,8 @@ static int ak4613_resume(struct snd_soc_codec *codec)
 static struct snd_soc_codec_driver soc_codec_dev_ak4613 = {
 	.resume			= ak4613_resume,
 	.set_bias_level		= ak4613_set_bias_level,
+	.controls		= ak4613_snd_controls,
+	.num_controls		= ARRAY_SIZE(ak4613_snd_controls),
 	.dapm_widgets		= ak4613_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(ak4613_dapm_widgets),
 	.dapm_routes		= ak4613_intercon,
-- 
1.9.1

