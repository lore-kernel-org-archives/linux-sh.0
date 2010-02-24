From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 24 Feb 2010 00:03:38 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: G4EVM KEYSC platform data
Message-Id: <ud3zvv6sl.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4B83B40E.5040203@renesas.com>
In-Reply-To: <4B83B40E.5040203@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear NISHIMOTO-san


> diff --git a/arch/arm/mach-shmobile/clock-sh7367.c b/arch/arm/mach-shmobile/clock-sh7367.c
> index 58bd54e..fddc5d9 100644
> --- a/arch/arm/mach-shmobile/clock-sh7367.c
> +++ b/arch/arm/mach-shmobile/clock-sh7367.c
> @@ -75,6 +75,11 @@ static struct clk usb0_clk = {
>  	.name	    = "usb0",
>  };
>  
> +/* a static keysc0 for now - enough to get sh_keysc working */
> +static struct clk keysc0_clk = {
> +	.name	    = "keysc0",
> +};
> +
>  static struct clk_lookup lookups[] = {
>  	{
>  		.clk = &peripheral_clk,
> @@ -82,6 +87,8 @@ static struct clk_lookup lookups[] = {
>  		.clk = &r_clk,
>  	}, {
>  		.clk = &usb0_clk,
> +	}, {
> +		.clk = &keysc0_clk,
>  	}
>  };

I think above settings are already done on Magnus's patch

Subject: [PATCH] ARM: mach-shmobile: G3EVM KEYSC platform data

This patch still isn't applied though  =)

Best regards
--
Kuninori Morimoto
 
