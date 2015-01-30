From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 30 Jan 2015 06:58:23 +0000
Subject: [PATCH] usb: renesas_usbhs: fix NULL pointer dereference in dma_release_channel()
Message-Id: <1422601103-1144-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch fixes an issue that the following commit causes NULL
pointer dereference in dma_release_channel().
 "usb: renesas_usbhs: add support for requesting DT DMA"
 (commit id abd2dbf6bb1b5f3a03a8c76b1a8879da1dd30caa)

The usbhsf_dma_init_dt() should set fifo->{t,r}x_chan to NULL if
dma_request_slave_channel_reason() returns IS_ERR value.
Otherwise, usbhsf_dma_quit() will call dma_release_channel(), and then
NULL pointer dereference happens.

Reported-by: Simon Horman <horms@verge.net.au>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
This patch is based on Felipe's usb.git / testing/next branch.
(commit id }b3990cb707ff91cd6507d53a0a730afe97)

 drivers/usb/renesas_usbhs/fifo.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
index 4c086b1..d891bff 100644
--- a/drivers/usb/renesas_usbhs/fifo.c
+++ b/drivers/usb/renesas_usbhs/fifo.c
@@ -1072,7 +1072,11 @@ static void usbhsf_dma_init_pdev(struct usbhs_fifo *fifo)
 static void usbhsf_dma_init_dt(struct device *dev, struct usbhs_fifo *fifo)
 {
 	fifo->tx_chan = dma_request_slave_channel_reason(dev, "tx");
+	if (IS_ERR(fifo->tx_chan))
+		fifo->tx_chan = NULL;
 	fifo->rx_chan = dma_request_slave_channel_reason(dev, "rx");
+	if (IS_ERR(fifo->rx_chan))
+		fifo->rx_chan = NULL;
 }
 
 static void usbhsf_dma_init(struct usbhs_priv *priv,
-- 
1.7.9.5

