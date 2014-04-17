From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 17 Apr 2014 22:45:01 +0000
Subject: [PATCH 12/14] ARM: shmobile: lager: switch to use dai info for R-Car sound
Message-Id: <50f359d7389be354b46d781f3b234d3008d20f2f.1397774191.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1397774190.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1397774190.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Now, R-Car sound driver supports dai info settings.
switch to use it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index f0104bf..6af09e1 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -567,20 +567,27 @@ static struct resource rsnd_resources[] __initdata = {
 };
 
 static struct rsnd_ssi_platform_info rsnd_ssi[] = {
-	RSND_SSI_SET(0, 0, gic_spi(370), RSND_SSI_PLAY),
-	RSND_SSI_SET(0, 0, gic_spi(371), RSND_SSI_CLK_PIN_SHARE),
+	RSND_SSI(0, gic_spi(370), 0),
+	RSND_SSI(0, gic_spi(371), RSND_SSI_CLK_PIN_SHARE),
 };
 
-static struct rsnd_scu_platform_info rsnd_scu[2] = {
+static struct rsnd_src_platform_info rsnd_src[2] = {
 	/* no member at this point */
 };
 
+static struct rsnd_dai_platform_info rsnd_dai = {
+	.playback = { .ssi = &rsnd_ssi[0], },
+	.capture  = { .ssi = &rsnd_ssi[1], },
+};
+
 static struct rcar_snd_info rsnd_info = {
 	.flags		= RSND_GEN2,
 	.ssi_info	= rsnd_ssi,
 	.ssi_info_nr	= ARRAY_SIZE(rsnd_ssi),
-	.scu_info	= rsnd_scu,
-	.scu_info_nr	= ARRAY_SIZE(rsnd_scu),
+	.src_info	= rsnd_src,
+	.src_info_nr	= ARRAY_SIZE(rsnd_src),
+	.dai_info	= &rsnd_dai,
+	.dai_info_nr	= 1,
 };
 
 static struct asoc_simple_card_info rsnd_card_info = {
-- 
1.8.4

