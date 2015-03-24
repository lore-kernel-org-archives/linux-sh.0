From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 24 Mar 2015 01:06:40 +0000
Subject: [PATCH 2/3] ARM: shmobile: armadillo800eva: fix clock inversion
Message-Id: <87d23z4329.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fv8v4353.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fv8v4353.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Simon <horms@verge.net.au>
Cc: Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>

From: Lars-Peter Clausen <lars@metafoo.de>

When operating in left-justfied mode both the frame-clock and the
bit-clock need to be inverted to be standards compliant.

This means that the exta clock inversion setting in the armadillo800eva
machine driver for CPU component should now be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
removed FSI driver fixup parts

 arch/arm/mach-shmobile/board-armadillo800eva.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index ac8e91d..bf37e3c 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1015,7 +1015,6 @@ static struct asoc_simple_card_info fsi_wm8978_info = {
 	.platform	= "sh_fsi2",
 	.daifmt		= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM,
 	.cpu_dai = {
-		.fmt	= SND_SOC_DAIFMT_IB_NF,
 		.name	= "fsia-dai",
 	},
 	.codec_dai = {
-- 
1.9.1

