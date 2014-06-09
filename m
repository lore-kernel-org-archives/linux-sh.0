From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 09 Jun 2014 10:32:37 +0000
Subject: Re: [PATCH 3/8] ARM: shmobile: r8a7790: Add PCIe device nodes
Message-Id: <1735665.3QTcJMYUcT@avalon>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Phil,

Thank you for the patch.

On Wednesday 28 May 2014 08:23:58 Phil Edworthy wrote:
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
>  arch/arm/boot/dts/r8a7790.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index ae7d3da..7c2b66c 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -876,4 +876,29 @@
>  		#size-cells = <0>;
>  		status = "disabled";
>  	};
> +
> +	pcie: pcie@fe000000 {
> +		compatible = "renesas,pcie-r8a7790";
> +		reg = <0 0xfe000000 0 0x80000>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		bus-range = <0x00 0xff>;
> +		device_type = "pci";
> +		ranges = <0x01000000 0 0x00000000 0 0xfe100000 0 0x00100000
> +			  0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000
> +			  0x02000000 0 0x30000000 0 0x30000000 0 0x08000000
> +			  0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
> +		/* Map all possible DDR as inbound ranges */
> +		dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000
> +			      0x43000000 1 0x80000000 1 0x80000000 0 0x80000000>;
> +		interrupts = <0 116 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 117 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 118 IRQ_TYPE_LEVEL_HIGH>;
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 0>;
> +		interrupt-map = <0 0 0 0 &gic 0 116 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp3_clks R8A7790_CLK_PCIE>, <&pcie_bus_clk>;
> +		clock-names = "pcie", "pcie_bus";

I would have removed the "pcie" prefix from the clock names, as it's clear 
that the clocks are related to the PCIe controller, and used names such as 
"fck" (for functional clock) and "bus" instead. I've missed that when the DT 
bindings were submitted for review (actually I've missed the patches 
completely).

> +		status = "disabled";
> +	};
>  };

-- 
Regards,

Laurent Pinchart

