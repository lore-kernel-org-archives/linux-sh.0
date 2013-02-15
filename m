From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 15 Feb 2013 15:13:59 +0000
Subject: [PATCH v4 10/13] mmc: tmio: remove unused and deprecated symbols
Message-Id: <1360941242-18153-11-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Arnd Bergmann <arnd@arndb.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

The tmio_mmc_cd_wakeup() inline function has been deprecated since 3.4 and
is unused since 3.4 too. Remove them.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 include/linux/mfd/tmio.h |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index d83af39..99bf3e66 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -65,12 +65,6 @@
  */
 #define TMIO_MMC_SDIO_IRQ		(1 << 2)
 /*
- * Some platforms can detect card insertion events with controller powered
- * down, using a GPIO IRQ, in which case they have to fill in cd_irq, cd_gpio,
- * and cd_flags fields of struct tmio_mmc_data.
- */
-#define TMIO_MMC_HAS_COLD_CD		(1 << 3)
-/*
  * Some controllers require waiting for the SD bus to become
  * idle before writing to some registers.
  */
@@ -117,18 +111,6 @@ struct tmio_mmc_data {
 };
 
 /*
- * This function is deprecated and will be removed soon. Please, convert your
- * platform to use drivers/mmc/core/cd-gpio.c
- */
-#include <linux/mmc/host.h>
-static inline void tmio_mmc_cd_wakeup(struct tmio_mmc_data *pdata)
-{
-	if (pdata)
-		mmc_detect_change(dev_get_drvdata(pdata->dev),
-				  msecs_to_jiffies(100));
-}
-
-/*
  * data for the NAND controller
  */
 struct tmio_nand_data {
-- 
1.7.2.5

