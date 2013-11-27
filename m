From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 27 Nov 2013 10:11:47 +0000
Subject: Re: [PATCH] ARM: shmobile: Use r8a7790 suffix for IRQC compat string
Message-Id: <1602466.4IFX4QyYPo@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20131120000740.27032.66529.sendpatchset@w520>
In-Reply-To: <20131120000740.27032.66529.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Magnus,

Thank you for the patch.

On Wednesday 20 November 2013 09:07:40 Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add "renesas,irqc-r8a7790" to the compatible string for IRQC
> in case of r8a7790. This makes the IRQC follow the same style
> as the other devices and also makes it more future proof.

You should update the device tree bindings documentation as well. As there's 
no such documentation of the irqc, you should create it ;-)

> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/boot/dts/r8a7790.dtsi |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- 0003/arch/arm/boot/dts/r8a7790.dtsi
> +++ work/arch/arm/boot/dts/r8a7790.dtsi	2013-11-20 08:20:30.000000000 +0900
> @@ -171,7 +171,7 @@
>  	};
> 
>  	irqc0: interrupt-controller@e61c0000 {
> -		compatible = "renesas,irqc";
> +		compatible = "renesas,irqc-r8a7790", "renesas,irqc";
>  		#interrupt-cells = <2>;
>  		interrupt-controller;
>  		reg = <0 0xe61c0000 0 0x200>;

-- 
Regards,

Laurent Pinchart

