From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 02 Sep 2010 07:20:40 +0000
Subject: [PATCH] ARM: mach-shmobile: pfc-sh7372: modify wrong comment
Message-Id: <w3p62yooblk.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/pfc-sh7372.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/pfc-sh7372.c b/arch/arm/mach-shmobile/pfc-sh7372.c
index ec42035..9c265da 100644
--- a/arch/arm/mach-shmobile/pfc-sh7372.c
+++ b/arch/arm/mach-shmobile/pfc-sh7372.c
@@ -166,12 +166,12 @@ enum {
 	MSIOF2_TSYNC_MARK,	MSIOF2_TSCK_MARK,	MSIOF2_RXD_MARK,
 	MSIOF2_TXD_MARK,
 
-	/* MSIOF3 */
+	/* BBIF1 */
 	BBIF1_RXD_MARK,		BBIF1_TSYNC_MARK,	BBIF1_TSCK_MARK,
 	BBIF1_TXD_MARK,		BBIF1_RSCK_MARK,	BBIF1_RSYNC_MARK,
 	BBIF1_FLOW_MARK,	BB_RX_FLOW_N_MARK,
 
-	/* MSIOF4 */
+	/* BBIF2 */
 	BBIF2_TSCK1_MARK,	BBIF2_TSYNC1_MARK,
 	BBIF2_TXD1_MARK,	BBIF2_RXD_MARK,
 
@@ -976,12 +976,12 @@ static struct pinmux_gpio pinmux_gpios[] = {
 	GPIO_FN(MSIOF2_TSYNC),	GPIO_FN(MSIOF2_TSCK),	GPIO_FN(MSIOF2_RXD),
 	GPIO_FN(MSIOF2_TXD),
 
-	/* MSIOF3 */
+	/* BBIF1 */
 	GPIO_FN(BBIF1_RXD),	GPIO_FN(BBIF1_TSYNC),	GPIO_FN(BBIF1_TSCK),
 	GPIO_FN(BBIF1_TXD),	GPIO_FN(BBIF1_RSCK),	GPIO_FN(BBIF1_RSYNC),
 	GPIO_FN(BBIF1_FLOW),	GPIO_FN(BB_RX_FLOW_N),
 
-	/* MSIOF4 */
+	/* BBIF2 */
 	GPIO_FN(BBIF2_TSCK1),	GPIO_FN(BBIF2_TSYNC1),
 	GPIO_FN(BBIF2_TXD1),	GPIO_FN(BBIF2_RXD),
 
-- 
1.7.0.4

