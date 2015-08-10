From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Aug 2015 08:54:59 +0000
Subject: Re: [PATCH 02/16 v5][RFC] arm64: renesas: Add new Renesas R-Car Gen3 SoC Kconfig
Message-Id: <CAMuHMdVWiRmHEpDr-iLNcCF20t9QXQxsf6wvHOixGNp_2U5zDQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87614reqrb.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87614reqrb.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Aug 7, 2015 at 5:15 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>
> Initial version of device tree for Renesas R-Car Gen3 SoC Kconfig
>
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v4 -> v5
>
>  - based on latest ARM branch (Kconfig.platforms)
>
>  arch/arm64/Kconfig.platforms | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index e2deb18..ee99121 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -55,11 +55,20 @@ config ARCH_ROCKCHIP
>           This enables support for the ARMv8 based Rockchip chipsets,
>           like the RK3368.
>
> +config ARCH_RCAR_GEN3
> +       bool "Renesas R-Car Gen3 SoC Platform"
> +       select ARCH_SHMOBILE
> +       help
> +         This enables support for Renesas SoC.
> +

Please insert ARCH_RCAR_GEN3 before ARCH_ROCKCHIP to keep
sort order. However...

>  config ARCH_SEATTLE
>         bool "AMD Seattle SoC Family"
>         help
>           This enables support for AMD Seattle SOC Family
>
> +config ARCH_SHMOBILE
> +       bool
> +

shouldn't we have ARCH_SHMOBILE first, and make ARCH_RCAR_GEN3
depend on it, cfr. what Tegra is doing (and everyone has been doing on 32-bit
arm)?

It's debatable though, and thus to be discussed with the arm-soc maintainers,
as Exynos is doing it the other way, too.

>  config ARCH_TEGRA
>         bool "NVIDIA Tegra SoC Family"
>         select ARCH_HAS_RESET_CONTROLLER

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
