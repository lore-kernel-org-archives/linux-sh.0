From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 17 Mar 2014 03:08:28 +0000
Subject: [PATCH] ARM: shmobkle: lager: fixup SND_SOC_DAIFMT_CBx_CFx flags
Message-Id: <87lhw9v7x2.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

SND_SOC_DAIFMT_CBx_CFx means "codec" side master/slave mode.
Then, rcar will be master mode if it was SND_SOC_DAIFMT_CBS_CFS.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
>> Simon

This patch is based on Mark's mark/fix/rcar branch.
I guess it will goes to linus/master soon.

 arch/arm/mach-shmobile/board-lager.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index f0104bf..18c7e03 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -588,14 +588,12 @@ static struct asoc_simple_card_info rsnd_card_info = {
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

