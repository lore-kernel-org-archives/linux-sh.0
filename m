From: Simon Horman <horms@verge.net.au>
Date: Fri, 11 Sep 2015 00:28:17 +0000
Subject: Re: [PATCH 01/14][RFC] arm64: renesas: tidyup MSTP9 reverse definition order
Message-Id: <20150911002815.GD27243@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87pp1qn40o.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87pp1qn40o.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

[CC Ulrich]

On Thu, Sep 10, 2015 at 08:30:11AM +0000, Kuninori Morimoto wrote:
> 
> Hi Geert
> 
> > > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > >
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > 
> > To be folded into "arm64: dts: r8a7795: add GPIO clocks" before submission
> > of the latter?
> 
> Yes.
> I guess current "GPIO clocks" patch is not formal one today,
> but queued on topic branch ?
> I hope v2 solved this order

That sounds sane to me.

I've CCed Ulrich as I believe he is taking care of GPIO patches.
