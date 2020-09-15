From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Tue, 15 Sep 2020 19:55:01 +0000
Subject: Re: [PATCH 6/6] dma-mapping: introduce DMA range map, supplanting dma_pfn_offset
Message-Id: <20200915195501.GA3666944@xps15>
List-Id: <linux-sh.vger.kernel.org>
References: <20200914073343.1579578-1-hch@lst.de>
 <20200914073343.1579578-7-hch@lst.de>
 <20200914230147.GA3251212@xps15>
 <20200915054122.GA18079@lst.de>
In-Reply-To: <20200915054122.GA18079@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jim Quinlan <james.quinlan@broadcom.com>, Nathan Chancellor <natechancellor@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-remoteproc@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, arnaud.pouliquen@st.com, loic.pallardy.st.com@xps15

On Tue, Sep 15, 2020 at 07:41:22AM +0200, Christoph Hellwig wrote:
> On Mon, Sep 14, 2020 at 05:01:47PM -0600, Mathieu Poirier wrote:
> 
> [700 lines of the fullquote deleted..]
> 
> > > +	for (r = map; r->size; r++)
> > > +		num_ranges++;
> > > +
> > > +	new_map = kmemdup(map, array_size(num_ranges + 1, sizeof(*map)),
> > > +			  GFP_KERNEL);
> > > +	if (!new_map)
> > > +		return -ENOMEM;
> > > +	to->dma_range_map = new_map;
> > > +	return 0;
> > > +}
> > > +
> > 
> > This patch seemed Ok to me but it broke the stm32 remoteproc implementation.  When
> > I tested things out function dma_coerce_mask_and_cohenrent() returns -5 and the
> > rest of the initialisation fails.  I isolated things to function dma_to_pfn()
> > [2].  In the original implementation __bus_to_pfn() returns 0xfffff and
> > dev->dma_pfn_offset is equal to 0x38000.  As such the function returns 0x137fff
> > and dma_supported() a non-zero value[3].
> > 
> > With this set function dma_to_pfn() received a face lift.  Function
> > __bus_to_pfn() still returns 0xfffff but translate_dma_to_phys() returns 0,
> > which forces dma_supported() to also return 0 and that is where the -5 (-EIO)
> > comes from.
> > 
> > Taking a futher look at translate_dma_to_phy(), @dma_addr never falls within the
> > bus_dma_region ranges and returns 0.
> > 
> > I'm suspecting an initialisation problem and if it occurred here, it will
> > likely show up elsewhere.
> 
> Can you try this incremental patch?
> 
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index 088c97181ab146..c6b21acba7a459 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -46,7 +46,7 @@ static inline phys_addr_t translate_dma_to_phys(struct device *dev,
>  		if (dma_addr >= m->dma_start && dma_addr - m->dma_start < m->size)
>  			return (phys_addr_t)dma_addr + m->offset;
>  
> -	return 0;
> +	return (phys_addr_t)-1;

That did the trick - the stm32 platform driver's probe() function completes and
the remote processor is operatinal. 

That being said the value returned by function dma_to_pfn()
is 0x137fff in the original code and 0xfffff with your patches applied.

Thanks,
Mathieu

>  }
>  
>  #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
