From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 20 Jun 2011 14:51:10 +0000
Subject: [PATCH] mmc: tmio: fix regression: restore TMIO_MMC_WRPROTECT_DISABLE
Message-Id: <Pine.LNX.4.64.1106201648480.11365@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: Ian Molton <ian@mnementh.co.uk>, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <damm@opensource.se>

Commit b6147490e6aac82fa2f4b9d7fce925d9891ebe8f broke handling of the
TMIO_MMC_WRPROTECT_DISABLE flag by the tmio-mmc driver. This patch
restores the original behaviour.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Chris, please push for 3.0

Thanks
Guennadi

 drivers/mmc/host/tmio_mmc_pio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index ad6347b..0b09e82 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -824,8 +824,8 @@ static int tmio_mmc_get_ro(struct mmc_host *mmc)
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 	struct tmio_mmc_data *pdata = host->pdata;
 
-	return ((pdata->flags & TMIO_MMC_WRPROTECT_DISABLE) ||
-		!(sd_ctrl_read32(host, CTL_STATUS) & TMIO_STAT_WRPROTECT));
+	return !((pdata->flags & TMIO_MMC_WRPROTECT_DISABLE) ||
+		 (sd_ctrl_read32(host, CTL_STATUS) & TMIO_STAT_WRPROTECT));
 }
 
 static int tmio_mmc_get_cd(struct mmc_host *mmc)
-- 
1.7.2.5

