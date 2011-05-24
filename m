From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 24 May 2011 10:42:15 +0000
Subject: [PATCH] ARM: mach-shmobile: Enable DMAEngine for SDHI on AG5EVM
Message-Id: <20110524104215.10359.57815.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
References: <20110524104033.10351.45149.sendpatchset@t400s>
In-Reply-To: <20110524104033.10351.45149.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add SDHI0 and SDHI1 slave ids for RX and TX to enable
DMA Engine support for SDHI on the AG5EVM board.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Has a build time dependency on the patch:
 "[PATCH] ARM: mach-shmobile: sh73a0 DMA Engine support for SY-DMAC"

 arch/arm/mach-shmobile/board-ag5evm.c |    4 ++++
 1 file changed, 4 insertions(+)

--- 0013/arch/arm/mach-shmobile/board-ag5evm.c
+++ work/arch/arm/mach-shmobile/board-ag5evm.c	2011-05-24 18:00:53.000000000 +0900
@@ -339,6 +339,8 @@ static struct platform_device mipidsi0_d
 };
 
 static struct sh_mobile_sdhi_info sdhi0_info = {
+	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
+	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED,
 	.tmio_ocr_mask	= MMC_VDD_27_28 | MMC_VDD_28_29,
 };
@@ -380,6 +382,8 @@ void ag5evm_sdhi1_set_pwr(struct platfor
 }
 
 static struct sh_mobile_sdhi_info sh_sdhi1_platdata = {
+	.dma_slave_tx	= SHDMA_SLAVE_SDHI1_TX,
+	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
 	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE,
 	.tmio_caps	= MMC_CAP_NONREMOVABLE,
 	.tmio_ocr_mask	= MMC_VDD_32_33 | MMC_VDD_33_34,
