From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 05 Aug 2014 07:25:57 +0000
Subject: Re: [PATCH] clk: shmobile: add missing 0x0100 for SDCKCR
Message-Id: <CAMuHMdW-MfCwwu+rqmOY86nBA__Qq4o5T2x2Sfx_-2oB1bKqRg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ppgf1kgv.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87ppgf1kgv.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Aug 5, 2014 at 9:09 AM, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Current cpg_sd01_div_table is missing
> "0x0100: x 1/8" division ratio.
> This patch is based on R-Car H2 v0.7, R-Car M2 v0.9.
>
> Reported-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

BTW, has this been verified by testing, or is it purely based on the datasheet?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
