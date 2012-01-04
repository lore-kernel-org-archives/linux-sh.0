From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 04 Jan 2012 14:17:15 +0000
Subject: [PATCH 10/11] mmc: tmio: reconfigure the controller on runtime resume
Message-Id: <1325686636-23905-11-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1325686636-23905-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1325686636-23905-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Samuel Ortiz <sameo@linux.intel.com>

After the controller has been runtime suspended it has to be reset and DMA
has to be re-enabled, if it is used.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc_pio.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 1811006..9106b3d 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -1031,6 +1031,10 @@ EXPORT_SYMBOL(tmio_mmc_host_suspend);
 int tmio_mmc_host_resume(struct device *dev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+
+	tmio_mmc_reset(host);
+	tmio_mmc_enable_dma(host, true);
 
 	/* The MMC core will perform the complete set up */
 	return mmc_resume_host(mmc);
-- 
1.7.2.5

