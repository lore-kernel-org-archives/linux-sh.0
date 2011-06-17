From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 17 Jun 2011 05:28:35 +0000
Subject: [RFC][PATCH 4/6 v2] dmaengine: shdma: add .needs_tend_set / .no_dmars
Message-Id: <w3pfwn9owl8.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
This is v2 of "dmaengine: shdma: add is_usbdmac flag"

v1 -> v2

 - use "needs_tend_set" / "no_dmars" instead of "is_usbdmac",

 drivers/dma/shdma.c    |    6 ++++++
 include/linux/sh_dma.h |    4 ++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index aa91309..d903bdc 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -194,6 +194,9 @@ static void dmae_start(struct sh_dmae_chan *sh_chan)
 	struct sh_dmae_device *shdev = to_sh_dev(sh_chan);
 	u32 chcr = chcr_read(sh_chan);
 
+	if (shdev->pdata->needs_tend_set)
+		sh_dmae_writel(sh_chan, 0xFFFFFFFF, TEND);
+
 	chcr |= CHCR_DE | shdev->chcr_ie_bit;
 	chcr_write(sh_chan, chcr & ~CHCR_TE);
 }
@@ -242,6 +245,9 @@ static int dmae_set_dmars(struct sh_dmae_chan *sh_chan, u16 val)
 	if (dmae_is_busy(sh_chan))
 		return -EBUSY;
 
+	if (pdata->no_dmars)
+		return 0;
+
 	/* in the case of a missing DMARS resource use first memory window */
 	if (!addr)
 		addr = (u16 __iomem *)shdev->chan_reg;
diff --git a/include/linux/sh_dma.h b/include/linux/sh_dma.h
index 6a98daf..3b9ffb9 100644
--- a/include/linux/sh_dma.h
+++ b/include/linux/sh_dma.h
@@ -66,6 +66,8 @@ struct sh_dmae_pdata {
 	u32 chcr_ie_bit;
 
 	u32 dmaor_is_32bit:1;
+	u32 needs_tend_set:1;
+	u32 no_dmars:1;
 };
 
 /* DMA register */
@@ -75,6 +77,8 @@ struct sh_dmae_pdata {
 #define CHCR	0x0C
 #define DMAOR	0x40
 
+#define TEND	0x18 /* USB-DMAC */
+
 /* DMAOR definitions */
 #define DMAOR_AE	0x00000004
 #define DMAOR_NMIF	0x00000002
-- 
1.7.4.1

