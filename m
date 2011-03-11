From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 11 Mar 2011 08:24:06 +0000
Subject: [PATCH/RFC 1/2 v2] mmc: tmio: fix power-mode interpretation
Message-Id: <Pine.LNX.4.64.1103110920180.23675@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1103110915290.23675@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1103110915290.23675@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>

The power-mode sequence on MMC is MMC_POWER_OFF -> MMC_POWER_UP ->
MMC_POWER_ON and not MMC_POWER_ON -> MMC_POWER_UP, as the driver currently
is implying.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Please, test on MFD!

V2: rebase on top of driver split

 drivers/mmc/host/tmio_mmc_pio.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index e1aed25..69772ab 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -746,20 +746,20 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (ios->clock)
 		tmio_mmc_set_clock(host, ios->clock);
 
-	/* Power sequence - OFF -> ON -> UP */
+	/* Power sequence - OFF -> UP -> ON */
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF: /* power down SD bus */
 		if (host->set_pwr)
 			host->set_pwr(host->pdev, 0);
 		tmio_mmc_clk_stop(host);
 		break;
-	case MMC_POWER_ON: /* power up SD bus */
+	case MMC_POWER_ON: /* start bus clock */
+		tmio_mmc_clk_start(host);
+		break;
+	case MMC_POWER_UP: /* power up SD bus */
 		if (host->set_pwr)
 			host->set_pwr(host->pdev, 1);
 		break;
-	case MMC_POWER_UP: /* start bus clock */
-		tmio_mmc_clk_start(host);
-		break;
 	}
 
 	switch (ios->bus_width) {
-- 
1.7.2.3

