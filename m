From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 16 Sep 2010 01:18:31 +0000
Subject: Re: [PATCH 2/2][RFC] ARM: mach-shmobile: clock-sh7372: FSI parent
Message-Id: <w3peicuwkns.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pd3sfwlxm.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pd3sfwlxm.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org


Hi Magnus

Thank you for your help !!

> > +       /* select FSIACK for AK4642 */
> > +       ret = clk_set_parent(fsia_ick, &fsiack_clk);
> > +       if (ret < 0) {
> > +               pr_err("Cannot set FSI-A parent: %d\n", ret);
> > +               goto out;
> > +       }
> > +
> > +       /* no divide */
> > +       ret = clk_set_rate(fsia_ick, 0);
> > +       if (ret < 0)
> > +               pr_err("Cannot set FSI-A rate: %d\n", ret);
> 
> This rate setting looks a bit strange to me. It looks like you select
> the external pin as parent, and then you try to set the rate to zero.
> What is the clock rate of the external pin?

The external pin (FSIACK) is connected to AK4642 now.
And the clock rate is depend on the playing sound rate.
 -> It mean I can not specify the clock rate here.

What should I do in this case ?

> >  * 26MHz default rate for the EXTAL1 root input clock.
> >  * If needed, reset this with clk_set_rate() from the platform code.
> > @@ -295,6 +302,8 @@ struct clk pllc2_clk = {
> >  static struct clk *main_clks[] = {
> >        &dv_clki_clk,
> >        &r_clk,
> > +       &fsiack_clk,
> > +       &fsibck_clk,
> >        &sh7372_extal1_clk,
> >        &sh7372_extal2_clk,
> >        &dv_clki_div2_clk,
> 
> I'd prefer to keep r_clk and extal clocks together since they are the
> main inputs to the cpu. Put the new clocks at the end of the list
> please.

understand
I will fix in v2

> > diff --git a/arch/arm/mach-shmobile/include/mach/sh7372.h b/arch/arm/mach-shmobile/include/mach/sh7372.h
> > index 33e9700..4d93c17 100644
> > --- a/arch/arm/mach-shmobile/include/mach/sh7372.h
> > +++ b/arch/arm/mach-shmobile/include/mach/sh7372.h
> > @@ -460,5 +460,7 @@ enum {
> >  extern struct clk dv_clki_clk;
> >  extern struct clk dv_clki_div2_clk;
> >  extern struct clk pllc2_clk;
> > +extern struct clk fsiack_clk;
> > +extern struct clk fsibck_clk;
> 
> I would prefer that the global clocks came with a sh7372 prefix,
> please add "sh7372_" before the variable names.

Thanks
I think you mean these all clocks.

Best regards
--
Kuninori Morimoto
