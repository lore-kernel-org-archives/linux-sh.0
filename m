From: Robin Murphy <robin.murphy@arm.com>
Date: Fri, 11 Sep 2020 11:12:00 +0000
Subject: Re: [PATCH 2/3] ARM/keystone: move the DMA offset handling under ifdef CONFIG_ARM_LPAE
Message-Id: <b3299b6e-aa0c-0a15-185d-392f406df8d9@arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200910054038.324517-1-hch@lst.de>
 <20200910054038.324517-3-hch@lst.de>
In-Reply-To: <20200910054038.324517-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, linux-sh@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org, Nathan Chancellor <natechancellor@gmail.com>, linux-arm-kernel@lists.infradead.org

On 2020-09-10 06:40, Christoph Hellwig wrote:
> The DMA offset notifier can only be used if PHYS_OFFSET is at least
> KEYSTONE_HIGH_PHYS_START, which can't be represented by a 32-bit
> phys_addr_t.  Currently the code compiles fine despite that, a pending
> change to the DMA offset handling would create a compiler warning for
> this case.  Add an ifdef to not compile the code except for LPAE
> configs.

Seems reasonable - once again I wonder whether this notifier is really 
needed any more since "dma-ranges" should now be handled properly for 
PCI devices as well, but that's not something to worry about in this series.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/arm/mach-keystone/keystone.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
> index 638808c4e12247..dcd031ba84c2e0 100644
> --- a/arch/arm/mach-keystone/keystone.c
> +++ b/arch/arm/mach-keystone/keystone.c
> @@ -24,6 +24,7 @@
>   
>   #include "keystone.h"
>   
> +#ifdef CONFIG_ARM_LPAE
>   static unsigned long keystone_dma_pfn_offset __read_mostly;
>   
>   static int keystone_platform_notifier(struct notifier_block *nb,
> @@ -48,14 +49,17 @@ static int keystone_platform_notifier(struct notifier_block *nb,
>   static struct notifier_block platform_nb = {
>   	.notifier_call = keystone_platform_notifier,
>   };
> +#endif /* CONFIG_ARM_LPAE */
>   
>   static void __init keystone_init(void)
>   {
> +#ifdef CONFIG_ARM_LPAE
>   	if (PHYS_OFFSET >= KEYSTONE_HIGH_PHYS_START) {
>   		keystone_dma_pfn_offset = PFN_DOWN(KEYSTONE_HIGH_PHYS_START -
>   						   KEYSTONE_LOW_PHYS_START);
>   		bus_register_notifier(&platform_bus_type, &platform_nb);
>   	}
> +#endif
>   	keystone_pm_runtime_init();
>   }
>   
> 
