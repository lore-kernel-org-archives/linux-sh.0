From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 17 Jun 2011 03:39:59 +0000
Subject: [RFC][PATCH 4/6] dmaengine: shdma: add is_usbdmac flag
Message-Id: <w3ppqmdp1m8.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/dma/shdma.c    |    8 ++++++++
 include/linux/sh_dma.h |    3 +++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index aa91309..3de661e 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -194,6 +194,10 @@ static void dmae_start(struct sh_dmae_chan *sh_chan)
 	struct sh_dmae_device *shdev = to_sh_dev(sh_chan);
 	u32 chcr = chcr_read(sh_chan);
 
+	/* USB-DMAC needs TEND settings */
+	if (shdev->pdata->is_usbdmac)
+		sh_dmae_writel(sh_chan, 0xFFFFFFFF, TEND);
+
 	chcr |= CHCR_DE | shdev->chcr_ie_bit;
 	chcr_write(sh_chan, chcr & ~CHCR_TE);
 }
@@ -242,6 +246,10 @@ static int dmae_set_dmars(struct sh_dmae_chan *sh_chan, u16 val)
 	if (dmae_is_busy(sh_chan))
 		return -EBUSY;
 
+	/* USB-DMAC doesn't need DMARS settings */
+	if (pdata->is_usbdmac)
+		return 0;
+
 	/* in the case of a missing DMARS resource use first memory window */
 	if (!addr)
 		addr = (u16 __iomem *)shdev->chan_reg;
diff --git a/include/linux/sh_dma.h b/include/linux/sh_dma.h
index 6a98daf..8a5bffd 100644
--- a/include/linux/sh_dma.h
+++ b/include/linux/sh_dma.h
@@ -66,6 +66,7 @@ struct sh_dmae_pdata {
 	u32 chcr_ie_bit;
 
 	u32 dmaor_is_32bit:1;
+	u32 is_usbdmac:1;
 };
 
 /* DMA register */
@@ -75,6 +76,8 @@ struct sh_dmae_pdata {
 #define CHCR	0x0C
 #define DMAOR	0x40
 
+#define TEND	0x18 /* USB-DMAC */
+
 /* DMAOR definitions */
 #define DMAOR_AE	0x00000004
 #define DMAOR_NMIF	0x00000002
-- 
1.7.4.1

