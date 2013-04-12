From: Simon Horman <horms@verge.net.au>
Date: Fri, 12 Apr 2013 06:49:36 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7778: use fixed ratio clock
Message-Id: <20130412064932.GA27274@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <877gkm6dz6.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877gkm6dz6.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 11, 2013 at 10:08:39PM -0700, Kuninori Morimoto wrote:
> 
> Hi Magnus
> 
> > On Sun, Mar 31, 2013 at 10:01:53PM -0700, Kuninori Morimoto wrote:
> > > R-Car M1 has many clocks, and it is possible to
> > > read/use clock ratio of these clocks from FRQMRx.
> > > But, these ratio are fixed value and
> > > these are decided by MD pin status.
> > > 
> > > This patch reads MD pin status,
> > > and used fixed ratio clock for all clocks.
> > > It was tesed on bock-w board.
> > > 
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > Thanks Morimoto-san, this looks good to me.
> > 
> > Magnus, can I get a review from you?
> 
> ping ?

pong.

I have discussed things briefly with Magnus and I am happy to apply this change.
Could you rebase it on top of renesas-next-20130411v2 ?
