From: Bastian Hecht <hechtb@googlemail.com>
Date: Mon, 24 Sep 2012 09:18:35 +0000
Subject: [PATCH v2 2/2] mtd: sh_flctl: Use DMA for data fifo FLTDFIFO when available
Message-Id: <1348478315-10789-2-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1348478315-10789-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1348478315-10789-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mtd@lists.infradead.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-sh@vger.kernel.org

Map and unmap DMA buffers, trigger the DMA and wait for the completion.
On failure we fallback to PIO mode.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
log v2: dropped a forward declaration

 drivers/mtd/nand/sh_flctl.c  |   97 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/mtd/sh_flctl.h |    1 +
 2 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 9659483..0d90af8 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -24,6 +24,8 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
@@ -106,6 +108,13 @@ static void wait_completion(struct sh_flctl *flctl)
 	writeb(0x0, FLTRCR(flctl));
 }
 
+static void flctl_dma_complete(void *param)
+{
+	struct sh_flctl *flctl = param;
+
+	complete(&flctl->dma_complete);
+}
+
 static void flctl_release_dma(struct sh_flctl *flctl)
 {
 	if (flctl->chan_fifo0_rx) {
@@ -331,6 +340,69 @@ static void wait_wecfifo_ready(struct sh_flctl *flctl)
 	timeout_error(flctl, __func__);
 }
 
+static void flctl_dma_fifo0_transfer(struct sh_flctl *flctl, unsigned long *buf,
+					int len, enum dma_data_direction dir)
+{
+	struct dma_async_tx_descriptor *desc = NULL;
+	struct dma_chan *chan;
+	enum dma_transfer_direction tr_dir;
+	dma_addr_t dma_addr;
+	dma_cookie_t cookie = -EINVAL;
+	uint32_t reg;
+	int ret;
+
+	if (dir = DMA_FROM_DEVICE) {
+		chan = flctl->chan_fifo0_rx;
+		tr_dir = DMA_DEV_TO_MEM;
+	} else {
+		chan = flctl->chan_fifo0_tx;
+		tr_dir = DMA_MEM_TO_DEV;
+	}
+
+	dma_addr = dma_map_single(chan->device->dev, buf, len, dir);
+
+	if (dma_addr)
+		desc = dmaengine_prep_slave_single(chan, dma_addr, len,
+			tr_dir, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+
+	if (desc) {
+		reg = readl(FLINTDMACR(flctl));
+		reg |= DREQ0EN;
+		writel(reg, FLINTDMACR(flctl));
+
+		desc->callback = flctl_dma_complete;
+		desc->callback_param = flctl;
+		cookie = dmaengine_submit(desc);
+
+		dma_async_issue_pending(chan);
+	}
+
+	if (!desc) {
+		/* DMA failed, fall back to PIO */
+		flctl_release_dma(flctl);
+		dev_warn(&flctl->pdev->dev,
+			 "DMA failed, falling back to PIO\n");
+		goto out;
+	}
+
+	ret +	wait_for_completion_timeout(&flctl->dma_complete,
+				msecs_to_jiffies(3000));
+
+	if (ret <= 0) {
+		chan->device->device_control(chan, DMA_TERMINATE_ALL, 0);
+		dev_err(&flctl->pdev->dev, "wait_for_completion_timeout\n");
+	}
+
+out:
+	reg = readl(FLINTDMACR(flctl));
+	reg &= ~DREQ0EN;
+	writel(reg, FLINTDMACR(flctl));
+
+	dma_unmap_single(chan->device->dev, dma_addr, len, dir);
+	init_completion(&flctl->dma_complete);
+}
+
 static void read_datareg(struct sh_flctl *flctl, int offset)
 {
 	unsigned long data;
@@ -349,6 +421,16 @@ static void read_fiforeg(struct sh_flctl *flctl, int rlen, int offset)
 
 	len_4align = (rlen + 3) / 4;
 
+	/* initiate DMA transfer */
+	if (flctl->chan_fifo0_rx && rlen >= 32) {
+		flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_DEV_TO_MEM);
+		for (i = 0; i < len_4align; i++)
+			buf[i] = be32_to_cpu(buf[i]);
+
+		return;
+	}
+
+	/* do polling transfer */
 	for (i = 0; i < len_4align; i++) {
 		wait_rfifo_ready(flctl);
 		buf[i] = readl(FLDTFIFO(flctl));
@@ -378,13 +460,24 @@ static enum flctl_ecc_res_t read_ecfiforeg
 static void write_fiforeg(struct sh_flctl *flctl, int rlen, int offset)
 {
 	int i, len_4align;
-	unsigned long *data = (unsigned long *)&flctl->done_buff[offset];
+	unsigned long *buf = (unsigned long *)&flctl->done_buff[offset];
 	void *fifo_addr = (void *)FLDTFIFO(flctl);
 
 	len_4align = (rlen + 3) / 4;
+
+	/* initiate DMA transfer */
+	if (flctl->chan_fifo0_tx && rlen >= 32) {
+		for (i = 0; i < len_4align; i++)
+			buf[i] = cpu_to_be32(buf[i]);
+
+		flctl_dma_fifo0_transfer(flctl, buf, rlen, DMA_MEM_TO_DEV);
+		return;
+	}
+
+	/* do polling transfer */
 	for (i = 0; i < len_4align; i++) {
 		wait_wfifo_ready(flctl);
-		writel(cpu_to_be32(data[i]), fifo_addr);
+		writel(cpu_to_be32(buf[i]), fifo_addr);
 	}
 }
 
diff --git a/include/linux/mtd/sh_flctl.h b/include/linux/mtd/sh_flctl.h
index 20d3f48..d55ec25 100644
--- a/include/linux/mtd/sh_flctl.h
+++ b/include/linux/mtd/sh_flctl.h
@@ -109,6 +109,7 @@
 #define ESTERINTE	(0x1 << 24)	/* ECC error interrupt enable */
 #define AC1CLR		(0x1 << 19)	/* ECC FIFO clear */
 #define AC0CLR		(0x1 << 18)	/* Data FIFO clear */
+#define DREQ0EN		(0x1 << 16)	/* FLDTFIFODMA Request Enable */
 #define ECERB		(0x1 << 9)	/* ECC error */
 #define STERB		(0x1 << 8)	/* Status error */
 #define STERINTE	(0x1 << 4)	/* Status error enable */
-- 
1.7.5.4

