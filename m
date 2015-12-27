From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 27 Dec 2015 08:51:56 +0000
Subject: Re: [PATCH/RFC] ARM: shmobile: LPAE memory bank CMA assignment prototype
Message-Id: <4022733.cPW423KUra@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20151219014005.6274.87661.sendpatchset@little-apple>
In-Reply-To: <20151219014005.6274.87661.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

Thank you for the patch.

On Saturday 19 December 2015 10:40:05 Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> This prototype patch extends the kernel to also reserve CMA memory
> in the top memory bank on R-Car Gen2 boards and ties this larger
> CMA area to the DU device for testing purpose.
> 
> This top portion of the memory requires 40-bits addressing support
> in bus master devices including LPAE for the ARM CPU cores.
> 
> The patch assigns a 512 MiB CMA area to the DU device that may be
> used with the IPMMU hardware to perform 40-bit bus master access.
> Without IPMMU the DU hardware only supports 32-bit addresses.
> 
> Tested on r8a7791 Koelsch HDMI output using the modetest utility:
> # modetest -M rcar-du -s 33:1024x768@AR24
> 
> Not for upstream merge.

I tried to understand where the setup-rcar-gen2.c code you're patching came 
from. Due to a rebase the commit message of 83850b04ae77 ("ARM: shmobile: 
rcar-gen2: Update for of_get_flat_dt_prop() update") is incorrect, but I've 
traced the original commit to ae8bf91c80b0 ("ARM: shmobile: Add shared R-Car 
Gen2 CMA reservation code") in Simon's tree.

That patch doesn't look like a very good approach to me, and neither does this 
one :-) drivers/staging/board is a hack, and we're starting to abuse it. I 
don't want to see board code coming back through the back door. What's wrong 
with just reserving memory in DT with the reserved-memory bindings and 
assigning it to the DU ?

> Not-Yet-Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  arch/arm/mach-shmobile/setup-rcar-gen2.c |   33 ++++++++-
>  drivers/staging/board/Makefile           |    1
>  drivers/staging/board/rcar-gen2.c        |  104 +++++++++++++++++++++++++++
>  3 files changed, 134 insertions(+), 4 deletions(-)
> 
> --- 0001/arch/arm/mach-shmobile/setup-rcar-gen2.c
> +++ work/arch/arm/mach-shmobile/setup-rcar-gen2.c
> 2015-12-19 09:38:09.750513000 +0900
> @@ -136,14 +136,14 @@ struct memory_reserve_config
> {
>  	u64 base, size;
>  };
> 
> -static int __init rcar_gen2_scan_mem(unsigned long node, const char *uname,
> -				     int depth, void *data)
> +static int __init __rcar_gen2_scan_mem(unsigned long node, const char
> *uname,
> +				     int depth, void *data,
> +				     u64 lpae_start)
>  {
>  	const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
>  	const __be32 *reg, *endp;
>  	int l;
>  	struct memory_reserve_config *mrc = data;
> -	u64 lpae_start = 1ULL << 32;
> 
>  	/* We are scanning "memory" nodes only */
>  	if (type = NULL || strcmp(type, "memory"))
> @@ -182,6 +182,20 @@ static int __init rcar_gen2_scan_mem(uns
>  	return 0;
>  }
> 
> +static int __init rcar_gen2_scan_mem_legacy(unsigned long node,
> +					    const char *uname,
> +					    int depth, void *data)
> +{
> +	return __rcar_gen2_scan_mem(node, uname, depth, data, 1ULL << 32);
> +}
> +
> +static int __init rcar_gen2_scan_mem_lpae(unsigned long node,
> +					  const char *uname,
> +					  int depth, void *data)
> +{
> +	return __rcar_gen2_scan_mem(node, uname, depth, data, 1ULL << 40);
> +}
> +
>  struct cma *rcar_gen2_dma_contiguous;
> 
>  void __init rcar_gen2_reserve(void)
> @@ -192,7 +206,18 @@ void __init rcar_gen2_reserve(void)
>  	memset(&mrc, 0, sizeof(mrc));
>  	mrc.reserved = SZ_256M;
> 
> -	of_scan_flat_dt(rcar_gen2_scan_mem, &mrc);
> +	of_scan_flat_dt(rcar_gen2_scan_mem_legacy, &mrc);
> +#ifdef CONFIG_DMA_CMA
> +	if (mrc.size && memblock_is_region_memory(mrc.base, mrc.size))
> +		dma_contiguous_reserve_area(mrc.size, mrc.base, 0,
> +					    &rcar_gen2_dma_contiguous, true);
> +#endif
> +
> +	/* reserve 512 MiB at the top of the 40-bit memory space */
> +	memset(&mrc, 0, sizeof(mrc));
> +	mrc.reserved = SZ_512M;
> +
> +	of_scan_flat_dt(rcar_gen2_scan_mem_lpae, &mrc);
>  #ifdef CONFIG_DMA_CMA
>  	if (mrc.size && memblock_is_region_memory(mrc.base, mrc.size))
>  		dma_contiguous_reserve_area(mrc.size, mrc.base, 0,
> --- 0001/drivers/staging/board/Makefile
> +++ work/drivers/staging/board/Makefile	2015-12-18 17:46:31.030513000 +0900
> @@ -1,3 +1,4 @@
>  obj-y	:= board.o
>  obj-$(CONFIG_ARCH_EMEV2)	+= kzm9d.o
>  obj-$(CONFIG_ARCH_R8A7740)	+= armadillo800eva.o
> +obj-$(CONFIG_ARCH_RCAR_GEN2)	+= rcar-gen2.o
> --- /dev/null
> +++ work/drivers/staging/board/rcar-gen2.c	2015-12-19 10:07:35.820513000
> +0900 @@ -0,0 +1,104 @@
> +/* Staging board support for R-Car Gen2. Enable not-yet-DT-capable bits
> here. */ +
> +#include <linux/kernel.h>
> +#include <linux/cma.h>
> +#include <linux/dma-contiguous.h>
> +#include <linux/errno.h>
> +#include <linux/notifier.h>
> +#include <linux/platform_device.h>
> +#include "board.h"
> +#include "../../../mm/cma.h"
> +
> +#if defined(CONFIG_CMA) && defined(CONFIG_DMA_CMA)
> +
> +static struct cma *largest_cma_area;
> +
> +static int cma_assign_bus_notifier(struct notifier_block *nb,
> +			      unsigned long action, void *data)
> +{
> +	struct device *dev = data;
> +	const struct device_node *node = dev->of_node;
> +
> +	if (action = BUS_NOTIFY_BIND_DRIVER) {
> +		if (of_device_is_compatible(node, "renesas,du-r8a7790") ||
> +		    of_device_is_compatible(node, "renesas,du-r8a7791") ||
> +		    of_device_is_compatible(node, "renesas,du-r8a7793") ||
> +		    of_device_is_compatible(node, "renesas,du-r8a7794")) {
> +
> +			pr_info("Board Staging: Assigning CMA to %s\n",
> +				of_node_full_name(node));
> +			dev_set_cma_area(dev, largest_cma_area);
> +		}
> +  	}
> +
> +	return 0;
> +}
> +
> +static struct notifier_block cma_assign_nb = {
> +	.notifier_call = cma_assign_bus_notifier,
> +};
> +
> +struct cma *find_largest_nondefault_cma(void)
> +{
> +	unsigned long largest_size;
> +	int k, largest_idx;
> +
> +	largest_size = 0;
> +	largest_idx = -ENOENT;
> +
> +	for (k = 0; k < cma_area_count; k++) {
> +		if (&cma_areas[k] = dma_contiguous_default_area)
> +			continue;
> +
> +		if (cma_get_size(&cma_areas[k]) > largest_size) {
> +			largest_size = cma_get_size(&cma_areas[k]);
> +			largest_idx = k;
> +		}
> +	}
> +
> +	if (largest_idx != -ENOENT)
> +		return &cma_areas[largest_idx];
> +
> +	return NULL;
> +}
> +
> +static void __init board_staging_init(void)
> +{
> +	struct cma *target;
> +	phys_addr_t cma_base;
> +
> +	target = find_largest_nondefault_cma();
> +
> +	if (target) {
> +		cma_base = cma_get_base(target);
> +
> +		pr_info("Board Staging: Located CMA at "
> +			"%pa, size %ld MiB\n", &cma_base,
> +			(unsigned long)cma_get_size(target) / SZ_1M);
> +
> +		largest_cma_area = target;
> +		bus_register_notifier(&platform_bus_type, &cma_assign_nb);
> +	}
> +}
> +#else
> +static inline void __init board_staging_init(void) {}
> +#endif
> +
> +static int __init runtime_board_check(void)
> +{
> +	if (of_machine_is_compatible("renesas,r8a7790"))
> +	       board_staging_init();
> +
> +	if (of_machine_is_compatible("renesas,r8a7791"))
> +	       board_staging_init();
> +
> +	if (of_machine_is_compatible("renesas,r8a7793"))
> +	       board_staging_init();
> +
> +	if (of_machine_is_compatible("renesas,r8a7794"))
> +	       board_staging_init();
> +
> +	return 0;
> +}
> +
> +arch_initcall(runtime_board_check)

-- 
Regards,

Laurent Pinchart

