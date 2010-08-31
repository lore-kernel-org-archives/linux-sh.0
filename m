From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 31 Aug 2010 05:46:53 +0000
Subject: [PATCH 2/4 v2] ASoC: fsi-codec: Add FSI - HDMI support
Message-Id: <w3pzkw35o6s.wl%kuninori.morimoto.gx@renesas.com>
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

o based on latest Mark's "for-2.6.37"

 sound/soc/sh/Kconfig    |    7 +++++
 sound/soc/sh/Makefile   |    2 +
 sound/soc/sh/fsi-hdmi.c |   61 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/sh/fsi-hdmi.c

diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index 52d7e8e..6b224d2 100644
--- a/sound/soc/sh/Kconfig
+++ b/sound/soc/sh/Kconfig
@@ -62,6 +62,13 @@ config SND_FSI_DA7210
 	  This option enables generic sound support for the
 	  FSI - DA7210 unit
 
+config SND_FSI_HDMI
+	bool "FSI-HDMI sound support"
+	depends on SND_SOC_SH4_FSI && FB_SH_MOBILE_HDMI
+	help
+	  This option enables generic sound support for the
+	  FSI - HDMI unit
+
 config SND_SIU_MIGOR
 	tristate "SIU sound support on Migo-R"
 	depends on SH_MIGOR
diff --git a/sound/soc/sh/Makefile b/sound/soc/sh/Makefile
index 8a5a192..94476d4 100644
--- a/sound/soc/sh/Makefile
+++ b/sound/soc/sh/Makefile
@@ -16,9 +16,11 @@ obj-$(CONFIG_SND_SOC_SH4_SIU)	+= snd-soc-siu.o
 snd-soc-sh7760-ac97-objs	:= sh7760-ac97.o
 snd-soc-fsi-ak4642-objs		:= fsi-ak4642.o
 snd-soc-fsi-da7210-objs		:= fsi-da7210.o
+snd-soc-fsi-hdmi-objs		:= fsi-hdmi.o
 snd-soc-migor-objs		:= migor.o
 
 obj-$(CONFIG_SND_SH7760_AC97)	+= snd-soc-sh7760-ac97.o
 obj-$(CONFIG_SND_FSI_AK4642)	+= snd-soc-fsi-ak4642.o
 obj-$(CONFIG_SND_FSI_DA7210)	+= snd-soc-fsi-da7210.o
+obj-$(CONFIG_SND_FSI_HDMI)	+= snd-soc-fsi-hdmi.o
 obj-$(CONFIG_SND_SIU_MIGOR)	+= snd-soc-migor.o
diff --git a/sound/soc/sh/fsi-hdmi.c b/sound/soc/sh/fsi-hdmi.c
new file mode 100644
index 0000000..950e3e0
--- /dev/null
+++ b/sound/soc/sh/fsi-hdmi.c
@@ -0,0 +1,61 @@
+/*
+ * FSI - HDMI sound support
+ *
+ * Copyright (C) 2010 Renesas Solutions Corp.
+ * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/platform_device.h>
+#include <sound/sh_fsi.h>
+#include <video/sh_mobile_hdmi.h>
+
+static struct snd_soc_dai_link fsi_dai_link = {
+	.name		= "HDMI",
+	.stream_name	= "HDMI",
+	.cpu_dai_name	= "fsib-dai", /* fsi B */
+	.codec_dai_name	= "sh_mobile_hdmi-hifi",
+	.platform_name	= "sh_fsi2",
+	.codec_name	= "sh-mobile-hdmi",
+};
+
+static struct snd_soc_card fsi_soc_card  = {
+	.name		= "FSI",
+	.dai_link	= &fsi_dai_link,
+	.num_links	= 1,
+};
+
+static struct platform_device *fsi_snd_device;
+
+static int __init fsi_hdmi_init(void)
+{
+	int ret = -ENOMEM;
+
+	fsi_snd_device = platform_device_alloc("soc-audio", FSI_PORT_B);
+	if (!fsi_snd_device)
+		goto out;
+
+	platform_set_drvdata(fsi_snd_device, &fsi_soc_card);
+	ret = platform_device_add(fsi_snd_device);
+
+	if (ret)
+		platform_device_put(fsi_snd_device);
+
+out:
+	return ret;
+}
+
+static void __exit fsi_hdmi_exit(void)
+{
+	platform_device_unregister(fsi_snd_device);
+}
+
+module_init(fsi_hdmi_init);
+module_exit(fsi_hdmi_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Generic SH4 FSI-HDMI sound card");
+MODULE_AUTHOR("Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>");
-- 
1.7.0.4

