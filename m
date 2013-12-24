From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 24 Dec 2013 04:44:23 +0000
Subject: [PATCH 2/3] ARM: shmobile: bockw: use HPBIF DMAEngine for sound
Message-Id: <8738lig8nv.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

R-Car sound driver is supporting Mem <-> SRU <-> SSI
transfer via DMAEngine.
The sound will be less noise if it uses SRU path
since it has FIFO.
This patch supports it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bockw.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index bdb78a7..24b4161 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -332,16 +332,24 @@ static struct rsnd_ssi_platform_info rsnd_ssi[] = {
 	RSND_SSI_UNUSED, /* SSI 0 */
 	RSND_SSI_UNUSED, /* SSI 1 */
 	RSND_SSI_UNUSED, /* SSI 2 */
-	RSND_SSI_SET(1, HPBDMA_SLAVE_SSI3_TX, gic_iid(0x85), RSND_SSI_PLAY),
-	RSND_SSI_SET(2, HPBDMA_SLAVE_SSI4_RX, gic_iid(0x85), RSND_SSI_CLK_PIN_SHARE),
-	RSND_SSI_SET(0, HPBDMA_SLAVE_SSI5_TX, gic_iid(0x86), RSND_SSI_PLAY),
-	RSND_SSI_SET(0, HPBDMA_SLAVE_SSI6_RX, gic_iid(0x86), 0),
-	RSND_SSI_SET(3, HPBDMA_SLAVE_SSI7_TX, gic_iid(0x86), RSND_SSI_PLAY),
-	RSND_SSI_SET(4, HPBDMA_SLAVE_SSI8_RX, gic_iid(0x86), RSND_SSI_CLK_PIN_SHARE),
+	RSND_SSI_SET(1, HPBDMA_SLAVE_HPBIF3_TX, gic_iid(0x85), RSND_SSI_PLAY),
+	RSND_SSI_SET(2, HPBDMA_SLAVE_HPBIF4_RX, gic_iid(0x85), RSND_SSI_CLK_PIN_SHARE),
+	RSND_SSI_SET(0, HPBDMA_SLAVE_HPBIF5_TX, gic_iid(0x86), RSND_SSI_PLAY),
+	RSND_SSI_SET(0, HPBDMA_SLAVE_HPBIF6_RX, gic_iid(0x86), 0),
+	RSND_SSI_SET(3, HPBDMA_SLAVE_HPBIF7_TX, gic_iid(0x86), RSND_SSI_PLAY),
+	RSND_SSI_SET(4, HPBDMA_SLAVE_HPBIF8_RX, gic_iid(0x86), RSND_SSI_CLK_PIN_SHARE),
 };
 
 static struct rsnd_scu_platform_info rsnd_scu[9] = {
-	/* no member at this point */
+	{ .flags = 0, }, /* SRU 0 */
+	{ .flags = 0, }, /* SRU 1 */
+	{ .flags = 0, }, /* SRU 2 */
+	{ .flags = RSND_SCU_USE_HPBIF, },
+	{ .flags = RSND_SCU_USE_HPBIF, },
+	{ .flags = RSND_SCU_USE_HPBIF, },
+	{ .flags = RSND_SCU_USE_HPBIF, },
+	{ .flags = RSND_SCU_USE_HPBIF, },
+	{ .flags = RSND_SCU_USE_HPBIF, },
 };
 
 enum {
-- 
1.7.9.5

