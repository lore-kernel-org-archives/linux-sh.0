From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 17 Apr 2014 00:32:10 +0000
Subject: [PATCH 2/5] ARM: shmobile: armadillo800eva: fixup SND_SOC_DAIFMT_CBx_CFx flags
Message-Id: <7b707277e734c553a8043e9b4d530eb47f4d60c8.1397694064.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1397694064.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1397694064.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

c7a507eea1db1430476289f525f9c853d5d485e8
(ASoC: fsi: fixup SND_SOC_DAIFMT_CBx_CFx flags)
exchanged sound flags, but armadillo800eva flags needs IB_NF.
The recorded sound will be noise without this patch.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 2858f38..486063d 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -992,6 +992,7 @@ static struct asoc_simple_card_info fsi_wm8978_info = {
 	.platform	= "sh_fsi2",
 	.daifmt		= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM,
 	.cpu_dai = {
+		.fmt	= SND_SOC_DAIFMT_IB_NF,
 		.name	= "fsia-dai",
 	},
 	.codec_dai = {
-- 
1.8.4

