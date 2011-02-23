From: Jeremy Kerr <jeremy.kerr@canonical.com>
Date: Wed, 23 Feb 2011 02:49:17 +0000
Subject: Re: [PATCH 1/2] Add a common struct clk
Message-Id: <201102231049.17466.jeremy.kerr@canonical.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1298256658.861611.43913489619.0.gpush@pororo>
	<1298256658.862188.178150188637.1.gpush@pororo>
	<20110222201725.GF22310@pengutronix.de>
In-Reply-To: <20110222201725.GF22310@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Uwe,

> > +static inline void clk_common_init(struct clk *clk) { }
> > +
> > +/*
> > + * For !CONFIG_USE_COMMON_STRUCT_CLK, we don't enforce any atomicity
> > + * requirements for clk_enable/clk_disable, so the prepare and unprepare
> > + * functions are no-ops
> > + */
> > +int clk_prepare(struct clk *clk) { return 0; }
> > +void clk_unprepare(struct clk *clk) { }
> 
> these should be static inline.  Otherwise these functions end up in many
> files and so provoke a build failure.

Ugh, brown paper bag time. Thanks for that, I'll update this patch.

Cheers,


Jeremy
