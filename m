From: Simon Horman <horms@verge.net.au>
Date: Wed, 13 Feb 2013 03:05:40 +0000
Subject: Re: [PATCH/RFC v2 7/8] ARM: shmobile: parse DT and configure pinmux early on kzm9g-reference
Message-Id: <20130213030540.GA16229@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1360348712-29255-8-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360348712-29255-8-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Feb 08, 2013 at 07:38:31PM +0100, Guennadi Liakhovetski wrote:
> GPIOs can be provided by the pinctrl subsystem, which can be initialised
> by DT. Therefore DT has to be parsed before requesting GPIOs. Also non-DT
> pinmux has to be configured early.

Thanks, applied to the boards-kzm9g-reference branch.

I am intending to merge that branch, which includes
the basic kzm9g reference code, into v3.10.

> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> Also a hack, that should be replaced by a proper pinctrl DT support.
> 
>  arch/arm/mach-shmobile/board-kzm9g-reference.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
> index 8280d8a..728c810 100644
> --- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
> +++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
> @@ -34,6 +34,9 @@
>  
>  static void __init kzm_init(void)
>  {
> +	sh73a0_add_standard_devices_dt();
> +	sh73a0_pinmux_init();
> +
>  	/* enable SCIFA4 */
>  	gpio_request(GPIO_FN_SCIFA4_TXD, NULL);
>  	gpio_request(GPIO_FN_SCIFA4_RXD, NULL);
> @@ -81,8 +84,6 @@ static void __init kzm_init(void)
>  	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
>  	l2x0_init(IOMEM(0xf0100000), 0x40460000, 0x82000fff);
>  #endif
> -
> -	sh73a0_add_standard_devices_dt();
>  }
>  
>  static void kzm9g_restart(char mode, const char *cmd)
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
