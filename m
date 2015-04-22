From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 22 Apr 2015 01:04:57 +0000
Subject: Re: [PATCH 3/3 v3] mmc: sh_mmcif: calculate best clock with parent clock
Message-Id: <87oamhm0uv.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <873840a4ch.wl%kuninori.morimoto.gx@renesas.com>
	<87vbgpubvr.wl%kuninori.morimoto.gx@renesas.com>
	<87r3rdubmv.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdUM4Cizij6q+6o9mADF_UjkzpZSvsUCdG+Y=PHo=A_qLw@mail.gmail.com>
In-Reply-To: <CAMuHMdUM4Cizij6q+6o9mADF_UjkzpZSvsUCdG+Y=PHo=A_qLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Laurent <laurent.pinchart@ideasonboard.com>, kobayashi <keita.kobayashi.ym@renesas.com>


Hi Geert

Thank you for your review.

> > +static const struct sh_mmcif_parent_clk mmcif_gen2_parent_clk = {
> > +       .max = 97500000,
> > +       .min = 12187500,
> > +       .clkdiv_map = 0x3ff,
> 
> Shouldn't this come from private data in the CPG clock driver, which supplies
> the parent clock? Then the mmcif driver will be independent from the parent
> clock.

As Laurent mentioned in other feedback, parent clock (= CFG::MMCxCKCR) 
is div6, and it can set 1/1 - 1/64 (= 780000000 - 12187500)
But, MMC can use 1/8 - 1/64 (= 97500000 - 12187500), we don't know this limit
came from. we thought that having limit on DIV6 is not good idea.


> > +               /* FIXME */
> > +               if (pclk->max != pclk->min * (pclk->max / pclk->min)) {
> > +                       dev_err(&host->pd->dev, "not assumed parent clk\n");
> > +                       return;
> > +               }
> 
> Why?

This time, max/min = 97500000/12187500 = 8.
But, we don't know the future.
It will be non-assumed result if it was below or similar
max = 91406250
min = 12187500 (max = min * 15/2)


> > +               parent_freq = 0;
> > +               clkdiv = 0;
> > +               diff_min = ~0;
> > +               for (i = pclk->max / pclk->min; i > 0; i--) {
> > +                       for (j = fls(pclk->clkdiv_map); j >= 0; j--) {
> > +                               if (!((1 << j) & pclk->clkdiv_map))
> > +                                       continue;
> > +
> > +                               myclk = ((pclk->min * i) / (1 << (j + 1)));
> > +                               diff = (myclk > clk) ? myclk - clk : clk - myclk;
> > +
> > +                               if (diff <= diff_min) {
> > +                                       parent_freq = pclk->min * i;
> > +                                       clkdiv = j;
> > +                                       diff_min = diff;
> > +                               }
> > +                       }
> > +               }
> 
> Shouldn't the above be handled by the CPG clock driver, through a clk API?

I don't think so.
it calculates best of parent clock (= from CPG) and divider (= from MMC)
Why CPG driver need to care about MMC's divider ??

> > +               dev_dbg(&host->pd->dev, "clk %d/%d (%d, %x)\n",
> 
> "%u" (all four)
(snip)
> > +               clk_set_rate(host->hclk, parent_freq);
> 
> Note that the last parameter of clk_set_rate() is "unsigned long", while
> parent_freq is "unsigned int".
(snip)
> > +               host->clk = clk_get_rate(host->hclk);
> 
> clk_get_rate() returns "unsigned long", while "host->clk" is "unsigned int".
(snip)
> > +               dev_dbg(&host->pd->dev, "parent clk %d/%d, %d/%d\n",
> 
> "%u" (all four)

Thanks !
I will fixup these in v2

Best regards
---
Kuninori Morimoto
