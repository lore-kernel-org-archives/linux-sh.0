From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 12 Jun 2012 12:57:18 +0000
Subject: [PATCH] mmc: tmio: Don't access hardware registers after stopping clocks
Message-Id: <1339505838-8831-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

The tmio_mmc_set_ios() function configures the MMC power, clock and bus
width. When the MMC controller gets powered off, runtime PM switches the
MSTP clock off. Writing to to CTL_SD_MEM_CARD_OPT register afterwards
fails and prints an error message to the kernel log.

As configuring the bus width is pointless when the interface gets
powered down, skip the operation when power is off.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/mmc/host/tmio_mmc_pio.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 9a7996a..de1226d 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -816,13 +816,15 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		tmio_mmc_clk_stop(host);
 	}
 
-	switch (ios->bus_width) {
-	case MMC_BUS_WIDTH_1:
-		sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, 0x80e0);
-	break;
-	case MMC_BUS_WIDTH_4:
-		sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, 0x00e0);
-	break;
+	if (host->power) {
+		switch (ios->bus_width) {
+		case MMC_BUS_WIDTH_1:
+			sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, 0x80e0);
+		break;
+		case MMC_BUS_WIDTH_4:
+			sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, 0x00e0);
+		break;
+		}
 	}
 
 	/* Let things settle. delay taken from winCE driver */
-- 
1.7.3.4

