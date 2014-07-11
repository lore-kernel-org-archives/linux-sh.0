From: Simon Horman <horms@verge.net.au>
Date: Fri, 11 Jul 2014 09:15:53 +0000
Subject: Re: [PATCH 08/13] ARM: shmobile: r8a73a4 dtsi: Add SoC-specific thermal compatible property
Message-Id: <20140711091553.GM12420@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1404908623-909-1-git-send-email-geert+renesas@glider.be>
 <1404908623-909-9-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1404908623-909-9-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, Jul 09, 2014 at 02:23:38PM +0200, Geert Uytterhoeven wrote:
> The thermal node used the generic compatible property only.
> Add the SoC-specific one, to make it future proof.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, please repost this once the binding has been
accepted by the maintainer.

> ---
>  arch/arm/boot/dts/r8a73a4.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
> index f3bd3d4603d7..59145b267862 100644
> --- a/arch/arm/boot/dts/r8a73a4.dtsi
> +++ b/arch/arm/boot/dts/r8a73a4.dtsi
> @@ -165,7 +165,7 @@
>  	};
>  
>  	thermal@e61f0000 {
> -		compatible = "renesas,rcar-thermal";
> +		compatible = "renesas,thermal-r8a73a4", "renesas,rcar-thermal";
>  		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>,
>  			 <0 0xe61f0200 0 0x38>, <0 0xe61f0300 0 0x38>;
>  		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
> -- 
> 1.9.1
> 
