From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 09 Feb 2015 08:16:12 +0000
Subject: [PATCH 2/4] usb: renesas_usbhs: add the channel number in dma-names
Message-Id: <1423469774-6532-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1423469774-6532-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1423469774-6532-1-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>

To connect the channel of USB-DMAC to USBHS DnFIFO number, this patch
adds this channel/FIFO number in dma-names. Otherwise, this driver
needs to add analysis code for device tree.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 .../devicetree/bindings/usb/renesas_usbhs.txt      |    5 ++++-
 drivers/usb/renesas_usbhs/fifo.c                   |   20 +++++++++++++-------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
index 61b045b..dc2a18f 100644
--- a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
+++ b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
@@ -15,7 +15,10 @@ Optional properties:
   - phys: phandle + phy specifier pair
   - phy-names: must be "usb"
   - dmas: Must contain a list of references to DMA specifiers.
-  - dma-names : Must contain a list of DMA names, "tx" or "rx".
+  - dma-names : Must contain a list of DMA names:
+   - tx0 ... tx<n>
+   - rx0 ... rx<n>
+    - This <n> means DnFIFO in USBHS module.
 
 Example:
 	usbhs: usb@e6590000 {
diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
index b1440d0..9fae14a 100644
--- a/drivers/usb/renesas_usbhs/fifo.c
+++ b/drivers/usb/renesas_usbhs/fifo.c
@@ -1069,23 +1069,29 @@ static void usbhsf_dma_init_pdev(struct usbhs_fifo *fifo)
 					    &fifo->rx_slave);
 }
 
-static void usbhsf_dma_init_dt(struct device *dev, struct usbhs_fifo *fifo)
+static void usbhsf_dma_init_dt(struct device *dev, struct usbhs_fifo *fifo,
+			       int channel)
 {
-	fifo->tx_chan = dma_request_slave_channel_reason(dev, "tx");
+	char name[16];
+
+	snprintf(name, sizeof(name), "tx%d", channel);
+	fifo->tx_chan = dma_request_slave_channel_reason(dev, name);
 	if (IS_ERR(fifo->tx_chan))
 		fifo->tx_chan = NULL;
-	fifo->rx_chan = dma_request_slave_channel_reason(dev, "rx");
+
+	snprintf(name, sizeof(name), "rx%d", channel);
+	fifo->rx_chan = dma_request_slave_channel_reason(dev, name);
 	if (IS_ERR(fifo->rx_chan))
 		fifo->rx_chan = NULL;
 }
 
-static void usbhsf_dma_init(struct usbhs_priv *priv,
-			    struct usbhs_fifo *fifo)
+static void usbhsf_dma_init(struct usbhs_priv *priv, struct usbhs_fifo *fifo,
+			    int channel)
 {
 	struct device *dev = usbhs_priv_to_dev(priv);
 
 	if (dev->of_node)
-		usbhsf_dma_init_dt(dev, fifo);
+		usbhsf_dma_init_dt(dev, fifo, channel);
 	else
 		usbhsf_dma_init_pdev(fifo);
 
@@ -1234,7 +1240,7 @@ do {									\
 			usbhs_get_dparam(priv, d##channel##_tx_id);	\
 	fifo->rx_slave.shdma_slave.slave_id =				\
 			usbhs_get_dparam(priv, d##channel##_rx_id);	\
-	usbhsf_dma_init(priv, fifo);					\
+	usbhsf_dma_init(priv, fifo, channel);				\
 } while (0)
 
 #define USBHS_DFIFO_INIT(priv, fifo, channel)				\
-- 
1.7.9.5

