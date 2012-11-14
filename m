From: Simon Horman <horms@verge.net.au>
Date: Wed, 14 Nov 2012 23:22:49 +0000
Subject: Re: [PATCH] ARM: shmobile: mackerel: Add FLCTL IRQ resource
Message-Id: <20121114232249.GN15960@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1352803609-16669-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1352803609-16669-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 13, 2012 at 11:46:49AM +0100, Bastian Hecht wrote:
> The FLCTL driver now requires the resource of the error IRQ.

Hi Bastian,

could you provide a little more information on:
* Why this is so. Is it related to a change in another commit?
* What the implications are of this change not being applied:
  the driver doesn't work?

> Signed-off-by: Bastian Hecht <hechtb@gmail.com>
> ---
>  arch/arm/mach-shmobile/board-mackerel.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
> index 0c27c81..66ec616 100644
> --- a/arch/arm/mach-shmobile/board-mackerel.c
> +++ b/arch/arm/mach-shmobile/board-mackerel.c
> @@ -1018,7 +1018,11 @@ static struct resource nand_flash_resources[] = {
>  		.start	= 0xe6a30000,
>  		.end	= 0xe6a3009b,
>  		.flags	= IORESOURCE_MEM,
> -	}
> +	},
> +	[1] = {
> +		.start	= evt2irq(0x0d80), /* flstei: status error irq */
> +		.flags	= IORESOURCE_IRQ,
> +	},
>  };
>  
>  static struct sh_flctl_platform_data nand_flash_data = {
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
