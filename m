From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 09 Aug 2015 23:31:13 +0000
Subject: Re: [PATCH] ARM: shmobile: IPMMU and DMAC prototype
Message-Id: <89949879.QppV1EtK2z@avalon>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

Thank you for the patch.

On Monday 27 July 2015 21:05:18 Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> This patch is a prototype hack to enable DMA Engine over IPMMU for
> devices such as QSPI, SDHI and MMCIF. The simple approach taken here
> is to identity map the DMA Engine slave devices in the IPMMU driver.
> 
> As expected this is just a test to see if the actual hardware works.
> I believe it at least half-works - the IPMMU fault errors go away
> when I test on r8a7791 Koelsch.
> 
> The code is far from ready for upstream merge for various reasons:
>  - The code is one huge layering violation (topology fixes should be
> elsewhere)
> - It also clobbers the virtual I/O space without reservation (corruption!)
> - Moreover, the identity mappings are added for all devices (just plain
> wrong)
> 
> Next step would be to figure out how to fix this properly.

Given that you've yourself identified this approach as being a big layering 
violation, the proper fix is to move it to a different layer :-)

The DMA engine API currently passes slave addresses as dma_addr_t but slave 
drivers pass physical addresses instead. There's only two ways to fix that:

(please read the "[periperi] About using IPMMU" mail thread for more 
information)

- Modify the DMA engine API to pass a phys_addr_t. Slave drivers will then be 
right, and DMAC drivers will need to map the phys_addr_t to a dma_addr_t 
(through the IOMMU) using the DMA mapping API.

- Keep the DMA engine API as-is and fix slave drivers to map the physical 
address to a dma_addr_t using the DMA mapping API.

The struct device used to create the mapping must be the DMAC device as that's 
the bus master that needs to be translated by the IOMMU. For that reason, and 
to keep slave drivers simple(r), I believe the first approach should be 
preferred.

This should of course be discussed on the dma-engine mailing list first. The 
good news is that the topic has already been discussed, and patches even got 
sent. See https://lkml.org/lkml/2015/7/10/167 for instance.

> Not-Yet-Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  arch/arm/boot/dts/r8a7791.dtsi |   32 +++++++++++++++++++++-
>  drivers/iommu/ipmmu-vmsa.c     |   57 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 88 insertions(+), 1 deletion(-)
> 
> --- 0001/arch/arm/boot/dts/r8a7791.dtsi
> +++ work/arch/arm/boot/dts/r8a7791.dtsi	2015-07-27 15:15:34.922366518 +0900
> @@ -270,6 +270,21 @@
>  		clock-names = "fck";
>  		#dma-cells = <1>;
>  		dma-channels = <15>;
> +		iommus = <&ipmmu_ds 0>,
> +		       <&ipmmu_ds 1>,
> +		       <&ipmmu_ds 2>,
> +		       <&ipmmu_ds 3>,
> +		       <&ipmmu_ds 4>,
> +		       <&ipmmu_ds 5>,
> +		       <&ipmmu_ds 6>,
> +		       <&ipmmu_ds 7>,
> +		       <&ipmmu_ds 8>,
> +		       <&ipmmu_ds 9>,
> +		       <&ipmmu_ds 10>,
> +		       <&ipmmu_ds 11>,
> +		       <&ipmmu_ds 12>,
> +		       <&ipmmu_ds 13>,
> +		       <&ipmmu_ds 14>;
>  	};
> 
>  	dmac1: dma-controller@e6720000 {
> @@ -300,6 +315,21 @@
>  		clock-names = "fck";
>  		#dma-cells = <1>;
>  		dma-channels = <15>;
> +		iommus = <&ipmmu_ds 15>,
> +		       <&ipmmu_ds 16>,
> +		       <&ipmmu_ds 17>,
> +		       <&ipmmu_ds 18>,
> +		       <&ipmmu_ds 19>,
> +		       <&ipmmu_ds 20>,
> +		       <&ipmmu_ds 21>,
> +		       <&ipmmu_ds 22>,
> +		       <&ipmmu_ds 23>,
> +		       <&ipmmu_ds 24>,
> +		       <&ipmmu_ds 25>,
> +		       <&ipmmu_ds 26>,
> +		       <&ipmmu_ds 27>,
> +		       <&ipmmu_ds 28>,
> +		       <&ipmmu_ds 29>;
>  	};
> 
>  	audma0: dma-controller@ec700000 {
> @@ -1522,7 +1552,7 @@
>  		interrupts = <0 198 IRQ_TYPE_LEVEL_HIGH>,
>  			     <0 199 IRQ_TYPE_LEVEL_HIGH>;
>  		#iommu-cells = <1>;
> -		status = "disabled";
> +		status = "okay";
>  	};
> 
>  	ipmmu_mp: mmu@ec680000 {
> --- 0001/drivers/iommu/ipmmu-vmsa.c
> +++ work/drivers/iommu/ipmmu-vmsa.c	2015-07-27 20:48:02.642366518 +0900
> @@ -491,6 +491,61 @@ static void ipmmu_domain_free(struct iom
>  	kfree(domain);
>  }
> 
> +/* Hack to identity map address ranges needed by the DMAC hardware */
> +static struct {
> +	phys_addr_t base;
> +	size_t size;
> +} dmac_workaround[] = {
> +	{
> +		.base = 0xe6b10000, /* QSPI */
> +		.size = SZ_4K,
> +	},
> +	{
> +		.base = 0xee100000, /* SDHI0 */
> +		.size = SZ_16K,
> +	},
> +	{
> +		.base = 0xee120000, /* SDHIx */
> +		.size = SZ_16K,
> +	},
> +	{
> +		.base = 0xee140000, /* SDHIy */
> +		.size = SZ_16K,
> +	},
> +	{
> +		.base = 0xee160000, /* SDHIz */
> +		.size = SZ_16K,
> +	},
> +	{
> +		.base = 0xee200000, /* MMCIF0 */
> +		.size = SZ_4K,
> +	},
> +	{
> +		.base = 0xee220000, /* MMCIF1 */
> +		.size = SZ_4K,
> +	},
> +};
> +
> +static void ipmmu_workaround(struct iommu_domain *domain)
> +{
> +	int k;
> +
> +	for (k = 0; k < ARRAY_SIZE(dmac_workaround); k++) {
> +		phys_addr_t phys_addr;
> +
> +		printk("xxxx adding workaround for device at %pap\n",
> +		       &dmac_workaround[k].base);
> +
> +		phys_addr = iommu_iova_to_phys(domain, dmac_workaround[k].base);
> +		if (phys_addr)
> +			continue;
> +
> +		iommu_map(domain, dmac_workaround[k].base,
> +			  dmac_workaround[k].base, dmac_workaround[k].size,
> +			  IOMMU_READ | IOMMU_READ);
> +	}
> +}
> +
>  static int ipmmu_attach_device(struct iommu_domain *io_domain,
>  			       struct device *dev)
>  {
> @@ -530,6 +585,8 @@ static int ipmmu_attach_device(struct io
>  	for (i = 0; i < archdata->num_utlbs; ++i)
>  		ipmmu_utlb_enable(domain, archdata->utlbs[i]);
> 
> +	ipmmu_workaround(io_domain);
> +
>  	return 0;
>  }

-- 
Regards,

Laurent Pinchart

