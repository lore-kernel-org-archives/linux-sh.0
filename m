From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 12 Apr 2013 07:17:09 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7778: use fixed ratio clock
Message-Id: <87zjx4nrpq.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <877gkm6dz6.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877gkm6dz6.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > > > R-Car M1 has many clocks, and it is possible to
> > > > read/use clock ratio of these clocks from FRQMRx.
> > > > But, these ratio are fixed value and
> > > > these are decided by MD pin status.
> > > > 
> > > > This patch reads MD pin status,
> > > > and used fixed ratio clock for all clocks.
> > > > It was tesed on bock-w board.
> > > > 
> > > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > 
> > > Thanks Morimoto-san, this looks good to me.
> > > 
> > > Magnus, can I get a review from you?
> > 
> > ping ?
> 
> pong.
> 
> I have discussed things briefly with Magnus and I am happy to apply this change.
> Could you rebase it on top of renesas-next-20130411v2 ?

OK, thank you
I send it soon


Best regards
---
Kuninori Morimoto
