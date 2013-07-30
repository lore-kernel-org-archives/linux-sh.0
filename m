From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 30 Jul 2013 09:00:49 +0000
Subject: [PATCH 1/5] ARM: shmobile: armadillo800eva: add DMA support to MMCIF
Message-Id: <872842084c6f01d5f9d1a4c9b7e39a3d68d0630d.1375174556.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1375174556.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1375174556.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Add DMA slave IDs to MMCIF Tx and Rx channels.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 66cfd56..4432f05 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -779,6 +779,8 @@ static struct sh_mmcif_plat_data sh_mmcif_plat = {
 	.caps		= MMC_CAP_4_BIT_DATA |
 			  MMC_CAP_8_BIT_DATA |
 			  MMC_CAP_NONREMOVABLE,
+	.slave_id_tx	= SHDMA_SLAVE_MMCIF_TX,
+	.slave_id_rx	= SHDMA_SLAVE_MMCIF_RX,
 };
 
 static struct resource sh_mmcif_resources[] = {
-- 
1.8.3.2

