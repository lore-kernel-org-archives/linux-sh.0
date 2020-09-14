From: Christoph Hellwig <hch@lst.de>
Date: Mon, 14 Sep 2020 07:33:42 +0000
Subject: [PATCH 5/6] usb: don't inherity DMA properties for USB devices
Message-Id: <20200914073343.1579578-6-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200914073343.1579578-1-hch@lst.de>
In-Reply-To: <20200914073343.1579578-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jim Quinlan <james.quinlan@broadcom.com>, Nathan Chancellor <natechancellor@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-remoteproc@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org

As the comment in usb_alloc_dev correctly states, drivers can't use
the DMA API on usb device, and at least calling dma_set_mask on them
is highly dangerous.  Unlike what the comment states upper level drivers
also can't really use the presence of a dma mask to check for DMA
support, as the dma_mask is set by default for most busses.

Setting the dma_mask comes from "[PATCH] usbcore dma updates (and doc)"
in BitKeeper times, as it seems like it was primarily for setting the
NETIF_F_HIGHDMA flag in USB drivers, something that has long been
fixed up since.

Setting the dma_pfn_offset comes from commit b44bbc46a8bb
("usb: core: setup dma_pfn_offset for USB devices and, interfaces"),
which worked around the fact that the scsi_calculate_bounce_limits
functions wasn't going through the proper driver interface to query
DMA information, but that function was removed in commit 21e07dba9fb1
("scsi: reduce use of block bounce buffers") years ago.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/usb/core/message.c |  6 ------
 drivers/usb/core/usb.c     | 12 ------------
 2 files changed, 18 deletions(-)

diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 6197938dcc2d8f..9e45732dc1d1d1 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1954,12 +1954,6 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
 		intf->dev.bus = &usb_bus_type;
 		intf->dev.type = &usb_if_device_type;
 		intf->dev.groups = usb_interface_groups;
-		/*
-		 * Please refer to usb_alloc_dev() to see why we set
-		 * dma_mask and dma_pfn_offset.
-		 */
-		intf->dev.dma_mask = dev->dev.dma_mask;
-		intf->dev.dma_pfn_offset = dev->dev.dma_pfn_offset;
 		INIT_WORK(&intf->reset_ws, __usb_queue_reset_device);
 		intf->minor = -1;
 		device_initialize(&intf->dev);
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index bafc113f2b3ef3..9b4ac4415f1a47 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -599,18 +599,6 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
 	dev->dev.bus = &usb_bus_type;
 	dev->dev.type = &usb_device_type;
 	dev->dev.groups = usb_device_groups;
-	/*
-	 * Fake a dma_mask/offset for the USB device:
-	 * We cannot really use the dma-mapping API (dma_alloc_* and
-	 * dma_map_*) for USB devices but instead need to use
-	 * usb_alloc_coherent and pass data in 'urb's, but some subsystems
-	 * manually look into the mask/offset pair to determine whether
-	 * they need bounce buffers.
-	 * Note: calling dma_set_mask() on a USB device would set the
-	 * mask for the entire HCD, so don't do that.
-	 */
-	dev->dev.dma_mask = bus->sysdev->dma_mask;
-	dev->dev.dma_pfn_offset = bus->sysdev->dma_pfn_offset;
 	set_dev_node(&dev->dev, dev_to_node(bus->sysdev));
 	dev->state = USB_STATE_ATTACHED;
 	dev->lpm_disable_count = 1;
-- 
2.28.0
