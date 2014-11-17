From: Simon Horman <horms@verge.net.au>
Date: Mon, 17 Nov 2014 01:36:18 +0000
Subject: Re: [PATCH 1/3] ARM: shmobile: r8a7779: Spelling/grammar s/entity/identity/, s/map/mapping/
Message-Id: <20141117013618.GJ11143@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1415981227-13580-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1415981227-13580-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Nov 14, 2014 at 05:07:05PM +0100, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, all three patches queued up.

> ---
>  arch/arm/mach-shmobile/setup-r8a7779.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
> index 9452dd4ea925a093..6156d172cf3108d7 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7779.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7779.c
> @@ -48,14 +48,14 @@
>  #include "r8a7779.h"
>  
>  static struct map_desc r8a7779_io_desc[] __initdata = {
> -	/* 2M entity map for 0xf0000000 (MPCORE) */
> +	/* 2M identity mapping for 0xf0000000 (MPCORE) */
>  	{
>  		.virtual	= 0xf0000000,
>  		.pfn		= __phys_to_pfn(0xf0000000),
>  		.length		= SZ_2M,
>  		.type		= MT_DEVICE_NONSHARED
>  	},
> -	/* 16M entity map for 0xfexxxxxx (DMAC-S/HPBREG/INTC2/LRAM/DBSC) */
> +	/* 16M identity mapping for 0xfexxxxxx (DMAC-S/HPBREG/INTC2/LRAM/DBSC) */
>  	{
>  		.virtual	= 0xfe000000,
>  		.pfn		= __phys_to_pfn(0xfe000000),
> @@ -680,7 +680,7 @@ void __init r8a7779_add_early_devices(void)
>  
>  	/* Early serial console setup is not included here due to
>  	 * memory map collisions. The SCIF serial ports in r8a7779
> -	 * are difficult to entity map 1:1 due to collision with the
> +	 * are difficult to identity map 1:1 due to collision with the
>  	 * virtual memory range used by the coherent DMA code on ARM.
>  	 *
>  	 * Anyone wanting to debug early can remove UPF_IOREMAP from
> -- 
> 1.9.1
> 
