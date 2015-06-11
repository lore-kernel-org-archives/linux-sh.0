From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 11 Jun 2015 01:20:07 +0000
Subject: Re: [PATCH v2 5/6] ARM: shmobile: lager: Set clock rates for SDHI
Message-Id: <87r3pjcabj.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1433892104.12074.49.camel@codethink.co.uk>
	<1433892257.12074.54.camel@codethink.co.uk>
In-Reply-To: <1433892257.12074.54.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>

Hi Ben

Sorry for my small amount of question, but I would like to ask 1 thing

> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> index aaa4f258e279..5f68e53c58ae 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -488,6 +488,9 @@
>  	pinctrl-0 = <&sdhi0_pins>;
>  	pinctrl-names = "default";
>  
> +	assigned-clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
> +	assigned-clock-rates = <156000000>;

Can we use "max-frequency" here ?
tmio/sh_mobile_sdhi have tmio_mmc_clk_update/sh_mobile_sdhi_clk_enable
