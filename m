From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 24 Dec 2013 04:44:15 +0000
Subject: [PATCH 1/3] ARM: shmobile: bockw: use SSI DMAEngine for sound
Message-Id: <874n5yg8o3.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

R-Car sound driver is supporting Mem <-> SSI
direct transfer via DMAEngine.
Current HPB-DMA is using double plane transfer,
but the sound may have noise since SSI doesn't have FIFO.
This patch supports it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bockw.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index c475220..bdb78a7 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -332,12 +332,12 @@ static struct rsnd_ssi_platform_info rsnd_ssi[] = {
 	RSND_SSI_UNUSED, /* SSI 0 */
 	RSND_SSI_UNUSED, /* SSI 1 */
 	RSND_SSI_UNUSED, /* SSI 2 */
-	RSND_SSI_SET(1, 0, gic_iid(0x85), RSND_SSI_PLAY),
-	RSND_SSI_SET(2, 0, gic_iid(0x85), RSND_SSI_CLK_PIN_SHARE),
-	RSND_SSI_SET(0, 0, gic_iid(0x86), RSND_SSI_PLAY),
-	RSND_SSI_SET(0, 0, gic_iid(0x86), 0),
-	RSND_SSI_SET(3, 0, gic_iid(0x86), RSND_SSI_PLAY),
-	RSND_SSI_SET(4, 0, gic_iid(0x86), RSND_SSI_CLK_PIN_SHARE),
+	RSND_SSI_SET(1, HPBDMA_SLAVE_SSI3_TX, gic_iid(0x85), RSND_SSI_PLAY),
+	RSND_SSI_SET(2, HPBDMA_SLAVE_SSI4_RX, gic_iid(0x85), RSND_SSI_CLK_PIN_SHARE),
+	RSND_SSI_SET(0, HPBDMA_SLAVE_SSI5_TX, gic_iid(0x86), RSND_SSI_PLAY),
+	RSND_SSI_SET(0, HPBDMA_SLAVE_SSI6_RX, gic_iid(0x86), 0),
+	RSND_SSI_SET(3, HPBDMA_SLAVE_SSI7_TX, gic_iid(0x86), RSND_SSI_PLAY),
+	RSND_SSI_SET(4, HPBDMA_SLAVE_SSI8_RX, gic_iid(0x86), RSND_SSI_CLK_PIN_SHARE),
 };
 
 static struct rsnd_scu_platform_info rsnd_scu[9] = {
-- 
1.7.9.5

