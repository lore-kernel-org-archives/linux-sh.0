From: Simon Horman <horms@verge.net.au>
Date: Wed, 06 Aug 2014 00:32:56 +0000
Subject: Re: [PATCH] clk: shmobile: add missing 0x0100 for SDCKCR
Message-Id: <20140806003253.GB32652@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87ppgf1kgv.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87ppgf1kgv.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Aug 05, 2014 at 01:51:12AM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> Thank you for your feedback
> 
> > > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > 
> > > Current cpg_sd01_div_table is missing
> > > "0x0100: x 1/8" division ratio.
> > > This patch is based on R-Car H2 v0.7, R-Car M2 v0.9.
> > > 
> > > Reported-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > ---
> (snip)
> > >  static const struct clk_div_table cpg_sd01_div_table[] = {
> > > +	{  4,  8 },
> > >  	{  5, 12 }, {  6, 16 }, {  7, 18 }, {  8, 24 },
> > >  	{ 10, 36 }, { 11, 48 }, { 12, 10 }, {  0,  0 },
> > >  };
> > 
> > Thanks. I have a few questions about this.
> > 
> > 1. Could you provide information on the patch that added this problem
> >    and the kernel version it was added in?
> 
> I see.
> It is added on v3.14.
> I can send v2 patch (or can you add it on log area ?)
> 
> > 2. Is this a bug-fix?
> >    If so, does it manifest in mainline?
> >    If so what happens?
> 
> This fixes hidden bug.
> No board/SoC doesn't have issue without this patch.

Thanks. Please send v2 with the above information.
Also please include the id and subject of the commit that added
the problem. e.g. 0123456789abcdef ("clk: shmobile: blah").

And I think that this patch needs to go via
Mike Turquette <mturquette@linaro.org> (CCed),
so please include him when you post v2.

> > 3. Should we also fix clock-r8a7790.c and clock-r8a7791.c?
> >    If so I can make a patch or I am happy for you to do so.
> 
> I can do it, but is it possible ?
> I'm afraid that clock-r8axxx is used for legacy (= non-DT)
> But, I'm happy to send it if you say "Yes"

Good point.

My not very strong feeling at this point is that if it is a fix then we
should add it.  Even if it is legacy code.
