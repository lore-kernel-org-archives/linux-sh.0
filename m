From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 08 Sep 2014 05:30:53 +0000
Subject: [PATCH][RFC] mmc: tmio_mmc: remove msleep(10) from tmio_mmc_clk_xxx()
Message-Id: <87vboyof05.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>
Cc: Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Shinobu Uehara <shinobu.uehara.xc@renesas.com>

From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>

Current tmio_mmc driver is calling msleep(10) in tmio_mmc_clk_xxx().
But, it has not been documented, and will be low performance,
especially if CONFIG_MMC_CLKGATE was enabled.
This patch remove it

[Kuninori Morimoto: tidyuped for upstreaming]

Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/mmc/host/tmio_mmc_pio.c |   14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index ba45413..657c33d 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -170,33 +170,26 @@ static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
 		host->set_clk_div(host->pdev, (clk>>22) & 1);
 
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk & 0x1ff);
-	msleep(10);
 }
 
 static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
 {
 	/* implicit BUG_ON(!res) */
-	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG) {
+	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG)
 		sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0000);
-		msleep(10);
-	}
 
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~0x0100 &
 		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
-	msleep(10);
 }
 
 static void tmio_mmc_clk_start(struct tmio_mmc_host *host)
 {
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, 0x0100 |
 		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
-	msleep(10);
 
 	/* implicit BUG_ON(!res) */
-	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG) {
+	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG)
 		sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0100);
-		msleep(10);
-	}
 }
 
 static void tmio_mmc_reset(struct tmio_mmc_host *host)
@@ -206,11 +199,10 @@ static void tmio_mmc_reset(struct tmio_mmc_host *host)
 	/* implicit BUG_ON(!res) */
 	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG)
 		sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0000);
-	msleep(10);
+
 	sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
 	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG)
 		sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0001);
-	msleep(10);
 }
 
 static void tmio_mmc_reset_work(struct work_struct *work)
-- 
1.7.9.5

