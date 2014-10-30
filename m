From: Simon Horman <horms@verge.net.au>
Date: Thu, 30 Oct 2014 01:20:54 +0000
Subject: Re: [PATCH 1/3] ARM: shmobile: r8a7790 dtsi: Drop bogus 0x unit-address prefix
Message-Id: <20141030012053.GG22052@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1414593053-25627-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1414593053-25627-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org

On Wed, Oct 29, 2014 at 03:30:51PM +0100, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm/boot/dts/r8a7790.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, I have queued-up this and the remaining patches in the series.

> 
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index 7add12c3750aa2fb..3e28ee16683bff1c 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -1328,7 +1328,7 @@
>  		status = "disabled";
>  	};
>  
> -	rcar_sound: rcar_sound@0xec500000 {
> +	rcar_sound: rcar_sound@ec500000 {
>  		#sound-dai-cells = <1>;
>  		compatible =  "renesas,rcar_sound-r8a7790", "renesas,rcar_sound-gen2", "renesas,rcar_sound";
>  		reg =	<0 0xec500000 0 0x1000>, /* SCU */
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
