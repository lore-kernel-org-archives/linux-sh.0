From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Jun 2015 08:09:14 +0000
Subject: Re: [PATCH 4/6][RFC] arm64: Add new Renesas R-Car Gen3 SoC Kconfig
Message-Id: <CAMuHMdUi4gPihAvkKgjZ16zYUHeT2DNDm5KhgRCsEkz5ys22sw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87zj41vaja.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87zj41vaja.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san, Inami-san,

On Mon, Jun 15, 2015 at 6:54 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>
> Initial version of device tree for Renesas R-Car Gen3 SoC Kconfig
>
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm64/Kconfig           | 13 +++++++++++++
>  arch/arm64/boot/dts/Makefile |  1 +
>  2 files changed, 14 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 99930cf..3c93c03 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -154,6 +154,12 @@ config PGTABLE_LEVELS
>         default 3 if ARM64_4K_PAGES && ARM64_VA_BITS_39
>         default 4 if ARM64_4K_PAGES && ARM64_VA_BITS_48
>
> +config ARCH_SHMOBILE
> +       bool
> +
> +config ARCH_SHMOBILE_MULTI
> +       bool
> +

Please drop ARCH_SHMOBILE_MULTI.
I don't think we're gonna need a distinction between legacy and
multiplatform on arm64 :-)

Ah, probably you need this to build properly various pieces of code under
drivers/? One more reason to get rid of ARCH_SHMOBILE_LEGACY soon...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
