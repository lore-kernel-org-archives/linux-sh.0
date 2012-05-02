From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 02 May 2012 20:49:30 +0000
Subject: Re: [PATCH v3 02/10] ARM: sh-mobile: mackerel: Add error IRQ resource
Message-Id: <201205022249.30426.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <1335951710-9390-1-git-send-email-hechtb@gmail.com>
 <1335951710-9390-3-git-send-email-hechtb@gmail.com>
In-Reply-To: <1335951710-9390-3-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bastian Hecht <hechtb@googlemail.com>
Cc: Artem Bityutskiy <dedekind1@gmail.com>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-mtd@lists.infradead.org, Laurent Pichart <laurent.pinchart@ideasonboard.com>, Brian Norris <computersforpeace@gmail.com>

On Wednesday, May 02, 2012, Bastian Hecht wrote:
> Supply the platform data for the FLSTEI error IRQ.
> 
> Signed-off-by: Bastian Hecht <hechtb@gmail.com>

I'm going to take this patch into the renesas.git tree and push it
upstream throuch arm-soc, if that's not a problem.

Thanks,
Rafael


> ---
>  arch/arm/mach-shmobile/board-mackerel.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
> index 8758f94..1de1fb7 100644
> --- a/arch/arm/mach-shmobile/board-mackerel.c
> +++ b/arch/arm/mach-shmobile/board-mackerel.c
> @@ -990,7 +990,11 @@ static struct resource nand_flash_resources[] = {
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
> 

