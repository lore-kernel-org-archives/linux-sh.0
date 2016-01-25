From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 25 Jan 2016 19:15:13 +0000
Subject: [PATCH 6/9] mmc: sdhi: use faster clock handling on RCar Gen2
Message-Id: <1453749316-1848-7-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1453749316-1848-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1453749316-1848-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Dirk Behme <dirk.behme@gmail.com>

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

