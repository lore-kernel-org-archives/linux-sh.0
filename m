From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 08 Aug 2013 21:44:03 +0000
Subject: [PATCH 2/2] ARM: shmobile: Marzen: enable DMA for SDHI0
Message-Id: <201308090144.03912.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201308090140.14515.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201308090140.14515.sergei.shtylyov@cogentembedded.com>
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

---
 arch/arm/mach-shmobile/board-marzen.c |    2 ++
 1 file changed, 2 insertions(+)

Index: renesas/arch/arm/mach-shmobile/board-marzen.c
=================================--- renesas.orig/arch/arm/mach-shmobile/board-marzen.c
+++ renesas/arch/arm/mach-shmobile/board-marzen.c
@@ -122,6 +122,8 @@ static struct resource sdhi0_resources[]
 };
 
 static struct sh_mobile_sdhi_info sdhi0_platform_data = {
+	.dma_slave_tx = HPBDMA_SLAVE_SDHI0_TX,
+	.dma_slave_rx = HPBDMA_SLAVE_SDHI0_RX,
 	.tmio_flags = TMIO_MMC_WRPROTECT_DISABLE | TMIO_MMC_HAS_IDLE_WAIT,
 	.tmio_caps = MMC_CAP_SD_HIGHSPEED,
 };
