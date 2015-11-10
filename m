From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 10 Nov 2015 00:26:31 +0000
Subject: Re: [PATCH v5] clk: add CS2000 Fractional-N driver
Message-Id: <87mvumln67.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <874mhmuyg8.wl%kuninori.morimoto.gx@renesas.com>
	<CAHp75VcKnJr2zaFky9_G-qetdiuB8fS=r8r7hQTbYPUwEZ7n4g@mail.gmail.com>
	<877flsknmk.wl%kuninori.morimoto.gx@renesas.com>
	<CAHp75VdYL_fjvcG3Ss=yk=E1i5JKox9-sTaFzKjG8O1Osez5tQ@mail.gmail.com>
In-Reply-To: <CAHp75VdYL_fjvcG3Ss=yk=E1i5JKox9-sTaFzKjG8O1Osez5tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Simon <horms@verge.net.au>, Michael Turquette <mturquette@baylibre.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, linux-clk@vger.kernel.org


Hi Andy

> >> > +static int cs2000_wait_pll_lock(struct cs2000_priv *priv)
> >> > +{
> >> > +       struct device *dev = priv_to_dev(priv);
> >> > +       s32 val;
> >> > +       unsigned int i;
> >> > +
> >> > +       for (i = 0; i < 256; i++) {
> >> > +               val = cs2000_read(priv, DEVICE_CTRL);
> >> > +               if (val < 0)
> >> > +                       return val;
> >> > +               if (!(val & PLL_UNLOCK))
> >> > +                       return 0;
> >> > +               udelay(1);
> >> > +       }
> >>
> >> unsigned int i = 256;
> >>
> >> do {
> >> val = read();
> >> …
> >> while ((val & PLL_UNLOCK) && --i);
> >>
> >> if (!i) {
> >>  …
> >>  return -EIO;
> >>
> >> Actually -ETIMEDOUT ?
> >>
> >> }
> >
> > What is the motivation of above ?
> > It needs "i" anyway ? it needs to check (val < 0) anyway ?
> > what is the difference between do {} while <-> for(xxx)
> 
> Just a style.
> Still the question about error code.

OK. do {} while is not bad, but for () loop
can avoid pointless check I think. I would like to use it.
And yes, next version will use -ETIMEDOUT

> >> > +       of_property_read_string(np, "clock-output-names", &name);
> >>
> >> What about device property API?
> >
> > Sorry, which API ?
> > Many other clk-xxx.c are using this style ?
> 
> Never mind then.

Thanks
