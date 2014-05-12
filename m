From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 12 May 2014 23:02:13 +0000
Subject: [PATCH 3/6] DMA: sudmac: Keep #include sorted alphabetically
Message-Id: <1399935736-16854-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This helps detecting duplicate includes.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/dma/sh/sudmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/sudmac.c b/drivers/dma/sh/sudmac.c
index 4e7df43..b5b7e54 100644
--- a/drivers/dma/sh/sudmac.c
+++ b/drivers/dma/sh/sudmac.c
@@ -14,12 +14,12 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/dmaengine.h>
 #include <linux/init.h>
-#include <linux/module.h>
-#include <linux/slab.h>
 #include <linux/interrupt.h>
-#include <linux/dmaengine.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 #include <linux/sudmac.h>
 
 struct sudmac_chan {
-- 
1.8.5.5

