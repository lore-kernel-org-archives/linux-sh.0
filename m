From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 09 Jun 2011 08:54:37 +0000
Subject: [PATCH] ARM: mach-shmobile: AG5EVM SDHI1 platform data update
Message-Id: <20110609090225.14384.8628.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add a flag for SDHI1 to enable SDIO IRQ, and remove DMA Engine
slave id:s to disable DMA as a workaround.

Tested on sh73a0/AG5EVM with a BCM4318-based SDIO card.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-ag5evm.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-ag5evm.c
+++ work/arch/arm/mach-shmobile/board-ag5evm.c	2011-06-09 17:58:37.000000000 +0900
@@ -382,10 +382,8 @@ void ag5evm_sdhi1_set_pwr(struct platfor
 }
 
 static struct sh_mobile_sdhi_info sh_sdhi1_platdata = {
-	.dma_slave_tx	= SHDMA_SLAVE_SDHI1_TX,
-	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
 	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE,
-	.tmio_caps	= MMC_CAP_NONREMOVABLE,
+	.tmio_caps	= MMC_CAP_NONREMOVABLE | MMC_CAP_SDIO_IRQ,
 	.tmio_ocr_mask	= MMC_VDD_32_33 | MMC_VDD_33_34,
 	.set_pwr	= ag5evm_sdhi1_set_pwr,
 };
