From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 24 Sep 2010 07:33:28 +0000
Subject: Re: [PATCH 2/2 v2] ARM: mach-shmobile: clock-sh7372: FSI parent select
Message-Id: <w3piq1vsiif.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org


Hi Magnus

Thank you for checking patch !!

> > +       /*
> > +        * FSIACK is connected to AK4642,
> > +        * and the rate is depend on playing sound rate.
> > +        * So, set dummy rate (= 48k) here
> > +        */
> > +       ret = clk_set_rate(&sh7372_fsiack_clk, FSIACK_DUMMY_RATE);
> > +       if (ret < 0) {
> > +               pr_err("Cannot set FSIACK dummy rate: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       fsia_ick = clk_get(&fsi_device.dev, "icka");
> > +       if (IS_ERR(fsia_ick)) {
> > +               ret = PTR_ERR(fsia_ick);
> > +               pr_err("Cannot get FSI ICK: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       ret = clk_set_parent(fsia_ick, &sh7372_fsiack_clk);
> > +       if (ret < 0) {
> > +               pr_err("Cannot set FSI-A parent: %d\n", ret);
> > +               goto out;
> > +       }
> > +
> > +       ret = clk_set_rate(fsia_ick, FSIACK_DUMMY_RATE);
> > +       if (ret < 0)
> > +               pr_err("Cannot set FSI-A rate: %d\n", ret);
> 
> Is it really necessary to perform clk_set_rate() two times?

Yes. both are needed.

1st dummy clk_set_rate is needed to ensure
clk->rate of external pin (which is needed for 2nd clk_set_rate).

2nd clk_set_rate assure 1/1 clock divide for FSI-A.
because default FSI-A division ratio is 1/64.

Thanks

Best regards
--
Kuninori Morimoto
