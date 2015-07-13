From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 13 Jul 2015 09:10:05 +0000
Subject: [PATCH/RFC] usb: gadget: udc: core: Fix argument of dma_map_single for IOMMU
Message-Id: <1436778605-5576-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The dma_map_single and dma_unmap_single should set "gadget->dev.parent"
instead of "&gadget->dev" in the first argument because the parent has
a udc controller's device pointer.
Otherwise, iommu functions are not called in ARM environment.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 This patch is based on the Felipe's usb.git / testing/next branch.
 commit id = 298623983e74d935fc241d0eb1d0740cf4c32599

 drivers/usb/gadget/udc/udc-core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index d69c355..362ee8a 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -60,13 +60,15 @@ static DEFINE_MUTEX(udc_lock);
 int usb_gadget_map_request(struct usb_gadget *gadget,
 		struct usb_request *req, int is_in)
 {
+	struct device *dev = gadget->dev.parent;
+
 	if (req->length = 0)
 		return 0;
 
 	if (req->num_sgs) {
 		int     mapped;
 
-		mapped = dma_map_sg(&gadget->dev, req->sg, req->num_sgs,
+		mapped = dma_map_sg(dev, req->sg, req->num_sgs,
 				is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 		if (mapped = 0) {
 			dev_err(&gadget->dev, "failed to map SGs\n");
@@ -75,11 +77,11 @@ int usb_gadget_map_request(struct usb_gadget *gadget,
 
 		req->num_mapped_sgs = mapped;
 	} else {
-		req->dma = dma_map_single(&gadget->dev, req->buf, req->length,
+		req->dma = dma_map_single(dev, req->buf, req->length,
 				is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 
-		if (dma_mapping_error(&gadget->dev, req->dma)) {
-			dev_err(&gadget->dev, "failed to map buffer\n");
+		if (dma_mapping_error(dev, req->dma)) {
+			dev_err(dev, "failed to map buffer\n");
 			return -EFAULT;
 		}
 	}
@@ -95,12 +97,12 @@ void usb_gadget_unmap_request(struct usb_gadget *gadget,
 		return;
 
 	if (req->num_mapped_sgs) {
-		dma_unmap_sg(&gadget->dev, req->sg, req->num_mapped_sgs,
+		dma_unmap_sg(gadget->dev.parent, req->sg, req->num_mapped_sgs,
 				is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 
 		req->num_mapped_sgs = 0;
 	} else {
-		dma_unmap_single(&gadget->dev, req->dma, req->length,
+		dma_unmap_single(gadget->dev.parent, req->dma, req->length,
 				is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 	}
 }
-- 
1.9.1

