From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 02 Apr 2015 00:12:03 +0000
Subject: Re: [PATCH] clk: shmobile: r8a7779: check return of of_property_read_string_index()
Message-Id: <87lhib75js.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87pp7o2xqg.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdWV3oNTPTq0RwMugLGoz62T=1Acn1LWbJb4WobfiCcG+g@mail.gmail.com>
In-Reply-To: <CAMuHMdWV3oNTPTq0RwMugLGoz62T=1Acn1LWbJb4WobfiCcG+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Mike Turquette <mturquette@linaro.org>, Simon Horman <horms+renesas@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Laurent <laurent.pinchart@ideasonboard.com>


Hi Geert

> > diff --git a/drivers/clk/shmobile/clk-r8a7779.c b/drivers/clk/shmobile/clk-r8a7779.c
> > index 652ecac..af439b2 100644
> > --- a/drivers/clk/shmobile/clk-r8a7779.c
> > +++ b/drivers/clk/shmobile/clk-r8a7779.c
> > @@ -155,8 +155,10 @@ static void __init r8a7779_cpg_clocks_init(struct device_node *np)
> >                 const char *name;
> >                 struct clk *clk;
> >
> > -               of_property_read_string_index(np, "clock-output-names", i,
> > -                                             &name);
> > +               if (of_property_read_string_index(np, "clock-output-names", i,
> > +                                                 &name))
> > +                       pr_err("%s: can't get clock-output-names (%d)\n",
> > +                              __func__, i);
> 
> Shouldn't you add a "continue;" here, too?
> 
> Anyway, I don't think this can fail, as
> i < of_property_count_strings(np, "clock-output-names");

Hmm.. indeed.
Thank you for your review, please drop this patch.

Best regards
---
Kuninori Morimoto
