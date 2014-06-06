From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 06 Jun 2014 05:54:40 +0000
Subject: Re: [alsa-devel] r8a7790 only has audio when clock is forced on
Message-Id: <87iooebn1d.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <538E0487.1010700@codethink.co.uk>
	<20140603214226.GA2520@sirena.org.uk>
	<87egz5ldtm.wl%kuninori.morimoto.gx@renesas.com>
	<538EE0BE.5030304@codethink.co.uk>
	<87zjhrj3gc.wl%kuninori.morimoto.gx@renesas.com>
	<539033ED.4010604@codethink.co.uk>
	<87fvjjitqm.wl%kuninori.morimoto.gx@renesas.com>
	<53903DCF.1050604@codethink.co.uk>
	<539048D3.6060306@codethink.co.uk>
In-Reply-To: <539048D3.6060306@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Violeta Menendez Gonzalez <violeta.menendez@codethink.co.uk>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@lists.codethink.co.uk, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, linux-sh@vger.kernel.org


Hi Ben, Violeta

> >>          reg =   <0 0xec500000 0 0x1000>, /* SCU */
> >>                  <0 0xec5a0000 0 0x100>,  /* ADG */
> >>                  <0 0xec540000 0 0x1000>, /* SSIU */
> >>                  <0 0xec541000 0 0x1280>; /* SSI */
> >>          clocks = <&mstp10_clks R8A7790_CLK_SSI>,
> >
> > I don't think we have this one here.
> 
> Indeed. Adding it fixed our issue.

Phew, nice !
Sorry for my poor English which causes delay solution.


> >>   - SSI(ALL) is called via pm_runtime_xxx() from sound driver
> >>   - SRC(ALL) is called as parent clock of SRCn clocks
> >
> > See, this is why I /hate/ the implicit clock management. This is
> > another case where we're getting bitten by it.

I troubled about this ALL bit too,
then, it become current style.

One reason was that
this driver is supporting Gen1 sound too.
But, this SRC(ALL) didn't exist on Gen1..
