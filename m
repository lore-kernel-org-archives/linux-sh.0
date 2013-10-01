From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 01 Oct 2013 02:37:16 +0000
Subject: [PATCH 11/12] ARM: shmobile: kzm9g: disable MMCIF Command Completion Signal
Message-Id: <58d0bbd1a734831262157f006306f084dda9605d.1380530519.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1380530519.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1380530519.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

MMCIF on sh73a0 doesn't support Command Completion Signal, a platform
parameter has to be added to disable it on kzm9g.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-kzm9g.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index f199496..fe689b7 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -366,6 +366,7 @@ static struct resource sh_mmcif_resources[] = {
 static struct sh_mmcif_plat_data sh_mmcif_platdata = {
 	.ocr		= MMC_VDD_165_195,
 	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
+	.ccs_unsupported = true,
 	.slave_id_tx	= SHDMA_SLAVE_MMCIF_TX,
 	.slave_id_rx	= SHDMA_SLAVE_MMCIF_RX,
 };
-- 
1.8.4

