From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 11 Dec 2013 12:43:06 +0000
Subject: [PATCH v3 3/3] DMA: shdma: Make sh_dmae_pm static
Message-Id: <1386765786-1926-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The structure isn't used outside of its compilation unit. Make it
static.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: dmaengine@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/dma/sh/shdmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index 2150987..dda7e75 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -639,7 +639,7 @@ static int sh_dmae_resume(struct device *dev)
 #define sh_dmae_resume NULL
 #endif
 
-const struct dev_pm_ops sh_dmae_pm = {
+static const struct dev_pm_ops sh_dmae_pm = {
 	.suspend		= sh_dmae_suspend,
 	.resume			= sh_dmae_resume,
 	.runtime_suspend	= sh_dmae_runtime_suspend,
-- 
1.8.3.2

