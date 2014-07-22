From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 22 Jul 2014 12:33:48 +0000
Subject: [PATCH/RFC 2/5] dmaengine: rcar-dmac: Fix typo in register definition
Message-Id: <1406032431-3807-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/dma/sh/rcar-dmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 0cc6e0d..09df914 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -192,7 +192,7 @@ struct rcar_dmac {
 #define RCAR_DMACHCR_DPM_DISABLED	(0 << 28)
 #define RCAR_DMACHCR_DPM_ENABLED	(1 << 28)
 #define RCAR_DMACHCR_DPM_REPEAT		(2 << 28)
-#define RCAR_DMACHCR_DPM_INFINIE	(3 << 28)
+#define RCAR_DMACHCR_DPM_INFINITE	(3 << 28)
 #define RCAR_DMACHCR_RPT_SAR		(1 << 27)
 #define RCAR_DMACHCR_RPT_DAR		(1 << 26)
 #define RCAR_DMACHCR_RPT_TCR		(1 << 25)
-- 
1.8.5.5

