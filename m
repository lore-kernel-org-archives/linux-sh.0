From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 15 Feb 2013 15:13:56 +0000
Subject: [PATCH v4 07/13] mmc: tmio-mmc: parse device-tree bindings
Message-Id: <1360941242-18153-8-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Arnd Bergmann <arnd@arndb.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Add parsing of common and driver-specific DT bindings to the tmio-mmc
MMC host driver and the sh_mobile_sdhi interface layer.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v4: add compatible string parsing to sh_mobile_sdhi, remove 
"toshiba,mmc-blksz-2bytes" and "toshiba,mmc-has-idle-wait" properties.

 drivers/mmc/host/sh_mobile_sdhi.c |   32 ++++++++++++++++++++++++++------
 drivers/mmc/host/tmio_mmc_pio.c   |   20 ++++++++++++++++++--
 2 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index e0ca0ab..06e1bc9 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
@@ -32,6 +33,16 @@
 
 #include "tmio_mmc.h"
 
+struct sh_mobile_sdhi_of_data {
+	unsigned long tmio_flags;
+};
+
+static const struct sh_mobile_sdhi_of_data sh_mobile_sdhi_of_cfg[] = {
+	{
+		.tmio_flags = TMIO_MMC_HAS_IDLE_WAIT,
+	},
+};
+
 struct sh_mobile_sdhi {
 	struct clk *clk;
 	struct tmio_mmc_data mmc_data;
@@ -117,8 +128,18 @@ static const struct sh_mobile_sdhi_ops sdhi_ops = {
 	.cd_wakeup = sh_mobile_sdhi_cd_wakeup,
 };
 
+static const struct of_device_id sh_mobile_sdhi_of_match[] = {
+	{ .compatible = "renesas,shmobile-sdhi" },
+	{ .compatible = "renesas,sh7372-sdhi" },
+	{ .compatible = "renesas,r8a7740-sdhi", .data = &sh_mobile_sdhi_of_cfg[0], },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sh_mobile_sdhi_of_match);
+
 static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *of_id +		of_match_device(sh_mobile_sdhi_of_match, &pdev->dev);
 	struct sh_mobile_sdhi *priv;
 	struct tmio_mmc_data *mmc_data;
 	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
@@ -186,6 +207,11 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	 */
 	mmc_data->flags |= TMIO_MMC_SDIO_IRQ;
 
+	if (of_id && of_id->data) {
+		const struct sh_mobile_sdhi_of_data *of_data = of_id->data;
+		mmc_data->flags |= of_data->tmio_flags;
+	}
+
 	ret = tmio_mmc_host_probe(&host, pdev, mmc_data);
 	if (ret < 0)
 		goto eprobe;
@@ -313,12 +339,6 @@ static const struct dev_pm_ops tmio_mmc_dev_pm_ops = {
 	.runtime_resume = tmio_mmc_host_runtime_resume,
 };
 
-static const struct of_device_id sh_mobile_sdhi_of_match[] = {
-	{ .compatible = "renesas,shmobile-sdhi" },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, sh_mobile_sdhi_of_match);
-
 static struct platform_driver sh_mobile_sdhi_driver = {
 	.driver		= {
 		.name	= "sh_mobile_sdhi",
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index b25adb4..e5b3fcf 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -918,6 +918,17 @@ static void tmio_mmc_init_ocr(struct tmio_mmc_host *host)
 		dev_warn(mmc_dev(mmc), "Platform OCR mask is ignored\n");
 }
 
+static void tmio_mmc_of_parse(struct platform_device *pdev,
+			      struct tmio_mmc_data *pdata)
+{
+	const struct device_node *np = pdev->dev.of_node;
+	if (!np)
+		return;
+
+	if (of_get_property(np, "toshiba,mmc-wrprotect-disable", NULL))
+		pdata->flags |= TMIO_MMC_WRPROTECT_DISABLE;
+}
+
 int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 				  struct platform_device *pdev,
 				  struct tmio_mmc_data *pdata)
@@ -928,6 +939,8 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	int ret;
 	u32 irq_mask = TMIO_MASK_CMD;
 
+	tmio_mmc_of_parse(pdev, pdata);
+
 	if (!(pdata->flags & TMIO_MMC_HAS_IDLE_WAIT))
 		pdata->write16_hook = NULL;
 
@@ -939,6 +952,8 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	if (!mmc)
 		return -ENOMEM;
 
+	mmc_of_parse(mmc);
+
 	pdata->dev = &pdev->dev;
 	_host = mmc_priv(mmc);
 	_host->pdata = pdata;
@@ -959,7 +974,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	}
 
 	mmc->ops = &tmio_mmc_ops;
-	mmc->caps = MMC_CAP_4_BIT_DATA | pdata->capabilities;
+	mmc->caps |= MMC_CAP_4_BIT_DATA | pdata->capabilities;
 	mmc->caps2 = pdata->capabilities2;
 	mmc->max_segs = 32;
 	mmc->max_blk_size = 512;
@@ -971,7 +986,8 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 
 	_host->native_hotplug = !(pdata->flags & TMIO_MMC_USE_GPIO_CD ||
 				  mmc->caps & MMC_CAP_NEEDS_POLL ||
-				  mmc->caps & MMC_CAP_NONREMOVABLE);
+				  mmc->caps & MMC_CAP_NONREMOVABLE ||
+				  mmc->slot.cd_irq >= 0);
 
 	_host->power = false;
 	pm_runtime_enable(&pdev->dev);
-- 
1.7.2.5

