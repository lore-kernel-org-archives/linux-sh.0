From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 18 Jan 2012 09:24:17 +0000
Subject: [PATCH] sh: sh7757lcr: update to the new MMCIF DMA configuration
Message-Id: <Pine.LNX.4.64.1201181016330.28782@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Specifying MMCIF DMA slave IDs via a struct sh_mmcif_dma instance is
deprecated. Update sh7757lcr to specify slave IDs embedded in
struct sh_mmcif_plat_data.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Would be good to get this upstream asap, then we could remove struct 
sh_mmcif_dma for 3.4, which is also a part of the following patch series.

 arch/sh/boards/board-sh7757lcr.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/sh/boards/board-sh7757lcr.c b/arch/sh/boards/board-sh7757lcr.c
index 895e337..d9deb15 100644
--- a/arch/sh/boards/board-sh7757lcr.c
+++ b/arch/sh/boards/board-sh7757lcr.c
@@ -209,20 +209,12 @@ static struct resource sh_mmcif_resources[] = {
 	},
 };
 
-static struct sh_mmcif_dma sh7757lcr_mmcif_dma = {
-	.chan_priv_tx	= {
-		.slave_id = SHDMA_SLAVE_MMCIF_TX,
-	},
-	.chan_priv_rx	= {
-		.slave_id = SHDMA_SLAVE_MMCIF_RX,
-	}
-};
-
 static struct sh_mmcif_plat_data sh_mmcif_plat = {
-	.dma		= &sh7757lcr_mmcif_dma,
 	.sup_pclk	= 0x0f,
 	.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 	.ocr		= MMC_VDD_32_33 | MMC_VDD_33_34,
+	.slave_id_tx	= SHDMA_SLAVE_MMCIF_TX,
+	.slave_id_rx	= SHDMA_SLAVE_MMCIF_RX,
 };
 
 static struct platform_device sh_mmcif_device = {
-- 
1.7.2.5

