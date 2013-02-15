From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 15 Feb 2013 15:13:50 +0000
Subject: [PATCH v4 01/13] mmc: sdhi, tmio: only check flags in tmio-mmc driver proper
Message-Id: <1360941242-18153-2-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Arnd Bergmann <arnd@arndb.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

tmio-mmc platform flags can be set by various means, including caller
drivers and device-tree bindings, therefore it is better to only check
them in the tmio-mmc driver proper, not in caller drivers themselves.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mobile_sdhi.c |    3 +--
 drivers/mmc/host/tmio_mmc_pio.c   |    3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 524a7f7..e0ca0ab 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -153,10 +153,9 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	mmc_data->clk_enable = sh_mobile_sdhi_clk_enable;
 	mmc_data->clk_disable = sh_mobile_sdhi_clk_disable;
 	mmc_data->capabilities = MMC_CAP_MMC_HIGHSPEED;
+	mmc_data->write16_hook = sh_mobile_sdhi_write16_hook;
 	if (p) {
 		mmc_data->flags = p->tmio_flags;
-		if (mmc_data->flags & TMIO_MMC_HAS_IDLE_WAIT)
-			mmc_data->write16_hook = sh_mobile_sdhi_write16_hook;
 		mmc_data->ocr_mask = p->tmio_ocr_mask;
 		mmc_data->capabilities |= p->tmio_caps;
 		mmc_data->capabilities2 |= p->tmio_caps2;
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 0f992e9..b25adb4 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -928,6 +928,9 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	int ret;
 	u32 irq_mask = TMIO_MASK_CMD;
 
+	if (!(pdata->flags & TMIO_MMC_HAS_IDLE_WAIT))
+		pdata->write16_hook = NULL;
+
 	res_ctl = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res_ctl)
 		return -EINVAL;
-- 
1.7.2.5

