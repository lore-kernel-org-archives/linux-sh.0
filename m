From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 25 Mar 2014 04:29:56 +0000
Subject: [PATCH 1/6] ARM: lager: fixup SND_SOC_DAIFMT_CBx_CFx flags
Message-Id: <87ha6mdhoe.wl%kuninori.morimoto.gx@gmail.com>
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

