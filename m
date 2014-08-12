From: Simon Horman <horms@verge.net.au>
Date: Tue, 12 Aug 2014 13:36:22 +0000
Subject: Re: [PATCH] ARM: shmobile: koelsch: Remove non-existent i2c6 pinmux
Message-Id: <20140812133622.GC10875@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1407848593-23040-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1407848593-23040-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Gaku Inami <gaku.inami.xw@bp.renesas.com>, linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org

On Tue, Aug 12, 2014 at 03:03:13PM +0200, Geert Uytterhoeven wrote:
> On r8a7791, i2c6 (aka iic3) doesn't need pinmux, but the koelsch dts
> refers to non-existent pinmux configuration data:
> 
> pinmux core: sh-pfc does not support function i2c6
> sh-pfc e6060000.pfc: invalid function i2c6 in map table
> 
> Remove it to fix this.
> 
> Fixes: commit 1d41f36a68c0f4e9b01d563ce33bab5201858b54 ("ARM: shmobile:
>        koelsch dts: Add VDD MPU regulator for DVFS")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks Geert. Does this manifest as a run-time problem?

Regardless, it looks like I should queue this up as
a fix for v3.17. Is that your thinking too?

> ---
>  arch/arm/boot/dts/r8a7791-koelsch.dts | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
> index 7966dace64ce..951a5c55003e 100644
> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> @@ -275,11 +275,6 @@
>  		renesas,function = "msiof0";
>  	};
>  
> -	i2c6_pins: i2c6 {
> -		renesas,groups = "i2c6";
> -		renesas,function = "i2c6";
> -	};
> -
>  	usb0_pins: usb0 {
>  		renesas,groups = "usb0";
>  		renesas,function = "usb0";
> @@ -477,8 +472,6 @@
>  };
>  
>  &i2c6 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2c6_pins>;
>  	status = "okay";
>  	clock-frequency = <100000>;
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
