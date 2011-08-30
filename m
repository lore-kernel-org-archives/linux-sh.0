From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 30 Aug 2011 16:26:44 +0000
Subject: [PATCH 2/2] ARM: mach-shmobile: simplify MMCIF DMA configuration
Message-Id: <Pine.LNX.4.64.1108301825450.19151@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1108301819150.19151@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1108301819150.19151@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Chris Ball <cjb@laptop.org>

Use the simplified method to specify MMCIF DMA slave configuration.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-ag5evm.c   |   11 ++---------
 arch/arm/mach-shmobile/board-ap4evb.c   |   12 ++----------
 arch/arm/mach-shmobile/board-mackerel.c |   12 ++----------
 3 files changed, 6 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index ce5c251..7f26ecc 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -158,19 +158,12 @@ static struct resource sh_mmcif_resources[] = {
 	},
 };
 
-static struct sh_mmcif_dma sh_mmcif_dma = {
-	.chan_priv_rx	= {
-		.slave_id	= SHDMA_SLAVE_MMCIF_RX,
-	},
-	.chan_priv_tx	= {
-		.slave_id	= SHDMA_SLAVE_MMCIF_TX,
-	},
-};
 static struct sh_mmcif_plat_data sh_mmcif_platdata = {
 	.sup_pclk	= 0,
 	.ocr		= MMC_VDD_165_195,
 	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
-	.dma		= &sh_mmcif_dma,
+	.slave_id_tx	= SHDMA_SLAVE_MMCIF_TX,
+	.slave_id_rx	= SHDMA_SLAVE_MMCIF_RX,
 };
 
 static struct platform_device mmc_device = {
diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index f530bf2..b8ed7a7 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -293,15 +293,6 @@ static struct resource sh_mmcif_resources[] = {
 	},
 };
 
-static struct sh_mmcif_dma sh_mmcif_dma = {
-	.chan_priv_rx	= {
-		.slave_id	= SHDMA_SLAVE_MMCIF_RX,
-	},
-	.chan_priv_tx	= {
-		.slave_id	= SHDMA_SLAVE_MMCIF_TX,
-	},
-};
-
 static struct sh_mmcif_plat_data sh_mmcif_plat = {
 	.sup_pclk	= 0,
 	.ocr		= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
@@ -309,7 +300,8 @@ static struct sh_mmcif_plat_data sh_mmcif_plat = {
 			  MMC_CAP_8_BIT_DATA |
 			  MMC_CAP_NEEDS_POLL,
 	.get_cd		= slot_cn7_get_cd,
-	.dma		= &sh_mmcif_dma,
+	.slave_id_tx	= SHDMA_SLAVE_MMCIF_TX,
+	.slave_id_rx	= SHDMA_SLAVE_MMCIF_RX,
 };
 
 static struct platform_device sh_mmcif_device = {
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 7e7da60..dfae824 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1164,15 +1164,6 @@ static struct resource sh_mmcif_resources[] = {
 	},
 };
 
-static struct sh_mmcif_dma sh_mmcif_dma = {
-	.chan_priv_rx	= {
-		.slave_id	= SHDMA_SLAVE_MMCIF_RX,
-	},
-	.chan_priv_tx	= {
-		.slave_id	= SHDMA_SLAVE_MMCIF_TX,
-	},
-};
-
 static struct sh_mmcif_plat_data sh_mmcif_plat = {
 	.sup_pclk	= 0,
 	.ocr		= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
@@ -1180,7 +1171,8 @@ static struct sh_mmcif_plat_data sh_mmcif_plat = {
 			  MMC_CAP_8_BIT_DATA |
 			  MMC_CAP_NEEDS_POLL,
 	.get_cd		= slot_cn7_get_cd,
-	.dma		= &sh_mmcif_dma,
+	.slave_id_tx	= SHDMA_SLAVE_MMCIF_TX,
+	.slave_id_rx	= SHDMA_SLAVE_MMCIF_RX,
 };
 
 static struct platform_device sh_mmcif_device = {
-- 
1.7.2.5

