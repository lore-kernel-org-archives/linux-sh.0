From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 09 Sep 2014 06:44:51 +0000
Subject: [PATCH 1/6 v4] mmc: use .multi_io_quirk on omap_hsmmc
Message-Id: <87iokx70nz.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87r3zvzohj.wl%kuninori.morimoto.gx@gmail.com>
	<87k35d70pz.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87k35d70pz.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Now, omap_hsmmc can use .multi_io_quirk callback
instead of MMC_CAP2_NO_MULTI_READ flags.
let's use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v3 -> v4

 - don't use flag

 drivers/mmc/host/omap_hsmmc.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index ece1634..df27bb4 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1829,7 +1829,17 @@ static int omap_hsmmc_disable_fclk(struct mmc_host *mmc)
 	return 0;
 }
 
-static const struct mmc_host_ops omap_hsmmc_ops = {
+static int omap_hsmmc_multi_io_quirk(struct mmc_card *card,
+				     unsigned int direction, int blk_size)
+{
+	/* This controller can't do multiblock reads due to hw bugs */
+	if (direction = MMC_DATA_READ)
+		return 1;
+
+	return blk_size;
+}
+
+static struct mmc_host_ops omap_hsmmc_ops = {
 	.enable = omap_hsmmc_enable_fclk,
 	.disable = omap_hsmmc_disable_fclk,
 	.post_req = omap_hsmmc_post_req,
@@ -2101,7 +2111,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 	if (host->pdata->controller_flags & OMAP_HSMMC_BROKEN_MULTIBLOCK_READ) {
 		dev_info(&pdev->dev, "multiblock reads disabled due to 35xx erratum 2.1.1.128; MMC read performance may suffer\n");
-		mmc->caps2 |= MMC_CAP2_NO_MULTI_READ;
+		omap_hsmmc_ops.multi_io_quirk = omap_hsmmc_multi_io_quirk;
 	}
 
 	pm_runtime_enable(host->dev);
-- 
1.7.9.5

