From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 31 Aug 2015 09:07:18 +0000
Subject: Re: [PATCH v8 01/07] arm64: renesas: r8a7795: Add Renesas R8A7795 SoC support
Message-Id: <CAMuHMdXQSE3YmXr=CCVZQE5WROE64NiWo15YMZPw7Kyv6Xr+QQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150831062918.24004.15458.sendpatchset@little-apple>
In-Reply-To: <20150831062918.24004.15458.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Mon, Aug 31, 2015 at 8:29 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
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

Thanks for the updates!

>  Documentation/devicetree/bindings/arm/shmobile.txt |    2
>  arch/arm64/Kconfig.platforms                       |   16 +++
>  arch/arm64/boot/dts/Makefile                       |    1
>  arch/arm64/boot/dts/renesas/Makefile               |    3
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi           |   87 ++++++++++++++++++++
>  include/dt-bindings/clock/r8a7795-clock.h          |   38 ++++++++

I think this should be split in two patches:
  - Kconfig update
  - DT

> --- 0001/arch/arm64/Kconfig.platforms
> +++ work/arch/arm64/Kconfig.platforms   2015-08-29 18:20:52.022366518 +0900
> @@ -66,6 +66,22 @@ config ARCH_SEATTLE
>         help
>           This enables support for AMD Seattle SOC Family
>
> +config ARCH_SHMOBILE
> +       bool
> +
> +config ARCH_RENESAS
> +       bool "Renesas SoC Platform"
> +       select ARCH_SHMOBILE
> +       select PM_GENERIC_DOMAINS if PM
> +       help
> +         This enables support for the ARMv8 based Renesas SoCs.
> +
> +config ARCH_R8A7795
> +       bool "Renesas R-Car H3 SoC Platform"
> +       depends on ARCH_RENESAS
> +       help
> +         This enables support for the Renesas R-Car H3 SoC.

At some point in time (now sounds OK to me, else we need one more tiny
patch when the PFC bits are added to .dtsi?) PINCTRL should be selected
by either ARCH_RENESAS or ARCH_R8A7795.
Logically the latter, but the former is OK as I don't expect any new SoCs
lacking pinctrl to show up in the future.

In arm64_defconfig, PINCTRL is enabled due other platforms selecting in.
But currently an R-Car Gen3-only kernel does not have PINCTRL support.

> --- /dev/null
> +++ work/arch/arm64/boot/dts/renesas/r8a7795.dtsi       2015-08-29 18:16:38.452366518 +0900
> @@ -0,0 +1,87 @@

> +       extal_clk: extal_clk {

Please call the node "extal" instead. Without "clock-output-names", the node
name (incl. the "_clk" suffix) will be used as the clock's name.

> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
