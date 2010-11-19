From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 19 Nov 2010 11:28:16 +0000
Subject: Re: [PATCH 2/6] ARM: mach-shmobile: ap4evb: FSI clock use proper
Message-Id: <Pine.LNX.4.64.1011191225570.20751@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <w3paal54w0z.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3paal54w0z.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, 19 Nov 2010, Liam Girdwood wrote:

> On Fri, 2010-11-19 at 16:23 +0900, Kuninori Morimoto wrote:
> > Current AP4 FSI set_rate function used bogus clock process
> > which didn't care enable/disable and clk->usecound.
> > To solve this issue, this patch also modify FSI driver to call
> > set_rate with enough options.
> > This patch modify it.

[snip]

> > -static int fsi_set_rate(int is_porta, int rate)
> > +	if (enable) {
> > +		ret = clk_set_rate(clk, clk_round_rate(clk, rate));
> > +		if (0 = ret)
> > +			ret = clk_enable(clk);
> > +	} else {
> > +		clk_disable(clk);
> > +	}
> > +
> 
> braces not needed for else here.

They are - according to the CodingStyle Chapter 3.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
