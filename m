From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 04 Jan 2012 14:17:11 +0000
Subject: [PATCH 06/11] mfd: tmio: remove now unneeded tmio_mmc_cd_wakeup()
Message-Id: <1325686636-23905-7-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1325686636-23905-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1325686636-23905-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Samuel Ortiz <sameo@linux.intel.com>

Now, that all users of tmio_mmc_cd_wakeup() have been converted over to
drivers/mmc/core/cd-gpio.c, that function can be removed.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 include/linux/mfd/tmio.h |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 4ef9307..08fb7d2 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -4,7 +4,6 @@
 #include <linux/device.h>
 #include <linux/fb.h>
 #include <linux/io.h>
-#include <linux/jiffies.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
@@ -110,16 +109,6 @@ struct tmio_mmc_data {
 };
 
 /*
- * This function is deprecated and will be removed soon. Please, convert your
- * platform to use drivers/mmc/core/cd-gpio.c
- */
-static inline void tmio_mmc_cd_wakeup(struct tmio_mmc_data *pdata)
-{
-	if (pdata)
-		mmc_detect_change(dev_get_drvdata(dev), msecs_to_jiffies(100));
-}
-
-/*
  * data for the NAND controller
  */
 struct tmio_nand_data {
-- 
1.7.2.5

