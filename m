From: Simon Horman <horms@verge.net.au>
Date: Fri, 11 Jul 2014 09:15:35 +0000
Subject: Re: [PATCH 07/13] ARM: shmobile: r8a73a4 dtsi: Add SoC-specific irqc compatible property
Message-Id: <20140711091534.GL12420@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1404908623-909-1-git-send-email-geert+renesas@glider.be>
 <1404908623-909-8-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1404908623-909-8-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jul 09, 2014 at 02:23:37PM +0200, Geert Uytterhoeven wrote:
> The interrupt controller used the generic compatible property only.
> Add the SoC-specific one, to make it future proof.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, please repost this once the binding has been
accepted by the maintainer.

> ---
>  arch/arm/boot/dts/r8a73a4.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
> index 82c5ac825386..f3bd3d4603d7 100644
> --- a/arch/arm/boot/dts/r8a73a4.dtsi
> +++ b/arch/arm/boot/dts/r8a73a4.dtsi
> @@ -51,7 +51,7 @@
>  	};
>  
>  	irqc0: interrupt-controller@e61c0000 {
> -		compatible = "renesas,irqc";
> +		compatible = "renesas,irqc-r8a73a4", "renesas,irqc";
>  		#interrupt-cells = <2>;
>  		interrupt-controller;
>  		reg = <0 0xe61c0000 0 0x200>;
> @@ -90,7 +90,7 @@
>  	};
>  
>  	irqc1: interrupt-controller@e61c0200 {
> -		compatible = "renesas,irqc";
> +		compatible = "renesas,irqc-r8a73a4", "renesas,irqc";
>  		#interrupt-cells = <2>;
>  		interrupt-controller;
>  		reg = <0 0xe61c0200 0 0x200>;
> -- 
> 1.9.1
> 
