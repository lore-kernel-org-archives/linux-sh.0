From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 06 Aug 2015 10:03:03 +0000
Subject: Re: [PATCH 02/13 v4][RFC] arm64: renesas: Add new Renesas R-Car Gen3 SoC Kconfig
Message-Id: <CAMuHMdVSiG+9XfY9tx7TL7DjG5Pr-qG4dx-oypWEskF=zp0Y0w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87twscyhev.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87twscyhev.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 6, 2015 at 10:04 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>
> Initial version of device tree for Renesas R-Car Gen3 SoC Kconfig
>
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v3 -> v4
>
>  - no change
>
>  arch/arm64/Kconfig | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 318175f..bd1257e 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig

arch/arm64/Kconfig.platforms?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
