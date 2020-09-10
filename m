From: Greg KH <greg@kroah.com>
Date: Thu, 10 Sep 2020 07:53:51 +0000
Subject: Re: [PATCH 3/3] dma-mapping: introduce DMA range map, supplanting dma_pfn_offset
Message-Id: <20200910075351.GA1092435@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200910054038.324517-1-hch@lst.de>
 <20200910054038.324517-4-hch@lst.de>
In-Reply-To: <20200910054038.324517-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>, Jim Quinlan <james.quinlan@broadcom.com>, Nathan Chancellor <natechancellor@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org

On Thu, Sep 10, 2020 at 07:40:38AM +0200, Christoph Hellwig wrote:
> From: Jim Quinlan <james.quinlan@broadcom.com>
> 
> The new field 'dma_range_map' in struct device is used to facilitate the
> use of single or multiple offsets between mapping regions of cpu addrs and
> dma addrs.  It subsumes the role of "dev->dma_pfn_offset" which was only
> capable of holding a single uniform offset and had no region bounds
> checking.
> 
> The function of_dma_get_range() has been modified so that it takes a single
> argument -- the device node -- and returns a map, NULL, or an error code.
> The map is an array that holds the information regarding the DMA regions.
> Each range entry contains the address offset, the cpu_start address, the
> dma_start address, and the size of the region.
> 
> of_dma_configure() is the typical manner to set range offsets but there are
> a number of ad hoc assignments to "dev->dma_pfn_offset" in the kernel
> driver code.  These cases now invoke the function
> dma_attach_offset_range(dev, cpu_addr, dma_addr, size).

So if an error happens, we don't do anything?

ice_init(dev->dev);
> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> index 6197938dcc2d8f..935ee98e049f65 100644
> --- a/drivers/usb/core/message.c
> +++ b/drivers/usb/core/message.c
> @@ -1956,10 +1956,11 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
>  		intf->dev.groups = usb_interface_groups;
>  		/*
>  		 * Please refer to usb_alloc_dev() to see why we set
> -		 * dma_mask and dma_pfn_offset.
> +		 * dma_mask and dma_range_map.
>  		 */
>  		intf->dev.dma_mask = dev->dev.dma_mask;
> -		intf->dev.dma_pfn_offset = dev->dev.dma_pfn_offset;
> +		if (dma_direct_copy_range_map(&intf->dev, &dev->dev))
> +			dev_err(&dev->dev, "failed to copy DMA map\n");

We tell the user, but then just keep on running?  Is there anything that
we can do here?

If not, why not have dma_direct_copy_range_map() print out the error?

thanks,

greg k-h
