From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 17 Jan 2012 08:49:38 +0000
Subject: [PATCH] sh: fix the sh_mmcif_plat_data in board-sh7757lcr
Message-Id: <4F153622.3090701@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The board has an eMMC chip, so we cannot remove the chip.
In this case, we have to set the MMC_CAP_NONREMOVABLE to the caps
parameter.

Reported-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/boards/board-sh7757lcr.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/sh/boards/board-sh7757lcr.c b/arch/sh/boards/board-sh7757lcr.c
index 0838154..33dc5b6 100644
--- a/arch/sh/boards/board-sh7757lcr.c
+++ b/arch/sh/boards/board-sh7757lcr.c
@@ -222,7 +222,8 @@ static struct sh_mmcif_dma sh7757lcr_mmcif_dma = {
 static struct sh_mmcif_plat_data sh_mmcif_plat = {
 	.dma		= &sh7757lcr_mmcif_dma,
 	.sup_pclk	= 0x0f,
-	.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
+	.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA |
+			  MMC_CAP_NONREMOVABLE,
 	.ocr		= MMC_VDD_32_33 | MMC_VDD_33_34,
 };

-- 
1.7.1
