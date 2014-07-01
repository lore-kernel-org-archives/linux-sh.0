From: Simon Horman <horms@verge.net.au>
Date: Tue, 01 Jul 2014 00:36:35 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790: Fix whitespace errors in pci nodes
Message-Id: <20140701003634.GA10620@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1404121793-11182-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1404121793-11182-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.or

On Mon, Jun 30, 2014 at 11:49:53AM +0200, Geert Uytterhoeven wrote:
> Remove spaces in between tabs.
> 
> Introduced by commit ff4f3eb8b3386208944fe60b85e6cba4d338198e ("ARM:
> shmobile: r8a7790: add internal PCI bridge nodes").
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I will queue this up.

> ---
>  arch/arm/boot/dts/r8a7790.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index bdcb7f08fcc5..d9ddecbb859c 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -946,8 +946,8 @@
>  		ranges = <0x02000000 0 0xee080000 0 0xee080000 0 0x00010000>;
>  		interrupt-map-mask = <0xff00 0 0 0x7>;
>  		interrupt-map = <0x0000 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
> -			      	 0x0800 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
> -			      	 0x1000 0 0 2 &gic 0 108 IRQ_TYPE_LEVEL_HIGH>;
> +				 0x0800 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
> +				 0x1000 0 0 2 &gic 0 108 IRQ_TYPE_LEVEL_HIGH>;
>  	};
>  
>  	pci1: pci@ee0b0000 {
> @@ -966,8 +966,8 @@
>  		ranges = <0x02000000 0 0xee0a0000 0 0xee0a0000 0 0x00010000>;
>  		interrupt-map-mask = <0xff00 0 0 0x7>;
>  		interrupt-map = <0x0000 0 0 1 &gic 0 112 IRQ_TYPE_LEVEL_HIGH
> -			      	 0x0800 0 0 1 &gic 0 112 IRQ_TYPE_LEVEL_HIGH
> -			      	 0x1000 0 0 2 &gic 0 112 IRQ_TYPE_LEVEL_HIGH>;
> +				 0x0800 0 0 1 &gic 0 112 IRQ_TYPE_LEVEL_HIGH
> +				 0x1000 0 0 2 &gic 0 112 IRQ_TYPE_LEVEL_HIGH>;
>  	};
>  
>  	pci2: pci@ee0d0000 {
> @@ -986,8 +986,8 @@
>  		ranges = <0x02000000 0 0xee0c0000 0 0xee0c0000 0 0x00010000>;
>  		interrupt-map-mask = <0xff00 0 0 0x7>;
>  		interrupt-map = <0x0000 0 0 1 &gic 0 113 IRQ_TYPE_LEVEL_HIGH
> -			      	 0x0800 0 0 1 &gic 0 113 IRQ_TYPE_LEVEL_HIGH
> -			      	 0x1000 0 0 2 &gic 0 113 IRQ_TYPE_LEVEL_HIGH>;
> +				 0x0800 0 0 1 &gic 0 113 IRQ_TYPE_LEVEL_HIGH
> +				 0x1000 0 0 2 &gic 0 113 IRQ_TYPE_LEVEL_HIGH>;
>  	};
>  
>  	pciec: pcie@fe000000 {
> -- 
> 1.9.1
> 
