From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 15 Jun 2015 07:46:47 +0000
Subject: Re: [PATCH 5/6][RFC] arm64: renesas: Add r8a7795 SoC support
Message-Id: <CANqRtoTA9PfcgeW40frE7FhBoEmjKxV1La1G268QQqVZL1J8JA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87y4jlvait.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y4jlvait.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Mon, Jun 15, 2015 at 1:54 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm64/boot/dts/renesas/Makefile      |  5 ++
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 90 +++++++++++++++++++++++++++++++
>  include/dt-bindings/clock/r8a7795-clock.h | 31 +++++++++++
>  3 files changed, 126 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/renesas/Makefile
>  create mode 100644 arch/arm64/boot/dts/renesas/r8a7795.dtsi
>  create mode 100644 include/dt-bindings/clock/r8a7795-clock.h
>
> diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
> new file mode 100644
> index 0000000..970627c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/Makefile
> @@ -0,0 +1,5 @@
> +dtb-$(CONFIG_ARCH_RCAR_GEN3) +> +
> +always         := $(dtb-y)
> +subdir-y       := $(dts-dirs)
> +clean-files    := *.dtb
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> new file mode 100644
> index 0000000..13c7d8d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -0,0 +1,90 @@
> +/*
> + * Device Tree Source for the r8a7795 SoC
> + *
> + * Copyright (C) 2015 Renesas Electronics Corp.
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +/dts-v1/;
> +
> +#include <dt-bindings/clock/r8a7795-clock.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +       compatible = "renesas,r8a7795";
> +       interrupt-parent = <&gic>;
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               /* 1core only at this point */
> +               a53_0: cpu@100 {
> +                       compatible = "arm,cortex-a53","arm,armv8";
> +                       reg = <0x100>;
> +                       device_type = "cpu";
> +               };
> +       };
> +
> +       gic: interrupt-controller@0xf1010000 {
> +               compatible = "arm,gic-400", "arm,cortex-a15-gic";
> +               #interrupt-cells = <3>;
> +               #address-cells = <0>;
> +               interrupt-controller;
> +               reg = <0x0 0xf1010000 0 0x1000>,
> +                     <0x0 0xf1020000 0 0x2000>;
> +               interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
> +       };

Thanks for your efforts. On ARM v8, is ARM v7 compat string
"arm,cortex-a15-gic" really correct?

Cheers,

/ magus
