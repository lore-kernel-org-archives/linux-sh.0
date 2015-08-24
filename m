From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Aug 2015 12:47:46 +0000
Subject: Re: [PATCH 15/25 v7][RFC] arm64: renesas: add Salvator-X board support on DTS
Message-Id: <CAMuHMdXDSq4qcvxu9iBoTb4xjF6=dDT0=vG0Qm2hGhAd39+UHg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <877fol7774.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877fol7774.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 24, 2015 at 4:30 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> @@ -0,0 +1,46 @@

> +&pfc {
> +       scif2_pins: scif2 {
> +               renesas,groups = "scif2_data";
> +               renesas,function = "scif2";
> +       };

The closing brace has 7 spaces instead of 1 TAB.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
