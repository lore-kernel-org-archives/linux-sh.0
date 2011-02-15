From: Jeremy Kerr <jeremy.kerr@canonical.com>
Date: Tue, 15 Feb 2011 02:00:28 +0000
Subject: Re: [RFC, PATCH 3/3] clk: add warnings for incorrect enable/prepare semantics
Message-Id: <201102151000.29385.jeremy.kerr@canonical.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1297233693.241680.897691111624.0.gpush@pororo>
	<1297233693.243373.411051105619.3.gpush@pororo>
	<20110210093756.GA24710@b20223-02.ap.freescale.net>
In-Reply-To: <20110210093756.GA24710@b20223-02.ap.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Richard,

> >  void clk_unprepare(struct clk *clk)
> >  {
> > 
> > +	WARN_ON(clk->enable_count != 0);
> > +
> 
> Other drivers may be using the clock and increased the enable_count.
> This check may be moved to where we actually do unprepare.

Of course, thanks. Will update the series.


Jeremy
