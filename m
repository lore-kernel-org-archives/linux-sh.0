From: Simon Horman <horms@verge.net.au>
Date: Tue, 16 Apr 2013 02:53:32 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7779 pinmux platform device cleanup
Message-Id: <20130416025332.GI28660@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1365769289-29402-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1365769289-29402-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Apr 12, 2013 at 02:21:29PM +0200, Laurent Pinchart wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Use DEFINE_RES_MEM() to save a couple of lines of code.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> [lp: Don't declare r8a7779_pfc_resources as const]
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks, queued up for v3.11 in the soc-r8a7779 branch.

> ---
>  arch/arm/mach-shmobile/setup-r8a7779.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
> index c14a69b..a93788e 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7779.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7779.c
> @@ -65,11 +65,7 @@ void __init r8a7779_map_io(void)
>  }
>  
>  static struct resource r8a7779_pfc_resources[] = {
> -	[0] = {
> -		.start	= 0xfffc0000,
> -		.end	= 0xfffc023b,
> -		.flags	= IORESOURCE_MEM,
> -	},
> +	DEFINE_RES_MEM(0xfffc0000, 0x023c),
>  };
>  
>  static struct platform_device r8a7779_pfc_device = {
> @@ -81,15 +77,8 @@ static struct platform_device r8a7779_pfc_device = {
>  
>  #define R8A7779_GPIO(idx, npins) \
>  static struct resource r8a7779_gpio##idx##_resources[] = {		\
> -	[0] = {								\
> -		.start	= 0xffc40000 + 0x1000 * (idx),			\
> -		.end	= 0xffc4002b + 0x1000 * (idx),			\
> -		.flags	= IORESOURCE_MEM,				\
> -	},								\
> -	[1] = {								\
> -		.start	= gic_iid(0xad + (idx)),			\
> -		.flags	= IORESOURCE_IRQ,				\
> -	}								\
> +	DEFINE_RES_MEM(0xffc40000 + (0x1000 * (idx)), 0x002c),		\
> +	DEFINE_RES_IRQ(gic_iid(0xad + (idx))),				\
>  };									\
>  									\
>  static struct gpio_rcar_config r8a7779_gpio##idx##_platform_data = {	\
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
