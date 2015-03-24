From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 24 Mar 2015 01:06:01 +0000
Subject: [PATCH 1/3] ARM: shmobile: armadillo800eva: Properly specify HDMI audio link format
Message-Id: <87egof433b.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fv8v4353.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fv8v4353.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Simon <horms@verge.net.au>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>

From: Lars-Peter Clausen <lars@metafoo.de>

The DAI link format should be specified for the whole link rather than just
one component on the link. So move the format specification for the HDMI
audio link from the CPU component to the link itself.

Since the sh-mobile-hdmi DAI driver doesn't implement the set_fmt() callback
in this case there is no functional difference between only specifying the
the format for the CPU side or for the whole link, but the later it will
allow us to remove support for just specifying the format for one component.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
same as original patch

 arch/arm/mach-shmobile/board-armadillo800eva.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 7eac846..ac8e91d 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1040,9 +1040,9 @@ static struct asoc_simple_card_info fsi2_hdmi_info = {
 	.card		= "FSI2B-HDMI",
 	.codec		= "sh-mobile-hdmi",
 	.platform	= "sh_fsi2",
+	.daifmt		= SND_SOC_DAIFMT_CBS_CFS,
 	.cpu_dai = {
 		.name	= "fsib-dai",
-		.fmt	= SND_SOC_DAIFMT_CBS_CFS,
 	},
 	.codec_dai = {
 		.name = "sh_mobile_hdmi-hifi",
-- 
1.9.1

