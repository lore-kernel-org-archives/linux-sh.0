From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 26 Jun 2013 14:40:50 +0000
Subject: [PATCH/RFC 1/7] DMA: shdma: also support single top-level DMAC DT nodes
Message-Id: <1372257656-9944-2-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1372257656-9944-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1372257656-9944-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>, Vinod Koul <vinod.koul@intel.com>

Currently we support DMAC DT nodes, located under a multiplexer. This also
supports systems with a single DMAC instance by placing it alone under such
a multiplexer node, but this is rather unnatural. This patch adds an
ability to shdma support such single DT nodes with no dummy multiplexer.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/sh/shdma-of.c |    5 +++--
 drivers/dma/sh/shdma.c    |   16 ++++++++++++++++
 include/linux/sh_dma.h    |    5 +++++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/shdma-of.c b/drivers/dma/sh/shdma-of.c
index 9ab869d..fd2fa10 100644
--- a/drivers/dma/sh/shdma-of.c
+++ b/drivers/dma/sh/shdma-of.c
@@ -19,8 +19,8 @@
 
 #define to_shdma_chan(c) container_of(c, struct shdma_chan, dma_chan)
 
-static struct dma_chan *shdma_of_xlate(struct of_phandle_args *dma_spec,
-				       struct of_dma *ofdma)
+struct dma_chan *shdma_of_xlate(struct of_phandle_args *dma_spec,
+				struct of_dma *ofdma)
 {
 	u32 id = dma_spec->args[0];
 	dma_cap_mask_t mask;
@@ -39,6 +39,7 @@ static struct dma_chan *shdma_of_xlate(struct of_phandle_args *dma_spec,
 
 	return chan;
 }
+EXPORT_SYMBOL(shdma_of_xlate);
 
 static int shdma_of_probe(struct platform_device *pdev)
 {
diff --git a/drivers/dma/sh/shdma.c b/drivers/dma/sh/shdma.c
index 70bc99a..98b2693 100644
--- a/drivers/dma/sh/shdma.c
+++ b/drivers/dma/sh/shdma.c
@@ -20,6 +20,8 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_dma.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/dmaengine.h>
@@ -849,6 +851,15 @@ static int sh_dmae_probe(struct platform_device *pdev)
 
 	pm_runtime_put(&pdev->dev);
 
+	if (pdev->dev.of_node &&
+	    !of_device_is_compatible(pdev->dev.of_node->parent,
+				     "renesas,shdma-mux")) {
+		err = of_dma_controller_register(pdev->dev.of_node,
+						 shdma_of_xlate, pdev);
+		if (err < 0)
+			goto eofdma;
+	}
+
 	err = dma_async_device_register(&shdev->shdma_dev.dma_dev);
 	if (err < 0)
 		goto edmadevreg;
@@ -856,6 +867,8 @@ static int sh_dmae_probe(struct platform_device *pdev)
 	return err;
 
 edmadevreg:
+	of_dma_controller_free(pdev->dev.of_node);
+eofdma:
 	pm_runtime_get(&pdev->dev);
 
 chan_probe_err:
@@ -901,6 +914,9 @@ static int sh_dmae_remove(struct platform_device *pdev)
 
 	dma_async_device_unregister(dma_dev);
 
+	/* Is a NOP if this controller isn't registered with of-dma */
+	of_dma_controller_free(pdev->dev.of_node);
+
 	if (errirq > 0)
 		free_irq(errirq, shdev);
 
diff --git a/include/linux/sh_dma.h b/include/linux/sh_dma.h
index 4e83f3e..887977d 100644
--- a/include/linux/sh_dma.h
+++ b/include/linux/sh_dma.h
@@ -99,4 +99,9 @@ struct sh_dmae_pdata {
 #define CHCR_TE	0x00000002
 #define CHCR_IE	0x00000004
 
+struct of_phandle_args;
+struct of_dma;
+struct dma_chan *shdma_of_xlate(struct of_phandle_args *dma_spec,
+				struct of_dma *ofdma);
+
 #endif
-- 
1.7.2.5

