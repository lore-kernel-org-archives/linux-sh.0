From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 07 Sep 2012 00:47:14 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: bugfix: correct mmcif interrupt settings
Message-Id: <87ehmeacc3.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1346915976-14079-1-git-send-email-koba@kmckk.co.jp>
In-Reply-To: <1346915976-14079-1-git-send-email-koba@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Kobayshi-san

> From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
> 
> Correct interrupt settings of sh_mmc:int and sh_mmc:error in board-kzm9g.c.
> 
> Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
> ---
> Hello, morimoto-san
> 
> I found small bug in interrpt setting of sh_mmc in board-kzm9g.c.
> According to SoC document, there are 2 interrupts for sh_mmc and smaller vector id is error. But the setting in board-kzm9g seems wrong.
> 
> Actually these 2 interrupts use the same interrupt handler. So this patch only affects the output of /proc/interrpts.
> 
> before this patch:
>   ...
> 172:          3          0       GIC  sh_mmc:int
> 173:       9504          0       GIC  sh_mmc:error
>   ...
> 
> after this patch:
>   ...
> 172:          3          0       GIC  sh_mmc:error
> 173:       9454          0       GIC  sh_mmc:int
>   ...
> 
> Morimoto-san, could you verify this?

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

> 
>  arch/arm/mach-shmobile/board-kzm9g.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
> index fd21fb6..87ec4ce 100644
> --- a/arch/arm/mach-shmobile/board-kzm9g.c
> +++ b/arch/arm/mach-shmobile/board-kzm9g.c
> @@ -346,11 +346,11 @@ static struct resource sh_mmcif_resources[] = {
>  		.flags	= IORESOURCE_MEM,
>  	},
>  	[1] = {
> -		.start	= gic_spi(141),
> +		.start	= gic_spi(140),
>  		.flags	= IORESOURCE_IRQ,
>  	},
>  	[2] = {
> -		.start	= gic_spi(140),
> +		.start	= gic_spi(141),
>  		.flags	= IORESOURCE_IRQ,
>  	},
>  };
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Best regards
---
Kuninori Morimoto
