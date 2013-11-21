From: Simon Horman <horms@verge.net.au>
Date: Thu, 21 Nov 2013 03:57:33 +0000
Subject: Re: [PATCH 1/3] ARM: shmobile: marzen: remove SDHI0 WP pin setting from DTS
Message-Id: <20131121035731.GA31130@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <8738mrahim.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8738mrahim.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 19, 2013 at 07:17:41PM -0800, Kuninori Morimoto wrote:
> WP pin is not implemented on Marzen

Thanks, I will queue this up.
Assuming all goes will I plan to push this and other updates
today or tomorrow.

> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/boot/dts/r8a7779-marzen-reference.dts |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7779-marzen-reference.dts b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
> index 13fa8be..918085c 100644
> --- a/arch/arm/boot/dts/r8a7779-marzen-reference.dts
> +++ b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
> @@ -94,8 +94,7 @@
>  	};
>  
>  	sdhi0_pins: sd0 {
> -		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd",
> -				 "sdhi0_wp";
> +		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd";
>  		renesas,function = "sdhi0";
>  	};
>  };
> -- 
> 1.7.9.5
> 
