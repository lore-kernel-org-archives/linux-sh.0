From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 29 Mar 2013 21:05:49 +0000
Subject: [PATCH v3 2/5] ARM: shmobile: mackerel: remove OCR masks, where regulators are used
Message-Id: <1364591152-4780-3-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Both SDHI and MMCIF drivers ignore their OCR platform values, when
available voltages can be retrieved from regulators.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/mach-shmobile/board-mackerel.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index c4f80d4..734565d 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1014,7 +1014,6 @@ static struct platform_device sdhi0_device = {
 static struct sh_mobile_sdhi_info sdhi1_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI1_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
-	.tmio_ocr_mask	= MMC_VDD_165_195,
 	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_NEEDS_POLL,
@@ -1125,7 +1124,6 @@ static struct resource sh_mmcif_resources[] = {
 
 static struct sh_mmcif_plat_data sh_mmcif_plat = {
 	.sup_pclk	= 0,
-	.ocr		= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
 	.caps		= MMC_CAP_4_BIT_DATA |
 			  MMC_CAP_8_BIT_DATA |
 			  MMC_CAP_NEEDS_POLL,
-- 
1.7.2.5

