From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 21 May 2010 15:28:51 +0000
Subject: [PATCH] sh: prevent the DMA driver from unloading, while in use
Message-Id: <Pine.LNX.4.64.1005211722410.8450@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This prevents the driver from unloading, while it is in use. Unloading of the
driver, while its DMA channels are held, leads to a kernel Oops.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/dma/shdma.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index 25ddb1e..58563a0 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -1186,6 +1186,7 @@ static struct platform_driver sh_dmae_driver = {
 	.remove		= __exit_p(sh_dmae_remove),
 	.shutdown	= sh_dmae_shutdown,
 	.driver = {
+		.owner	= THIS_MODULE,
 		.name	= "sh-dma-engine",
 	},
 };
-- 
1.6.2.4

