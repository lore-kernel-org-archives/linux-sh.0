From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 19 Jan 2016 16:20:58 +0000
Subject: [RFC 3/6] mmc: tmio: add flag to reduce delay after changing clock status
Message-Id: <1453220461-2598-4-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

The docs for RCar Gen2 & 3 I have access to, mention delays of 5ms after
stop and 1ms after start. Make it possible to apply these values.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 4 ++--
 include/linux/mfd/tmio.h        | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index a10fde40b6c3dd..de1edb794c53a0 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -185,14 +185,14 @@ static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
 
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~0x0100 &
 		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
-	msleep(10);
+	msleep(host->pdata->flags & TMIO_MMC_FAST_CLK_CHG ? 5 : 10);
 }
 
 static void tmio_mmc_clk_start(struct tmio_mmc_host *host)
 {
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, 0x0100 |
 		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
-	msleep(10);
+	msleep(host->pdata->flags & TMIO_MMC_FAST_CLK_CHG ? 1 : 10);
 
 	/* implicit BUG_ON(!res) */
 	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG) {
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 24b86d538e8852..05d58ee5e6a78f 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -65,6 +65,10 @@
  * Some controllers can support SDIO IRQ signalling.
  */
 #define TMIO_MMC_SDIO_IRQ		(1 << 2)
+
+/* Some controllers don't need to wait 10ms for clock changes */
+#define TMIO_MMC_FAST_CLK_CHG		(1 << 3)
+
 /*
  * Some controllers require waiting for the SD bus to become
  * idle before writing to some registers.
-- 
2.1.4

