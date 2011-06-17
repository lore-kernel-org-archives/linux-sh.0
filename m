From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 17 Jun 2011 08:20:56 +0000
Subject: [RFC][PATCH 3/6 v3] dmaengine: shdma: add dmaor_is_32bit flag
Message-Id: <w3p4o3oq36f.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v2 -> v3

 - u32 -> unsigned int for dmaor_is_32bit:1
 - remove type-cast

 drivers/dma/shdma.c    |   14 ++++++++++++--
 include/linux/sh_dma.h |    2 ++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index 9412de3..6a21cd8 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -70,12 +70,22 @@ static u32 sh_dmae_readl(struct sh_dmae_chan *sh_dc, u32 reg)
 
 static u16 dmaor_read(struct sh_dmae_device *shdev)
 {
-	return __raw_readw(shdev->chan_reg + DMAOR / sizeof(u32));
+	u32 __iomem *addr = shdev->chan_reg + DMAOR / sizeof(u32);
+
+	if (shdev->pdata->dmaor_is_32bit)
+		return __raw_readl(addr);
+	else
+		return __raw_readw(addr);
 }
 
 static void dmaor_write(struct sh_dmae_device *shdev, u16 data)
 {
-	__raw_writew(data, shdev->chan_reg + DMAOR / sizeof(u32));
+	u32 __iomem *addr = shdev->chan_reg + DMAOR / sizeof(u32);
+
+	if (shdev->pdata->dmaor_is_32bit)
+		__raw_writel(data, addr);
+	else
+		__raw_writew(data, addr);
 }
 
 static void chcr_write(struct sh_dmae_chan *sh_dc, u32 data)
diff --git a/include/linux/sh_dma.h b/include/linux/sh_dma.h
index 96803aa..f25afc6 100644
--- a/include/linux/sh_dma.h
+++ b/include/linux/sh_dma.h
@@ -64,6 +64,8 @@ struct sh_dmae_pdata {
 	u16 dmaor_init;
 	unsigned int chcr_offset;
 	u32 chcr_ie_bit;
+
+	unsigned int dmaor_is_32bit:1;
 };
 
 /* DMA register */
-- 
1.7.4.1

