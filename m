From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 19 Jan 2015 03:53:16 +0000
Subject: [PATCH 1/2] usb: renesas_usbhs: add usbhsf_dma_init_pdev() function
Message-Id: <1421639597-2784-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

To add support for requesting DT DMA in the future, this patch adds
usbhsf_dma_init_pdev() function.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/fifo.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
index f46271c..48e31b9 100644
--- a/drivers/usb/renesas_usbhs/fifo.c
+++ b/drivers/usb/renesas_usbhs/fifo.c
@@ -1054,10 +1054,8 @@ static void usbhsf_dma_quit(struct usbhs_priv *priv, struct usbhs_fifo *fifo)
 	fifo->rx_chan = NULL;
 }
 
-static void usbhsf_dma_init(struct usbhs_priv *priv,
-			    struct usbhs_fifo *fifo)
+static void usbhsf_dma_init_pdev(struct usbhs_fifo *fifo)
 {
-	struct device *dev = usbhs_priv_to_dev(priv);
 	dma_cap_mask_t mask;
 
 	dma_cap_zero(mask);
@@ -1069,6 +1067,14 @@ static void usbhsf_dma_init(struct usbhs_priv *priv,
 	dma_cap_set(DMA_SLAVE, mask);
 	fifo->rx_chan = dma_request_channel(mask, usbhsf_dma_filter,
 					    &fifo->rx_slave);
+}
+
+static void usbhsf_dma_init(struct usbhs_priv *priv,
+			    struct usbhs_fifo *fifo)
+{
+	struct device *dev = usbhs_priv_to_dev(priv);
+
+	usbhsf_dma_init_pdev(fifo);
 
 	if (fifo->tx_chan || fifo->rx_chan)
 		dev_dbg(dev, "enable DMAEngine (%s%s%s)\n",
-- 
1.7.9.5

