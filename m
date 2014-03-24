From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 24 Mar 2014 03:27:30 +0000
Subject: [PATCH] ARM: bockw: fixup SND_SOC_DAIFMT_CBx_CFx flags
Message-Id: <87ha6oi8dg.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

SND_SOC_DAIFMT_CBx_CFx means "codec" side master/slave mode.
Then, rcar will be master mode if it was SND_SOC_DAIFMT_CBS_CFS.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
>> Mark, Simon

I'm so sorry. current Mark's fix/rcar branch has
SND_SOC_DAIFMT_CBx_CFx fixup patches,
but it didn't care about bockw board.
This patch is for it.
This Subject is using "ARM: bockw:" prefix,
but, should it be "ASoC: rcar" ?

 arch/arm/mach-shmobile/board-bockw.c |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index b5867b7..f444be2 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -467,14 +467,12 @@ static struct asoc_simple_card_info rsnd_card_info[] = {
 		.card		= "SSI56-AK4643",
 		.codec		= "ak4642-codec.0-0012",
 		.platform	= "rcar_sound",
-		.daifmt		= SND_SOC_DAIFMT_LEFT_J,
+		.daifmt		= SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_CBM_CFM,
 		.cpu_dai = {
 			.name	= "rsnd-dai.0",
-			.fmt	= SND_SOC_DAIFMT_CBS_CFS,
 		},
 		.codec_dai = {
 			.name	= "ak4642-hifi",
-			.fmt	= SND_SOC_DAIFMT_CBM_CFM,
 			.sysclk	= 11289600,
 		},
 	},
@@ -484,10 +482,9 @@ static struct asoc_simple_card_info rsnd_card_info[] = {
 		.card		= "SSI3-AK4554(playback)",
 		.codec		= "ak4554-adc-dac.0",
 		.platform	= "rcar_sound",
+		.daifmt		= SND_SOC_DAIFMT_CBS_CFS | SND_SOC_DAIFMT_RIGHT_J,
 		.cpu_dai = {
 			.name	= "rsnd-dai.1",
-			.fmt	= SND_SOC_DAIFMT_CBM_CFM |
-				  SND_SOC_DAIFMT_RIGHT_J,
 		},
 		.codec_dai = {
 			.name	= "ak4554-hifi",
@@ -499,10 +496,9 @@ static struct asoc_simple_card_info rsnd_card_info[] = {
 		.card		= "SSI4-AK4554(capture)",
 		.codec		= "ak4554-adc-dac.0",
 		.platform	= "rcar_sound",
+		.daifmt		= SND_SOC_DAIFMT_CBS_CFS | SND_SOC_DAIFMT_LEFT_J,
 		.cpu_dai = {
 			.name	= "rsnd-dai.2",
-			.fmt	= SND_SOC_DAIFMT_CBM_CFM |
-				  SND_SOC_DAIFMT_LEFT_J,
 		},
 		.codec_dai = {
 			.name	= "ak4554-hifi",
@@ -514,10 +510,9 @@ static struct asoc_simple_card_info rsnd_card_info[] = {
 		.card		= "SSI7-AK4554(playback)",
 		.codec		= "ak4554-adc-dac.1",
 		.platform	= "rcar_sound",
+		.daifmt		= SND_SOC_DAIFMT_CBS_CFS | SND_SOC_DAIFMT_RIGHT_J,
 		.cpu_dai = {
 			.name	= "rsnd-dai.3",
-			.fmt	= SND_SOC_DAIFMT_CBM_CFM |
-				  SND_SOC_DAIFMT_RIGHT_J,
 		},
 		.codec_dai = {
 			.name	= "ak4554-hifi",
@@ -529,10 +524,9 @@ static struct asoc_simple_card_info rsnd_card_info[] = {
 		.card		= "SSI8-AK4554(capture)",
 		.codec		= "ak4554-adc-dac.1",
 		.platform	= "rcar_sound",
+		.daifmt		= SND_SOC_DAIFMT_CBS_CFS | SND_SOC_DAIFMT_LEFT_J,
 		.cpu_dai = {
 			.name	= "rsnd-dai.4",
-			.fmt	= SND_SOC_DAIFMT_CBM_CFM |
-				  SND_SOC_DAIFMT_LEFT_J,
 		},
 		.codec_dai = {
 			.name	= "ak4554-hifi",
-- 
1.7.9.5

