From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 31 Aug 2015 10:44:25 +0000
Subject: Re: [PATCH v8 01/07] arm64: renesas: r8a7795: Add Renesas R8A7795 SoC support
Message-Id: <1472444.0Vbqv29K5J@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20150831062918.24004.15458.sendpatchset@little-apple>
In-Reply-To: <20150831062918.24004.15458.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

Thank you for the patch.

On Monday 31 August 2015 15:29:18 Magnus Damm wrote:
> From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> 
> Initial version of Renesas R-Car H3 support (V8)
> 
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  Changes since v7: (Magnus Damm <damm+renesas@opensource.se>)
>   - Folded together the following patches from v7:
>      [PATCH 6/25] arm64: renesas: Add new Renesas R-Car Gen3 SoC Kconfig
>      [PATCH 7/25] arm64: renesas: r8a7795: Add Renesas R8A7795 SoC support
>      [PATCH 8/25] arm64: renesas: r8a7795: Add initial SoC support
>   - Updated Kconfig bits
>      Changed to CONFIG_ARCH_R8A7795 and CONFIG_RENESAS
>      CONFIG_ARCH_SHMOBILE is still set to be able to build various drivers
>      CONFIG_ARCH_SHMOBILE_MULTI is gone
>      select PM_GENERIC_DOMAINS if PM
>   - Moved "s3d4_clk" to clock patch from geert
>   - Replaced CPG clock-output-names with clock-indices
>   - set #power-domain-cells to 0
> 
>  Documentation/devicetree/bindings/arm/shmobile.txt |    2
>  arch/arm64/Kconfig.platforms                       |   16 +++
>  arch/arm64/boot/dts/Makefile                       |    1
>  arch/arm64/boot/dts/renesas/Makefile               |    3
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi           |   87 +++++++++++++++++
>  include/dt-bindings/clock/r8a7795-clock.h          |   38 ++++++++
>  6 files changed, 147 insertions(+)
> 
> --- 0001/Documentation/devicetree/bindings/arm/shmobile.txt
> +++ work/Documentation/devicetree/bindings/arm/shmobile.txt	2015-08-29
> 18:14:12.652366518 +0900 @@ -27,6 +27,8 @@ SoCs:
>      compatible = "renesas,r8a7793"
>    - R-Car E2 (R8A77940)
>      compatible = "renesas,r8a7794"
> +  - R-Car H3 (R8A77950)
> +    compatible = "renesas,r8a7795"
> 
> 
>  Boards:
> --- 0001/arch/arm64/Kconfig.platforms
> +++ work/arch/arm64/Kconfig.platforms	2015-08-29 18:20:52.022366518 +0900
> @@ -66,6 +66,22 @@ config ARCH_SEATTLE
>  	help
>  	  This enables support for AMD Seattle SOC Family
> 
> +config ARCH_SHMOBILE
> +	bool

It's tempting to get rid of ARCH_SHMOBILE going forward and define 
ARCH_RENESAS on ARM32 instead. I'm not sure whether that's worth it, even 
though the change would just be a search & replace.

> +config ARCH_RENESAS
> +	bool "Renesas SoC Platform"

s/Platform/Platforms/ ?

> +	select ARCH_SHMOBILE
> +	select PM_GENERIC_DOMAINS if PM
> +	help
> +	  This enables support for the ARMv8 based Renesas SoCs.
> +
> +config ARCH_R8A7795
> +	bool "Renesas R-Car H3 SoC Platform"
> +	depends on ARCH_RENESAS
> +	help
> +	  This enables support for the Renesas R-Car H3 SoC.
> +
>  config ARCH_TEGRA
>  	bool "NVIDIA Tegra SoC Family"
>  	select ARCH_HAS_RESET_CONTROLLER
> --- 0001/arch/arm64/boot/dts/Makefile
> +++ work/arch/arm64/boot/dts/Makefile	2015-08-29 18:14:12.652366518 +0900
> @@ -9,6 +9,7 @@ dts-dirs += hisilicon
>  dts-dirs += marvell
>  dts-dirs += mediatek
>  dts-dirs += qcom
> +dts-dirs += renesas
>  dts-dirs += rockchip
>  dts-dirs += sprd
>  dts-dirs += xilinx
> --- /dev/null
> +++ work/arch/arm64/boot/dts/renesas/Makefile	2015-08-29 
18:14:13.672366518
> +0900 @@ -0,0 +1,3 @@
> +always		:= $(dtb-y)
> +subdir-y	:= $(dts-dirs)

Is this a case of cargo-cult programming, or is subdir-y really needed ? :-)

> +clean-files	:= *.dtb
> --- /dev/null
> +++ work/arch/arm64/boot/dts/renesas/r8a7795.dtsi	2015-08-29
> 18:16:38.452366518 +0900 @@ -0,0 +1,87 @@
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
> +	extal_clk: extal_clk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <0>;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		interrupt-parent = <&gic>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		gic: interrupt-controller@0xf1010000 {
> +			compatible = "arm,gic-400";
> +			#interrupt-cells = <3>;
> +			#address-cells = <0>;
> +			interrupt-controller;
> +			reg = <0x0 0xf1010000 0 0x1000>,
> +			      <0x0 0xf1020000 0 0x2000>;
> +			interrupts = <GIC_PPI 9
> +					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
> +		};
> +
> +		timer {
> +			compatible = "arm,armv8-timer";
> +			interrupts = <GIC_PPI 13
> +					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
> +				     <GIC_PPI 14
> +					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
> +				     <GIC_PPI 11
> +					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
> +				     <GIC_PPI 10
> +					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
> +		};
> +
> +		clock {
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			#clock-cells = <1>;
> +			ranges;
> +
> +			cpg_clocks: cpg_clocks@e6150000 {
> +				compatible = "renesas,r8a7795-cpg-clocks",
> +					     "renesas,rcar-gen3-cpg-clocks";
> +				reg = <0 0xe6150000 0 0x1000>;
> +				clocks = <&extal_clk>;
> +				clock-indices = <
> +					R8A7795_CLK_MAIN R8A7795_CLK_PLL0
> +					R8A7795_CLK_PLL1 R8A7795_CLK_PLL2
> +					R8A7795_CLK_PLL3 R8A7795_CLK_PLL4
> +				>;
> +				#power-domain-cells = <0>;
> +			};
> +		};
> +	};
> +};
> --- /dev/null
> +++ work/include/dt-bindings/clock/r8a7795-clock.h	2015-08-29
> 18:14:13.682366518 +0900 @@ -0,0 +1,38 @@
> +/*
> + * Copyright (C) 2015 Renesas Electronics Corp.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +#ifndef __DT_BINDINGS_CLOCK_R8A7795_H__
> +#define __DT_BINDINGS_CLOCK_R8A7795_H__
> +
> +/* CPG */
> +#define R8A7795_CLK_MAIN		0
> +#define R8A7795_CLK_PLL0		1
> +#define R8A7795_CLK_PLL1		2
> +#define R8A7795_CLK_PLL2		3
> +#define R8A7795_CLK_PLL3		4
> +#define R8A7795_CLK_PLL4		5
> +
> +/* MSTP0 */
> +
> +/* MSTP1 */
> +
> +/* MSTP2 */
> +
> +/* MSTP3 */
> +
> +/* MSTP5 */
> +
> +/* MSTP7 */
> +
> +/* MSTP8 */
> +
> +/* MSTP9 */
> +
> +/* MSTP10 */
> +
> +#endif /* __DT_BINDINGS_CLOCK_R8A7795_H__ */

Shouldn't this be moved to the CPG patch series ?

-- 
Regards,

Laurent Pinchart

