From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 12 May 2014 23:02:11 +0000
Subject: [PATCH 1/6] DMA: shdmac: Keep #include sorted alphabetically
Message-Id: <1399935736-16854-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This helps detecting duplicate includes.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/dma/sh/shdmac.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index dda7e75..7313537 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -18,21 +18,21 @@
  *
  */
 
+#include <linux/delay.h>
+#include <linux/dmaengine.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kdebug.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/slab.h>
-#include <linux/interrupt.h>
-#include <linux/dmaengine.h>
-#include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/rculist.h>
 #include <linux/sh_dma.h>
-#include <linux/notifier.h>
-#include <linux/kdebug.h>
+#include <linux/slab.h>
 #include <linux/spinlock.h>
-#include <linux/rculist.h>
 
 #include "../dmaengine.h"
 #include "shdma.h"
-- 
1.8.5.5

