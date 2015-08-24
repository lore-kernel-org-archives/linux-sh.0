From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Aug 2015 09:43:09 +0000
Subject: Re: [PATCH 25/25 v7][RFC] Local: Hack: disable CONFIG_SUSPEND
Message-Id: <CAMuHMdUp1ws043KNzL4H0_xntWgKBYacEvmJS=FFTPG-phxm3A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87si795sht.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87si795sht.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san, Inami-san,

On Mon, Aug 24, 2015 at 4:33 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>
> Since cpu suspend is not supported in R-Car Gen3 initial version,
> disable CONFIG_SUSPEND as interim fix until pcsi is available.

> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index fcf375a..a2ddca9 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -59,6 +59,7 @@ CONFIG_CMA=y
>  CONFIG_CMDLINE="console=ttyAMA0"
>  # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
>  CONFIG_COMPAT=y
> +# CONFIG_SUSPEND is not set

Is this really needed? My local .config used with v5 of your patchset
has CONFIG_SUSPEND=y and booted fine.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
