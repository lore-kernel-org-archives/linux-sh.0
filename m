From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 27 Oct 2014 12:42:31 +0000
Subject: [PATCH] dmaengine: shdma: Allocate cyclic sg list with GFP_NOWAIT
Message-Id: <1414413751-22102-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1405691010-24995-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1405691010-24995-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The cyclic preparation handler is called in atomic context by the rcar
sound driver. Use GFP_NOWAIT instead of GFP_KERNEL.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/dma/sh/shdma-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
index 42d497416196..b392a74dfa54 100644
--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -705,7 +705,7 @@ static struct dma_async_tx_descriptor *shdma_prep_dma_cyclic(
 	 * Allocate the sg list dynamically as it would consumer too much stack
 	 * space.
 	 */
-	sgl = kcalloc(sg_len, sizeof(*sgl), GFP_KERNEL);
+	sgl = kcalloc(sg_len, sizeof(*sgl), GFP_NOWAIT);
 	if (!sgl)
 		return NULL;
 
-- 
Regards,

Laurent Pinchart

