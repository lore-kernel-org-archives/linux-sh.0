From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 18 Apr 2013 00:27:03 +0000
Subject: Re: [PATCH 1/6] sh-pfc: r8a7778: add SDHI support
Message-Id: <87vc7ksmy3.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ehe9enys.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ehe9enys.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent

Thank you for your review

> > +/* - SDHI macro
> > ------------------------------------------------------------- */ +#define
> > SDHI_PFC(name, pclk, pcmd, pdat0, pdat1, pdat2, pdat3, pcd, pwp,\ +		      
> > mclk, mcmd, mdat0, mdat1, mdat2, mdat3, mcd, mwp)\
> > +	static const unsigned int name ##_pins[] =			\
> > +	{ pclk, pcmd, pdat0, pdat1, pdat2, pdat3, pcd, pwp };		\
> > +	static const unsigned int name ##_mux[] =			\
> > +	{ mclk##_MARK,  mcmd##_MARK,  mdat0##_MARK, mdat1##_MARK,	\
> > +	  mdat2##_MARK, mdat3##_MARK, mcd##_MARK,   mwp##_MARK }
> > +
> > +/* - SDHI0
> > ------------------------------------------------------------------ */
> > +SDHI_PFC(sdhi0,		RCAR_GP_PIN(3, 11),	RCAR_GP_PIN(3, 12),
> > +			RCAR_GP_PIN(3, 13),	RCAR_GP_PIN(3, 14),
> > +			RCAR_GP_PIN(3, 15),	RCAR_GP_PIN(3, 16),
> > +			RCAR_GP_PIN(3, 17),	RCAR_GP_PIN(3, 18),
> > +			SD0_CLK,		SD0_CMD,
> > +			SD0_DAT0,		SD0_DAT1,
> > +			SD0_DAT2,		SD0_DAT3,
> > +			SD0_CD,			SD0_WP);
> 
> Unlike for SCIF, I actually think the macro hinders readability here compared 
> to the raw arrays. That's a personal opinion, you can keep the macro if you 
> prefer.

Not a big deal.
I can send v2 patch which is same style as SCIF


Best regards
---
Kuninori Morimoto
