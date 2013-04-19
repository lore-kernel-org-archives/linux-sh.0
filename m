From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 19 Apr 2013 00:30:52 +0000
Subject: Re: [PATCH 1/6 v2] sh-pfc: r8a7778: add SDHI support
Message-Id: <878v4f745j.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87k3o0safu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k3o0safu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent, Simon

> > +/* - SDHI macro
> > ------------------------------------------------------------- */ +#define
> > SDHI_PFC_PIN(name, clk, cmd, dat0, dat1, dat2, dat3, cd, wp)	\ +	static
> > const unsigned int name ##_pins[] =			\
> > +	{ clk, cmd, dat0, dat1, dat2, dat3, cd, wp }
> > +
> > +#define SDHI_PFC_MUX(name, clk, cmd, dat0, dat1, dat2, dat3, cd, wp)	\
> > +	static const unsigned int name ##_mux[] =			\
> > +	{ clk##_MARK,  cmd##_MARK,  dat0##_MARK, dat1##_MARK,		\
> > +	  dat2##_MARK, dat3##_MARK, cd##_MARK,   wp##_MARK }
> 
> I think you should split the macros in 5 (or possibly 4) macros. The CD and WP 
> signals are not mandatory, some boards might use the SDHI interface without 
> them, and reuse them for other purposes. They thus need to be selectable 
> separately. Similarly, boards can choose to use a 1-bit data bus instead of 
> the full 4-bits data bus. Please see pfc-r8a7740.c for an example of what I 
> mean.

Thank you for your advice.
I understand it, and will re-post v3

Best regards
---
Kuninori Morimoto
