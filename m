From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 21 Apr 2011 10:32:54 +0000
Subject: [PATCH] MMC: TMIO: add runtime PM calls to global suspend() / redume()
Message-Id: <Pine.LNX.4.64.1104211231240.29172@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, Ian Molton <ian@mnementh.co.uk>

The TMIO MMC driver cannot generally suspend itself at runtime even
with no card inserted, because otherwise it wouldn't be able to detect
new cards. But when the system goes down for a global suspend, we can
use runtime PM calls to let it activate platform-specific PM hooks,
e.g., to switch off respective power domains.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc.h     |    2 ++
 drivers/mmc/host/tmio_mmc_pio.c |    6 ++++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 249c724..58138a2 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -52,6 +52,8 @@ struct tmio_mmc_host {
 	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_clk_div)(struct platform_device *host, int state);
 
+	int			pm_error;
+
 	/* pio related stuff */
 	struct scatterlist      *sg_ptr;
 	struct scatterlist      *sg_orig;
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index d1791ba..26598f1 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -980,6 +980,8 @@ int tmio_mmc_host_suspend(struct device *dev)
 	if (!ret)
 		tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
 
+	host->pm_error = pm_runtime_put_sync(dev);
+
 	return ret;
 }
 EXPORT_SYMBOL(tmio_mmc_host_suspend);
@@ -987,6 +989,10 @@ EXPORT_SYMBOL(tmio_mmc_host_suspend);
 int tmio_mmc_host_resume(struct device *dev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+
+	if (!host->pm_error)
+		pm_runtime_get_sync(dev);
 
 	tmio_mmc_reset(mmc_priv(mmc));
 
-- 
1.7.2.5

