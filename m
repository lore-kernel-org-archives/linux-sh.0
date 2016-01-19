From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 19 Jan 2016 16:21:00 +0000
Subject: [RFC 5/6] mmc: sdhi: use faster clock handling on RCar Gen2
Message-Id: <1453220461-2598-6-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 5a10fb3c01a1dd..557e2b9dadeec7 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -59,7 +59,7 @@ static const struct sh_mobile_sdhi_of_data of_rcar_gen1_compatible = {
 
 static const struct sh_mobile_sdhi_of_data of_rcar_gen2_compatible = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
-			  TMIO_MMC_CLK_ACTUAL,
+			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_FAST_CLK_CHG,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
 	.dma_buswidth	= DMA_SLAVE_BUSWIDTH_4_BYTES,
 	.dma_rx_offset	= 0x2000,
-- 
2.1.4

