From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 26 Aug 2015 17:42:10 +0000
Subject: Re: [PATCH 06/25 v7][RFC] arm64: renesas: Add new Renesas R-Car Gen3 SoC Kconfig
Message-Id: <CAMuHMdUgcYj1cDgkEPCCrDJSpvU2jz4xN_AgRLGW8SLCSWZReA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87k2sl77bs.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k2sl77bs.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san, Inami-san,

On Mon, Aug 24, 2015 at 4:27 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Gaku Inami <gaku.inami.xw@bp.renesas.com>

> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -51,6 +51,12 @@ config ARCH_QCOM
>         help
>           This enables support for the ARMv8 based Qualcomm chipsets.
>
> +config ARCH_RCAR_GEN3
> +       bool "Renesas R-Car Gen3 SoC Platform"
> +       select ARCH_SHMOBILE

Given patch 4 introduced pinctrl support, this should select PINCTRL.
In arm64_defconfig, PINCTRL is enabled due other platforms selecting in.
But currently an R-Car Gen3-only kernel does not have PINCTRL support.

> +       help
> +         This enables support for Renesas SoC.
> +

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
