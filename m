From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 14 Sep 2015 02:05:58 +0000
Subject: Re: [PATCH] misc: add CS2000 Fractional-N driver
Message-Id: <87vbbdkbcm.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87mvwuokd3.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mvwuokd3.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Arnd

Thank you for your feedback

> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > This patch adds CS2000 Fractional-N driver as clock provider.
> > It is useful if it supports runtime clock setting, but it supports
> > fixed clock rate at this point.
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> >  .../devicetree/bindings/misc/cs2000-cp.txt         |  20 ++
> >  drivers/misc/Kconfig                               |   6 +
> >  drivers/misc/Makefile                              |   1 +
> >  drivers/misc/cs2000-cp.c                           | 341 +++++++++++++++++++++
> >  4 files changed, 368 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/cs2000-cp.txt
> >  create mode 100644 drivers/misc/cs2000-cp.c
> 
> I think the driver should be in drivers/clk/ if it provides a clk to
> other devices.
> 
> Please also split out the binding document into a separate patch and
> Cc the devicetree mailing list.

OK, thanks
I will do it, and send to clock ML

> > +       ret = cs2000_get_clk(client, &rate_in, &rate_out);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       ret = cs2000_enable_dev_config(client);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       ret = cs2000_clk_in_bound_rate(client, rate_in);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       ret = cs2000_ratio_set(client, ch, rate_in, rate_out);
> > +       if (ret < 0)
> > +               return ret;
> 
> The probe function lacks unwinding if anything goes wrong, so you end
> up with clocks that are registered but the driver being absent.
> For most things, you can use the devm_*() interfaces here.

I got it.
Thanks

Best regards
---
Kuninori Morimoto
