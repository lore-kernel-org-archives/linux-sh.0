From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 02 Aug 2013 12:48:02 +0000
Subject: [PATCH] mmc: sh_mmcif: move header include from header into .c
Message-Id: <Pine.LNX.4.64.1308021445040.28012@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>

sh_dma.h isn't needed in sh_mmcif.h, move it into sh_mmcif.c.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 drivers/mmc/host/sh_mmcif.c  |    1 +
 include/linux/mmc/sh_mmcif.h |    1 -
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 6706b5e..220ee30 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -61,6 +61,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_qos.h>
 #include <linux/pm_runtime.h>
+#include <linux/sh_dma.h>
 #include <linux/spinlock.h>
 #include <linux/module.h>
 
diff --git a/include/linux/mmc/sh_mmcif.h b/include/linux/mmc/sh_mmcif.h
index e7d5dd6..5fcd3eb 100644
--- a/include/linux/mmc/sh_mmcif.h
+++ b/include/linux/mmc/sh_mmcif.h
@@ -16,7 +16,6 @@
 
 #include <linux/io.h>
 #include <linux/platform_device.h>
-#include <linux/sh_dma.h>
 
 /*
  * MMCIF : CE_CLK_CTRL [19:16]
-- 
1.7.2.5

