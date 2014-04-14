From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 14 Apr 2014 00:59:34 +0000
Subject: [PATCH] ARM: shmobile: lager: fixup SND_SOC_DAIFMT_CBx_CFx flags
Message-Id: <87ha5w20b0.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

e1508289404ab6ca28e0dc931612600f0441c417
(ASoC: rcar: fixup SND_SOC_DAIFMT_CBx_CFx flags)
corrected SND_SOC_DAIFMT_CBx_CFx definition.
But then, Lager board was maintenanced other branch.
This patch correct SND_SOC_DAIFMT_CBx_CFx flag for lager

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-lager.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 6af09e1..05c263b 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -595,14 +595,12 @@ static struct asoc_simple_card_info rsnd_card_info = {
 	.card		= "SSI01-AK4643",
 	.codec		= "ak4642-codec.2-0012",
 	.platform	= "rcar_sound",
-	.daifmt		= SND_SOC_DAIFMT_LEFT_J,
+	.daifmt		= SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_CBM_CFM,
 	.cpu_dai = {
 		.name	= "rcar_sound",
-		.fmt	= SND_SOC_DAIFMT_CBS_CFS,
 	},
 	.codec_dai = {
 		.name	= "ak4642-hifi",
-		.fmt	= SND_SOC_DAIFMT_CBM_CFM,
 		.sysclk	= 11289600,
 	},
 };
-- 
1.7.9.5

