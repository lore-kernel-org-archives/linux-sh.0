From: Simon Horman <horms@verge.net.au>
Date: Thu, 19 Feb 2015 16:10:12 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: r8a7794: add MMCIF DT support
Message-Id: <20150219161012.GA3864@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <29687119.ELU9MoH02q@wasted.cogentembedded.com>
 <4040756.88Rqm1nt32@wasted.cogentembedded.com>
In-Reply-To: <4040756.88Rqm1nt32@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Feb 17, 2015 at 01:59:02AM +0300, Sergei Shtylyov wrote:
> Define the generic R8A7794 part of the MMCIF0 device node.
> 
> Based on the orginal patch by Shinobu Uehara <shinobu.uehara.xc@renesas.com>.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
>  arch/arm/boot/dts/r8a7794.dtsi |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> Index: renesas/arch/arm/boot/dts/r8a7794.dtsi
> =================================> --- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
> +++ renesas/arch/arm/boot/dts/r8a7794.dtsi
> @@ -346,6 +346,17 @@
>  		status = "disabled";
>  	};
>  
> +	mmcif0: mmc@ee200000 {
> +		compatible = "renesas,mmcif-r8a7794", "renesas,sh-mmcif";

Please submit a patch to add "renesas,mmcif-r8a7794" to
Documentation/devicetree/bindings/mmc/renesas,mmcif.txt.
I looked and I couldn't find such a change in-tree or in-flight.

> +		reg = <0 0xee200000 0 0x80>;
> +		interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp3_clks R8A7794_CLK_MMCIF0>;
> +		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>;
> +		dma-names = "tx", "rx";
> +		reg-io-width = <4>;
> +		status = "disabled";
> +	};
> +
>  	clocks {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
