From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 19 Jan 2015 03:53:17 +0000
Subject: [PATCH 2/2] usb: renesas_usbhs: add support for requesting DT DMA
Message-Id: <1421639597-2784-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4F05318F.9060209@renesas.com>
In-Reply-To: <4F05318F.9060209@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds dma_request_slave_channel_reason() calling to request
dma slave channels for multiplatform environment.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 .../devicetree/bindings/usb/renesas_usbhs.txt      |    2 ++
 drivers/usb/renesas_usbhs/fifo.c                   |   11 ++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
index b08c903..61b045b 100644
--- a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
+++ b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
@@ -14,6 +14,8 @@ Optional properties:
 			 function should be enabled
   - phys: phandle + phy specifier pair
   - phy-names: must be "usb"
+  - dmas: Must contain a list of references to DMA specifiers.
+  - dma-names : Must contain a list of DMA names, "tx" or "rx".
 
 Example:
 	usbhs: usb@e6590000 {
diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
index 48e31b9..4c086b1 100644
--- a/drivers/usb/renesas_usbhs/fifo.c
+++ b/drivers/usb/renesas_usbhs/fifo.c
@@ -1069,12 +1069,21 @@ static void usbhsf_dma_init_pdev(struct usbhs_fifo *fifo)
 					    &fifo->rx_slave);
 }
 
+static void usbhsf_dma_init_dt(struct device *dev, struct usbhs_fifo *fifo)
+{
+	fifo->tx_chan = dma_request_slave_channel_reason(dev, "tx");
+	fifo->rx_chan = dma_request_slave_channel_reason(dev, "rx");
+}
+
 static void usbhsf_dma_init(struct usbhs_priv *priv,
 			    struct usbhs_fifo *fifo)
 {
 	struct device *dev = usbhs_priv_to_dev(priv);
 
-	usbhsf_dma_init_pdev(fifo);
+	if (dev->of_node)
+		usbhsf_dma_init_dt(dev, fifo);
+	else
+		usbhsf_dma_init_pdev(fifo);
 
 	if (fifo->tx_chan || fifo->rx_chan)
 		dev_dbg(dev, "enable DMAEngine (%s%s%s)\n",
-- 
1.7.9.5

