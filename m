From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 18 Jun 2014 09:11:26 +0000
Subject: [PROTOTYPE 8/8] shdmac-of: fixup for test
Message-Id: <87bntqy43k.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/dma/sh/shdma-of.c             |    9 +++++----
 drivers/dma/sh/shdmac.c               |    2 +-
 include/dt-bindings/dma/r8a7790-dma.h |    2 ++
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sh/shdma-of.c b/drivers/dma/sh/shdma-of.c
index 696716b..6296f19 100644
--- a/drivers/dma/sh/shdma-of.c
+++ b/drivers/dma/sh/shdma-of.c
@@ -43,11 +43,11 @@ static struct sh_dmae_pdata arm_dmae_info = {
 
 struct sh_dmae_of_info shdma_arm_info = {
 	.pdata_template	= &arm_dmae_info,
-	.channel_offset	= 0x8000-0x20,
+	.channel_offset	= 0x8000,
 	.channel_stride	= 0x80,
-	.offset		= 0x0,
-	.dmars		= 0x40,
-	.chclr_offset	= 0x80,
+	.offset		= 0x00 - 0x20,
+	.dmars		= 0x40 - 0x20,
+	.chclr_offset	= 0x80 - 0x20,
 };
 
 /* Need global index due to shdma_slave_used being global */
@@ -123,6 +123,7 @@ static struct dma_chan *shdma_of_xlate(struct of_phandle_args *dma_spec,
 			client->cfg.slave_id = id;
 			client->cfg.mid_rid = id;
 			client->cfg.chcr = dma_spec->args[1];
+			INIT_LIST_HEAD(&client->node);
 
 			dev_dbg(&pdev->dev, "new client %d, %02x\n",
 				client->index, id);
diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index f2ecec8..7d2d086 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -691,7 +691,7 @@ static const struct shdma_ops sh_dmae_shdma_ops = {
 
 static const struct of_device_id sh_dmae_of_match[] = {
 	{ .compatible = "renesas,shdma-r8a73a4", .data = r8a73a4_shdma_devid },
-	{ .compatible = "renesas,dma-r8a7790", .data = &shdma_arm_info },
+	{ .compatible = "renesas,shdma-r8a7790", .data = &shdma_arm_info },
 	{}
 };
 MODULE_DEVICE_TABLE(of, sh_dmae_of_match);
diff --git a/include/dt-bindings/dma/r8a7790-dma.h b/include/dt-bindings/dma/r8a7790-dma.h
index 732422a..6b90206 100644
--- a/include/dt-bindings/dma/r8a7790-dma.h
+++ b/include/dt-bindings/dma/r8a7790-dma.h
@@ -222,6 +222,8 @@
 #define R8A7790_DMA_SSIND9_TX	(0x13)
 #define R8A7790_DMA_SSIND9_RX	(0x14)
 
+#define CHCR_RX_16BIT	SHDMA_ARM_CHCR_RX(SHDMA_ARM_SZ_16BIT)
+#define CHCR_TX_16BIT	SHDMA_ARM_CHCR_TX(SHDMA_ARM_SZ_16BIT)
 #define CHCR_RX_32BIT	SHDMA_ARM_CHCR_RX(SHDMA_ARM_SZ_32BIT)
 #define CHCR_TX_32BIT	SHDMA_ARM_CHCR_TX(SHDMA_ARM_SZ_32BIT)
 #define CHCR_RX_256BIT	SHDMA_ARM_CHCR_RX(SHDMA_ARM_SZ_256BIT)
-- 
1.7.9.5

