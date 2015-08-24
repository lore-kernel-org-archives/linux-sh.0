From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Aug 2015 10:55:02 +0000
Subject: Re: [PATCH 01/25 v7][RFC] clk: shmobile: add Renesas R-Car Gen3 CPG support
Message-Id: <CAMuHMdXTJLgbST2FfS==NC3AcgY1i7pJr0JHUzEi0rXui2cvzw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87r3mt77ek.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87r3mt77ek.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san, Inami-san,

On Mon, Aug 24, 2015 at 4:25 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> --- /dev/null
> +++ b/drivers/clk/shmobile/clk-rcar-gen3.c

> +/*
> + *   MD                EXTAL           PLL0    PLL1    PLL2    PLL3    PLL4
> + * 14 13 19 17 (MHz)           *1      *1      *1
> + *-------------------------------------------------------------------
> + * 0  0  0  0  16.66 x 1       x180/2  x192/2  x144/2  x192    x144
> + * 0  0  0  1  16.66 x 1       x180/2  x192/2  x144/2  x128    x144
> + * 0  0  1  0  Prohibited setting
> + * 0  0  1  1  16.66 x 1       x180/2  x192/2  x144/2  x192    x144
> + * 0  1  0  0  20    x 1       x150/2  x156/2  x120/2  x156    x120
> + * 0  1  0  1  20    x 1       x150/2  x156/2  x120/2  x106    x120
> + * 0  1  1  0  Prohibited setting
> + * 0  1  1  1  20    x 1       x150/2  x156/2  x120/2  x156    x120
> + * 1  0  0  0  25    x 1       x120/2  x128/2  x96/2   x128    x96
> + * 1  0  0  1  25    x 1       x120/2  x128/2  x96/2   x84     x96
> + * 1  0  1  0  Prohibited setting
> + * 1  0  1  1  25    x 1       x120/2  x128/2  x96/2   x128    x96
> + * 1  1  0  0  33.33 / 2       x180/2  x192/2  x144/2  x192    x144
> + * 1  1  0  1  33.33 / 2       x180/2  x192/2  x144/2  x128    x144
> + * 1  1  1  0  Prohibited setting
> + * 1  1  1  1  33.33 / 2       x180/2  x192/2  x144/2  x192    x144
> + *
> + * *1 : datasheet indicates VCO output (PLLx = VCO/2)

Do we want to have "pll1" output half the frequency of "PLL1"?
While most dividers are fed by "PLL1/2", "RPCSRC" is fed by "PLL1".

On Gen2 we had "pll1_div2_clk" in DT.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
