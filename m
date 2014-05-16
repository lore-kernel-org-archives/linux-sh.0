From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 16 May 2014 15:26:49 +0000
Subject: [PATCH/RFC 1/7] DMA: shdma: Add r8a7791 support
Message-Id: <1400254015-29539-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/dma/shdma.txt |    5 +++--
 drivers/dma/sh/shdmac.c                         |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/shdma.txt b/Documentation/devicetree/bindings/dma/shdma.txt
index c236e9c0be15..2b61cab0525c 100644
--- a/Documentation/devicetree/bindings/dma/shdma.txt
+++ b/Documentation/devicetree/bindings/dma/shdma.txt
@@ -24,8 +24,9 @@ Optional properties (currently unused):
 Required properties:
 - compatible:	should be of the form "renesas,shdma-<soc>", where <soc> should
 		be replaced with the desired SoC model, e.g.
-		"renesas,shdma-r8a73a4" for the system DMAC on r8a73a4 SoC
-		"renesas,shdma-r8a7790" for the DMAC on the R8A7790.
+		"renesas,shdma-r8a73a4" for the system DMAC on r8a73a4 SoC,
+		"renesas,shdma-r8a7790" for the DMAC on the R8A7790,
+		"renesas,shdma-r8a7791" for the DMAC on the R8A7791.
 
 Example:
 	dmac: dma-multiplexer@0 {
diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index 91b3f744d7b2..cdbc68e72ca1 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -691,6 +691,7 @@ static const struct shdma_ops sh_dmae_shdma_ops = {
 static const struct of_device_id sh_dmae_of_match[] = {
 	{ .compatible = "renesas,shdma-r8a73a4", .data = r8a73a4_shdma_devid },
 	{ .compatible = "renesas,shdma-r8a7790", .data = &shdma_arm_info },
+	{ .compatible = "renesas,shdma-r8a7791", .data = &shdma_arm_info },
 	{}
 };
 MODULE_DEVICE_TABLE(of, sh_dmae_of_match);
-- 
1.7.9.5

