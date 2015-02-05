From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 05 Feb 2015 07:11:44 +0000
Subject: [PATCH 2/6] ASoC: sh: discontinue support of sh7760-ac97 driver
Message-Id: <877fvwj0gh.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87egq7774l.wl%kuninori.morimoto.gx@renesas.com>
	<87a90sj0hy.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87a90sj0hy.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@linaro.org>, Mark Brown <broonie@kernel.org>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

In upstream kernel, no one is using SND_SH7760_AC97.
This patch discontinue support of sh7760-ac97 driver to reducing
maintenance cost. Thank you and good bye sh7760-ac97 driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/sh/Kconfig       |   13 --------
 sound/soc/sh/Makefile      |    5 ---
 sound/soc/sh/sh7760-ac97.c |   73 --------------------------------------------
 3 files changed, 91 deletions(-)
 delete mode 100644 sound/soc/sh/sh7760-ac97.c

diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index 8b8409c..a931c96 100644
--- a/sound/soc/sh/Kconfig
+++ b/sound/soc/sh/Kconfig
@@ -41,17 +41,4 @@ config SND_SOC_RCAR
 	help
 	  This option enables R-Car SUR/SCU/SSIU/SSI sound support
 
-##
-## Boards
-##
-
-config SND_SH7760_AC97
-	tristate "SH7760 AC97 sound support"
-	depends on CPU_SUBTYPE_SH7760 && SND_SOC_PCM_SH7760
-	select SND_SOC_SH4_HAC
-	select SND_SOC_AC97_CODEC
-	help
-	  This option enables generic sound support for the first
-	  AC97 unit of the SH7760.
-
 endmenu
diff --git a/sound/soc/sh/Makefile b/sound/soc/sh/Makefile
index a462960..20f50ea 100644
--- a/sound/soc/sh/Makefile
+++ b/sound/soc/sh/Makefile
@@ -14,8 +14,3 @@ obj-$(CONFIG_SND_SOC_SH4_SIU)	+= snd-soc-siu.o
 
 ## audio units for R-Car
 obj-$(CONFIG_SND_SOC_RCAR)	+= rcar/
-
-## boards
-snd-soc-sh7760-ac97-objs	:= sh7760-ac97.o
-
-obj-$(CONFIG_SND_SH7760_AC97)	+= snd-soc-sh7760-ac97.o
diff --git a/sound/soc/sh/sh7760-ac97.c b/sound/soc/sh/sh7760-ac97.c
deleted file mode 100644
index 4a3568a..0000000
--- a/sound/soc/sh/sh7760-ac97.c
+++ /dev/null
@@ -1,73 +0,0 @@
-/*
- * Generic AC97 sound support for SH7760
- *
- * (c) 2007 Manuel Lauss
- *
- * Licensed under the GPLv2.
- */
-
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/platform_device.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/soc.h>
-#include <asm/io.h>
-
-#define IPSEL 0xFE400034
-
-static struct snd_soc_dai_link sh7760_ac97_dai = {
-	.name = "AC97",
-	.stream_name = "AC97 HiFi",
-	.cpu_dai_name = "hac-dai.0",	/* HAC0 */
-	.codec_dai_name = "ac97-hifi",
-	.platform_name = "sh7760-pcm-audio",
-	.codec_name = "ac97-codec",
-	.ops = NULL,
-};
-
-static struct snd_soc_card sh7760_ac97_soc_machine  = {
-	.name = "SH7760 AC97",
-	.owner = THIS_MODULE,
-	.dai_link = &sh7760_ac97_dai,
-	.num_links = 1,
-};
-
-static struct platform_device *sh7760_ac97_snd_device;
-
-static int __init sh7760_ac97_init(void)
-{
-	int ret;
-	unsigned short ipsel;
-
-	/* enable both AC97 controllers in pinmux reg */
-	ipsel = __raw_readw(IPSEL);
-	__raw_writew(ipsel | (3 << 10), IPSEL);
-
-	ret = -ENOMEM;
-	sh7760_ac97_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!sh7760_ac97_snd_device)
-		goto out;
-
-	platform_set_drvdata(sh7760_ac97_snd_device,
-			     &sh7760_ac97_soc_machine);
-	ret = platform_device_add(sh7760_ac97_snd_device);
-
-	if (ret)
-		platform_device_put(sh7760_ac97_snd_device);
-
-out:
-	return ret;
-}
-
-static void __exit sh7760_ac97_exit(void)
-{
-	platform_device_unregister(sh7760_ac97_snd_device);
-}
-
-module_init(sh7760_ac97_init);
-module_exit(sh7760_ac97_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Generic SH7760 AC97 sound machine");
-MODULE_AUTHOR("Manuel Lauss <mano@roarinelk.homelinux.net>");
-- 
1.7.9.5

