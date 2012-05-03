From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 03 May 2012 15:05:57 +0000
Subject: [PATCH 28/29] mmc: mmcif: add support for generic GPIO CD polling
Message-Id: <1336057558-11031-29-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org

The generic MMC OF support can be used to configure GPIO card-detection, use
this ability.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 4fdedcf..295a078 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -54,6 +54,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sdio.h>
 #include <linux/mmc/sh_mmcif.h>
+#include <linux/mmc/slot-gpio.h>
 #include <linux/of.h>
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
@@ -1006,6 +1007,9 @@ static int sh_mmcif_get_cd(struct mmc_host *mmc)
 {
 	struct sh_mmcif_host *host = mmc_priv(mmc);
 	struct sh_mmcif_plat_data *p = host->pd->dev.platform_data;
+	int ret = mmc_gpio_get_cd(mmc);
+	if (ret >= 0)
+		return ret;
 
 	if (!p || !p->get_cd)
 		return -ENOSYS;
-- 
1.7.2.5

