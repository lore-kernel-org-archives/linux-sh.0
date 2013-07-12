From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 12 Jul 2013 13:43:56 +0000
Subject: [PATCH 6/8] DMA: shdma: pass SoC-specific configuration to the driver via OF matching
Message-Id: <1373636638-18496-7-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1373636638-18496-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1373636638-18496-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Vinod Koul <vinod.koul@intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Similar to the non-DT case, this patch passes SoC-specific configuration
to the driver via device ID matching, instead of platform data.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 Documentation/devicetree/bindings/dma/shdma.txt |    7 +++++--
 drivers/dma/sh/shdmac.c                         |   21 ++++++++++++++-------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/shdma.txt b/Documentation/devicetree/bindings/dma/shdma.txt
index c15994a..7702e35 100644
--- a/Documentation/devicetree/bindings/dma/shdma.txt
+++ b/Documentation/devicetree/bindings/dma/shdma.txt
@@ -22,7 +22,10 @@ Optional properties (currently unused):
 * DMA controller
 
 Required properties:
-- compatible:	should be "renesas,shdma"
+- compatible:	should be one of
+		"renesas,shdma-r8a73a4" for the system DMAC on r8a73a4 SoC
+		"renesas,shdma-r8a7740" for the DMACs (not RTDMAC) on r8a7740
+		"renesas,shdma" for a generic DMAC
 
 Example:
 	dmac: dma-mux0 {
@@ -36,7 +39,7 @@ Example:
 		ranges;
 
 		dma0: shdma@fe008020 {
-			compatible = "renesas,shdma";
+			compatible = "renesas,shdma-r8a7740";
 			reg = <0xfe008020 0x270>,
 				<0xfe009000 0xc>;
 			interrupt-parent = <&gic>;
diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index a6d53fa..b095d74 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_dma.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
@@ -665,6 +666,14 @@ static const struct shdma_ops sh_dmae_shdma_ops = {
 	.get_partial = sh_dmae_get_partial,
 };
 
+static const struct of_device_id sh_dmae_of_match[] = {
+	{.compatible = "renesas,shdma",},
+	{.compatible = "renesas,shdma-r8a73a4", .data = r8a73a4_shdma_devid,},
+	{.compatible = "renesas,shdma-r8a7740", .data = r8a7740_shdma_devid,},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sh_dmae_of_match);
+
 static int sh_dmae_probe(struct platform_device *pdev)
 {
 	struct sh_dmae_pdata *pdata;
@@ -676,7 +685,11 @@ static int sh_dmae_probe(struct platform_device *pdev)
 	struct dma_device *dma_dev;
 	struct resource *chan, *dmars, *errirq_res, *chanirq_res;
 
-	pdata = (void *)pdev->id_entry->driver_data ? : pdev->dev.platform_data;
+	if (pdev->dev.of_node)
+		pdata = of_match_device(sh_dmae_of_match, &pdev->dev)->data;
+	else
+		pdata = (void *)pdev->id_entry->driver_data ? :
+			pdev->dev.platform_data;
 
 	/* get platform data */
 	if (!pdata || !pdata->channel_num)
@@ -915,12 +928,6 @@ static int sh_dmae_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id sh_dmae_of_match[] = {
-	{ .compatible = "renesas,shdma", },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, sh_dmae_of_match);
-
 const struct platform_device_id sh_dmae_id_table[] = {
 	{.name = SH_DMAE_DRV_NAME,},
 	{.name = "shdma-r8a73a4", .driver_data = (kernel_ulong_t)r8a73a4_shdma_devid,},
-- 
1.7.2.5

