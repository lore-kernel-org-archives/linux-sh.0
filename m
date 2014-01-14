From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 14 Jan 2014 17:23:16 +0000
Subject: Re: [PATCH 1/2] ARM: dts: r8a7790: Add SATA nodes to r8a7790.dtsi
Message-Id: <1792742.4Is9hLd5UJ@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1389719131-24376-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1389719131-24376-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Valentine,

Thank you for the patch.

On Tuesday 14 January 2014 21:05:30 Valentine Barshak wrote:
> This adds SATA[01] device nodes to r8a7790.dtsi
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> ---
>  arch/arm/boot/dts/r8a7790.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index b2c2845..f2f5394 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -400,6 +400,24 @@
>  		status = "disabled";
>  	};
> 
> +	sata0: sata@ee300000 {
> +		compatible = "renesas,sata-r8a7790";
> +		reg = <0 0xee300000 0 0x2000>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp8_clks R8A7790_CLK_SATA0>;

If I'm not mistaken the RCar SATA DT bindings don't document the clocks 
property. Could you please submit a patch to fix that ?

There's no need to delay this patch set.

> +		status = "disabled";
> +	};
> +
> +	sata1: sata@ee500000 {
> +		compatible = "renesas,sata-r8a7790";
> +		reg = <0 0xee500000 0 0x2000>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp8_clks R8A7790_CLK_SATA1>;
> +		status = "disabled";
> +	};
> +
>  	clocks {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
-- 
Regards,

Laurent Pinchart

