From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 13 May 2015 08:37:55 +0000
Subject: Re: [PATCH 3/3 v5] mmc: sh_mmcif: calculate best clock with parent clock
Message-Id: <87mw18euww.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <873840a4ch.wl%kuninori.morimoto.gx@renesas.com>
	<87a8x9fck7.wl%kuninori.morimoto.gx@renesas.com>
	<87617xfchj.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdV5aVEqEkOi5sk4rB2NoqzWBp2NvtP=k4pXJ0JjNeKo1w@mail.gmail.com>
In-Reply-To: <CAMuHMdV5aVEqEkOi5sk4rB2NoqzWBp2NvtP=k4pXJ0JjNeKo1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Laurent <laurent.pinchart@ideasonboard.com>, kobayashi <keita.kobayashi.ym@renesas.com>


Hi Geert

Thank you for your feedback

> > +/*
> > + * difference for each SoC
> > + */
> > +struct sh_mmcif_ver {
> > +       u32 clkdiv_map;         /* see CE_CLK_CTRL::CLKDIV */
> > +       unsigned int pf_min;    /* parent frequency min */
> 
> I don't think you need an explicit lower limit: clk_round_rate() will
> never return a frequency that's lower than the parent clock's lower limit.

Indeed... Good catch

> > +static const struct sh_mmcif_ver sh_mmcif_gen2 = {
> > +       .clkdiv_map     = 0x3ff,
> > +       .pf_min         = 12187500,
> > +       .pf_max         = 97500000,
> 
> By any chance, does setting "max-frequency = <97500000>" from the standard
> MMC DT bindings have the same effect?

I'm still not understanding about this.
If we can specify SoC (via compatible), the clock frequency limitation
can be specified in same time.
Why do we need to have flexibility for it ?
What is yuur "any chance" mean ?
