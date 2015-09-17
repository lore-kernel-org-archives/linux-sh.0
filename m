From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 17 Sep 2015 04:21:33 +0000
Subject: [PATCH 03/20 v2] dmaengine: OF DMAEngine API based on CONFIG_DMA_OF instead of CONFIG_OF
Message-Id: <87r3lx7k8g.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

5fa422c ("dmaengine: move drivers/of/dma.c -> drivers/dma/of-dma.c")
moved OF base DMAEngine code to of-dma.c, then it based on CONFIG_DMA_OF.
But, OF base DMAEngine API on of_dma.h still based on CONFIG_OF now.
So, current kernel can't find OF base DMAEngine API if .config has CONFIG_OF,
but not have CONFIG_DMA_OF. This patch tidyup it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - already posted, not yet merged

 include/linux/of_dma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/of_dma.h b/include/linux/of_dma.h
index 98ba752..36112cd 100644
--- a/include/linux/of_dma.h
+++ b/include/linux/of_dma.h
@@ -34,7 +34,7 @@ struct of_dma_filter_info {
 	dma_filter_fn	filter_fn;
 };
 
-#ifdef CONFIG_OF
+#ifdef CONFIG_DMA_OF
 extern int of_dma_controller_register(struct device_node *np,
 		struct dma_chan *(*of_dma_xlate)
 		(struct of_phandle_args *, struct of_dma *),
-- 
1.9.1

