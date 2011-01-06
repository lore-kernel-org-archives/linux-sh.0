From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 06 Jan 2011 10:55:41 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7372 Enable SDIO IRQs for Mackerel
Message-Id: <20110106105541.16675.33745.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Enable SDIO IRQ support for the Mackerel board.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-mackerel.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-mackerel.c
+++ work/arch/arm/mach-shmobile/board-mackerel.c	2011-01-06 19:48:22.000000000 +0900
@@ -462,7 +462,7 @@ static int slot_cn7_get_cd(struct platfo
 static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
-	.tmio_caps	= MMC_CAP_SD_HIGHSPEED,
+	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
 };
 
 static struct resource sdhi0_resources[] = {
@@ -495,7 +495,7 @@ static struct sh_mobile_sdhi_info sdhi1_
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
 	.tmio_ocr_mask	= MMC_VDD_165_195,
 	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE,
-	.tmio_caps	= MMC_CAP_SD_HIGHSPEED |
+	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_NEEDS_POLL,
 	.get_cd		= slot_cn7_get_cd,
 };
@@ -529,7 +529,7 @@ static struct sh_mobile_sdhi_info sdhi2_
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI2_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI2_RX,
 	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE,
-	.tmio_caps	= MMC_CAP_SD_HIGHSPEED |
+	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_NEEDS_POLL,
 };
 
