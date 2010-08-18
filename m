From: Arnd Hannemann <arnd@arndnet.de>
Date: Wed, 18 Aug 2010 16:24:13 +0000
Subject: [PATCH] ARM: mach-shmobile: ap4evb: fix write protect for SDHI1
Message-Id: <1282148653-5000-1-git-send-email-arnd@arndnet.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SDHI1 on AP4EVB has no pin to detect write protection of a card.
This had the result that a card inserted in this slot was always detected
as read only. This patch adds the corresponding flag to disable
write protection detection for SDHI1.

Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
---
 arch/arm/mach-shmobile/board-ap4evb.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 23d472f..97c31fe 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -25,6 +25,7 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/mfd/sh_mobile_sdhi.h>
+#include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
@@ -307,6 +308,7 @@ static struct sh_mobile_sdhi_info sdhi1_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI1_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
 	.tmio_ocr_mask	= MMC_VDD_165_195,
+	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE,
 };
 
 static struct resource sdhi1_resources[] = {
-- 
1.7.0.4

