From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 09 Oct 2013 06:50:51 +0000
Subject: [PATCH 03/14] ARM: shmobile: marzen: enable DMA for SDHI0
Message-Id: <e6a8b11b82fdeaa78dad52552f945b772ee1a5c9.1381299817.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1381299817.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1381299817.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Max Filippov <max.filippov@cogentembedded.com>

Pass HPB-DMA slave IDs in the SDHI0 platform data to enable DMA in the SDHI
driver.

Signed-off-by: Max Filippov <max.filippov@cogentembedded.com>
[Sergei: removed #include <mach/dma.h>]
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 434b213..da1352f 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -125,6 +125,8 @@ static struct resource sdhi0_resources[] = {
 };
 
 static struct sh_mobile_sdhi_info sdhi0_platform_data = {
+	.dma_slave_tx = HPBDMA_SLAVE_SDHI0_TX,
+	.dma_slave_rx = HPBDMA_SLAVE_SDHI0_RX,
 	.tmio_flags = TMIO_MMC_WRPROTECT_DISABLE | TMIO_MMC_HAS_IDLE_WAIT,
 	.tmio_caps = MMC_CAP_SD_HIGHSPEED,
 };
-- 
1.8.4

