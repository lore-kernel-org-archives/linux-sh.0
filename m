From: Lars-Peter Clausen <lars@metafoo.de>
Date: Wed, 21 Jan 2015 13:38:10 +0000
Subject: [PATCH v2 1/3] ARM: shmobile: armadillo800eva: Properly specify HDMI audio link format
Message-Id: <1421847492-8857-1-git-send-email-lars@metafoo.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>

The DAI link format should be specified for the whole link rather than just
one component on the link. So move the format specification for the HDMI
audio link from the CPU component to the link itself.

Since the sh-mobile-hdmi DAI driver doesn't implement the set_fmt() callback
in this case there is no functional difference between only specifying the
the format for the CPU side or for the whole link, but the later it will
allow us to remove support for just specifying the format for one component.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
No changes since v1.
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 6d949f1..75de26c 100644
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
1.8.0

