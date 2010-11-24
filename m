From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 24 Nov 2010 01:27:17 +0000
Subject: Re: [PATCH 2/6] ARM: mach-shmobile: ap4evb: FSI clock use proper
Message-Id: <w3py68jzf2m.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3paal54w0z.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3paal54w0z.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Liam

Thank you for checking patches

> >  /* FSI */
> >  #define IRQ_FSI		evt2irq(0x1840)
> > +static int __fsi_set_rate(struct clk *clk, long rate, int enable)
> > +{
> > +	int ret = 0;
> > +
> > +	if (rate <= 0)
> > +		return 0;
> 
> why do you need to set ret = 0 here ?

return ret; seems good here.
Thanks


> >  	switch (rate) {
> >  	case 44100:
> > -		clk_set_rate(fsib_clk, clk_round_rate(fsib_clk, 11283000));
> > -		ret = SH_FSI_ACKMD_256 | SH_FSI_BPFMD_64;
> > +		fsib_rate	= 11283000;
> 
> I'd expect to see 11289600 here, i.e. 44100 * 256
> 
> > +		ackmd_bpfmd	= SH_FSI_ACKMD_256 | SH_FSI_BPFMD_64;
> >  		break;
> >  	case 48000:
> > -		clk_set_rate(fsib_clk, clk_round_rate(fsib_clk, 85428000));
> > -		clk_set_rate(fdiv_clk, clk_round_rate(fdiv_clk, 12204000));
> > -		ret = SH_FSI_ACKMD_256 | SH_FSI_BPFMD_64;
> > +		fsib_rate	= 85428000;
> > +		fdiv_rate	= 12204000;
> 
> This looks wrong too. 12288000 is 48000 * 256

Thanks.
These value came from FSI and its divider ability.
But now it can use clk_round_rate.
So, I will modify it in v2 patch.

Best regards
--
Kuninori Morimoto
 
