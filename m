From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 14 Mar 2014 00:56:25 +0000
Subject: [PATCH 1/2 v2] ASoC: fsi: fixup SND_SOC_DAIFMT_CBx_CFx flags
Message-Id: <87bnx9pphk.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87txb3rjzw.wl%kuninori.morimoto.gx@gmail.com>
	<87d2hpppk3.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87d2hpppk3.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
Cc: Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

SND_SOC_DAIFMT_CBx_CFx means "codec" side master/slave mode.
Then, FSI will be master mode if it was SND_SOC_DAIFMT_CBS_CFS.

This patch fixup platform settings too.
Then, it tidyups SND_SOC_DAIFMT_INV settings.

Acked-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - removed dtsi settings.
   I confused on v1, dtsi settings doesn't need exchange
 - Added Simon's Acked-by

 arch/arm/mach-shmobile/board-armadillo800eva.c |    4 +---
 arch/arm/mach-shmobile/board-kzm9g.c           |    4 +---
 arch/arm/mach-shmobile/board-mackerel.c        |    6 ++----
 arch/sh/boards/mach-ecovec24/setup.c           |    4 +---
 arch/sh/boards/mach-se/7724/setup.c            |    4 +---
 sound/soc/sh/fsi.c                             |    2 +-
 6 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 93533e2..9323854 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -988,14 +988,12 @@ static struct asoc_simple_card_info fsi_wm8978_info = {
 	.card		= "FSI2A-WM8978",
 	.codec		= "wm8978.0-001a",
 	.platform	= "sh_fsi2",
-	.daifmt		= SND_SOC_DAIFMT_I2S,
+	.daifmt		= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM,
 	.cpu_dai = {
 		.name	= "fsia-dai",
-		.fmt	= SND_SOC_DAIFMT_CBS_CFS | SND_SOC_DAIFMT_IB_NF,
 	},
 	.codec_dai = {
 		.name	= "wm8978-hifi",
-		.fmt	= SND_SOC_DAIFMT_CBM_CFM | SND_SOC_DAIFMT_NB_NF,
 		.sysclk	= 12288000,
 	},
 };
diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index bc40b85..03dc3ac 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -589,14 +589,12 @@ static struct asoc_simple_card_info fsi2_ak4648_info = {
 	.card		= "FSI2A-AK4648",
 	.codec		= "ak4642-codec.0-0012",
 	.platform	= "sh_fsi2",
-	.daifmt		= SND_SOC_DAIFMT_LEFT_J,
+	.daifmt		= SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_CBM_CFM,
 	.cpu_dai = {
 		.name	= "fsia-dai",
-		.fmt	= SND_SOC_DAIFMT_CBS_CFS,
 	},
 	.codec_dai = {
 		.name	= "ak4642-hifi",
-		.fmt	= SND_SOC_DAIFMT_CBM_CFM,
 		.sysclk	= 11289600,
 	},
 };
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 3aba037..8c43321 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -509,9 +509,9 @@ static struct asoc_simple_card_info fsi2_hdmi_info = {
 	.card		= "FSI2B-HDMI",
 	.codec		= "sh-mobile-hdmi",
 	.platform	= "sh_fsi2",
+	.fmt		= SND_SOC_DAIFMT_CBS_CFS,
 	.cpu_dai = {
 		.name	= "fsib-dai",
-		.fmt	= SND_SOC_DAIFMT_CBM_CFM | SND_SOC_DAIFMT_IB_NF,
 	},
 	.codec_dai = {
 		.name	= "sh_mobile_hdmi-hifi",
@@ -905,14 +905,12 @@ static struct asoc_simple_card_info fsi2_ak4643_info = {
 	.card		= "FSI2A-AK4643",
 	.codec		= "ak4642-codec.0-0013",
 	.platform	= "sh_fsi2",
-	.daifmt		= SND_SOC_DAIFMT_LEFT_J,
+	.daifmt		= SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_CBM_CFM,
 	.cpu_dai = {
 		.name	= "fsia-dai",
-		.fmt	= SND_SOC_DAIFMT_CBS_CFS,
 	},
 	.codec_dai = {
 		.name	= "ak4642-hifi",
-		.fmt	= SND_SOC_DAIFMT_CBM_CFM,
 		.sysclk	= 11289600,
 	},
 };
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 5bc3a15..85d5255 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -861,14 +861,12 @@ static struct asoc_simple_card_info fsi_da7210_info = {
 	.card		= "FSIB-DA7210",
 	.codec		= "da7210.0-001a",
 	.platform	= "sh_fsi.0",
-	.daifmt		= SND_SOC_DAIFMT_I2S,
+	.daifmt		= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM,
 	.cpu_dai = {
 		.name	= "fsib-dai",
-		.fmt	= SND_SOC_DAIFMT_CBS_CFS | SND_SOC_DAIFMT_IB_NF,
 	},
 	.codec_dai = {
 		.name	= "da7210-hifi",
-		.fmt	= SND_SOC_DAIFMT_CBM_CFM,
 	},
 };
 
diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index 21e4230..1162bc6 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -304,14 +304,12 @@ static struct asoc_simple_card_info fsi_ak4642_info = {
 	.card		= "FSIA-AK4642",
 	.codec		= "ak4642-codec.0-0012",
 	.platform	= "sh_fsi.0",
-	.daifmt		= SND_SOC_DAIFMT_LEFT_J,
+	.daifmt		= SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_CBM_CFM,
 	.cpu_dai = {
 		.name	= "fsia-dai",
-		.fmt	= SND_SOC_DAIFMT_CBS_CFS | SND_SOC_DAIFMT_IB_NF,
 	},
 	.codec_dai = {
 		.name	= "ak4642-hifi",
-		.fmt	= SND_SOC_DAIFMT_CBM_CFM,
 		.sysclk	= 11289600,
 	},
 };
diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 1967f44..710a079 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1711,9 +1711,9 @@ static int fsi_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	/* set master/slave audio interface */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
-		fsi->clk_master = 1;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFS:
+		fsi->clk_master = 1; /* codec is slave, cpu is master */
 		break;
 	default:
 		return -EINVAL;
-- 
1.7.9.5

