From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 11 Mar 2011 08:24:10 +0000
Subject: [PATCH/RFC 2/2 v2] mmc: tmio: support aggressive clock gating
Message-Id: <Pine.LNX.4.64.1103110921150.23675@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1103110915290.23675@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1103110915290.23675@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Please, test on MFD!

v2: rebase on top of driver split

 drivers/mmc/host/tmio_mmc_pio.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 69772ab..e35e179 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -747,19 +747,18 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		tmio_mmc_set_clock(host, ios->clock);
 
 	/* Power sequence - OFF -> UP -> ON */
-	switch (ios->power_mode) {
-	case MMC_POWER_OFF: /* power down SD bus */
-		if (host->set_pwr)
+	if (ios->power_mode = MMC_POWER_OFF || !ios->clock) {
+		/* power down SD bus */
+		if (ios->power_mode = MMC_POWER_OFF && host->set_pwr)
 			host->set_pwr(host->pdev, 0);
 		tmio_mmc_clk_stop(host);
-		break;
-	case MMC_POWER_ON: /* start bus clock */
-		tmio_mmc_clk_start(host);
-		break;
-	case MMC_POWER_UP: /* power up SD bus */
+	} else if (ios->power_mode = MMC_POWER_UP) {
+		/* power up SD bus */
 		if (host->set_pwr)
 			host->set_pwr(host->pdev, 1);
-		break;
+	} else {
+		/* start bus clock */
+		tmio_mmc_clk_start(host);
 	}
 
 	switch (ios->bus_width) {
-- 
1.7.2.3

