From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 01 Oct 2013 02:37:15 +0000
Subject: [PATCH 10/12] ARM: shmobile: armadillo800eva: disable MMCIF Command Completion Signal
Message-Id: <fbf3264c046a6cce4cefec6e069fc86c0175f7d3.1380530519.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1380530519.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1380530519.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

MMCIF on r8a7740 doesn't support Command Completion Signal, a platform
parameter has to be added to disable it on armadillo800eva.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 5bd1479..fc8f9f8 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -823,6 +823,7 @@ static struct sh_mmcif_plat_data sh_mmcif_plat = {
 	.caps		= MMC_CAP_4_BIT_DATA |
 			  MMC_CAP_8_BIT_DATA |
 			  MMC_CAP_NONREMOVABLE,
+	.ccs_unsupported = true,
 	.slave_id_tx	= SHDMA_SLAVE_MMCIF_TX,
 	.slave_id_rx	= SHDMA_SLAVE_MMCIF_RX,
 };
-- 
1.8.4

