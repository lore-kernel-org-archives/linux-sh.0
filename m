From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 25 Jan 2016 19:15:12 +0000
Subject: [PATCH 5/9] mmc: tmio: remove stale comments
Message-Id: <1453749316-1848-6-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1453749316-1848-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1453749316-1848-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Dirk Behme <dirk.behme@gmail.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

These don't make sense anymore. Since commit 5d60e500541ed1 ("mmc: tmio:
add new TMIO_MMC_HAVE_HIGH_REG flags"), we don't deal with a resource
here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index ffff687e98b1e3..207e77a09cda51 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -178,7 +178,6 @@ static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
 
 static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
 {
-	/* implicit BUG_ON(!res) */
 	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG) {
 		sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0000);
 		msleep(10);
@@ -195,7 +194,6 @@ static void tmio_mmc_clk_start(struct tmio_mmc_host *host)
 		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
 	msleep(host->pdata->flags & TMIO_MMC_FAST_CLK_CHG ? 1 : 10);
 
-	/* implicit BUG_ON(!res) */
 	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG) {
 		sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0100);
 		msleep(10);
@@ -206,7 +204,6 @@ static void tmio_mmc_reset(struct tmio_mmc_host *host)
 {
 	/* FIXME - should we set stop clock reg here */
 	sd_ctrl_write16(host, CTL_RESET_SD, 0x0000);
-	/* implicit BUG_ON(!res) */
 	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG)
 		sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0000);
 	msleep(10);
-- 
2.1.4

