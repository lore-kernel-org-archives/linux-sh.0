From: Simon Horman <horms@verge.net.au>
Date: Thu, 21 Nov 2013 03:58:49 +0000
Subject: Re: [PATCH 3/3] ARM: shmobile: sh73a0: fixup sdhi compatible name
Message-Id: <20131121035847.GC31130@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87zjoz92xd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87zjoz92xd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 19, 2013 at 07:18:09PM -0800, Kuninori Morimoto wrote:
> sh73a0 != r8a7740
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, I will queue this up.
Assuming all goes will I plan to push this and other updates
today or tomorrow.

Can you confirm that at this time there is no run-time
affect of this change?

> ---
>  arch/arm/boot/dts/sh73a0.dtsi |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
> index aef8a61..29d2ee6 100644
> --- a/arch/arm/boot/dts/sh73a0.dtsi
> +++ b/arch/arm/boot/dts/sh73a0.dtsi
> @@ -203,7 +203,7 @@
>  	};
>  
>  	sdhi0: sd@ee100000 {
> -		compatible = "renesas,sdhi-r8a7740";
> +		compatible = "renesas,sdhi-sh73a0";
>  		reg = <0xee100000 0x100>;
>  		interrupt-parent = <&gic>;
>  		interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH
> @@ -215,7 +215,7 @@
>  
>  	/* SDHI1 and SDHI2 have no CD pins, no need for CD IRQ */
>  	sdhi1: sd@ee120000 {
> -		compatible = "renesas,sdhi-r8a7740";
> +		compatible = "renesas,sdhi-sh73a0";
>  		reg = <0xee120000 0x100>;
>  		interrupt-parent = <&gic>;
>  		interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH
> @@ -226,7 +226,7 @@
>  	};
>  
>  	sdhi2: sd@ee140000 {
> -		compatible = "renesas,sdhi-r8a7740";
> +		compatible = "renesas,sdhi-sh73a0";
>  		reg = <0xee140000 0x100>;
>  		interrupt-parent = <&gic>;
>  		interrupts = <0 104 IRQ_TYPE_LEVEL_HIGH
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
