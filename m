From: Simon Horman <horms@verge.net.au>
Date: Wed, 28 Jan 2015 06:48:14 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7794: Add DMAC devices to DT
Message-Id: <20150128064812.GA3581@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1422378737-1211-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1422378737-1211-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 27, 2015 at 07:12:17PM +0200, Laurent Pinchart wrote:
> Instantiate the two system DMA controllers in the r8a7794 device tree.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks, I have queued this up for v3.21.

> ---
>  arch/arm/boot/dts/r8a7794.dtsi | 60 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
> index 8f78da5ef10b..74745356afe2 100644
> --- a/arch/arm/boot/dts/r8a7794.dtsi
> +++ b/arch/arm/boot/dts/r8a7794.dtsi
> @@ -107,6 +107,66 @@
>  			     <0 17 IRQ_TYPE_LEVEL_HIGH>;
>  	};
>  
> +	dmac0: dma-controller@e6700000 {
> +		compatible = "renesas,rcar-dmac";
> +		reg = <0 0xe6700000 0 0x20000>;
> +		interrupts = <0 197 IRQ_TYPE_LEVEL_HIGH
> +			      0 200 IRQ_TYPE_LEVEL_HIGH
> +			      0 201 IRQ_TYPE_LEVEL_HIGH
> +			      0 202 IRQ_TYPE_LEVEL_HIGH
> +			      0 203 IRQ_TYPE_LEVEL_HIGH
> +			      0 204 IRQ_TYPE_LEVEL_HIGH
> +			      0 205 IRQ_TYPE_LEVEL_HIGH
> +			      0 206 IRQ_TYPE_LEVEL_HIGH
> +			      0 207 IRQ_TYPE_LEVEL_HIGH
> +			      0 208 IRQ_TYPE_LEVEL_HIGH
> +			      0 209 IRQ_TYPE_LEVEL_HIGH
> +			      0 210 IRQ_TYPE_LEVEL_HIGH
> +			      0 211 IRQ_TYPE_LEVEL_HIGH
> +			      0 212 IRQ_TYPE_LEVEL_HIGH
> +			      0 213 IRQ_TYPE_LEVEL_HIGH
> +			      0 214 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "error",
> +				"ch0", "ch1", "ch2", "ch3",
> +				"ch4", "ch5", "ch6", "ch7",
> +				"ch8", "ch9", "ch10", "ch11",
> +				"ch12", "ch13", "ch14";
> +		clocks = <&mstp2_clks R8A7794_CLK_SYS_DMAC0>;
> +		clock-names = "fck";
> +		#dma-cells = <1>;
> +		dma-channels = <15>;
> +	};
> +
> +	dmac1: dma-controller@e6720000 {
> +		compatible = "renesas,rcar-dmac";
> +		reg = <0 0xe6720000 0 0x20000>;
> +		interrupts = <0 220 IRQ_TYPE_LEVEL_HIGH
> +			      0 216 IRQ_TYPE_LEVEL_HIGH
> +			      0 217 IRQ_TYPE_LEVEL_HIGH
> +			      0 218 IRQ_TYPE_LEVEL_HIGH
> +			      0 219 IRQ_TYPE_LEVEL_HIGH
> +			      0 308 IRQ_TYPE_LEVEL_HIGH
> +			      0 309 IRQ_TYPE_LEVEL_HIGH
> +			      0 310 IRQ_TYPE_LEVEL_HIGH
> +			      0 311 IRQ_TYPE_LEVEL_HIGH
> +			      0 312 IRQ_TYPE_LEVEL_HIGH
> +			      0 313 IRQ_TYPE_LEVEL_HIGH
> +			      0 314 IRQ_TYPE_LEVEL_HIGH
> +			      0 315 IRQ_TYPE_LEVEL_HIGH
> +			      0 316 IRQ_TYPE_LEVEL_HIGH
> +			      0 317 IRQ_TYPE_LEVEL_HIGH
> +			      0 318 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "error",
> +				"ch0", "ch1", "ch2", "ch3",
> +				"ch4", "ch5", "ch6", "ch7",
> +				"ch8", "ch9", "ch10", "ch11",
> +				"ch12", "ch13", "ch14";
> +		clocks = <&mstp2_clks R8A7794_CLK_SYS_DMAC1>;
> +		clock-names = "fck";
> +		#dma-cells = <1>;
> +		dma-channels = <15>;
> +	};
> +
>  	scifa0: serial@e6c40000 {
>  		compatible = "renesas,scifa-r8a7794", "renesas,scifa";
>  		reg = <0 0xe6c40000 0 64>;
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
