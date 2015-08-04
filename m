From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 04 Aug 2015 12:22:14 +0000
Subject: Re: [PATCH 3/4 v3][RFC] arm64: renesas: Add initial r8a7795 SoC support
Message-Id: <1559394.i3FG4v33fI@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <873801w377.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <873801w377.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

Thank you for the patch.

On Monday 03 August 2015 01:53:23 Kuninori Morimoto wrote:
> From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> 
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v2 -> v3
> 
>  - no change
> 
>  Documentation/devicetree/bindings/arm/shmobile.txt |  2 +
>  .../bindings/clock/renesas,cpg-mstp-clocks.txt     |  1 +
>  arch/arm64/boot/dts/Makefile                       |  1 +
>  arch/arm64/boot/dts/renesas/Makefile               |  5 ++
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 93 +++++++++++++++++++
>  include/dt-bindings/clock/r8a7795-clock.h          | 31 ++++++++
>  6 files changed, 133 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/renesas/Makefile
>  create mode 100644 arch/arm64/boot/dts/renesas/r8a7795.dtsi
>  create mode 100644 include/dt-bindings/clock/r8a7795-clock.h

[snip]

> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> b/arch/arm64/boot/dts/renesas/r8a7795.dtsi new file mode 100644
> index 0000000..0f298c3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -0,0 +1,93 @@
> +/*
> + * Device Tree Source for the r8a7795 SoC
> + *
> + * Copyright (C) 2015 Renesas Electronics Corp.
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +#include <dt-bindings/clock/r8a7795-clock.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	compatible = "renesas,r8a7795";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/* 1core only at this point */
> +		a57_0: cpu@0 {
> +			compatible = "arm,cortex-a57", "arm,armv8";
> +			reg = <0x0>;
> +			device_type = "cpu";
> +		};
> +	};
> +
> +	gic: interrupt-controller@0xf1010000 {
> +		compatible = "arm,gic-400";
> +		#interrupt-cells = <3>;
> +		#address-cells = <0>;
> +		interrupt-controller;
> +		reg = <0x0 0xf1010000 0 0x1000>,
> +		      <0x0 0xf1020000 0 0x2000>;
> +		interrupts = <GIC_PPI 9
> +				(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
> +	};

Shouldn't the memory-mapped peripherals be put under a bus node instead of the 
root DT node ?

> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13
> +				(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14
> +				(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11
> +				(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10
> +				(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +
> +	clocks {

Let's try to make it right from the start on Gen3. The CPG node should be a 
direct child of the bus node mentioned above, and the MSTP clocks should be 
children of the CPG node.

I'm not sure where to put the non-memory-mapped clocks though, should they be 
directly under the root node ? It would make sense for extal_clk, but how 
about the fixed-factor clocks ? Should they be children of the CPG node too ?

> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		extal_clk: extal_clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <0>;
> +			clock-output-names = "extal";
> +		};
> +		cpg_clocks: cpg_clocks@e6150000 {
> +			compatible = "renesas,r8a7795-cpg-clocks",
> +				     "renesas,rcar-gen3-cpg-clocks";
> +			reg = <0 0xe6150000 0 0x1000>;
> +			clocks = <&extal_clk>;
> +			#clock-cells = <1>;
> +			clock-output-names = "main", "pll0", "pll1","pll2",
> +					     "pll3", "pll4";
> +		};
> +		p_clk: p_clk {
> +			compatible = "fixed-factor-clock";
> +			clocks = <&cpg_clocks RCAR_GEN3_CLK_PLL1>;
> +			#clock-cells = <0>;
> +			clock-div = <24>;
> +			clock-mult = <1>;
> +			clock-output-names = "p";
> +		};
> +		mstp3_clks: mstp3_clks@e615013c {
> +			compatible = "renesas,r8a7795-mstp-clocks",
> +				     "renesas,cpg-mstp-clocks";
> +			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
> +			clocks =  <&p_clk>;
> +			#clock-cells = <1>;
> +			renesas,clock-indices = <RCAR_GEN3_CLK_IRDA>;
> +			clock-output-names = "irda";
> +		};
> +	};
> +};

-- 
Regards,

Laurent Pinchart

