From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 Sep 2015 08:32:52 +0000
Subject: Re: [PATCH 03/18 v3] arm64: renesas: r8a7795: add AUDIO_DMAC support
Message-Id: <CAMuHMdVJj9e9Xp05MmebtdE2vc9Xtyo5roxj_=pOHHNWx_OTAQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878u841o94.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878u841o94.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Fri, Sep 18, 2015 at 4:03 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> --- a/include/dt-bindings/clock/r8a7795-clock.h
> +++ b/include/dt-bindings/clock/r8a7795-clock.h
> @@ -32,6 +32,8 @@
>  #define R8A7795_CLK_SCIF2              10
>
>  /* MSTP5 */
> +#define R8A7795_CLK_AUDIO_DMAC0                2
> +#define R8A7795_CLK_AUDIO_DMAC1                1

Please sort by increasing bit number.

Sorry for missing this before.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
