From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 02 Jan 2018 13:54:02 +0000
Subject: Re: [PATCH v2 4/9] ARM: dts: r7s72100: Add Capture Engine Unit (CEU)
Message-Id: <2050708.XlLFKrlIvW@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1514469681-15602-1-git-send-email-jacopo+renesas@jmondi.org> <1514469681-15602-5-git-send-email-jacopo+renesas@jmondi.org>
In-Reply-To: <1514469681-15602-5-git-send-email-jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jacopo Mondi <jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>
Cc: magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, geert-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Jacopo,

Thank you for the patch.

On Thursday, 28 December 2017 16:01:16 EET Jacopo Mondi wrote:
> Add Capture Engine Unit (CEU) node to device tree.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  arch/arm/boot/dts/r7s72100.dtsi | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r7s72100.dtsi
> b/arch/arm/boot/dts/r7s72100.dtsi index ab9645a..b09b032 100644
> --- a/arch/arm/boot/dts/r7s72100.dtsi
> +++ b/arch/arm/boot/dts/r7s72100.dtsi
> @@ -135,9 +135,9 @@
>  			#clock-cells = <1>;
>  			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-
clocks";
>  			reg = <0xfcfe042c 4>;
> -			clocks = <&p0_clk>;
> -			clock-indices = <R7S72100_CLK_RTC>;
> -			clock-output-names = "rtc";
> +			clocks = <&b_clk>, <&p0_clk>;
> +			clock-indices = <R7S72100_CLK_CEU R7S72100_CLK_RTC>;
> +			clock-output-names = "ceu", "rtc";
>  		};
> 
>  		mstp7_clks: mstp7_clks@fcfe0430 {
> @@ -667,4 +667,13 @@
>  		power-domains = <&cpg_clocks>;
>  		status = "disabled";
>  	};
> +
> +	ceu: ceu@e8210000 {
> +		reg = <0xe8210000 0x209c>;

With the reg issue pointed out by Geert fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +		compatible = "renesas,r7s72100-ceu";
> +		interrupts = <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp6_clks R7S72100_CLK_CEU>;
> +		power-domains = <&cpg_clocks>;
> +		status = "disabled";
> +	};
>  };

-- 
Regards,

Laurent Pinchart

