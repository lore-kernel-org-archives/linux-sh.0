From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 24 May 2011 10:31:12 +0000
Subject: [PATCH 01/03] dmaengine: shdma: Make second memory window optional
Message-Id: <20110524103112.10334.53844.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch makes the shdma.c driver allow slave operation
on DMA hardware mapped with a single I/O-memory window.

The dmae_set_dmars() function is adjusted to use the
first memory window in case of a missing DMARS window.

At probe() time the code is updated to enable DMA_SLAVE
only if slave information is passed with the platform data.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/dma/shdma.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- 0001/drivers/dma/shdma.c
+++ work/drivers/dma/shdma.c	2011-05-24 18:52:25.000000000 +0900
@@ -200,12 +200,17 @@ static int dmae_set_dmars(struct sh_dmae
 						struct sh_dmae_device, common);
 	struct sh_dmae_pdata *pdata = shdev->pdata;
 	const struct sh_dmae_channel *chan_pdata = &pdata->channel[sh_chan->id];
-	u16 __iomem *addr = shdev->dmars + chan_pdata->dmars / sizeof(u16);
+	u16 __iomem *addr = shdev->dmars;
 	int shift = chan_pdata->dmars_bit;
 
 	if (dmae_is_busy(sh_chan))
 		return -EBUSY;
 
+	/* in the case of a missing DMARS resource use first memory window */
+	if (!addr)
+		addr = (u16 __iomem *)shdev->chan_reg;
+	addr += chan_pdata->dmars / sizeof(u16);
+
 	__raw_writew((__raw_readw(addr) & (0xff00 >> shift)) | (val << shift),
 		     addr);
 
@@ -1056,7 +1061,7 @@ static int __init sh_dmae_probe(struct p
 		return -ENODEV;
 
 	chan = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	/* DMARS area is optional, if absent, this controller cannot do slave DMA */
+	/* DMARS area is optional */
 	dmars = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	/*
 	 * IRQ resources:
@@ -1123,7 +1128,7 @@ static int __init sh_dmae_probe(struct p
 	INIT_LIST_HEAD(&shdev->common.channels);
 
 	dma_cap_set(DMA_MEMCPY, shdev->common.cap_mask);
-	if (dmars)
+	if (pdata->slave && pdata->slave_num)
 		dma_cap_set(DMA_SLAVE, shdev->common.cap_mask);
 
 	shdev->common.device_alloc_chan_resources
