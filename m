From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 04 Jan 2012 14:17:13 +0000
Subject: [PATCH 08/11] mmc: tmio_mmc: remove unused sdio_irq_enabled flag
Message-Id: <1325686636-23905-9-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1325686636-23905-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1325686636-23905-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Samuel Ortiz <sameo@linux.intel.com>

The sdio_irq_enabled member of struct tmio_mmc_host is a left-over from the
previously removed SDIO IRQ workaround. It is no longer needed and can now
be removed too.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc.h     |    1 -
 drivers/mmc/host/tmio_mmc_pio.c |    2 --
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 0c39002..62d0d14 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -47,7 +47,6 @@ struct tmio_mmc_host {
 	struct mmc_request      *mrq;
 	struct mmc_data         *data;
 	struct mmc_host         *mmc;
-	unsigned int		sdio_irq_enabled;
 
 	/* Controller power state */
 	bool			power;
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 478e57b..1811006 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -127,7 +127,6 @@ static void tmio_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 
 	if (enable) {
-		host->sdio_irq_enabled = 1;
 		host->sdio_irq_mask = TMIO_SDIO_MASK_ALL &
 					~TMIO_SDIO_STAT_IOIRQ;
 		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0001);
@@ -136,7 +135,6 @@ static void tmio_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 		host->sdio_irq_mask = TMIO_SDIO_MASK_ALL;
 		sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
 		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0000);
-		host->sdio_irq_enabled = 0;
 	}
 }
 
-- 
1.7.2.5

