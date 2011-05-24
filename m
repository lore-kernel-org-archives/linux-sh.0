From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 24 May 2011 10:40:33 +0000
Subject: [PATCH] ARM: mach-shmobile: Enable DMAEngine for MMCIF on AG5EVM
Message-Id: <20110524104033.10351.45149.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Simply add MMCIF slave ids for RX and TX to enable
DMA Engine support for the AG5EVM board.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Has a build time dependency on the patch:
 "[PATCH] ARM: mach-shmobile: sh73a0 DMA Engine support for SY-DMAC"

 arch/arm/mach-shmobile/board-ag5evm.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- 0009/arch/arm/mach-shmobile/board-ag5evm.c
+++ work/arch/arm/mach-shmobile/board-ag5evm.c	2011-05-24 17:48:42.000000000 +0900
@@ -158,10 +158,19 @@ static struct resource sh_mmcif_resource
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
 static struct sh_mmcif_plat_data sh_mmcif_platdata = {
 	.sup_pclk	= 0,
 	.ocr		= MMC_VDD_165_195,
 	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
+	.dma		= &sh_mmcif_dma,
 };
 
 static struct platform_device mmc_device = {
