From: Simon Horman <horms@verge.net.au>
Date: Fri, 29 Aug 2014 00:06:25 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: kzm9g-reference dts: Use tabs for indentation
Message-Id: <20140829000625.GJ16165@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1409214116-6016-1-git-send-email-geert+renesas@glider.be>
 <1409214116-6016-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1409214116-6016-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org

On Thu, Aug 28, 2014 at 10:21:56AM +0200, Geert Uytterhoeven wrote:
> Checkpatch says:
> 
> ERROR: code indent should use tabs where possible

Thanks, I have queued this up.

> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> index 18662aec2ec4..477f8153debd 100644
> --- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> +++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> @@ -66,7 +66,7 @@
>  	};
>  
>  	vmmc_sdhi0: regulator@2 {
> -	        compatible = "regulator-fixed";
> +		compatible = "regulator-fixed";
>  		regulator-name = "SDHI0 Vcc";
>  		regulator-min-microvolt = <3300000>;
>  		regulator-max-microvolt = <3300000>;
> @@ -75,7 +75,7 @@
>  	};
>  
>  	vmmc_sdhi2: regulator@3 {
> -	        compatible = "regulator-fixed";
> +		compatible = "regulator-fixed";
>  		regulator-name = "SDHI2 Vcc";
>  		regulator-min-microvolt = <3300000>;
>  		regulator-max-microvolt = <3300000>;
> -- 
> 1.9.1
> 
