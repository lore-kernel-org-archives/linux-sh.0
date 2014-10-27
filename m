From: Simon Horman <horms@verge.net.au>
Date: Mon, 27 Oct 2014 23:43:30 +0000
Subject: Re: [PATCH] ARM: shmobile: Select CONFIG_ZONE_DMA when CONFIG_ARM_LPAE is enabled
Message-Id: <20141027234329.GA2770@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1414075111-4642-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1414075111-4642-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Oct 23, 2014 at 05:38:31PM +0300, Laurent Pinchart wrote:
> Most IP cores on ARM Renesas platforms can only address 32 bits of
> physical memory for DMA. Without CONFIG_ZONE_DMA enabled and with the
> recent CMA highmem allocation support, the default CMA zone is reserved
> above the 4GiB limit when LPAE is enabled, resulting in various driver
> failures.
> 
> Fix the problem by selecting CONFIG_ZONE_DMA. Other options to
> investigate in the future would be to either enable IOMMU support or use
> custom CMA reservations for peripherals not supporting LPAE.
> 
> While not a strict dependency, the "[PATCH 0/4] Low/high memory CMA
> reservation fixes" series is also required to fix a different but related CMA
> allocation problem.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks, I have queued this up.

> ---
>  arch/arm/mach-shmobile/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> index 21f457b..6bc018f 100644
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -1,5 +1,6 @@
>  config ARCH_SHMOBILE
>  	bool
> +	select ZONE_DMA if ARM_LPAE
>  
>  config PM_RCAR
>  	bool
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
