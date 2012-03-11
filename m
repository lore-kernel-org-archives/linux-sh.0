From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sun, 11 Mar 2012 19:36:24 +0000
Subject: [PATCH 4/7] arch/sh/drivers/dma/{dma-g2,dmabrg}.c: ensure arguments to request_irq and free_irq are
Message-Id: <1331494587-12196-5-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <linux-sh.vger.kernel.org>
References: <1331494587-12196-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1331494587-12196-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: kernel-janitors@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Convert calls to free_irq so that the second argument is the same as the
last argument of the corresponding call to request_irq.  Without this
property, free_irq does nothing.

In the case of dmabrg.c the change is merely cosmetic - changing 0 to NULL.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 arch/sh/drivers/dma/dma-g2.c |    4 ++--
 arch/sh/drivers/dma/dmabrg.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sh/drivers/dma/dma-g2.c b/arch/sh/drivers/dma/dma-g2.c
index be9ca7c..e1ab6eb 100644
--- a/arch/sh/drivers/dma/dma-g2.c
+++ b/arch/sh/drivers/dma/dma-g2.c
@@ -181,14 +181,14 @@ static int __init g2_dma_init(void)
 
 	ret = register_dmac(&g2_dma_info);
 	if (unlikely(ret != 0))
-		free_irq(HW_EVENT_G2_DMA, 0);
+		free_irq(HW_EVENT_G2_DMA, &g2_dma_info);
 
 	return ret;
 }
 
 static void __exit g2_dma_exit(void)
 {
-	free_irq(HW_EVENT_G2_DMA, 0);
+	free_irq(HW_EVENT_G2_DMA, &g2_dma_info);
 	unregister_dmac(&g2_dma_info);
 }
 
diff --git a/arch/sh/drivers/dma/dmabrg.c b/arch/sh/drivers/dma/dmabrg.c
index 3d66a32..c0dd904 100644
--- a/arch/sh/drivers/dma/dmabrg.c
+++ b/arch/sh/drivers/dma/dmabrg.c
@@ -189,8 +189,8 @@ static int __init dmabrg_init(void)
 	if (ret = 0)
 		return ret;
 
-	free_irq(DMABRGI1, 0);
-out1:	free_irq(DMABRGI0, 0);
+	free_irq(DMABRGI1, NULL);
+out1:	free_irq(DMABRGI0, NULL);
 out0:	kfree(dmabrg_handlers);
 	return ret;
 }

