From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 05 May 2011 15:56:31 +0000
Subject: [PATCH 2/2] ARM: mach-shmobile: add DMA for MMCIF on mackerel
Message-Id: <Pine.LNX.4.64.1105051755100.29735@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add DMA mode support for the MMCIF controller on mackerel.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-mackerel.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 8fe1f00..5b09cb5 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -803,6 +803,15 @@ static struct resource sh_mmcif_resources[] = {
 	},
 };
 
+static struct sh_mmcif_dma sh_mmcif_dma = {
+	.chan_priv_rx	= {
+		.slave_id	= SHDMA_SLAVE_MMCIF_RX,
+	},
+	.chan_priv_tx	= {
+		.slave_id	= SHDMA_SLAVE_MMCIF_TX,
+	},
+};
+
 static struct sh_mmcif_plat_data sh_mmcif_plat = {
 	.sup_pclk	= 0,
 	.ocr		= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
@@ -810,6 +819,7 @@ static struct sh_mmcif_plat_data sh_mmcif_plat = {
 			  MMC_CAP_8_BIT_DATA |
 			  MMC_CAP_NEEDS_POLL,
 	.get_cd		= slot_cn7_get_cd,
+	.dma		= &sh_mmcif_dma,
 };
 
 static struct platform_device sh_mmcif_device = {
-- 
1.7.2.5

