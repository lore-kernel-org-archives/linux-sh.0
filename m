From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Fri, 21 Aug 2009 00:42:59 +0000
Subject: [PATCH v3 3/4] ASoC: Add FSI-AK4642 sound support for SuperH
Message-Id: <ud46qnem4.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, alsa-devel@alsa-project.org
Cc: lethal@linux-sh.org, broonie@opensource.wolfsonmicro.com

This patch is tested by ms7724se

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
v2 -> v3

o remove un-used ak4642_setup_data

I used Paul's git for base and merge from
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

 sound/soc/sh/Kconfig      |    8 +++
 sound/soc/sh/Makefile     |    2 +
 sound/soc/sh/fsi-ak4642.c |  107 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/sh/fsi-ak4642.c

diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index 01943a1..9154b43 100644
--- a/sound/soc/sh/Kconfig
+++ b/sound/soc/sh/Kconfig
@@ -40,4 +40,12 @@ config SND_SH7760_AC97
 	  This option enables generic sound support for the first
 	  AC97 unit of the SH7760.
 
+config SND_FSI_AK4642
+	bool "FSI-AK4642 sound support"
+	depends on SND_SOC_SH4_FSI
+	select SND_SOC_AK4642
+	help
+	  This option enables generic sound support for the
+	  FSI - AK4642 unit
+
 endmenu
diff --git a/sound/soc/sh/Makefile b/sound/soc/sh/Makefile
index 9fbcc4a..a699787 100644
--- a/sound/soc/sh/Makefile
+++ b/sound/soc/sh/Makefile
@@ -12,5 +12,7 @@ obj-$(CONFIG_SND_SOC_SH4_FSI)	+= snd-soc-fsi.o
 
 ## boards
 snd-soc-sh7760-ac97-objs	:= sh7760-ac97.o
+snd-soc-fsi-ak4642-objs		:= fsi-ak4642.o
 
 obj-$(CONFIG_SND_SH7760_AC97)	+= snd-soc-sh7760-ac97.o
+obj-$(CONFIG_SND_FSI_AK4642)	+= snd-soc-fsi-ak4642.o
diff --git a/sound/soc/sh/fsi-ak4642.c b/sound/soc/sh/fsi-ak4642.c
new file mode 100644
index 0000000..c7af097
--- /dev/null
+++ b/sound/soc/sh/fsi-ak4642.c
@@ -0,0 +1,107 @@
+/*
+ * FSI-AK464x sound support for ms7724se
+ *
+ * Copyright (C) 2009 Renesas Solutions Corp.
+ * Kuninori Morimoto <morimoto.kuninori@renesas.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+#include <linux/io.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <sound/sh_fsi.h>
+#include <../sound/soc/codecs/ak4642.h>
+
+static struct snd_soc_dai_link fsi_dai_link = {
+	.name		= "AK4642",
+	.stream_name	= "AK4642",
+	.cpu_dai	= &fsi_soc_dai[0], /* fsi */
+	.codec_dai	= &ak4642_dai,
+	.ops		= NULL,
+};
+
+static struct snd_soc_card fsi_soc_card  = {
+	.name		= "FSI",
+	.platform	= &fsi_soc_platform,
+	.dai_link	= &fsi_dai_link,
+	.num_links	= 1,
+};
+
+static struct snd_soc_device fsi_snd_devdata = {
+	.card		= &fsi_soc_card,
+	.codec_dev	= &soc_codec_dev_ak4642,
+};
+
+#define AK4642_BUS 0
+#define AK4642_ADR 0x12
+static int ak4642_add_i2c_device(void)
+{
+	struct i2c_board_info info;
+	struct i2c_adapter *adapter;
+	struct i2c_client *client;
+
+	memset(&info, 0, sizeof(struct i2c_board_info));
+	info.addr = AK4642_ADR;
+	strlcpy(info.type, "ak4642", I2C_NAME_SIZE);
+
+	adapter = i2c_get_adapter(AK4642_BUS);
+	if (!adapter) {
+		printk(KERN_DEBUG "can't get i2c adapter\n");
+		return -ENODEV;
+	}
+
+	client = i2c_new_device(adapter, &info);
+	i2c_put_adapter(adapter);
+	if (!client) {
+		printk(KERN_DEBUG "can't add i2c device\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static struct platform_device *fsi_snd_device;
+
+static int __init fsi_ak4642_init(void)
+{
+	int ret = -ENOMEM;
+
+	ak4642_add_i2c_device();
+
+	fsi_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!fsi_snd_device)
+		goto out;
+
+	platform_set_drvdata(fsi_snd_device,
+			     &fsi_snd_devdata);
+	fsi_snd_devdata.dev = &fsi_snd_device->dev;
+	ret = platform_device_add(fsi_snd_device);
+
+	if (ret)
+		platform_device_put(fsi_snd_device);
+
+out:
+	return ret;
+}
+
+static void __exit fsi_ak4642_exit(void)
+{
+	platform_device_unregister(fsi_snd_device);
+}
+
+module_init(fsi_ak4642_init);
+module_exit(fsi_ak4642_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Generic SH4 FSI-AK4642 sound card");
+MODULE_AUTHOR("Kuninori Morimoto <morimoto.kuninori@renesas.com>");
-- 
1.6.0.4

