From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 14 Sep 2015 09:44:13 +0000
Subject: Re: [PATCH] clk: add CS2000 Fractional-N driver
Message-Id: <87fv2hjq4y.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87twqxk92u.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdX=vDeUSWy2sOmLQxOSGLJ7REXEAAdXO-p4pLT5zdf7EA@mail.gmail.com>
In-Reply-To: <CAMuHMdX=vDeUSWy2sOmLQxOSGLJ7REXEAAdXO-p4pLT5zdf7EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Simon <horms@verge.net.au>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk <linux-clk@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Magnus <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>


Hi Geert

Thank you for your review

> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >
> > This patch adds CS2000 Fractional-N driver as clock provider.
> > It is useful if it supports runtime clock setting, but it supports
> > fixed clock rate only at this point.
> >
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Thanks for your patch!

> As you have multiple inputs, I think it makes sense to use "clock-names".
(snip)
> Why do you call them differently from the datasheet?
> Especially the different CLK_IN can be confusing.
(snip)
> This can fail, so the error should be propagated, and checked in all
> callers of cs2000_write().
(snip)
> i2c_smbus_read_byte_data returns s32, and the return value will be
> negative in case of a failure.
(snip)
> Should check for failure.
(snip)
> unsigned int i
(snip)
> Please use do_div() for 64-by-32 divides, as full 64-bit divisions are
> usually not available on 32-bit architectures.
> "s32 val", and please check for failures.
(snip)
> const char *revision;

Thanks
will be fiex in v2

> > +       clk_main = of_clk_get(np, CLK_MAIN);
> > +       /* not yet provided */
> > +       if (IS_ERR(clk_main))
> > +               return -EPROBE_DEFER;
> > +
> > +       clk_in = of_clk_get(np, CLK_IN);
> > +       if (IS_ERR(clk_in))
> > +               return PTR_ERR(clk_in);
> 
> Named clk_get(), for both?

Thanks
I will use devm_clk_get() to avoid clk_put()

>> +       if (CH_ERR(ch))
>>
>> I think it's more readable to drop the CH_ERR() macro, and open code
>> "(ch < 0) || (ch >= CH_MAX)" (also in cs2000_ratio_select()).

In my opinion, complex judgment should use same method (= macro)
Current driver is using this macro only 2 places, so,
not a big deal at this point.
But someone might add mistake in additional patch if it was opened code,
and it exists in many places.
So, I would like to keep this macro in v2.
But, CH_ERR() is a littile bit ununderstandable naming.
it will be CH_SIZE_ERR()

Best regards
---
Kuninori Morimoto
