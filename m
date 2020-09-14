From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 14 Sep 2020 07:51:40 +0000
Subject: Re: [PATCH 5/6] usb: don't inherity DMA properties for USB devices
Message-Id: <20200914075140.GA1033580@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200914073343.1579578-1-hch@lst.de>
 <20200914073343.1579578-6-hch@lst.de>
In-Reply-To: <20200914073343.1579578-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>, Jim Quinlan <james.quinlan@broadcom.com>, Nathan Chancellor <natechancellor@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-remoteproc@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org

On Mon, Sep 14, 2020 at 09:33:42AM +0200, Christoph Hellwig wrote:
> As the comment in usb_alloc_dev correctly states, drivers can't use
> the DMA API on usb device, and at least calling dma_set_mask on them
> is highly dangerous.  Unlike what the comment states upper level drivers
> also can't really use the presence of a dma mask to check for DMA
> support, as the dma_mask is set by default for most busses.
> 
> Setting the dma_mask comes from "[PATCH] usbcore dma updates (and doc)"
> in BitKeeper times, as it seems like it was primarily for setting the
> NETIF_F_HIGHDMA flag in USB drivers, something that has long been
> fixed up since.
> 
> Setting the dma_pfn_offset comes from commit b44bbc46a8bb
> ("usb: core: setup dma_pfn_offset for USB devices and, interfaces"),
> which worked around the fact that the scsi_calculate_bounce_limits
> functions wasn't going through the proper driver interface to query
> DMA information, but that function was removed in commit 21e07dba9fb1
> ("scsi: reduce use of block bounce buffers") years ago.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
