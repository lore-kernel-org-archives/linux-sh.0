From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 12 May 2014 23:02:12 +0000
Subject: [PATCH 2/6] DMA: shdmac: Include linux/err.h
Message-Id: <1399935736-16854-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

linux/err.h isn't implicitly included by the current headers on all
platforms, resulting in compilation failures due to implicit
declarations of IS_ERR and PTR_ERR. Fix this by including linux/err.h.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/dma/sh/shdmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index 7313537..146d5df 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -20,6 +20,7 @@
 
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
+#include <linux/err.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/kdebug.h>
-- 
1.8.5.5

