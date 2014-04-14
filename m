From: Simon Horman <horms@verge.net.au>
Date: Mon, 14 Apr 2014 22:40:10 +0000
Subject: Re: [PATCH] ARM: shmobile: koelsch: correct renesas,gpios to renesas,groups in sd[012] pfc
Message-Id: <20140414224007.GC22518@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140414101321.12239.82374.sendpatchset@w520>
In-Reply-To: <20140414101321.12239.82374.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Apr 14, 2014 at 07:13:21PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
>    
> Fix typo of renesas,groups in the koeslch dt. The kernel has no
> renesas,gpios but this should match renesas,groups.
> 
> Noticed thanks to similar fix for Lager by Rob Taylor and Ben Dooks.        
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---

Thanks, I have queued this up as a fix for v3.15.

> 
>  arch/arm/boot/dts/r8a7791-koelsch.dts |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> --- 0005/arch/arm/boot/dts/r8a7791-koelsch.dts
> +++ work/arch/arm/boot/dts/r8a7791-koelsch.dts	2014-04-14 17:47:50.000000000 +0900
> @@ -264,17 +264,17 @@
>  	};
>  
>  	sdhi0_pins: sd0 {
> -		renesas,gpios = "sdhi0_data4", "sdhi0_ctrl";
> +		renesas,groups = "sdhi0_data4", "sdhi0_ctrl";
>  		renesas,function = "sdhi0";
>  	};
>  
>  	sdhi1_pins: sd1 {
> -		renesas,gpios = "sdhi1_data4", "sdhi1_ctrl";
> +		renesas,groups = "sdhi1_data4", "sdhi1_ctrl";
>  		renesas,function = "sdhi1";
>  	};
>  
>  	sdhi2_pins: sd2 {
> -		renesas,gpios = "sdhi2_data4", "sdhi2_ctrl";
> +		renesas,groups = "sdhi2_data4", "sdhi2_ctrl";
>  		renesas,function = "sdhi2";
>  	};
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
