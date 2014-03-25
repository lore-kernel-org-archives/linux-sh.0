From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 25 Mar 2014 04:30:26 +0000
Subject: [PATCH 5/6] ARM: shmobile: bockw: switch to use dai info for R-Car sound
Message-Id: <87bnwudhnj.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Now, R-Car sound driver supports dai info settings.
switch to use it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bockw.c |   53 ++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 1aca107..f444be2 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -345,24 +345,39 @@ static struct rsnd_ssi_platform_info rsnd_ssi[] = {
 	RSND_SSI_UNUSED, /* SSI 0 */
 	RSND_SSI_UNUSED, /* SSI 1 */
 	RSND_SSI_UNUSED, /* SSI 2 */
-	RSND_SSI_SET(1, HPBDMA_SLAVE_HPBIF3_TX, gic_iid(0x85), RSND_SSI_PLAY),
-	RSND_SSI_SET(2, HPBDMA_SLAVE_HPBIF4_RX, gic_iid(0x85), RSND_SSI_CLK_PIN_SHARE),
-	RSND_SSI_SET(0, HPBDMA_SLAVE_HPBIF5_TX, gic_iid(0x86), RSND_SSI_PLAY),
-	RSND_SSI_SET(0, HPBDMA_SLAVE_HPBIF6_RX, gic_iid(0x86), 0),
-	RSND_SSI_SET(3, HPBDMA_SLAVE_HPBIF7_TX, gic_iid(0x86), RSND_SSI_PLAY),
-	RSND_SSI_SET(4, HPBDMA_SLAVE_HPBIF8_RX, gic_iid(0x86), RSND_SSI_CLK_PIN_SHARE),
+	RSND_SSI(HPBDMA_SLAVE_HPBIF3_TX, gic_iid(0x85), 0),
+	RSND_SSI(HPBDMA_SLAVE_HPBIF4_RX, gic_iid(0x85), RSND_SSI_CLK_PIN_SHARE),
+	RSND_SSI(HPBDMA_SLAVE_HPBIF5_TX, gic_iid(0x86), 0),
+	RSND_SSI(HPBDMA_SLAVE_HPBIF6_RX, gic_iid(0x86), 0),
+	RSND_SSI(HPBDMA_SLAVE_HPBIF7_TX, gic_iid(0x86), 0),
+	RSND_SSI(HPBDMA_SLAVE_HPBIF8_RX, gic_iid(0x86), RSND_SSI_CLK_PIN_SHARE),
 };
 
-static struct rsnd_scu_platform_info rsnd_scu[9] = {
-	{ .flags = 0, }, /* SRU 0 */
-	{ .flags = 0, }, /* SRU 1 */
-	{ .flags = 0, }, /* SRU 2 */
-	{ .flags = RSND_SCU_USE_HPBIF, },
-	{ .flags = RSND_SCU_USE_HPBIF, },
-	{ .flags = RSND_SCU_USE_HPBIF, },
-	{ .flags = RSND_SCU_USE_HPBIF, },
-	{ .flags = RSND_SCU_USE_HPBIF, },
-	{ .flags = RSND_SCU_USE_HPBIF, },
+static struct rsnd_src_platform_info rsnd_src[9] = {
+	RSND_SRC_UNUSED, /* SRU 0 */
+	RSND_SRC_UNUSED, /* SRU 1 */
+	RSND_SRC_UNUSED, /* SRU 2 */
+	RSND_SRC(0, 0),
+	RSND_SRC(0, 0),
+	RSND_SRC(0, 0),
+	RSND_SRC(0, 0),
+	RSND_SRC(0, 0),
+	RSND_SRC(0, 0),
+};
+
+static struct rsnd_dai_platform_info rsnd_dai[] = {
+	{
+		.playback = { .ssi = &rsnd_ssi[5], .src = &rsnd_src[5] },
+		.capture  = { .ssi = &rsnd_ssi[6], .src = &rsnd_src[6] },
+	}, {
+		.playback = { .ssi = &rsnd_ssi[3], .src = &rsnd_src[3] },
+	}, {
+		.capture  = { .ssi = &rsnd_ssi[4], .src = &rsnd_src[4] },
+	}, {
+		.playback = { .ssi = &rsnd_ssi[7], .src = &rsnd_src[7] },
+	}, {
+		.capture  = { .ssi = &rsnd_ssi[8], .src = &rsnd_src[8] },
+	},
 };
 
 enum {
@@ -437,8 +452,10 @@ static struct rcar_snd_info rsnd_info = {
 	.flags		= RSND_GEN1,
 	.ssi_info	= rsnd_ssi,
 	.ssi_info_nr	= ARRAY_SIZE(rsnd_ssi),
-	.scu_info	= rsnd_scu,
-	.scu_info_nr	= ARRAY_SIZE(rsnd_scu),
+	.src_info	= rsnd_src,
+	.src_info_nr	= ARRAY_SIZE(rsnd_src),
+	.dai_info	= rsnd_dai,
+	.dai_info_nr	= ARRAY_SIZE(rsnd_dai),
 	.start		= rsnd_start,
 	.stop		= rsnd_stop,
 };
-- 
1.7.9.5

