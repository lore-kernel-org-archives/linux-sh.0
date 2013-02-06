From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 06 Feb 2013 19:46:55 +0000
Subject: [PATCH v3 08/13] mmc: sh_mobile_sdhi: remove unused .pdata field
Message-Id: <1360180020-18555-9-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1360180020-18555-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360180020-18555-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

The struct sh_mobile_sdhi_info::pdata field was only used for platform-
based card detection and isn't used anymore since the migration to GPIO-
based MMC slot functions. Remove it.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mobile_sdhi.c  |    4 ----
 include/linux/mmc/sh_mobile_sdhi.h |    2 --
 2 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index e0ca0ab..17d5778 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -135,7 +135,6 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	mmc_data = &priv->mmc_data;
 
 	if (p) {
-		p->pdata = mmc_data;
 		if (p->init) {
 			ret = p->init(pdev, &sdhi_ops);
 			if (ret)
@@ -284,9 +283,6 @@ static int sh_mobile_sdhi_remove(struct platform_device *pdev)
 	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
 	int i = 0, irq;
 
-	if (p)
-		p->pdata = NULL;
-
 	tmio_mmc_host_remove(host);
 
 	while (1) {
diff --git a/include/linux/mmc/sh_mobile_sdhi.h b/include/linux/mmc/sh_mobile_sdhi.h
index b65679f..b76bcf0 100644
--- a/include/linux/mmc/sh_mobile_sdhi.h
+++ b/include/linux/mmc/sh_mobile_sdhi.h
@@ -4,7 +4,6 @@
 #include <linux/types.h>
 
 struct platform_device;
-struct tmio_mmc_data;
 
 #define SH_MOBILE_SDHI_IRQ_CARD_DETECT	"card_detect"
 #define SH_MOBILE_SDHI_IRQ_SDCARD	"sdcard"
@@ -26,7 +25,6 @@ struct sh_mobile_sdhi_info {
 	unsigned long tmio_caps2;
 	u32 tmio_ocr_mask;	/* available MMC voltages */
 	unsigned int cd_gpio;
-	struct tmio_mmc_data *pdata;
 	void (*set_pwr)(struct platform_device *pdev, int state);
 	int (*get_cd)(struct platform_device *pdev);
 
-- 
1.7.2.5

