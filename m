From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 19 Jan 2016 16:20:59 +0000
Subject: [RFC 4/6] mmc: tmio: remove stale comments
Message-Id: <1453220461-2598-5-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

These don't make sense anymore since commit 5d60e500541ed1 ("mmc: tmio:
add new TMIO_MMC_HAVE_HIGH_REG flags") dropped using the function
checking the resource.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index de1edb794c53a0..f8103bab0fce31 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -177,7 +177,6 @@ static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
 
 static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
 {
-	/* implicit BUG_ON(!res) */
 	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG) {
 		sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0000);
 		msleep(10);
@@ -194,7 +193,6 @@ static void tmio_mmc_clk_start(struct tmio_mmc_host *host)
 		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
 	msleep(host->pdata->flags & TMIO_MMC_FAST_CLK_CHG ? 1 : 10);
 
-	/* implicit BUG_ON(!res) */
 	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG) {
 		sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0100);
 		msleep(10);
@@ -205,7 +203,6 @@ static void tmio_mmc_reset(struct tmio_mmc_host *host)
 {
 	/* FIXME - should we set stop clock reg here */
 	sd_ctrl_write16(host, CTL_RESET_SD, 0x0000);
-	/* implicit BUG_ON(!res) */
 	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG)
 		sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0000);
 	msleep(10);
-- 
2.1.4

